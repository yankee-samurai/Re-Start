USE [Production_finance]

DECLARE @CurrFY AS INT

SET @CurrFY = 
	CASE	
		WHEN MONTH(GETDATE()) > 6 THEN YEAR(GETDATE())+1
		ELSE YEAR(GETDATE())
	END

SELECT 
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

ORDER BY
	glt_gl_key
	,glt_gl_obj

--USE production_finance SELECT TOP 1000 * FROM glt_trns_dtl WHERE glt_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')