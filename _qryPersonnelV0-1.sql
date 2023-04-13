--:CONNECT sczsq31.co.santa-cruz.ca.us
SELECT *
--B.[JobClass],
--A.[EmpNo]
--      ,[EmpIndex]
--      ,A.[BenStat]
--      ,[LastName]
--      ,[FirstName]
--      ,[MiddleName]
--      ,[FirstInit]
--      ,[MiddleInit]
--      ,[Suffix]
--      ,[StatusCode]
--      ,[OriginalHireDate]
      
   FROM [Payroll2].[dbo].[EmpKey] AS A

  INNER JOIN [Payroll2].[dbo].[EmpHist] AS B
	ON A.EmpNo = B.EmpNo

  where 
	--B.[JobClass] IN ('DD1', 'DD2', 'DD3', 'DD4', 'HH1', 'HH2', 'HH3', 'HH4', 'TT1', 'TT2', 'TT3', 'TT4', 'TT6'
	--				,'UM2', 'UM3', 'UM4', 'UM5', 'UM6', 'UM8', 'UN4', 'UN5', 'UN6', 'UO2', 'UO3', 'GG1', 'GG2', 'GG3'
	--				,'NN1', 'NN2', 'NN3', 'NN4', 'UP3', 'UP7', 'UP8', 'UP9', 'UJ1', 'UJ3', 'UJ4', 'UJ5', 'UJ6', 'UU5', 'UU7'
	--				, 'CV3', 'CV7', 'XC5', 'XC7', 'UL1', 'UK7')
	StatusCode = '1'
	AND LEFT(EmpIndex,2) = '42'
	AND ModifiedON > 2019-01-01

	--GROUP BY
	--B.[JobClass],
	--A.[EmpNo]
 --     ,[EmpIndex]
 --     ,A.[BenStat]
 --     ,[LastName]
 --     ,[FirstName]
 --     ,[MiddleName]
 --     ,[FirstInit]
 --     ,[MiddleInit]
 --     ,[Suffix]
 --     ,[StatusCode]
 --     ,[OriginalHireDate]