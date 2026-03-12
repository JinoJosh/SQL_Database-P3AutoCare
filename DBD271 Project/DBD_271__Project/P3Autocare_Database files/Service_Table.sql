USE P3AutoCare

CREATE TABLE Service(
[ServiceID] int identity(1,1) PRIMARY KEY,
[ServiceDescription] varchar(500) not null,
[ServiceCost] money not null)