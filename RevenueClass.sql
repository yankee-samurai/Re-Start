USE [Production_finance]

DECLARE @STRUC AS TABLE
	(GF VARCHAR(7)
	,HSA VARCHAR(7)
	,HSD VARCHAR(7)
	,OTH VARCHAR(7)
	)

DECLARE @REVENUE AS TABLE
	(FY INT
	,FM VARCHAR(2)
	,GLKEY VARCHAR(7)
	,Type VARCHAR(3)
	,O61215 FLOAT
	,O61220 FLOAT
	,O62214 FLOAT
	,O62221 FLOAT
	,O62325 FLOAT
	,O62349 FLOAT
	,Total FLOAT
	)

--Changes to the reporting structure have to made here.  First column is GF G/L Keys, Second column is HSA G/L KEys, HSD G/L Keys, and then OTH	
--Best solution is to have discriminator fields added to the database
INSERT INTO @STRUC 
	SELECT		 '103210', '360110', '392100', '231000'
	UNION SELECT '103300', '360112', '', '251000'
	UNION SELECT '103400', '360113', '', '304100'
	UNION SELECT '106000', '360120', '', '304400'
	UNION SELECT '109100', '360750', '', '333500'
	UNION SELECT '121000', '367100', '', '515100'
	UNION SELECT '122100', '367200', '', '515505'
	UNION SELECT '122300', '', '', '601000'
	UNION SELECT '123100', '', '', '610110'
	UNION SELECT '123200', '', '', '621900'
	UNION SELECT '123300', '', '', '625175'
	UNION SELECT '123400', '', '', '691700'
	UNION SELECT '123700', '', '', '700600'
	UNION SELECT '123800', '', '', '702000'
	UNION SELECT '151000', '', '', '702810'
	UNION SELECT '181000', '', '', '721750'
	UNION SELECT '182000', '', '', '750900'
	UNION SELECT '183000', '', '', '800001'
	UNION SELECT '185000', '', '', '90011'
	UNION SELECT '214000', '', '', '90040'
	UNION SELECT '242000', '', '', '90041'
	UNION SELECT '271220', '', '', '90095'
	UNION SELECT '272100', '', '', 'G001-19'
	UNION SELECT '302100', '', '', 'G003-19'
	UNION SELECT '331000', '', '', 'G012-19'
	UNION SELECT '333100', '', '', 'G090-18'
	UNION SELECT '333200', '', '', 'G097-18'
	UNION SELECT '333300', '', '', 'G101-18'
	UNION SELECT '333400', '', '', 'G105-18'
	UNION SELECT '333700', '', '', 'G110-18'
	UNION SELECT '334100', '', '', 'G112-18'
	UNION SELECT '334200', '', '', 'G116-18'
	UNION SELECT '351000', '', '', 'G117-18'
	UNION SELECT '431000', '', '', 'G132-18'
	UNION SELECT '491100', '', '', 'G134-18'
	UNION SELECT '492100', '', '', 'G140-18'
	UNION SELECT '510000', '', '', 'G144-18'
	UNION SELECT '541100', '', '', ''
	UNION SELECT '541300', '', '', ''
	UNION SELECT '541500', '', '', ''
	UNION SELECT '541600', '', '', ''
	UNION SELECT '542100', '', '', ''
	UNION SELECT '542200', '', '', ''
	UNION SELECT '542300', '', '', ''
	UNION SELECT '542700', '', '', ''
	UNION SELECT '543100', '', '', ''
	UNION SELECT '574000', '', '', ''
	UNION SELECT '661100', '', '', ''
	UNION SELECT '661300', '', '', ''
	UNION SELECT '661400', '', '', ''
	UNION SELECT '662110', '', '', ''
	UNION SELECT '662300', '', '', ''
	UNION SELECT '731000', '', '', ''
	UNION SELECT '732000', '', '', ''
	UNION SELECT '733000', '', '', ''
	UNION SELECT '734000', '', '', ''

;
WITH GF AS
	(SELECT 
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS 'G/L Key'
		,CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN 'GF' 
			ELSE NULL
		END AS 'Type'
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

	INNER JOIN @STRUC ON
		[glt_gl_key] = GF
    
	--WHERE 
		 --[glt_gl_key] IN (@GF)

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key] 
		,CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN 'GF' 
			ELSE NULL
		END
),

HSA AS
	(SELECT 
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS 'G/L Key'
		,CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN 'HSA' 
			ELSE NULL
		END AS 'Type'
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

	INNER JOIN @STRUC ON
		[glt_gl_key] = HSA
    
	--WHERE 
		 --[glt_gl_key] IN (@GF)

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key] 
		,CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN 'HSA' 
			ELSE NULL
		END
),

HSD AS
	(SELECT 
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS 'G/L Key'
		,CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN 'HSD' 
			ELSE NULL
		END AS 'Type'
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

	INNER JOIN @STRUC ON
		[glt_gl_key] = HSD
    
	--WHERE 
		 --[glt_gl_key] IN (@GF)

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key] 
		,CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN 'HSD' 
			ELSE NULL
		END
),

OTH AS
	(SELECT 
		[glt_gl_fy] AS FY
		,[glt_gl_pr] AS FM
		,[glt_gl_key] AS 'G/L Key'
		,CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN 'OTH' 
			ELSE NULL
		END AS 'Type'
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

	INNER JOIN @STRUC ON
		[glt_gl_key] = OTH
    
	--WHERE 
		 --[glt_gl_key] IN (@GF)

	GROUP BY
		[glt_gl_fy] 
		,[glt_gl_pr] 
		,[glt_gl_key] 
		,CASE WHEN [glt_gl_obj] IN ('61215', '61220', '62214', '62221', '62325', '62349')
			THEN 'OTH' 
			ELSE NULL
		END
)

INSERT INTO @REVENUE
SELECT * FROM GF
UNION SELECT * FROM HSA
UNION SELECT * FROM HSD
UNION SELECT * FROM OTH

SELECT * FROM @REVENUE
WHERE Type IS NOT NULL 