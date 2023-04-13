USE [Production_finance]

DECLARE @CurrFY AS INT

SET @CurrFY = 
	CASE	
		WHEN MONTH(GETDATE()) > 6 THEN YEAR(GETDATE())
		ELSE YEAR(GETDATE())-1
	END
;
WITH X AS

	(SELECT 
		GLKey
		,Object

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-8 AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-08ALW'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-8 AND AmountType = 'Adjusted'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY-08ADJ'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-7 AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-07ALW'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-7 AND AmountType = 'Adjusted'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY-07ADJ'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-6 AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-06ALW'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-6 AND AmountType = 'Adjusted'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY-06ADJ'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-5 AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-05ALW'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-5 AND AmountType = 'Adjusted'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY-05ADJ'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-4 AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-04ALW'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-4 AND AmountType = 'Adjusted'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY-04ADJ'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-3 AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-03ALW'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-3 AND AmountType = 'Adjusted'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY-03ADJ'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-2 AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-02ALW'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-2 AND AmountType = 'Adjusted'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY-02ADJ'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-1 AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-01ALW'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY-1 AND AmountType = 'Adjusted'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY-01ADJ'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = @CurrFY AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'CURRFYALW'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = @CurrFY AND AmountType = 'Adjusted'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'CURRFYADJ'

FROM [SCZSQ26].[county_of_santa_cruz_budget_rpt].[dbo].[BudgetDetails]
  
WHERE 
	FiscalYear > @CurrFY - 10
	AND GLKey IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
		GLKey
		,Object
),

Y01 AS
	(SELECT 
		glt_gl_key
		,glt_gl_obj
		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 8 AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-08M01'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 7 AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-07M01'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 6 AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-06M01'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 5 AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-05M01'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 4 AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-04M01'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 3 AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-03M01'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 2 AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-02M01'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 1 AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-01M01'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY AND glt_gl_pr = 1
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'CurrFYM01'

FROM [glt_trns_dtl]

WHERE glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
		glt_gl_key
		,glt_gl_obj

	),

Y02 AS
	(SELECT 
		glt_gl_key
		,glt_gl_obj
		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 8 AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-08M02'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 7 AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-07M02'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 6 AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-06M02'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 5 AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-05M02'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 4 AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-04M02'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 3 AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-03M02'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 2 AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-02M02'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 1 AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-01M02'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY AND glt_gl_pr = 2
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'CurrFYM02'

FROM [glt_trns_dtl]

WHERE glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
		glt_gl_key
		,glt_gl_obj

	),

Y03 AS
	(SELECT 
		glt_gl_key
		,glt_gl_obj
		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 8 AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-08M03'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 7 AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-07M03'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 6 AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-06M03'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 5 AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-05M03'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 4 AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-04M03'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 3 AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-03M03'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 2 AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-02M03'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 1 AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-01M03'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY AND glt_gl_pr = 3
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'CurrFYM03'

FROM [glt_trns_dtl]

WHERE glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
		glt_gl_key
		,glt_gl_obj

	),

Y04 AS
	(SELECT 
		glt_gl_key
		,glt_gl_obj
		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 8 AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-08M04'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 7 AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-07M04'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 6 AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-06M04'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 5 AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-05M04'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 4 AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-04M04'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 3 AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-03M04'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 2 AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-02M04'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 1 AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-01M04'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY AND glt_gl_pr = 4
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'CurrFYM04'

FROM [glt_trns_dtl]

WHERE glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
		glt_gl_key
		,glt_gl_obj

	),

Y05 AS
	(SELECT 
		glt_gl_key
		,glt_gl_obj
		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 8 AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-08M05'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 7 AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-07M05'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 6 AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-06M05'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 5 AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-05M05'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 4 AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-04M05'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 3 AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-03M05'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 2 AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-02M05'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 1 AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-01M05'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY AND glt_gl_pr = 5
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'CurrFYM05'

FROM [glt_trns_dtl]

WHERE glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
		glt_gl_key
		,glt_gl_obj

	),

Y06 AS
	(SELECT 
		glt_gl_key
		,glt_gl_obj
		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 8 AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-08M06'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 7 AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-07M06'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 6 AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-06M06'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 5 AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-05M06'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 4 AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-04M06'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 3 AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-03M06'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 2 AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-02M06'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY - 1 AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'FY-01M06'

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = @CurrFY AND glt_gl_pr = 6
					THEN glt_cr - glt_dr
					ELSE 0
				END
			),0
		) AS 'CurrFYM06'

FROM [glt_trns_dtl]

WHERE glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
		glt_gl_key
		,glt_gl_obj

	)

SELECT
	[X].[GLKey]
	,[X].[Object]
	,CASE 
		WHEN [X].[FY-08ALW] = 0 THEN 0
		ELSE [Y01].[FY-08M01]/[X].[FY-08ALW]
	END AS [FY-08M01]
	,CASE 
		WHEN [X].[FY-07ALW] = 0 THEN 0
		ELSE [Y01].[FY-07M01]/[X].[FY-07ALW]
	END AS [FY-07M01]
FROM X
INNER JOIN [Y01]
	ON [X].[GLKey] = [Y01].[glt_gl_key]
	AND [X].[Object] = [Y01].[glt_gl_obj]
ORDER BY 
	GLKey
	,Object