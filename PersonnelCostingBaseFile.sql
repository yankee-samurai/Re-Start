USE Payroll2

SELECT 
	A.EmpIndex AS 'GL Key'
	,A.Dept
	,CONCAT(A.LastName,', ',A.FirstName,' ',LEFT(A.MiddleName,1)) AS Name
	,C.BenStatName
	,A.BenStat AS 'B/S'
	,CONCAT(A.JobClass,A.PosNo,A.JobClassSfx) AS 'Position Code'
	,E.JobClassDesc
	,A.Range
	,A.StepNo AS Step
	,A.PctFullTime AS FTE
	,A.PayRateYearly
	,A.EmpNo
	,A.Sec
	,A.PosNo
	--,A.HireDate
	--,B.ApptEffectiveDate
	,A.JobClass
	,A.LoaReasonActionCode AS 'LOA CD'
	,G.ActionCodeDesc AS 'LOA Reason'
	,CASE	
		WHEN A.LoaDateBeg != '1900-01-01' THEN A.LoaDateBeg
		ELSE NULL
	END AS 'LOA Begin Date'
	,CASE
		WHEN A.LoaDateEnd != '1900-01-01' THEN A.LoaDateEnd
		ELSE NULL
	END AS 'LOA End Date'
	,A.SeparationActionCode AS 'Sep CD'
	,F.ActionCodeDesc AS 'Separation Reason'
	,A.PersonnelActionCodeDate
	,A.PayRateBiWeekly
	,A.PayRateHourly
	,B.Tier

FROM EmpStatus AS A

INNER JOIN CalPERSEmpInfo AS B
	ON A.EmpNo = B.EmpNo

INNER JOIN BenefitStatus AS C
	ON A.BenStat = C.BenStat

LEFT JOIN JobClass AS E
	ON A.JobClass = E.JobClass

LEFT JOIN ActionCode AS F
	ON A.SeparationActionCode = F.ActionCode

LEFT JOIN ActionCode AS G
	ON A.LoaReasonActionCode = G.ActionCode

WHERE
	A.Dept IN ('42', '43')

ORDER BY
	A.EmpIndex
	,A.Range
	,A.PosNo



