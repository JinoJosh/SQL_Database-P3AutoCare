USE P3AutoCare

CREATE TABLE Vehicle(
[VehicleID] int identity(1,1) PRIMARY KEY,
[CarMake] varchar(50) not null,
[CarModel] varchar(50) not null,
[Year] Date not null,
[Color] varchar(50) not null,
[CustomerID] int,
FOREIGN KEY ([CustomerID]) REFERENCES [Customers]([CustomerID]))