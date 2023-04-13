USE Production_finance

SELECT [en_orig_fy] AS [Fiscal Year]
	--,CASE WHEN LEN(MONTH([en_post_dt])) < 2
	--	THEN CONCAT('0',MONTH([en_post_dt])) 
	--	ELSE MONTH([en_post_dt])
	--END AS [Fiscal Month]
	,CASE	WHEN MONTH([en_post_dt]) = 7 THEN '01/Jul'
			WHEN MONTH([en_post_dt]) = 8 THEN '02/Aug'
			WHEN MONTH([en_post_dt]) = 9 THEN '03/Sep'
			WHEN MONTH([en_post_dt]) = 10 THEN '04/Oct'
			WHEN MONTH([en_post_dt]) = 11 THEN '05/Nov'
			WHEN MONTH([en_post_dt]) = 12 THEN '06/Dec'
			WHEN MONTH([en_post_dt]) = 1 THEN '07/Jan'
			WHEN MONTH([en_post_dt]) = 2 THEN '08/Feb'
			WHEN MONTH([en_post_dt]) = 3 THEN '09/Mar'
			WHEN MONTH([en_post_dt]) = 4 THEN '10/Apr'
			WHEN MONTH([en_post_dt]) = 5 THEN '11/May'
			WHEN MONTH([en_post_dt]) = 6 THEN '12/Jun'
			ELSE NULL
	END AS [Fiscal Month]
	,[en_gl_key] AS [GLKey]
	,[en_gl_obj] AS [Object]
	,B.[glo_obj_dl] [Description]
	,[en_pe_id] [Vendor No]
	,[en_pe_name] [Vendor Name]
	,[en_ref] [Document]
	--,[en_desc] [Description]
	--,[en_type] [Type]
	,SUM([en_dist_amt]) AS [Amount]
	--,[en_post_dt] [Posted]
    --,B.[glo_bal_type] [Balance_type]
	--,SUM(CASE
	--	WHEN ([en_type] = 'EN' )
	--		THEN [en_dist_amt]
	--		ELSE 0
	--	END) AS [Encumbrance]
FROM en_dtl AS A

INNER JOIN [glo_obj_mstr] AS B
	ON B.glo_obj =  A.en_gl_obj
	AND [glo_gr] = 'GL'

WHERE 
	SUBSTRING(A.en_gl_key,1,2) in ('42', '43') 
	AND [en_tr_format] <> '' 
	--AND [en_dtl].[en_ref] NOT IN 
	--	(select [en_ref] 
	--	from [en_dtl] 
	AND [en_type] NOT IN ('DE', 'EN')				--,N'FP')
	AND LEFT(en_gl_key,2) IN ('42', '43') 
	AND en_orig_fy >= '2015'				--@CurrFY

GROUP BY
	[en_orig_fy] 
	,MONTH([en_post_dt]) 
	,[en_gl_key] 
	,[en_gl_obj]
	,[en_pe_id] 
	,[en_pe_name] 
	,[en_ref] 
	,B.[glo_obj_dl] 
	,[en_dist_amt]