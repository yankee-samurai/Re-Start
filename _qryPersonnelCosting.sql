--sczsq31.co.santa-cruz.ca.us
SELECT distinct [ChkStmtDetail_Archive].EmpNo
      ,[PayDate]
      ,[SeqNo]
      ,[LineNum]
      ,[DataGroup]
      ,[EmpHrs]
      ,[EmpCur]
      ,[CoCur]
      ,[ChkDesc]
      ,[Misc]
      ,[WarrantCtr]
  FROM [Payroll2].[dbo].[ChkStmtDetail_Archive]

  LEFT JOIN [Payroll2].[dbo].[EmpKey] employee 
  on employee.EmpNo = [ChkStmtDetail_Archive].EmpNo 

  Where Left(Employee.EmpIndex,2) in('42','43')  and PayDate > '2015' and 
  [DataGroup] not in('10','40','60','70')