USE P3AutoCare

CREATE TABLE WorkOrderParts(
[WorkOrderID] int,
[PartID] int,
[Quantity] int, 
PRIMARY KEY(WorkOrderID, PartID),
FOREIGN KEY ([WorkOrderID]) REFERENCES [WorkOrder]([WorkOrderID]),
FOREIGN KEY ([PartID]) REFERENCES [Parts]([PartID]))