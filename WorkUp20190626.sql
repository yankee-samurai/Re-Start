USE [Production_finance]

DECLARE @CurrFY AS INT
DECLARE @ISD AS VARCHAR(99)

SET @CurrFY = 
			CASE WHEN MONTH(GETDATE()) < 7
				THEN YEAR(GETDATE())
				ELSE YEAR(GETDATE())-1
			END
--SET @ISD = ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')
;
WITH X AS

	(SELECT
		[glt_gl_pr] AS FM
		,[glt_gl_key] AS GL
		,[glt_gl_obj] AS Obj
		,AVG([glt_dr]) AS EX5
		,AVG([glt_cr]) AS RV5
	
	FROM [dbo].[glt_trns_dtl]

	WHERE [glt_gl_fy] < @CurrFY
		AND [glt_gl_key] IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

	GROUP BY
		[glt_gl_pr]
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,Y AS

	(SELECT
		[glt_gl_pr] AS FM
		,[glt_gl_key] AS GL
		,[glt_gl_obj] AS Obj
		,SUM([glt_dr]) AS EXc
		,SUM([glt_cr]) AS RVc
	
	FROM [dbo].[glt_trns_dtl]

	WHERE [glt_gl_fy] = @CurrFY
		AND [glt_gl_key] IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')

	GROUP BY
		[glt_gl_pr]
		,[glt_gl_key]
		,[glt_gl_obj]
	)

SELECT 
	X.FM
	,X.GL
	,X.Obj
	,X.EX5
	,X.RV5
	,Y.EXc
	,Y.RVc

FROM X

INNER JOIN Y
	ON Y.FM = X.FM
	AND Y.GL = X.GL
	AND Y.Obj = X.Obj

ORDER BY
	X.FM,
	X.GL,
	X.Obj


