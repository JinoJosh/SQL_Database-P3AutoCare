-- SQL Script for P3AutoCare Database

-- List of Tables with Descriptions
SELECT 'Customers' AS P3AutoCare_TABLE_LIST, 'Contains customer information including contact details and preferences.' AS P3AutoCare_TABLE_LIST_DESCRIPTION
UNION ALL
SELECT 'Vehicle', 'Stores information about customer vehicles, including make, model, and year.'
UNION ALL
SELECT 'Service', 'Details the services provided, including descriptions and costs.'
UNION ALL
SELECT 'Employee', 'Holds employee information such as names, roles, and contact details.'
UNION ALL
SELECT 'Appointment', 'Tracks appointments including dates, services to be performed, and assigned employees.'
UNION ALL
SELECT 'Parts', 'Inventory of parts with details like name, manufacturer, and price.'
UNION ALL
SELECT 'WorkOrder', 'Records of work orders detailing services performed on vehicles.'
UNION ALL
SELECT 'WorkOrderParts', 'Associates parts with work orders, including quantities used.'
UNION ALL
SELECT 'WorkOrderService', 'Links services to work orders, indicating what services were performed.';

-- List of Stored Procedures with Descriptions
SELECT 'CalculateTotalCost' AS P3AutoCare_PROCEDURE, 'Calculates the total cost of services rendered for a work order.' AS P3AutoCare_PROCEDURE_DESCRIPTION
UNION ALL
SELECT 'UpdateAppointmentStatus', 'Updates the status of appointments to reflect completion or cancellation.' AS  P3AutoCare_PROCEDURE_DESCRIPTION
UNION ALL
SELECT 'GetAvailableParts', 'Retrieves a list of parts that are currently available in inventory, including quantities.' AS  P3AutoCare_PROCEDURE_DESCRIPTION
UNION ALL
SELECT 'ScheduleService', 'Schedules a new service appointment for a customer, assigning employees and estimating duration.' AS  P3AutoCare_PROCEDURE_DESCRIPTION
UNION ALL
SELECT 'RecordServiceCompletion', 'Records the completion of a service, updating the work order and vehicle service history.' AS  P3AutoCare_PROCEDURE_DESCRIPTION;

-- List of Views with Descriptions
SELECT 'AppointmentSummary' AS P3AutoCare_VIEW, 'Provides a summary of customer appointments, including service details and status.' AS P3AutoCare_VIEW_DESCRIPTION
UNION ALL
SELECT 'WorkOrderSummary', 'Displays a summary of work orders, including vehicle details and services performed.' AS P3AutoCare_VIEW_DESCRIPTION
UNION ALL
SELECT 'CustomerVehicles', 'Lists all vehicles owned by each customer, including registration details.' AS P3AutoCare_VIEW_DESCRIPTION
UNION ALL
SELECT 'EmployeeSchedules', 'Shows the upcoming schedule for each employee, including appointments and availability.' AS P3AutoCare_VIEW_DESCRIPTION
UNION ALL
SELECT 'ServiceHistory', 'Provides a complete history of services for each vehicle, including dates and service types.' AS P3AutoCare_VIEW_DESCRIPTION;

-- List of Triggers with Descriptions
SELECT 'UpdateInventoryCount' AS P3AutoCare_TRIGGER, 'Automatically updates the inventory count after a part is used in a service.' AS P3AutoCare_TRIGGER_DESCRIPTION
UNION ALL
SELECT 'AutoAssignEmployee', 'Automatically assigns an employee to new appointments based on availability and expertise.' AS P3AutoCare_TRIGGER_DESCRIPTION
UNION ALL
SELECT 'RecordPartUsage', 'Logs the usage of parts when a work order is updated, for inventory tracking.' AS P3AutoCare_TRIGGER_DESCRIPTION
UNION ALL
SELECT 'CheckInventoryLevels', 'Checks and alerts if inventory levels for any part fall below a specified threshold.' AS P3AutoCare_TRIGGER_DESCRIPTION
UNION ALL
SELECT 'ValidateVehicleOwnership', 'Ensures that the vehicle is owned by the customer when creating an appointment, for data integrity.' AS P3AutoCare_TRIGGER_DESCRIPTION;

