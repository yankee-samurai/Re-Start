--:CONNECT sczsq23.co.santa-cruz.ca.us\onesolution
USE [Production_finance]

SELECT *,
	[glt_gl_fy] AS FY
	,[glt_gl_pr] AS FM
	,[glt_gl_key] AS 'G/L Key'
	,[glt_gl_obj] AS 'Object'
	,[glt_dr] AS 'Debit'
	,[glt_cr] AS 'Credit'
	,[glt_dr] - [glt_cr] AS 'Amount'
	,[glt_ref] AS 'Reference'
	,[glt_desc] AS 'Description'
	,[glt_jl_key] AS 'JL Key'
	,[glt_pe_id] AS 'PE_ID'
	,[glt_date2] AS Date
	,[glt_ref2] AS 'Reference 2'
            
  FROM [Production_finance].[dbo].[glt_trns_dtl]
    
  WHERE 
	[glt_gl_gr]= N'GL'
	AND SUBSTRING([glt_gl_key],1,2) IN (N'42', N'43')
	AND [glt_gl_fy] >= '2019'
	--AND [glt_dr] >= 5000
	--AND [glt_gl_obj] IN ('62325')--('61215', '62325', '62349', '61220', '62214', '62221', '95387', '95550')
	--AND [glt_subs_id] = 'JE'
	--AND [glt_desc] LIKE '%PROGRAM%' --OR [glt_desc] LIKE '%NCF%')

--GROUP BY
--	[glt_gl_key]

ORDER BY
	[glt_gl_fy]
	,[glt_gl_pr]


