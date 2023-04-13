


;
WITH X AS

	(SELECT 
		CONCAT (RIGHT(MIN(glt_gl_fy),2),' - ',RIGHT(MAX(glt_gl_fy),2)) AS 'Range'
		--,glt_gl_pr
		,glt_gl_key
		,SUM(
			CASE
				WHEN glt_gl_obj = '62214' 
					AND glt_gl_fy >= '2015' 
					AND LEFT(glt_ref, 2) IN ('IB')
				THEN (glt_dr - glt_cr) 
				ELSE 0
			END)/5 AS 'Obj62214'
		,SUM(
			CASE
				WHEN glt_gl_obj = '62221' 
					AND glt_gl_fy >= '2015' 
					AND LEFT(glt_ref, 2) IN ('IB')
					--AND glt_gl_key IN ('103210', '103300', '106000', '185000', '302100', '333200', '333300', '334100', '351000', '491100',
					--				'109100', '121000', '151000', '181000', '182000', '184000', '214000', '214100', '242000',  --'231000',
					--				'271220', '272100', '331000', '333100', '333400', '333500', '333600', '333700', '333800', '334200',
					--				'360122', '367100', '367200', '367300', '367500', '367600', '510000', '515505', '541100', '541300', 
					--				'541500', '541600', '542100', '542200', '542300', '542400', '542700', '543100', '572000',
					--				'574000', '661100', '661700', '662110', '701510', '702000', '731000', '732000', '733000', '734000',
					--				'661300', '661400', '367400', '351000', '333520', '702810', '661850', '124000', '126000', '128000',
					--				'662300', '123200', '123400', '123600')
				THEN (glt_dr - glt_cr) 
				ELSE 0
			END)/5 AS 'Obj62221'
		,SUM(
			CASE
				WHEN 
					--glt_gl_obj IN ('62330', '75320', '75321')
					--AND glt_gl_key IN ('601000', '625175', '621902', '625110', '621217', '621550')
					 glt_gl_fy >= '2015' 
					AND (glt_jl_key) IN ('P60011', 'P53105', 'P19804' ,'P51023', 'P60046', 'P79088', 'P48042', 'P13402')
					AND (glt_jl_obj) IN ('3491', '3484')
				THEN (glt_dr - glt_cr) 
				ELSE 0
			END)/5 AS 'Obj62330'

	FROM [Production_finance].[dbo].[glt_trns_dtl]  

	WHERE --[glt_gl_gr]= N'GL' 
		--AND 
		glt_gl_fy >= '2015'
		AND glt_gl_obj IN ('62214', '62221', '62330', '75320', '75321')
		--AND LEFT(glt_ref, 2) IN ('IB')
	
	GROUP BY

		--,glt_gl_pr
		glt_gl_key

	)

SELECT
		Range
		--,glt_gl_pr
		,glt_gl_key AS 'G/L Key'
		,B.glk_title_dl
		,Obj62214
		,Obj62221
		,Obj62330
		,(Obj62214 + Obj62221 + Obj62330) AS Total

FROM X

INNER JOIN [Production_finance].[dbo].[glk_key_mstr] AS B
	ON X.glt_gl_key = B.glk_key

WHERE 
	(Obj62214 + Obj62221 + Obj62330) != 0

ORDER BY 

	--,glt_gl_pr
	glt_gl_key
	
