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
  
WHERE FiscalYear > 2008
	AND GLKey IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

GROUP BY
		GLKey
		,Object
),

Y AS
	(SELECT
		glt_gl_key
		,glt_gl_obj
		,CASE WHEN glt_gl_pr = 1 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [01JulAct]
		,CASE WHEN glt_gl_pr = 2 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [02AugAct]
		,CASE WHEN glt_gl_pr = 3 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [03SepAct]
		,CASE WHEN glt_gl_pr = 4 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [04OctAct]
		,CASE WHEN glt_gl_pr = 5 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [05NovAct]
		,CASE WHEN glt_gl_pr = 6 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [06DecAct]
		,CASE WHEN glt_gl_pr = 7 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [07JanAct]
		,CASE WHEN glt_gl_pr = 8 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [08FebAct]
		,CASE WHEN glt_gl_pr = 9 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [09MarAct]
		,CASE WHEN glt_gl_pr = 10 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [10AprAct]
		,CASE WHEN glt_gl_pr = 11 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [11MayAct]
		,CASE WHEN glt_gl_pr = 12 
			THEN SUM(glt_cr - glt_dr)
			ELSE 0
		END AS [12JunAct]

	FROM glt_trns_dtl

	WHERE
		glt_gl_fy = @CurrFY
		AND glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

	GROUP BY
		glt_gl_key
		,glt_gl_obj
		,glt_gl_pr
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

	),

Z01 AS
	(SELECT 
		X.GLKey
		,X.Object
		,CASE WHEN [X].[FY-08ALW] = 0
			THEN 0
			ELSE [Y01].[FY-08M01]/[X].[FY-08ALW]
		END AS [FY-8]
		,CASE WHEN [X].[FY-07ALW] = 0
			THEN 0
			ELSE [Y01].[FY-07M01]/[X].[FY-07ALW]
		END AS [FY-7]
		,CASE WHEN [X].[FY-06ALW] = 0
			THEN 0
			ELSE [Y01].[FY-06M01]/[X].[FY-06ALW]
		END AS [FY-6]
		,CASE WHEN [X].[FY-05ALW] = 0
			THEN 0
			ELSE [Y01].[FY-05M01]/[X].[FY-05ALW]
		END AS [FY-5]
		,CASE WHEN [X].[FY-04ALW] = 0
			THEN 0
			ELSE [Y01].[FY-04M01]/[X].[FY-04ALW]
		END AS [FY-4]
		,CASE WHEN [X].[FY-03ALW] = 0
			THEN 0
			ELSE [Y01].[FY-03M01]/[X].[FY-03ALW]
		END AS [FY-3]
		,CASE WHEN [X].[FY-02ALW] = 0
			THEN 0
			ELSE [Y01].[FY-02M01]/[X].[FY-02ALW]
		END AS [FY-2]
			,CASE WHEN [X].[FY-01ALW] = 0
			THEN 0
			ELSE [Y01].[FY-01M01]/[X].[FY-01ALW]
		END AS [FY-1]
	FROM X

	INNER JOIN Y01
		ON X.GLKey = Y01.glt_gl_key
		AND X.Object = Y01.glt_gl_obj
	),

Z02 AS
	(SELECT 
		X.GLKey
		,X.Object
		,CASE WHEN [X].[FY-08ALW] = 0
			THEN 0
			ELSE [Y02].[FY-08M02]/[X].[FY-08ALW]
		END AS [FY-8]
		,CASE WHEN [X].[FY-07ALW] = 0
			THEN 0
			ELSE [Y02].[FY-07M02]/[X].[FY-07ALW]
		END AS [FY-7]
		,CASE WHEN [X].[FY-06ALW] = 0
			THEN 0
			ELSE [Y02].[FY-06M02]/[X].[FY-06ALW]
		END AS [FY-6]
		,CASE WHEN [X].[FY-05ALW] = 0
			THEN 0
			ELSE [Y02].[FY-05M02]/[X].[FY-05ALW]
		END AS [FY-5]
		,CASE WHEN [X].[FY-04ALW] = 0
			THEN 0
			ELSE [Y02].[FY-04M02]/[X].[FY-04ALW]
		END AS [FY-4]
		,CASE WHEN [X].[FY-03ALW] = 0
			THEN 0
			ELSE [Y02].[FY-03M02]/[X].[FY-03ALW]
		END AS [FY-3]
		,CASE WHEN [X].[FY-02ALW] = 0
			THEN 0
			ELSE [Y02].[FY-02M02]/[X].[FY-02ALW]
		END AS [FY-2]
			,CASE WHEN [X].[FY-01ALW] = 0
			THEN 0
			ELSE [Y02].[FY-01M02]/[X].[FY-01ALW]
		END AS [FY-1]
	FROM X

	INNER JOIN Y02
		ON X.GLKey = Y02.glt_gl_key
		AND X.Object = Y02.glt_gl_obj
	),

Z03 AS
	(SELECT 
		X.GLKey
		,X.Object
		,CASE WHEN [X].[FY-08ALW] = 0
			THEN 0
			ELSE [Y03].[FY-08M03]/[X].[FY-08ALW]
		END AS [FY-8]
		,CASE WHEN [X].[FY-07ALW] = 0
			THEN 0
			ELSE [Y03].[FY-07M03]/[X].[FY-07ALW]
		END AS [FY-7]
		,CASE WHEN [X].[FY-06ALW] = 0
			THEN 0
			ELSE [Y03].[FY-06M03]/[X].[FY-06ALW]
		END AS [FY-6]
		,CASE WHEN [X].[FY-05ALW] = 0
			THEN 0
			ELSE [Y03].[FY-05M03]/[X].[FY-05ALW]
		END AS [FY-5]
		,CASE WHEN [X].[FY-04ALW] = 0
			THEN 0
			ELSE [Y03].[FY-04M03]/[X].[FY-04ALW]
		END AS [FY-4]
		,CASE WHEN [X].[FY-03ALW] = 0
			THEN 0
			ELSE [Y03].[FY-03M03]/[X].[FY-03ALW]
		END AS [FY-3]
		,CASE WHEN [X].[FY-02ALW] = 0
			THEN 0
			ELSE [Y03].[FY-02M03]/[X].[FY-02ALW]
		END AS [FY-2]
			,CASE WHEN [X].[FY-01ALW] = 0
			THEN 0
			ELSE [Y03].[FY-01M03]/[X].[FY-01ALW]
		END AS [FY-1]
	FROM X

	INNER JOIN Y03
		ON X.GLKey = Y03.glt_gl_key
		AND X.Object = Y03.glt_gl_obj
	),

Z04 AS
	(SELECT 
		X.GLKey
		,X.Object
		,CASE WHEN [X].[FY-08ALW] = 0
			THEN 0
			ELSE [Y04].[FY-08M04]/[X].[FY-08ALW]
		END AS [FY-8]
		,CASE WHEN [X].[FY-07ALW] = 0
			THEN 0
			ELSE [Y04].[FY-07M04]/[X].[FY-07ALW]
		END AS [FY-7]
		,CASE WHEN [X].[FY-06ALW] = 0
			THEN 0
			ELSE [Y04].[FY-06M04]/[X].[FY-06ALW]
		END AS [FY-6]
		,CASE WHEN [X].[FY-05ALW] = 0
			THEN 0
			ELSE [Y04].[FY-05M04]/[X].[FY-05ALW]
		END AS [FY-5]
		,CASE WHEN [X].[FY-04ALW] = 0
			THEN 0
			ELSE [Y04].[FY-04M04]/[X].[FY-04ALW]
		END AS [FY-4]
		,CASE WHEN [X].[FY-03ALW] = 0
			THEN 0
			ELSE [Y04].[FY-03M04]/[X].[FY-03ALW]
		END AS [FY-3]
		,CASE WHEN [X].[FY-02ALW] = 0
			THEN 0
			ELSE [Y04].[FY-02M04]/[X].[FY-02ALW]
		END AS [FY-2]
			,CASE WHEN [X].[FY-01ALW] = 0
			THEN 0
			ELSE [Y04].[FY-01M04]/[X].[FY-01ALW]
		END AS [FY-1]
	FROM X

	INNER JOIN Y04
		ON X.GLKey = Y04.glt_gl_key
		AND X.Object = Y04.glt_gl_obj
	),

Z05 AS
	(SELECT 
		X.GLKey
		,X.Object
		,CASE WHEN [X].[FY-08ALW] = 0
			THEN 0
			ELSE [Y05].[FY-08M05]/[X].[FY-08ALW]
		END AS [FY-8]
		,CASE WHEN [X].[FY-07ALW] = 0
			THEN 0
			ELSE [Y05].[FY-07M05]/[X].[FY-07ALW]
		END AS [FY-7]
		,CASE WHEN [X].[FY-06ALW] = 0
			THEN 0
			ELSE [Y05].[FY-06M05]/[X].[FY-06ALW]
		END AS [FY-6]
		,CASE WHEN [X].[FY-05ALW] = 0
			THEN 0
			ELSE [Y05].[FY-05M05]/[X].[FY-05ALW]
		END AS [FY-5]
		,CASE WHEN [X].[FY-04ALW] = 0
			THEN 0
			ELSE [Y05].[FY-04M05]/[X].[FY-04ALW]
		END AS [FY-4]
		,CASE WHEN [X].[FY-03ALW] = 0
			THEN 0
			ELSE [Y05].[FY-03M05]/[X].[FY-03ALW]
		END AS [FY-3]
		,CASE WHEN [X].[FY-02ALW] = 0
			THEN 0
			ELSE [Y05].[FY-02M05]/[X].[FY-02ALW]
		END AS [FY-2]
			,CASE WHEN [X].[FY-01ALW] = 0
			THEN 0
			ELSE [Y05].[FY-01M05]/[X].[FY-01ALW]
		END AS [FY-1]
	FROM X

	INNER JOIN Y05
		ON X.GLKey = Y05.glt_gl_key
		AND X.Object = Y05.glt_gl_obj
	),

Z06 AS
	(SELECT 
		X.GLKey
		,X.Object
		,CASE WHEN [X].[FY-08ALW] = 0
			THEN 0
			ELSE [Y06].[FY-08M06]/[X].[FY-08ALW]
		END AS [FY-8]
		,CASE WHEN [X].[FY-07ALW] = 0
			THEN 0
			ELSE [Y06].[FY-07M06]/[X].[FY-07ALW]
		END AS [FY-7]
		,CASE WHEN [X].[FY-06ALW] = 0
			THEN 0
			ELSE [Y06].[FY-06M06]/[X].[FY-06ALW]
		END AS [FY-6]
		,CASE WHEN [X].[FY-05ALW] = 0
			THEN 0
			ELSE [Y06].[FY-05M06]/[X].[FY-05ALW]
		END AS [FY-5]
		,CASE WHEN [X].[FY-04ALW] = 0
			THEN 0
			ELSE [Y06].[FY-04M06]/[X].[FY-04ALW]
		END AS [FY-4]
		,CASE WHEN [X].[FY-03ALW] = 0
			THEN 0
			ELSE [Y06].[FY-03M06]/[X].[FY-03ALW]
		END AS [FY-3]
		,CASE WHEN [X].[FY-02ALW] = 0
			THEN 0
			ELSE [Y06].[FY-02M06]/[X].[FY-02ALW]
		END AS [FY-2]
			,CASE WHEN [X].[FY-01ALW] = 0
			THEN 0
			ELSE [Y06].[FY-01M06]/[X].[FY-01ALW]
		END AS [FY-1]
	FROM X

	INNER JOIN Y06
		ON X.GLKey = Y06.glt_gl_key
		AND X.Object = Y06.glt_gl_obj
	)


SELECT 
	X.GLKey
	,X.Object
	,X.CURRFYALW
	,(([Z01].[FY-8] + [Z01].[FY-7] + [Z01].[FY-6] + [Z01].[FY-5] + [Z01].[FY-4] + [Z01].[FY-3] + [Z01].[FY-2] + [Z01].[FY-1])/8) * [X].[CurrFYALW] AS [01JulObg]
	,[Y].[01JulAct]
	,(([Z02].[FY-8] + [Z02].[FY-7] + [Z02].[FY-6] + [Z02].[FY-5] + [Z02].[FY-4] + [Z02].[FY-3] + [Z02].[FY-2] + [Z02].[FY-1])/8) * [X].[CurrFYALW] AS [02AugObg]	
	,[Y].[02AUgAct]
	,(([Z03].[FY-8] + [Z03].[FY-7] + [Z03].[FY-6] + [Z03].[FY-5] + [Z03].[FY-4] + [Z03].[FY-3] + [Z03].[FY-2] + [Z03].[FY-1])/8) * [X].[CurrFYALW] AS [03SepObg]	
	,[Y].[03SepAct]
	,(([Z04].[FY-8] + [Z04].[FY-7] + [Z04].[FY-6] + [Z04].[FY-5] + [Z04].[FY-4] + [Z04].[FY-3] + [Z04].[FY-2] + [Z04].[FY-1])/8) * [X].[CurrFYALW] AS [04OctObg]	
	,[Y].[04OctAct]
	,(([Z05].[FY-8] + [Z05].[FY-7] + [Z05].[FY-6] + [Z05].[FY-5] + [Z05].[FY-4] + [Z05].[FY-3] + [Z05].[FY-2] + [Z05].[FY-1])/8) * [X].[CurrFYALW] AS [05NovObg]	
	,[Y].[05NovAct]
	,(([Z06].[FY-8] + [Z06].[FY-7] + [Z06].[FY-6] + [Z06].[FY-5] + [Z06].[FY-4] + [Z06].[FY-3] + [Z06].[FY-2] + [Z06].[FY-1])/8) * [X].[CurrFYALW] AS [06DecObg]	
	,[Y].[06DecAct]


FROM X

LEFT JOIN Y
	ON [X].[GLKey] = [Y].[glt_gl_key]
	AND [X].[Object] = [Y].[glt_gl_obj]	

LEFT JOIN Z01
	ON [X].[GLKey] = [Z01].[GLKey]
	AND X.Object = Z01.Object

LEFT JOIN Z02
	ON [X].[GLKey] = [Z02].[GLKey]
	AND X.Object = Z02.Object

LEFT JOIN Z03
	ON [X].[GLKey] = [Z03].[GLKey]
	AND X.Object = Z03.Object

LEFT JOIN Z04
	ON [X].[GLKey] = [Z04].[GLKey]
	AND X.Object = Z04.Object

LEFT JOIN Z05
	ON [X].[GLKey] = [Z05].[GLKey]
	AND X.Object = Z05.Object

LEFT JOIN Z06
	ON [X].[GLKey] = [Z06].[GLKey]
	AND X.Object = Z06.Object


--USE [Production_finance] SELECT TOP 100 * FROM [dbo].[ar_trns_dtl]


