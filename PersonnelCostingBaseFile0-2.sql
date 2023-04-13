USE Payroll2	

;

WITH BS AS
	(SELECT DISTINCT 
		R.BenStat
		,CONCAT(R.JobClass, R.PosNo) AS Ind1
	FROM EmpStatus AS R
	INNER JOIN Position AS Q
		ON Q.JobClass = R.JobClass
		AND Q.PosNo = R.PosNo
	)
	
SELECT 
	CASE
		WHEN D.EmpIndex IS NULL THEN CONCAT(A.Dept, A.Div, A.Sec)
		ELSE D.EmpIndex
	END AS 'GL Key'
	,A.Dept
	,CASE
		WHEN (D.LastName IS NULL AND D.FirstName IS NULL) THEN ''
		ELSE CONCAT(D.LastName,', ',D.FirstName,' ',LEFT(D.MiddleName,1)) 
	END AS Name
	,CASE
		WHEN C.BenStatName IS NULL THEN ''
		ELSE  C.BenStatName
	END AS 'Benefits Status'
	,CASE
		WHEN D.BenStat IS NULL THEN I.BenStat
		ELSE D.BenStat
	END AS 'B/S'
	,D.BenStat
	,CASE
		WHEN C.BenStatName IS NULL THEN CONCAT(A.JobClass, A.PosNo, 'A', A.PosStatus)
		ELSE CONCAT(A.JobClass, A.PosNo, D.JobClassSfx, D.PosStatus)
	END AS 'Position Code'
	,E.JobClassDesc
	,D.Range
	,D.StepNo AS Step
	,D.PctFullTime AS FTE
	,D.PayRateYearly
	,D.EmpNo
	--,A.Div
	--,A.Sec
	,A.JobClass
	,A.PosNo
	,A.Funded
	,A.PosStatus
	--,A.HireDate
	--,B.ApptEffectiveDate

	--,A.LoaReasonActionCode AS 'LOA CD'
	--,G.ActionCodeDesc AS 'LOA Reason'
	--,CASE	
	--	WHEN A.LoaDateBeg != '1900-01-01' THEN A.LoaDateBeg
	--	ELSE NULL
	--END AS 'LOA Begin Date'	
	--,CASE	
	--	WHEN A.LoaDateEnd != '1900-01-01' THEN A.LoaDateEnd
	--	ELSE NULL
	--END AS 'LOA End Date'	
	,D.SeparationActionCode AS 'Sep CD'
	,F.ActionCodeDesc AS 'Separation Reason'
	--,A.PersonnelActionCodeDate
	,D.PayRateBiWeekly
	,D.PayRateHourly
	,B.Tier
	,H.StepHours
	,H.ServiceHrs
	,D.DiffLongevity
	,D.DiffCareer
	,D.DiffMisc
	,D.DiffMisc2
	,A.PosSchedHrsCode
	--,I.MonthlyAmt
	,A.Funded
	,A.Confidential
	,A.Comment
	
FROM Position  AS A	
	

LEFT JOIN EmpStatus AS D
	ON A.Dept = D.Dept
	--AND A.Div = D.Div
	--AND A.Sec = D.Sec
	AND A.JobClass = D.JobClass
	AND A.PosNo = D.PosNo
	--AND D.Dept IN ('42' ,'43')

LEFT JOIN CalPERSEmpInfo AS B	
	ON D.EmpNo = B.EmpNo
	
LEFT JOIN BenefitStatus AS C	
	ON D.BenStat = C.BenStat

	LEFT JOIN JobClass AS E	
	ON A.JobClass = E.JobClass
	
LEFT JOIN ActionCode AS F	
	ON D.SeparationActionCode = F.ActionCode
	
LEFT JOIN ActionCode AS G	
	ON D.LoaReasonActionCode = G.ActionCode

LEFT JOIN EmpTotals AS H
	ON D.EmpNo = H.EmpNo

LEFT JOIN BS AS I
	ON I.Ind1 = CONCAT(A.JobClass,A.PosNo)
		
WHERE	
	--A.Dept IN ('42', '43')
	--AND 
	D.BenStat IS NOT NULL
	
ORDER BY	
	D.EmpIndex
	,D.Range
	,A.PosNo
