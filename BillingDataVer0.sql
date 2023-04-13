SELECT 	
	glt_gl_fy
	,glt_gl_pr
	--,glt_ref
	--,glt_desc
	,glt_gl_key
	,glt_gl_obj
	,SUM(glt_dr - glt_cr) AS Net
	,CASE 
		WHEN LEFT(glt_desc,11) = 'PROGRAMMING'
		THEN 'ProgRev'
		ELSE CASE 
			WHEN LEFT(glt_desc,7) = 'NETWORK'
			THEN 'Networks'
			ELSE CASE
				WHEN LEFT(glt_desc,5) = 'BATCH'
				THEN 'Batch'
				ELSE CASE
					WHEN LEFT(glt_desc,4) = 'CICS'
					THEN 'MainFrame'
					ELSE glt_gl_obj
					END
				END
			END
		END AS Type
	
FROM [Production_finance].[dbo].[glt_trns_dtl]  	
	
LEFT JOIN [Production_finance].[dbo].[glo_obj_mstr] ob on ob.glo_obj = [glt_gl_obj]  and [glo_gr] = 'GL' 	
	
WHERE [glt_gl_gr]= N'GL' 	
AND glt_gl_fy >= '2009'	
AND glt_gl_key = '702810'
AND glt_gl_obj IN ('61215', '61220', '62214', '62221', '62325')	
--AND 	

GROUP BY
	glt_gl_fy
	,glt_gl_pr
	,glt_gl_key
	,glt_gl_obj
	,CASE 
		WHEN LEFT(glt_desc,11) = 'PROGRAMMING'
		THEN 'ProgRev'
		ELSE CASE 
			WHEN LEFT(glt_desc,7) = 'NETWORK'
			THEN 'Networks'
			ELSE CASE
				WHEN LEFT(glt_desc,5) = 'BATCH'
				THEN 'Batch'
				ELSE CASE
					WHEN LEFT(glt_desc,4) = 'CICS'
					THEN 'MainFrame'
					ELSE glt_gl_obj
					END
				END
			END
		END
	
ORDER BY 	
	glt_gl_fy
	,glt_gl_pr
	--,glt_ref
