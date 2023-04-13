USE [Production_finance]
;

WITH 

X AS

	(SELECT DISTINCT 
		[glb_fy] AS FY
		,[glb_key] AS GLkey
		,[glb_obj] AS Object
		,[glb_amt] AS Proposed

	FROM [glb_batch_dtl] AS A

	WHERE 
		[glb_key] IN ('190500', '421000', '422000', '423000')
		AND [glb_fy] >= '2019'
		AND (SUBSTRING([glb_ref],7,2) = 'LP' OR LEFT([glb_ref], 2) = 'JA')
	)

,Y AS

	(SELECT DISTINCT 
		[glb_fy] AS FY
		,[glb_key] AS GLkey
		,[glb_obj] AS Object
		,[glb_amt] AS Funded

	FROM [glb_batch_dtl] AS A

	WHERE 
		[glb_key] IN ('190500', '421000', '422000', '423000')
		AND [glb_fy] >= '2019'
		AND (SUBSTRING([glb_ref],7,2) = 'LA')
	)

,Month1 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '01'
			THEN [glt_dr]
			ELSE 0
		END) AS 'Jul'

	FROM [glt_trns_dtl]

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '01'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,Month2 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '02'
			THEN [glt_dr]
			ELSE 0
		END) AS 'Aug'

	FROM [glt_trns_dtl]

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '02'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,Month3 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '03'
			THEN [glt_dr]
			ELSE 0
		END) AS 'Sep'

	FROM [glt_trns_dtl]

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '03'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,Month4 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '04'
			THEN [glt_dr]
			ELSE 0
		END) AS 'Oct'

	FROM [glt_trns_dtl]

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '04'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

	,Month5 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '05'
			THEN [glt_dr]
			ELSE 0
		END) AS 'Nov'

	FROM [glt_trns_dtl]

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '05'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,Month6 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '06'
			THEN [glt_dr] 
			ELSE 0
		END) AS 'Dec'

	FROM [glt_trns_dtl] 

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '06'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,Month7 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '07'
			THEN [glt_dr] 
			ELSE 0
		END) AS 'Jan'

	FROM [glt_trns_dtl] 

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '07'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,Month8 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '08'
			THEN [glt_dr] 
			ELSE 0
		END) AS 'Feb'

	FROM [glt_trns_dtl] 

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '08'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,Month9 AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '09'
			THEN [glt_dr] 
			ELSE 0
		END) AS 'Mar'

	FROM [glt_trns_dtl] 

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '09'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,MonthA AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '10'
			THEN [glt_dr] 
			ELSE 0
		END) AS 'Apr'

	FROM [glt_trns_dtl] 

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '10'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,MonthB AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '11'
			THEN [glt_dr] 
			ELSE 0
		END) AS 'May'

	FROM [glt_trns_dtl] 

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '11'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

,MonthC AS
	(SELECT
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS GLkey
		,[glt_gl_obj] AS Object
		,SUM(CASE WHEN [glt_gl_pr] = '12'
			THEN [glt_dr] 
			ELSE 0
		END) AS 'Jun'

	FROM [glt_trns_dtl] 

	WHERE 
		[glt_gl_key] IN ('190500', '421000', '422000', '423000')
		AND [glt_gl_fy] >= '2019'
		AND [glt_gl_pr] = '12'

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key]
		,[glt_gl_obj]
	)

SELECT DISTINCT
	X.FY
	,X.GLkey
	,X.Object
	,(X.Proposed) AS Proposed
	,(Y.Funded) AS Funded
	,(Month1.Jul) AS Jul
	,(Month2.Aug) AS Aug
	,(Month3.Sep) AS Sep
	,(Month4.Oct) AS Oct
	,(Month5.Nov) AS Nov
	,(Month6.Dec) AS Dec
	,(Month7.Jan) AS Jan
	,(Month8.Feb) AS Feb
	,(Month9.Mar) AS Mar
	,(MonthA.Apr) AS Apr
	,(MonthB.May) AS May
	,(MonthC.Jun) AS Jun

FROM X

FULL OUTER JOIN Y
	ON X.FY = Y.FY
	AND X.GLkey = Y.GLkey
	AND X.Object = Y.Object

FULL OUTER JOIN Month1
	ON Month1.FY = X.FY
	AND Month1.GLkey = X.GLkey
	AND Month1.Object = X.Object

FULL OUTER JOIN Month2
	ON Month2.FY = X.FY
	AND Month2.GLkey = X.GLkey
	AND Month2.Object = X.Object

FULL OUTER JOIN Month3
	ON Month3.FY = X.FY
	AND Month3.GLkey = X.GLkey
	AND Month3.Object = X.Object

FULL OUTER JOIN Month4
	ON Month4.FY = X.FY
	AND Month4.GLkey = X.GLkey
	AND Month4.Object = X.Object

FULL OUTER JOIN Month5
	ON Month5.FY = X.FY
	AND Month5.GLkey = X.GLkey
	AND Month5.Object = X.Object

FULL OUTER JOIN Month6
	ON Month6.FY = X.FY
	AND Month6.GLkey = X.GLkey
	AND Month6.Object = X.Object

LEFT JOIN Month7
	ON Month7.FY = X.FY
	AND Month7.GLkey = X.GLkey
	AND Month7.Object = X.Object

LEFT JOIN Month8
	ON Month8.FY = X.FY
	AND Month8.GLkey = X.GLkey
	AND Month8.Object = X.Object

LEFT JOIN Month9
	ON Month9.FY = X.FY
	AND Month9.GLkey = X.GLkey
	AND Month9.Object = X.Object

LEFT JOIN MonthA
	ON MonthA.FY = X.FY
	AND MonthA.GLkey = X.GLkey
	AND MonthA.Object = X.Object

LEFT JOIN MonthB
	ON MonthB.FY = X.FY
	AND MonthB.GLkey = X.GLkey
	AND MonthB.Object = X.Object

LEFT JOIN MonthC
	ON MonthC.FY = X.FY
	AND MonthC.GLkey = X.GLkey
	AND MonthC.Object = X.Object

WHERE 
	X.GLkey IN ('190500', '421000', '422000', '423000')
	AND X.FY >= '2019'
	AND X.Proposed IS NOT NULL

--GROUP BY
--	Budget.FY
--	,Budget.GLkey
----	--,(Budget.Proposed)
----	--,(Budget.Budgeted)
--	,(Month1.Jul)
--	,(Month6.Dec)

ORDER BY
	X.GLkey
	,X.Object
	


