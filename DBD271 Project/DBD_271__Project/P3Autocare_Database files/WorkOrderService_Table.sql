USE P3AutoCare

CREATE TABLE WorkOrderService(
[WorkOrderID] int,
[ServiceID] int,
PRIMARY KEY(WorkOrderID, ServiceID),
FOREIGN KEY ([WorkOrderID]) REFERENCES [WorkOrder]([WorkOrderID]),
FOREIGN KEY ([ServiceID]) REFERENCES [Service]([ServiceID]))