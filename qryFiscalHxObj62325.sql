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
AND glt_gl_obj = '62325'
--AND LEFT(glt_desc,11) = 'PROGRAMMING'

ORDER BY 
	glt_gl_fy
	,glt_gl_pr
	,glt_ref

--and SUBSTRING([glt_gl_key],1,2) IN (N'42', N'43')"]), "Trimmed Text" = Table.TransformColumns(Source,{{"GLKey", Text.Trim}, {"GL Obj", Text.Trim}})

;
WITH X AS
	(SELECT DISTINCT glt_ref
	FROM [Production_finance].[dbo].[glt_trns_dtl] 
	WHERE [glt_gl_gr]= N'GL' 
	AND glt_gl_fy >= '2018'
	AND glt_gl_obj = '62325')

--(Y AS
	SELECT
		A.glt_gl_fy
		,A.glt_gl_pr
		,X.glt_ref
		,COUNT(A.glt_ref)
	FROM X
	INNER JOIN [Production_finance].[dbo].[glt_trns_dtl]  AS A
	ON X.glt_ref = A.glt_ref
	WHERE [glt_gl_gr]= N'GL' 
AND glt_gl_fy >= '2018'
AND glt_gl_obj = '62325'
	GROUP BY 
		A.glt_gl_fy
		,A.glt_gl_pr
		,X.glt_ref
	ORDER BY x.glt_ref

