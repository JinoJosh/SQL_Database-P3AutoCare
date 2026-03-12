-- Table to store the names and descriptions of Tables
CREATE TABLE P3AutoCare_Tables_List (
    TableName VARCHAR(255),
    Description VARCHAR(MAX)
);

-- Table to store the names and descriptions of Stored Procedures
CREATE TABLE P3AutoCare_Procedures (
    ProcedureName VARCHAR(255),
    Description VARCHAR(MAX)
);

-- Table to store the names and descriptions of Views
CREATE TABLE P3AutoCare_Views (
    ViewName VARCHAR(255),
    Description VARCHAR(MAX)
);

-- Table to store the names and descriptions of Triggers
CREATE TABLE P3AutoCare_Triggers (
    TriggerName VARCHAR(255),
    Description VARCHAR(MAX)
);

-- Insert data into the Tables table
INSERT INTO P3AutoCare_Tables_List (TableName, Description) VALUES
('Customers', 'Contains customer information including contact details and preferences.'),
('Vehicle', 'Stores information about customer vehicles, including make, model, and year.'),
('Service', 'Details the services provided, including descriptions and costs.'),
('Employee', 'Holds employee information such as names, roles, and contact details.'),
('Appointment', 'Tracks appointments including dates, services to be performed, and assigned employees.'),
('Parts', 'Inventory of parts with details like name, manufacturer, and price.'),
('WorkOrder', 'Records of work orders detailing services performed on vehicles.'),
('WorkOrderParts', 'Associates parts with work orders, including quantities used.'),
('WorkOrderService', 'Links services to work orders, indicating what services were performed.');

-- Insert data into the Procedures table
INSERT INTO P3AutoCare_Procedures (ProcedureName, Description) VALUES
('CalculateTotalCost', 'Calculates the total cost of services rendered for a work order.'),
('UpdateAppointmentStatus', 'Updates the status of appointments to reflect completion or cancellation.'),
('GetAvailableParts', 'Retrieves a list of parts that are currently available in inventory, including quantities.'),
('ScheduleService', 'Schedules a new service appointment for a customer, assigning employees and estimating duration.'),
('RecordServiceCompletion', 'Records the completion of a service, updating the work order and vehicle service history.');

-- Insert data into the Views table
INSERT INTO P3AutoCare_Views (ViewName, Description) VALUES
('AppointmentSummary', 'Provides a summary of customer appointments, including service details and status.'),
('WorkOrderSummary', 'Displays a summary of work orders, including vehicle details and services performed.'),
('CustomerVehicles', 'Lists all vehicles owned by each customer, including registration details.'),
('EmployeeSchedules', 'Shows the upcoming schedule for each employee, including appointments and availability.'),
('ServiceHistory', 'Provides a complete history of services for each vehicle, including dates and service types.');

-- Insert data into the Triggers table
INSERT INTO P3AutoCare_Triggers (TriggerName, Description) VALUES
('UpdateInventoryCount', 'Automatically updates the inventory count after a part is used in a service.'),
('AutoAssignEmployee', 'Automatically assigns an employee to new appointments based on availability and expertise.'),
('RecordPartUsage', 'Logs the usage of parts when a work order is updated, for inventory tracking.'),
('CheckInventoryLevels', 'Checks and alerts if inventory levels for any part fall below a specified threshold.'),
('ValidateVehicleOwnership', 'Ensures that the vehicle is owned by the customer when creating an appointment, for data integrity.');

-- Select statements to verify the data
SELECT * FROM P3AutoCare_Tables_List;
SELECT * FROM P3AutoCare_Procedures;
SELECT * FROM P3AutoCare_Views;
SELECT * FROM P3AutoCare_Triggers;
