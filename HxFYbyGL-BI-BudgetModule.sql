:CONNECT sczsq26.co.santa-cruz.ca.us

DECLARE @CurrFY as INT
DECLARE @Parm1 AS VARCHAR(2)
DECLARE @Parm2 AS VARCHAR(2)

SET @CurrFY = 
	CASE	
		WHEN MONTH(GETDATE()) > 6 THEN YEAR(GETDATE())+1
		ELSE YEAR(GETDATE())
	END
SET @Parm1 = 'EX'
SET @Parm2 = 'RV'

USE [county_of_santa_cruz_budget_rpt]
;
WITH X AS

(SELECT 
	GLKey
	,Object
	,ROUND(
		SUM(
			CASE WHEN FiscalYear = (@CurrFY - 7) AND AmountType = 'Allowed'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY-7 Allowed'

		,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY - 6 AND AmountType = 'Allowed'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY-6 Allowed'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY - 5 AND AmountType = 'Allowed'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY-5 Allowed'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY - 4 AND AmountType = 'Allowed'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY-4 Allowed'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY - 3 AND AmountType = 'Allowed'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY-3 Allowed'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY - 2 AND AmountType = 'Allowed'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY-2 Allowed'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY - 1 AND AmountType = 'Allowed'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY-1 Allowed'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY AND AmountType = 'Allowed'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY Allowed'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY AND AmountType = 'Adjusted'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY Adjusted'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY + 1 AND AmountType IN ('Requested', 'Recommended', 'Projected')
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY+1 Recommended'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY + 2 AND AmountType = 'Projected'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY+2 Projected'

FROM BudgetDetails

WHERE GLKey IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
	GLKey
	,Object
)
,
BUDGETEX AS

(SELECT 
		--*
		@CurrFY AS FY
		,GLKey
		,@Parm1 AS Type
		,-SUM([FY-7 Allowed]) AS [FY-7 Allowed]
		,-SUM([FY-6 Allowed]) AS [FY-6 Allowed]
		,-SUM([FY-5 Allowed]) AS [FY-5 Allowed]
		,-SUM([FY-4 Allowed]) AS [FY-4 Allowed]
		,-SUM([FY-3 Allowed]) AS [FY-3 Allowed]
		,-SUM([FY-2 Allowed]) AS [FY-2 Allowed]
		,-SUM([FY-1 Allowed]) AS [FY-1 Allowed]
		,-SUM([FY Allowed]) AS [FY Allowed]
		,-SUM([FY+1 Recommended]) AS [FY+1 Recommended]
		,-SUM([FY+2 Projected]) AS [FY+2 Projected]
			
	FROM X

	WHERE Object NOT IN ('40175', '40178', '40440', '41163', '41164', '41232', '42010', '42022', '42042', '42050', '42100', '42105',
						'42112', '42123', '42124', '42131', '42132', '42133', '42134', '42135', '42136', '42137', '42332', '42375',
						'42380', '42384', '42462', '42465', '42473', '42474', '42928', '90000', '91010', '95190', '95220', '95254',
						'95387', '95550', '98705')
	GROUP BY 
		GLKey
)
,
BUDGETRV AS

(SELECT 
		--*
		@CurrFY AS FY
		,GLKey
		,@Parm2 AS Type
		,SUM([FY-7 Allowed]) AS [FY-7 Allowed]
		,SUM([FY-6 Allowed]) AS [FY-6 Allowed]
		,SUM([FY-5 Allowed]) AS [FY-5 Allowed]
		,SUM([FY-4 Allowed]) AS [FY-4 Allowed]
		,SUM([FY-3 Allowed]) AS [FY-3 Allowed]
		,SUM([FY-2 Allowed]) AS [FY-2 Allowed]
		,SUM([FY-1 Allowed]) AS [FY-1 Allowed]
		,SUM([FY Allowed]) AS [FY Allowed]
		,SUM([FY+1 Recommended]) AS [FY+1 Recommended]
		,SUM([FY+2 Projected]) AS [FY+2 Projected]
			
	FROM X

	WHERE Object IN ('40175', '40178', '40440', '41163', '41164', '41232', '42010', '42022', '42042', '42050', '42100', '42105',
						'42112', '42123', '42124', '42131', '42132', '42133', '42134', '42135', '42136', '42137', '42332', '42375',
						'42380', '42384', '42462', '42465', '42473', '42474', '42928')
	GROUP BY 
		GLKey
	)
,
BUDGETXF AS

(SELECT 
		--*
		@CurrFY AS FY
		,GLKey
		,@Parm2 AS Type
		,-SUM([FY-7 Allowed]) AS [FY-7 Allowed]
		,-SUM([FY-6 Allowed]) AS [FY-6 Allowed]
		,-SUM([FY-5 Allowed]) AS [FY-5 Allowed]
		,-SUM([FY-4 Allowed]) AS [FY-4 Allowed]
		,-SUM([FY-3 Allowed]) AS [FY-3 Allowed]
		,-SUM([FY-2 Allowed]) AS [FY-2 Allowed]
		,-SUM([FY-1 Allowed]) AS [FY-1 Allowed]
		,-SUM([FY Allowed]) AS [FY Allowed]
		,-SUM([FY+1 Recommended]) AS [FY+1 Recommended]
		,-SUM([FY+2 Projected]) AS [FY+2 Projected]
			
	FROM X

	WHERE Object IN ('90000', '91010', '95190', '95220', '95254', '95387', '95550', '98705')

	GROUP BY 
		GLKey
	)

SELECT *

FROM BUDGETEX

UNION SELECT 
	A.FY AS FY
	,A.GLKey AS GlKey
	,A.Type AS Type
	,SUM(A.[FY-7 Allowed] + CASE WHEN B.[FY-7 Allowed] IS NULL THEN 0 ELSE B.[FY-7 Allowed] END)
	,SUM(A.[FY-6 Allowed] + CASE WHEN B.[FY-6 Allowed] IS NULL THEN 0 ELSE B.[FY-6 Allowed] END)
	,SUM(A.[FY-5 Allowed] + CASE WHEN B.[FY-5 Allowed] IS NULL THEN 0 ELSE B.[FY-5 Allowed] END)
	,SUM(A.[FY-4 Allowed] + CASE WHEN B.[FY-4 Allowed] IS NULL THEN 0  ELSE B.[FY-4 Allowed] END)
	,SUM(A.[FY-3 Allowed] + CASE WHEN B.[FY-3 Allowed] IS NULL THEN 0 ELSE B.[FY-3 Allowed] END)
	,SUM(A.[FY-2 Allowed] + CASE WHEN B.[FY-2 Allowed] IS NULL THEN 0 ELSE B.[FY-2 Allowed] END)
	,SUM(A.[FY-1 Allowed] + CASE WHEN B.[FY-1 Allowed] IS NULL THEN 0 ELSE B.[FY-1 Allowed] END)
	,SUM(A.[FY Allowed] + CASE WHEN B.[FY Allowed] IS NULL THEN 0 ELSE B.[FY Allowed] END)
	,SUM(A.[FY+1 Recommended] + CASE WHEN B.[FY+1 Recommended] IS NULL THEN 0 ELSE B.[FY+1 Recommended] END)
	,SUM(A.[FY+2 Projected] + CASE WHEN B.[FY+2 Projected] IS NULL THEN 0 ELSE B.[FY+2 Projected] END)

FROM BUDGETRV AS A

LEFT JOIN 
BUDGETXF AS B
	ON A.FY = B.FY
	AND A.GLKey = B.GLKey
	AND A.Type = B.Type

GROUP BY
	A.FY
	,A.GLKey
	,A.Type

ORDER BY
	GLKey
	--,Object