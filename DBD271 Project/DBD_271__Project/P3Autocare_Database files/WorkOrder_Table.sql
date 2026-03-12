USE P3AutoCare

CREATE TABLE WorkOrder(
[WorkOrderID] int identity(1,1) PRIMARY KEY,
[DateRecieved] Date not null,
[EstimatedCompletionTime] Date not null,
[Status] varchar(50) not null,
[VehicleID] int,
FOREIGN KEY ([VehicleID]) REFERENCES [Vehicle]([VehicleID]))