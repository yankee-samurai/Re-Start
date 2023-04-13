USE Payroll2
SELECT
	A.EmpNo
	,A.EmpIndex
	,A.BenStat
	,A.LastName
	,A.FirstName
	,A.JobClass
	,A.PosNo
	,A.JobClassSfx
	,A.PosStatus
	,A.Range
	,A.StepNo
	,B.ServiceHrs
	,B.StepHours
	,B.VacationBal
	,B.SickLeaveBal
	,B.AdminLeaveBal
	,B.CompTimeBal

FROM EmpStatus AS A

INNER JOIN EmpTotals AS B
	ON A.EmpNo = B.EmpNo

WHERE 
A.Dept in ('42', '43')