USE P3AutoCare

CREATE TABLE Appointment(
[AppointmentID] int identity(1,1) PRIMARY KEY,
[AppointmentDate] Date not null,
[AppointmentDescription] varchar(500) not null,
[VehicleID] int, 
[EmployeeID] int,
FOREIGN KEY ([VehicleID]) REFERENCES [Vehicle]([VehicleID]), 
FOREIGN KEY ([EmployeeID]) REFERENCES [Employee]([EmployeeID]))