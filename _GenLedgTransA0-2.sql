--:CONNECT sczsq23.co.santa-cruz.ca.us\onesolution
USE [Production_finance]

SELECT *,
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
		WHEN [glt_gl_key] IN ('103210','103300','103400','106000','109100','121000','122100','122300','123100','123200','123300','123400', '123600', '123700','123800', '124000', '126000', '128000', '151000','181000','182000','183000','184000','185000',
								'214000', '214100', '231000','242000','271220','272100', '271400', '302100','331000','333100','333200','333300','333400', '333520', '333600', '333700', '333800', '334100','334200', '351000','431000',
								'491100', '492100', '492300', '493130', '493150', '494000', '495200', '495300', '510000','541100','541300',
								'541500','541600','542100','542200','542300','542700','543100','572000', '574000', '574100', '591000', '661100', '661200', '661300','661400', '661700', '661800', '661850', '662110','662300', '662405', '662440', '662460', '662500', '731000','732000','733000','734000')
			 THEN 'GF'
		WHEN [glt_gl_key] IN ('360110', '360111', '360112', '360113', '360120', '360122', '360180', '361100', '361112', '361210', '361231', '361241', '361250', '361260', '361270', '361310', '361330', '361331', '361341', '361350', '361360', '361441', '361920', '361950', '361951',
								'362010', '362100', '362110', '362120', '362200', '362300', '362501', '362503', '362750', '362800', '362851', '362960', '363101', '363102', '363103', '363104', '363105', '363111', '363112', '363113', '363114', '363115', '363116', '363117', 
								'363118', '363119', '363120', '363121', '363122', '363124', '363125', '363130', '363141', '363142', '363144', '363149', '363173', '363174', '363320', '364012', '364022', '364032', '364033', '365001', '365200', '365210', '367100', '367200', 
								'367300', '367400', '367500', '367600')
			THEN 'HSA'
		WHEN [glt_gl_key] IN ('392100', '393000')
			THEN 'HSD'
		WHEN [glt_gl_key] IN ('251000', '304100', '333500', '421000', '422000', '424100', '424200', '424400', '424500', '515100', '515505', '601000', '610110', '621900', '625175', '680410', '680600', '680810', '681110', '681310', '681410', '681800', '683100', '684810', '685010', '689510',
							'691700', '700600', '701510', '702000', '702810', '702820', '702830', '721750', '722100', '750900', '800001', '90011', '90040', '90041', '90095')
			THEN 'NGF'
		ELSE NULL
	END AS 'Type'

            
  FROM [Production_finance].[dbo].[glt_trns_dtl]
    
  WHERE 
	--[glt_gl_gr]= N'GL'
	--AND SUBSTRING([glt_gl_key],1,2) IN (N'42', N'43')
	--AND [glt_gl_key] = '431000'
	 [glt_gl_fy] >= '2014'
	AND [glt_gl_obj] IN ('62325')--('61215', '62325', '62349', '61220', '62214', '62221', '95387', '95550')
	AND [glt_subs_id] = 'JE'
	AND ([glt_desc] LIKE '%NETWORK CO%' OR [glt_desc] LIKE '%NCF%')

--GROUP BY
--	[glt_gl_key]

ORDER BY 
	[glt_gl_key]