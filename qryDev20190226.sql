USE [Production_finance]
;

WITH X AS

	(SELECT
		[glb_fy] AS FY
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS GLobj
		,CASE WHEN SUBSTRING([glb_ref],7,2) = 'LP'
			THEN [glb_amt]
			ELSE 0
		END AS 'Proposed'

	FROM [glb_batch_dtl] AS A

	INNER JOIN [glt_trns_dtl] AS B
		ON [glb_key] = [glt_gl_key]
		AND [glb_obj]  = [glt_gl_obj]
		AND [glb_fy] = '2019'

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000')
		AND [glt_gl_fy] >= '2019'
	)

,Y AS

	(SELECT
		[glb_fy] AS FY
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,CASE WHEN SUBSTRING([glb_ref],7,2) = 'LA'
			THEN [glb_amt]
			ELSE 0
		END AS 'Budgeted'

	FROM [glb_batch_dtl] AS A

	INNER JOIN [glt_trns_dtl] AS B
		ON [glb_key] = [glt_gl_key]
		AND [glb_obj]  = [glt_gl_obj]
		AND [glb_fy] = '2019'

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000')
		AND [glt_gl_fy] >= '2019'
	)

,Month1 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,SUM(CASE WHEN [glt_gl_pr] = '01'
			THEN [glt_dr]
			ELSE 0
		END) AS 'Jul'

	FROM [glt_trns_dtl]

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '01'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
	)

,Month6 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,SUM(CASE WHEN [glt_gl_pr] = '06'
			THEN [glt_dr] 
			ELSE 0
		END) AS 'Dec'

	FROM [glt_trns_dtl] 

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '06'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
	)

SELECT DISTINCT
	X.FY
	,X.GLkey
	,(X.Proposed) AS Proposed
	,(Y.Budgeted) AS Funded
	,(Month1.Jul) AS Jul
	,(Month6.Dec) AS Dec

FROM X

INNER JOIN Y
	ON X.FY = Y.FY
	AND X.GLkey = Y.GLkey

LEFT JOIN Month1
	ON Month1.FY = X.FY
	AND Month1.GLkey = X.GLkey

LEFT JOIN Month6
	ON Month6.FY = X.FY
	AND Month6.GLkey = X.GLkey

WHERE 
	X.GLkey IN ('190500') --, '421000', '422000')
	AND X.FY >= '2019'

--GROUP BY
--	Budget.FY
--	,Budget.GLkey
----	--,(Budget.Proposed)
----	--,(Budget.Budgeted)
--	,(Month1.Jul)
--	,(Month6.Dec)


