:CONNECT sczsq23.co.santa-cruz.ca.us\onesolution
USE [Production_finance]

SELECT
	[glt_gl_fy] AS FY
	,[glt_gl_pr] AS FM
	,[glt_gl_key] AS 'G/L Key'
	,[glt_gl_obj] AS 'Object'
	,[glt_dr] AS 'Debit'
	,[glt_cr] AS 'Credit'
	,[glt_ref] AS 'Reference'
	,[glt_desc] AS 'Description'
	,[glt_jl_key] AS 'JL Key'
	,[glt_pe_id] AS 'PE_ID'
	,[glt_date2] AS Date
	,[glt_ref2] AS 'Reference 2'
	,CASE 
		WHEN [glt_gl_key] IN ('103210','103300','103400','106000','109100','121000','122100','122300','123100','123200','123300','123400','123700','123800','151000','181000','182000','183000','184000','185000',
								'214000','231000','242000','271220','272100','302100','331000','333100','333200','333300','333400','333700','334100','334200','351000','431000','491100','510000','541100','541300',
								'541500','541600','542100','542200','542300','542700','543100','574000','661100','661300','661400','662110','662300','731000','732000','733000','734000')
			 THEN 'GF'
		WHEN [glt_gl_key] IN ('360110', '360112', '360113', '360120', '362010', '362750', '367100', '367200')
			THEN 'HSA'
		WHEN [glt_gl_key] IN ('392100')
			THEN 'HSD'
		WHEN [glt_gl_key] IN ('251000', '304100', '333500', '515100', '515505', '601000', '610110', '621900', '625175', '700600', '702000', '702810', '721750', '750900', '800001', '90011', '90040', '90041', '90095')
			THEN 'NGF'
		ELSE NULL
	END AS 'Type'

            
  FROM [Production_finance].[dbo].[glt_trns_dtl]
    
  WHERE 
	[glt_gl_gr]= N'GL'
	--AND SUBSTRING([glt_gl_key],1,2) IN (N'42', N'43')
	--AND [glt_gl_key] = '431000'
	AND [glt_gl_fy] = '2019'
	and [glt_gl_obj] IN ('61215')       --, '62325', '62349', '61220', '62214', '62221')

--GROUP BY
--	[glt_gl_key]

ORDER BY 
	[glt_gl_key]