USE P3AutoCare

DECLARE @EmpID int;
DECLARE @Name varchar(50);

DECLARE Emp_Cursor CURSOR FOR
SELECT EmployeeID, EmployeeFirstName
FROM Employee

Open Emp_Cursor

Fetch next from Emp_Cursor Into @EmpID, @Name
While @@FETCH_STATUS = 0
Begin
	PRINT CAST(@EmpID as varchar)+ ' ' + @Name;
	Fetch next from Emp_Cursor INTO @EmpID, @Name;
End

Close Emp_Cursor
DEALLOCATE Emp_Cursor