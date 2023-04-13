--:CONNECT sczsq23.co.santa-cruz.ca.us\onesolution
USE [Production_finance]

SELECT DISTINCT *
	--[glt_gl_key] 
	,right([glb_ref],10) AS AZ

FROM [glb_batch_dtl]
 
WHERE 
	[glb_key] = '190500'
	--AND [glt_gl_fy] >= '2005'


USE [Production_finance]

SELECT DISTINCT *
	--[glt_gl_key] 

FROM [glt_trns_dtl]
 
WHERE 
	[glt_gl_key] IN ('190500', '424400')
	AND [glt_gl_fy] >= '2019'