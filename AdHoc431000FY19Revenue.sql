USE [Production_Finance]
SELECT 
	[glt_gl_key] AS GL_Key
	,SUM([glt_dr]) AS RCF
FROM [glt_trns_dtl]
WHERE 
	[glt_gl_fy] = '2019'
	--AND [glt_gl_key] = '431000'
	AND [glt_gl_obj] = '61215'
	AND [glt_desc] LIKE 'RADIO SHOP%%%'
GROUP BY [glt_gl_key]
ORDER BY [glt_gl_key]