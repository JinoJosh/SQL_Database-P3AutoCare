USE P3AutoCare

CREATE TABLE Customers(
 [CustomerID] int identity(1,1) PRIMARY KEY,
 [CustomerFirstName] varchar(150) Not null,
 [CustomerLastName] varchar(150) not null,
 [Phone] int not null,
 [Email] varchar(320))



