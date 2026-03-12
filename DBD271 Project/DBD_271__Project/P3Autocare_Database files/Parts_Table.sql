USE P3AutoCare

CREATE TABLE Parts(
[PartID] int identity(1,1) PRIMARY KEY,
[PartName] varchar(75) not null,
[PartManufacturer] varchar(50) not null,
[PartPrice] money not null)