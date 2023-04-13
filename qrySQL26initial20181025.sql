USE county_of_santa_cruz_budget_rpt

SELECT 
	FiscalYear
	,Department
	,GLKey
	,GLKeyTitle
	,Character
	,CharacterTitle
	,Object
	,ObjectTitle
	,Fund
	,FundTitle
	,Amount
	,AmountType
	--,Function AS Fn
	,FunctionTitle
	,SubObjectType
	
	,WorksheetSource
	,WorksheetName
	,WorksheetRow



FROM BI.EstimatedActuals

WHERE 
	FiscalYear >= 2013
	AND GLKey IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '424600', '431000')
	--AND Adjustment != 'None'

ORDER BY
	FiscalYear
	,GLKey
	,Character
	,Object