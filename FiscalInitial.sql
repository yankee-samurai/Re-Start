USE Production_finance

SELECT DISTINCT 
	fiscal_year
	,ledger_code
	,budget_code
	,budget_key
	,budget_object
	,budget_level
	,glb_budget01
	,glb_budget02
	,glb_budget03
	,glb_budget04
	,glb_budget05
	,glb_budget06
	,glb_budget07
	,glb_budget08
	,glb_budget09
	,glb_budget10
	,glb_budget11
	,glb_Budget12
	,gla_actual01
	,gla_actual02
	,gla_actual03
	,gla_actual04
	,gla_actual05
	,gla_actual06
	,gla_actual07
	,gla_actual08
	,gla_actual09
	,gla_actual10
	,gla_actual11
	,gla_actual12

FROM CalcBudget AS A

WHERE 
	fiscal_year IN ('2016', '2017' ,'2018', '2019')
	AND budget_key = '423000'
	--AND budget_object = '62867'
	AND gla_en01 != 0
	AND gla_en02 != 0
	AND gla_en03 != 0
	AND gla_en04 != 0
	AND gla_en05 != 0
	AND gla_en06 != 0
	AND gla_en07 != 0
	AND gla_en08 != 0
	AND gla_en09 != 0
	AND gla_en10 != 0
	AND gla_en11 != 0
	--AND gla_en12 != 0
	AND budget_idx = '6'

ORDER BY 
	fiscal_year

--WHERE gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '431000')


