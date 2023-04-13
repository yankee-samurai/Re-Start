USE [Production_finance]

SELECT 
	[glt_gl_fy] AS FY
	,[glt_gl_pr] AS FM
	,[glt_gl_key] AS 'G/L Key'

	,SUM(
		CASE WHEN [glt_gl_obj] = '61215'
			THEN ([glt_dr] - [glt_cr]) 
			ELSE 0
		END)
	AS '61215'
	,SUM(
		CASE WHEN [glt_gl_obj] = '61220'
			THEN ([glt_dr] - [glt_cr]) 
			ELSE 0
		END)
	AS '61220'
	,SUM(
		CASE WHEN [glt_gl_obj] = '62214'
			THEN ([glt_dr] - [glt_cr]) 
			ELSE 0
		END)
	AS '61214'
	,SUM(
		CASE WHEN [glt_gl_obj] = '62221'
			THEN ([glt_dr] - [glt_cr]) 
			ELSE 0
		END)
	AS '61221'
	,SUM(
		CASE WHEN [glt_gl_obj] = '62325'
			THEN ([glt_dr] - [glt_cr]) 
			ELSE 0
		END)
	AS '62325'
	,SUM(
		CASE WHEN [glt_gl_obj] = '62349'
			THEN ([glt_dr] - [glt_cr]) 
			ELSE 0
		END)
	AS '62349'
	,SUM(
		CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN ([glt_dr] - [glt_cr]) 
			ELSE 0
		END)
	AS 'Total'
            
  FROM [Production_finance].[dbo].[glt_trns_dtl]
    
  WHERE 
	 [glt_gl_key] IN ('103210', '103300', '103400', '106000', '109100', '121000', '122100', '122300', '123100', '123200', '123300', '123400', '123700', '123800', '151000', '181000', '182000',
						'183000', '184000', '185000', '214000', '231000', '242000', '271220', '272100', '302100', '331000', '333100', '333200', '333300', '333400', '333700', '334100', '334200',
						'351000', '431000', '491100', '510000',	'541100', '541300',	'541500', '541600', '542100', '542200', '542300', '542700', '543100', '574000', '661100', '661300', '661400',
						'662110', '662300', '731000', '732000', '733000', '734000')

GROUP BY
	[glt_gl_fy] 
	,[glt_gl_pr] 
	,[glt_gl_key] 

ORDER BY
	[glt_gl_fy] 
	,[glt_gl_pr] 
	,[glt_gl_key] 

