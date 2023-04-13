SELECT [EmpNo]
      ,[EmpIndex]
      ,[BenStat]
      ,[LastName]
      ,[FirstName]
      ,[MiddleName]
      ,[FirstInit]
      ,[MiddleInit]
      ,[Suffix]
      ,[StatusCode]
      ,[OriginalHireDate]
      
  FROM [Payroll2].[dbo].[EmpKey] 

  where LEFT([EmpIndex],2) in ('42','43')