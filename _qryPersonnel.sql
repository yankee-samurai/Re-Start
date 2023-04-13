--sczsq31.co.santa-cruz.ca.us
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

  where 
	LEFT([EmpIndex],2) in ('42','43')
	AND StatusCode = '1'