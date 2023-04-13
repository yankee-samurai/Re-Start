:CONNECT sczsq23.co.santa-cruz.ca.us\onesolution
USE Production_finance

SELECT [en_orig_fy] [Fiscal Year]
	,[en_post_dt] [Posted]
	,[en_ref] [Document]
	,SUBSTRING([en_gl_key],1,2) [Department]
	,[en_gl_key] [GLKey]
	,[en_gl_obj] [Object]
	,[en_type] [Type]
	,[en_dist_amt] [Amount]
	,[en_desc] [Description]
	,[en_pe_id] [Vendor No]
	,[en_pe_name] [Vendor Name]
	--,CASE
	--	WHEN [en_type] = 'PP' OR [en_type] = 'FP'
	--		THEN [en_dist_amt]
	--		ELSE 0 
	--	END [Payment]
	--,CASE
	--	WHEN ([en_type] = 'EN' )
	--		THEN [en_dist_amt]
	--		ELSE 0
	--	END [Credit]
      ,B.[glo_obj_dl] [Description]
      ,B.[glo_bal_type] [Balance_type]
		
FROM en_dtl AS A

INNER JOIN [glo_obj_mstr] AS B
	ON B.glo_obj =  A.en_gl_obj
	AND [glo_gr] = 'GL'

WHERE 
	SUBSTRING(A.en_gl_key,1,2) in (N'42',N'43') 
	AND [en_tr_format] <> '' 
	--AND [en_dtl].[en_ref] NOT IN 
	--	(select [en_ref] 
	--	from [en_dtl] 
	--	where [en_type] in (N'DE',N'FP'))
	AND en_gl_key = '422000'
	AND en_orig_fy = '2019'

--GROUP BY
--	[Fiscal Year]
--	,[GL Key]

--USE Production_finance
--SELECT DISTINCT en_type
--FROM en_dtl