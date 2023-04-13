:CONNECT sczsq23.co.santa-cruz.ca.us\onesolution

--DECLARE @CurrFY AS INT

--SET @CurrFY = 
--	CASE	
--		WHEN MONTH(GETDATE()) > 6 THEN YEAR(GETDATE())+1
--		ELSE YEAR(GETDATE())
--	END

USE Production_finance

SELECT [en_orig_fy] [Fiscal Year]
	--,SUBSTRING([en_gl_key],1,2) [Department]
	,[en_gl_key] [GLKey]
	,[en_gl_obj] [Object]
	--,[en_pe_id] [Vendor No]
	--,[en_pe_name] [Vendor Name]
	--,[en_ref] [Document]
	,B.[glo_obj_dl] [Description]
	--,[en_desc] [Description]
	--,[en_type] [Type]
	--,[en_dist_amt] [Amount]
	--,[en_post_dt] [Posted]
    --,B.[glo_bal_type] [Balance_type]
	--,SUM(CASE
	--	WHEN ([en_type] = 'EN' )
	--		THEN [en_dist_amt]
	--		ELSE 0
	--	END) AS [Encumbrance]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 7
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Jul]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 8
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Aug]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 9
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Sep]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 10
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Oct]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 11
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Nov]	
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 12
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Dec]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 1
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Jan]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 2
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Feb]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 3
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Mar]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 4
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Apr]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 5
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [May]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP') AND MONTH([en_post_dt]) = 6
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [Jun]
	,SUM(CASE
		WHEN ([en_type] = 'PP' OR [en_type] = 'FP')
			THEN [en_dist_amt]
			ELSE 0 
		END) AS [FYTD]
	--,(SUM(CASE
	--	WHEN ([en_type] = 'EN' )
	--		THEN [en_dist_amt]
	--		ELSE 0
	--	END)
	---
	--SUM(CASE
	--	WHEN ([en_type] = 'PP' OR [en_type] = 'FP')
	--		THEN [en_dist_amt]
	--		ELSE 0 
	--	END)) AS [Avail]

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
	AND [en_type] NOT IN ('DE')				--,N'FP')
	AND LEFT(en_gl_key,2) IN ('42', '43') 
	AND en_orig_fy >= '2015'				--@CurrFY

GROUP BY
	[en_orig_fy] 
	,SUBSTRING([en_gl_key],1,2) 
	,[en_gl_key] 
	,[en_gl_obj]
	--,[en_pe_id] 
	--,[en_pe_name] 
	--,[en_ref] 
	,B.[glo_obj_dl] 

--USE Production_finance SELECT DISTINCT en_type FROM en_dtl