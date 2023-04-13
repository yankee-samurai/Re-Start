USE [Production_finance]

SELECT 	
	glt_gl_fy
	--,glt_desc
	,glt_gl_key
	,glt_gl_obj
	,SUM(
		CASE WHEN glt_gl_pr ='01'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Jul
	,SUM(
		CASE WHEN glt_gl_pr ='02'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Aug
	,SUM(
		CASE WHEN glt_gl_pr ='03'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Sep
	,SUM(
		CASE WHEN glt_gl_pr ='04'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Oct
	,SUM(
		CASE WHEN glt_gl_pr ='05'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Nov
	,SUM(
		CASE WHEN glt_gl_pr ='06'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Dec
	,SUM(
		CASE WHEN glt_gl_pr ='07'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Jan
	,SUM(
		CASE WHEN glt_gl_pr ='08'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Feb
	,SUM(
		CASE WHEN glt_gl_pr ='09'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Mar
	,SUM(
		CASE WHEN glt_gl_pr ='10'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Apr
	,SUM(
		CASE WHEN glt_gl_pr ='11'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS May
	,SUM(
		CASE WHEN glt_gl_pr ='12'
			THEN (glt_dr - glt_cr) 
			ELSE 0
		END)
	AS Jun
	,SUM(glt_dr - glt_cr) AS YTD
	
FROM [Production_finance].[dbo].[glt_trns_dtl]  	
	
LEFT JOIN [Production_finance].[dbo].[glo_obj_mstr] ob on ob.glo_obj = [glt_gl_obj]  and [glo_gr] = 'GL' 	
	
WHERE [glt_gl_gr]= N'GL' 	
AND glt_gl_fy >= '2009'	
--AND glt_gl_key = '702810'
AND glt_gl_obj IN ('61215', '61220', '62214', '62221', '62325')	

GROUP BY
	glt_gl_fy
	,glt_gl_key
	,glt_gl_obj
	--,glt_desc
	
ORDER BY 	
	glt_gl_fy
	,glt_gl_key
	,glt_gl_obj
