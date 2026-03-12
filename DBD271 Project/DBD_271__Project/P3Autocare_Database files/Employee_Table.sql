USE P3AutoCare

CREATE TABLE Employee(
[EmployeeID] int identity(1,1) PRIMARY KEY,
[EmployeeFirstName] varchar(150) not null,
[EmployeeLastName] varchar(150) not null,
[Phone] int not null,
[Email] varchar(320),
[AppointmentID] int,
FOREIGN KEY ([AppointmentID]) References [Appointment]([AppointmentID]))