SELECT 
	glt_gl_fy
	,glt_gl_pr
	,glt_ref
	,glt_desc
	,glt_gl_key
	,glt_gl_obj
	,glt_dr
	,glt_cr

FROM [Production_finance].[dbo].[glt_trns_dtl]  

LEFT JOIN [Production_finance].[dbo].[glo_obj_mstr] ob on ob.glo_obj = [glt_gl_obj]  and [glo_gr] = 'GL' 

WHERE [glt_gl_gr]= N'GL' 
AND glt_gl_fy >= '2016'
AND glt_gl_obj = '62214'
--AND glt_desc LIKE '### GIS/NTWRK/PROG ###'

ORDER BY 
	glt_gl_fy
	,glt_gl_pr
	,glt_ref