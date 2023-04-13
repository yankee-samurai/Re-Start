:CONNECT sczsq26.co.santa-cruz.ca.us

USE [county_of_santa_cruz_budget_rpt]

SELECT 
	GLKey
	,Object
	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2014' AND AmountType = 'Actual'
				THEN (Amount)
				ELSE 0
			END
		),0
	) AS 'FY14 Actuals'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2015' AND AmountType = 'Actual'
				THEN (Amount)
				ELSE 0
			END
		),0
	) AS 'FY15 Actuals'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2016' AND AmountType = 'Actual'
				THEN (Amount)
				ELSE 0
			END
		),0
	) AS 'FY16 Actuals'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2017' AND AmountType = 'Actual'
				THEN (Amount)
				ELSE 0
			END
		),0
	) AS 'FY17 Actuals'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2018' AND AmountType = 'Actual'
				THEN (Amount)
				ELSE 0
			END
		),0
	) AS 'FY18 Actuals'

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
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY19 Adjusted'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2019' AND AmountType = 'Estimated'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY19 Estimated'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2020' AND AmountType = 'Requested'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY20 Requested'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2020' AND AmountType = 'Recommended'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY20 Recommended'

	,ROUND(
		SUM(
			CASE WHEN FiscalYear = '2021' AND AmountType = 'Projected'
				THEN Amount
				ELSE 0
			END
		),0
	) AS 'FY21 Projected'

	,(
		ROUND(
			SUM(
				CASE WHEN FiscalYear = '2020' AND AmountType = 'Recommended'
					THEN Amount
					ELSE 0
				END
			),0
		) 
		
	-
	
		ROUND(
			SUM(
				CASE WHEN FiscalYear = '2019' AND AmountType = 'Adjusted'
					THEN Amount
					ELSE 0
				END
			),0
		)
	) AS 'Change from Allowed'

	,(
		ROUND(
			SUM(
				CASE WHEN FiscalYear = '2020' AND AmountType = 'Recommended'
					THEN Amount
					ELSE 0
				END
			),0
		) 
		
	-
	
		ROUND(
			SUM(
				CASE WHEN FiscalYear = '2019' AND AmountType = 'Estimated'
					THEN Amount
					ELSE 0
				END
			),0
		)
	) AS 'Change from Estimated'

FROM BudgetDetails

WHERE GLKey IN ('421000', '422000', '423000', '424100', '424200', '424400', '424500', '431000')

GROUP BY
	GLKey
	,Object

ORDER BY
	GLKey
	,Object