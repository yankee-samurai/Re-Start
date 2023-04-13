--sczsq31.co.santa-cruz.ca.us

;
WITH X AS
	(SELECT 
		[ChkStmtDetail_Archive].EmpNo
		,CASE	
			WHEN MONTH([PayDate]) > 6 THEN YEAR([PayDate]) + 1
			ELSE YEAR([PayDate])
		END AS FY
		--,[PayDate]
		--,[SeqNo]
		--,[LineNum]
		,[DataGroup]
		,[EmpHrs]
		,[EmpCur]
		,[CoCur]
		,[ChkDesc]
		--,[Misc]
		--,[WarrantCtr]

	FROM [Payroll2].[dbo].[ChkStmtDetail_Archive]

	LEFT JOIN [Payroll2].[dbo].[EmpKey] employee 
	ON employee.EmpNo = [ChkStmtDetail_Archive].EmpNo 

	WHERE 
		LEFT(Employee.EmpIndex,2) IN ('42','43')  
		AND PayDate > '2015' 
		--AND [DataGroup] not in('10','40','60','70')
		--AND [ChkStmtDetail_Archive].EmpNo = '013636'
	)

SELECT 
	EmpNo
	,FY
	--,PayDate
    --,[SeqNo]
    --,[LineNum]
     ,[DataGroup]
     ,SUM([EmpHrs]) AS Hours
     ,SUM([EmpCur]) AS Emp
     ,SUM([CoCur]) AS County
     ,[ChkDesc]
      --,[Misc]
      --,[WarrantCtr]

  FROM X

GROUP BY
	EmpNo
	,FY
	--,[PayDate]
	,[DataGroup]
	,[ChkDesc]

ORDER BY
	EmpNo
	,FY
	--,[PayDate]
	,[DataGroup]
	,[ChkDesc]


--SELECT DISTINCT [ChkDesc] FROM [Payroll2].[dbo].[ChkStmtDetail_Archive] WHERE [CoCur] != 0 AND [DataGroup] = '50'