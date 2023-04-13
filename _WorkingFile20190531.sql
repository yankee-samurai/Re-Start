:CONNECT sczsq23.co.santa-cruz.ca.us\onesolution
USE [Production_finance]
----,
--:CONNECT sczsq26.co.santa-cruz.ca.us
--USE [county_of_santa_cruz_budget_rpt]

EXEC sp_addlinkedserver 
	 @server = 'sczsq26.co.santa-cruz.ca.us'
	,@provider = 'SQLNCLI'

;

WITH X AS

	(SELECT 
		GLKey
		,Object
		,FiscalYear
		,ROUND(
			SUM(
				CASE WHEN FiscalYear = '2019' AND AmountType = 'Allowed'
					THEN Amount
					ELSE 0
				END
			),0
		) AS 'FY19 Allowed'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = '2019' AND AmountType = 'Adjusted'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY19 Adjusted'

		,ROUND(
			SUM(
				CASE WHEN FiscalYear = '2019' AND AmountType = 'Actual'
					THEN (Amount)
					ELSE 0
				END
			),0
		) AS 'FY19 Actuals'

	FROM [SQLNCLI].[county_of_santa_cruz_budget_rpt].[dbo].[BudgetDetails]

	WHERE 
		GLKey IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')
		AND FiscalYear = '2019'

	GROUP BY
		FiscalYear
		,GLKey
		,Object
	)

,Y AS

	(SELECT 
		[glt_gl_fy]
		--,[glt_gl_pr]
		,[glt_gl_key]
		,[glt_gl_obj]

		,ROUND(
			SUM(
				CASE WHEN glt_gl_fy = '2019' AND glt_gl_pr = '01'
					THEN Amount
					ELSE 0
				END
			),0
		) AS '201907'
	FROM [Production_finance].[dbo].[glt_trns_dtl]
    
	WHERE 
		[glt_gl_gr]= N'GL'
		AND SUBSTRING([glt_gl_key],1,2) IN (N'42', N'43')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_key] IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')
)

SELECT *

FROM X

INNER JOIN Y
	ON FiscalYear = Y.glt_gl_fy
	AND GLKey = Y.glt_gl_key
	AND Object = Y.glt_gl_obj

--GROUP BY
--	GLKey
--	,Obje

ORDER BY
	GLKey
	,Object