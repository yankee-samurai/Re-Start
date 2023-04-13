USE [Production_finance]

DECLARE @CurrFY AS INT

DECLARE @Tdist AS TABLE
	(
		DF INT
		,Parm FLOAT(8)
	)

DECLARE @Cal AS TABLE
	(
		FM INT
		,FiscMo VARCHAR(6)
	)

SET @CurrFY = 
	CASE	
		WHEN MONTH(GETDATE()) > 6 THEN YEAR(GETDATE())+1
		ELSE YEAR(GETDATE())
	END

INSERT INTO @Tdist
	SELECT       1, 12.706
	UNION SELECT 2, 4.303
	UNION SELECT 3, 3.182
	UNION SELECT 4, 2.776
	UNION SELECT 5, 2.571
	UNION SELECT 6, 2.447
	UNION SELECT 7, 2.365
	UNION SELECT 8, 2.306
	UNION SELECT 9, 2.262
	UNION SELECT 10, 2.228
	UNION SELECT 11, 2.201
	UNION SELECT 12, 2.179
	UNION SELECT 13, 2.160
	UNION SELECT 14, 2.145
	UNION SELECT 15, 2.131
	UNION SELECT 16, 2.120
	UNION SELECT 17, 2.110
	UNION SELECT 18, 2.101
	UNION SELECT 19, 2.093
	UNION SELECT 20, 2.086
	UNION SELECT 21, 2.080	
	UNION SELECT 22, 2.074
	UNION SELECT 23, 2.069
	UNION SELECT 24, 2.064
	UNION SELECT 25, 2.060
	UNION SELECT 26, 2.056
	UNION SELECT 27, 2.052
	UNION SELECT 28, 2.048
	UNION SELECT 29, 2.045
	UNION SELECT 30, 2.042

INSERT INTO @Cal
	SELECT 01, '01/Jul'
	UNION SELECT 02, '02/Aug'
	UNION SELECT 03, '03/Sep'
	UNION SELECT 04, '04/Oct'
	UNION SELECT 05, '05/Nov'
	UNION SELECT 06, '06/Dec'
	UNION SELECT 07, '07/Jan'
	UNION SELECT 08, '08/Feb'
	UNION SELECT 09, '09/Mar'
	UNION SELECT 10, '10/Apr'
	UNION SELECT 11, '11/May'
	UNION SELECT 12, '12/Jun'

;

WITH X AS

(SELECT 
	[A].[FiscalYear]
	,[A].[GLKey]
	,[B].[GLCategoryTitle]
	,[B].[Character]
	,[A].[Object]
	,[A].[AmountType]
	,SUM([A].[Amount]) AS Bud

FROM [SCZSQ26].[county_of_santa_cruz_budget_rpt].[dbo].[BudgetDetails] AS A

INNER JOIN [SCZSQ26].[county_of_santa_cruz_budget_rpt].[Reporting].[ObjectHierarchy] AS B
	ON [A].[Object] = B.[Object]

WHERE 
	[FiscalYear] > 2010
	AND [GLKey] IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')
	AND [AmountType] IN ('Allowed' , 'Adjusted')

GROUP BY
	[A].[FiscalYear]
	,[B].[GLCategoryTitle]
	,[A].[GLKey]
	,[B].[Character]
	,[A].[Object]
	,[A].[AmountType]

),

Y AS

(SELECT
	[A].[glt_gl_fy] AS FY
	,[A].[glt_gl_pr] AS FM
	,[X].[GLCategoryTitle] AS Cat
	,[A].[glt_gl_key] AS GL
	,[A].[glt_gl_obj] AS Obj
	,[X].[AmountType] AS Pos
	,[X].[Bud]
	,SUM([A].[glt_cr]) AS Cr
	,SUM([A].[glt_dr]) AS Dr
	,CASE
		WHEN [X].[Bud] = 0
			THEN 0
			ELSE SUM([A].[glt_cr])/[X].[Bud] 
		END AS CrProp
	,CASE
		WHEN [X].[Bud] = 0
			THEN 0
			ELSE SUM([A].[glt_dr])/[X].[Bud] 
		END AS DrProp


FROM [glt_trns_dtl] AS A

INNER JOIN X
	ON [X].[FiscalYear] = [A].[glt_gl_fy]
	AND [X].[GLKey] = [A].[glt_gl_key]
	AND [X].[Object] = [A].[glt_gl_obj]

GROUP BY 
	[A].[glt_gl_fy]
	,[A].[glt_gl_pr]
	,[X].[GLCategoryTitle]
	,[A].[glt_gl_key]
	,[A].[glt_gl_obj]
	,[X].[AmountType]
	,[X].[Bud]

),

Z AS

(SELECT 
	FM
	,Cat
	,GL
	,Obj
	,Pos
	,AVG(CrProp) AS CrProp
	,AVG(DrProp) AS DrProp

FROM Y

GROUP BY
	FM
	,Cat
	,GL
	,Obj
	,Pos

),

Zhi AS

(SELECT 
	FM
	,Cat
	,GL
	,Obj
	,Pos
	,COUNT(FY) AS N
	,AVG(CrProp) + (STDEV(CrProp) / SQRT(COUNT(CrProp)) * (SELECT Parm from @TDist WHERE DF = COUNT(FY))) AS CrPrHi
	,AVG(DrProp) + (STDEV(DrProp) / SQRT(COUNT(DrProp)) * (SELECT Parm from @TDist WHERE DF = COUNT(FY))) AS DrPrHi

FROM Y

GROUP BY
	FM
	,Cat
	,GL
	,Obj
	,Pos

)

SELECT 
	X.FiscalYear
	,U.FiscMo
	,Z.Cat
	,Z.GL
	,Z.Obj
	,Z.Pos
	,(Z.CrProp - Z.DrProp) * X.Bud AS ObgPlan
	,(Y.Cr - Y.Dr) AS Actual
	--,Zhi.N
	--,(Zhi.CrPrHi - Zhi.DrPrHi) * X.Bud AS ObgHi 

FROM Z

INNER JOIN @Cal AS U
	ON Z.FM = U.FM

LEFT JOIN X
	ON Z.GL = X.GLKey
	AND Z.Obj = X.Object
	AND Z.Pos = X.AmountType
	AND X.FiscalYear = @CurrFY

LEFT JOIN Y
	ON Y.FM = Z.FM
	AND Y.GL = Z.GL
	AND Y.Obj = Z.Obj
	AND Y.Pos = Z.Pos
	AND Y.FY = @CurrFY

--LEFT JOIN Zhi
--	ON Y.FM = Zhi.FM
--	AND Y.GL = Zhi.GL
--	AND Y.Obj = Zhi.Obj
--	AND Y.Pos = Zhi.Pos
--	AND Y.FY = @CurrFY

WHERE 
	X.FiscalYear is NOT NULL

--ORDER BY
	--[Z].[FM]
	--,[Z].[GL]
	--,[Z].[Cat]
	--,[Z].[Obj]
	--,[Z].[Pos]	
	
--USE [Production_finance]

--SELECT TOP 1000 *

--FROM glt_trns_dtl

--WHERE glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

