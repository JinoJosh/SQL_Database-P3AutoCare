--Stored Procedures
-----------------------------------------------------------------
-- Stored Procedure: CalculateTotalCost
CREATE PROCEDURE CalculateTotalCost
    @WorkOrderID INT
AS
BEGIN
    SELECT 
        SUM(s.ServiceCost) + SUM(p.PartPrice * wop.Quantity) AS TotalCost
    FROM 
        WorkOrderService wos
    JOIN 
        Service s ON wos.ServiceID = s.ServiceID
    JOIN 
        WorkOrderParts wop ON wos.WorkOrderID = wop.WorkOrderID
    JOIN 
        Parts p ON wop.PartID = p.PartID
    WHERE 
        wos.WorkOrderID = @WorkOrderID;
END;
GO

-- Stored Procedure: UpdateAppointmentStatus
CREATE PROCEDURE UpdateAppointmentStatus
    @AppointmentID INT,
    @Status VARCHAR(255)
AS
BEGIN
    UPDATE Appointment
    SET Status = @Status
    WHERE AppointmentID = @AppointmentID;
END;
GO

-- Stored Procedure: GetAvailableParts
CREATE PROCEDURE GetAvailableParts
AS
BEGIN
    SELECT 
        PartID,
        PartName,
        PartManufacturer,
        PartPrice,
        (SELECT SUM(Quantity) FROM WorkOrderParts WHERE PartID = p.PartID) AS AvailableQuantity
    FROM 
        Parts p;
END;
GO

-- Stored Procedure: ScheduleService
CREATE PROCEDURE ScheduleService
    @CustomerID INT,
    @VehicleID INT,
    @EmployeeID INT,
    @ServiceID INT,
    @AppointmentDate DATETIME,
    @AppointmentDesription VARCHAR(255)
AS
BEGIN
    INSERT INTO Appointment (CustomerID, VehicleID, EmployeeID, ServiceID, AppointmentDate, AppointmentDesription)
    VALUES (@CustomerID, @VehicleID, @EmployeeID, @ServiceID, @AppointmentDate, @AppointmentDesription);
END;
GO

-- Stored Procedure: RecordServiceCompletion
CREATE PROCEDURE RecordServiceCompletion
    @WorkOrderID INT,
    @ServiceID INT,
    @CompletionDate DATETIME
AS
BEGIN
    UPDATE WorkOrderService
    SET CompletionDate = @CompletionDate
    WHERE WorkOrderID = @WorkOrderID AND ServiceID = @ServiceID;
END;
GO

--Views
---------------------------------------------------------------------------
-- View: AppointmentSummary
CREATE VIEW AppointmentSummary AS
SELECT 
    a.AppointmentID,
    a.AppointmentDate,
    a.AppointmentDesription,
    e.EmployeeFirstName + ' ' + e.EmployeeLastName AS EmployeeName,
    v.CarMake + ' ' + v.CarModel AS Vehicle,
    a.Status
FROM 
    Appointment a
JOIN 
    Employee e ON a.EmployeeID = e.EmployeeID
JOIN 
    Vehicle v ON a.VehicleID = v.VehicleID;

-- View: WorkOrderSummary
CREATE VIEW WorkOrderSummary AS
SELECT 
    wo.WorkOrderID,
    wo.DateRecieved,
    wo.EstimatedCompletionTime,
    wo.Status,
    v.CarMake + ' ' + v.CarModel AS Vehicle,
    s.ServiceDescription,
    s.ServiceCost
FROM 
    WorkOrder wo
JOIN 
    Vehicle v ON wo.VehicleID = v.VehicleID
JOIN 
    WorkOrderService wos ON wo.WorkOrderID = wos.WorkOrderID
JOIN 
    Service s ON wos.ServiceID = s.ServiceID;

-- View: CustomerVehicles
CREATE VIEW CustomerVehicles AS
SELECT 
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    v.VehicleID,
    v.CarMake,
    v.CarModel,
    v.Year,
    v.Color
FROM 
    Customer c
JOIN 
    Vehicle v ON c.CustomerID = v.CustomerID;

-- View: EmployeeSchedules
CREATE VIEW EmployeeSchedules AS
SELECT 
    e.EmployeeID,
    e.EmployeeFirstName + ' ' + e.EmployeeLastName AS EmployeeName,
    a.AppointmentDate,
    a.AppointmentDesription
FROM 
    Employee e
JOIN 
    Appointment a ON e.EmployeeID = a.EmployeeID;

-- View: ServiceHistory
CREATE VIEW ServiceHistory AS
SELECT 
    v.VehicleID,
    v.CarMake + ' ' + v.CarModel AS Vehicle,
    s.ServiceID,
    s.ServiceDescription,
    s.ServiceCost,
    a.AppointmentDate
FROM 
    Service s
JOIN 
    WorkOrderService wos ON s.ServiceID = wos.ServiceID
JOIN 
    WorkOrder wo ON wos.WorkOrderID = wo.WorkOrderID
JOIN 
    Vehicle v ON wo.VehicleID = v.VehicleID
JOIN 
    Appointment a ON v.VehicleID = a.VehicleID;

--TRIGGERS
---------------------------------------------------------------------------
-- Trigger to update inventory count after a part is used in a service
CREATE TRIGGER InventoryCount
ON WorkOrderParts
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Parts
    SET PartPrice = PartPrice - inserted.Quantity
    FROM Parts
    INNER JOIN inserted ON Parts.PartID = inserted.PartID
END;
GO

-- Trigger to automatically assign an employee to new appointments
CREATE TRIGGER AutoAssignEmployee
ON Appointment
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EmployeeID INT;
    SELECT TOP 1 @EmployeeID = EmployeeID FROM Employee ORDER BY NEWID();
    UPDATE Appointment
    SET EmployeeID = @EmployeeID
    WHERE AppointmentID IN (SELECT DISTINCT AppointmentID FROM inserted);
END;
GO

-- Trigger to log the usage of parts when a work order is updated
CREATE TRIGGER RecordPartUsage
ON WorkOrderParts
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO PartsUsageLog (WorkOrderID, PartID, QuantityUsed, DateUsed)
    SELECT inserted.WorkOrderID, inserted.PartID, inserted.Quantity, GETDATE()
    FROM inserted;
END;
GO

-- Trigger to check inventory levels and alert if below threshold
CREATE TRIGGER CheckInventoryLevels
ON Parts
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (SELECT PartPrice FROM inserted) < 10 -- Example threshold value
    BEGIN
        DECLARE @PartID INT;
        SELECT @PartID = PartID FROM inserted;
        RAISERROR ('Alert: Inventory levels for part %d have fallen below the threshold.', 16, 1, @PartID);
    END
END;
GO

-- Trigger to validate vehicle ownership when creating an appointment
CREATE TRIGGER ValidateVehicleOwnership
ON Appointment
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (
        SELECT 1
        FROM Vehicle
        WHERE VehicleID IN (SELECT DISTINCT VehicleID FROM inserted)
          AND CustomerID IN (SELECT DISTINCT CustomerID FROM inserted)
    )
    BEGIN
        RAISERROR ('Invalid appointment creation: Vehicle does not belong to the customer.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
