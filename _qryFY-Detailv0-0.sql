USE [Production_finance]

DECLARE @CurrFY AS INT

SET @CurrFY = 
	CASE	
		WHEN MONTH(GETDATE()) > 6 THEN YEAR(GETDATE())+1
		ELSE YEAR(GETDATE())
	END

SELECT
	en_gl_key
	,en_gl_obj
	,en_ref
	--placeholder for vendor name
	--placeholder for contract/PO description
	,SUM(
		CASE
			WHEN en_type = 'EN'
			THEN en_dist_amt
			ELSE 0
		END)
	AS 'Encumb'

	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201807'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201807'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201808'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201808'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201809'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201809'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201810'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201810'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201811'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201811'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201812'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201812'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201901'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201901'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201902'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201902'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201903'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201903'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201904'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201904'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201905'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201905'
	,SUM(
		CASE 
			WHEN LEFT(en_jl_obj,6) = '201906'
			THEN en_dist_amt
			ELSE 0
		END) 
	AS '201906'
	,SUM(
		CASE 
			WHEN en_type = 'PP'
			THEN en_dist_amt
			ELSE 0
		END)
	AS 'FY19YTD'
	,SUM(
		CASE
			WHEN en_type = 'EN'
			THEN en_dist_amt
			ELSE 0
		END)
	-SUM(
		CASE 
			WHEN en_type = 'PP'
			THEN en_dist_amt
			ELSE 0
		END)
	AS 'Avail'
	,SUM(
		CASE 
			WHEN en_type = 'PP'
			THEN en_dist_amt
			ELSE 0
		END) * 100
	/
	CASE
		WHEN
			SUM(
				CASE
					WHEN en_type = 'EN'
					THEN en_dist_amt
				ELSE 0
			END) = 0
		THEN 1
		ELSE
			SUM(
				CASE
					WHEN en_type = 'EN'
					THEN en_dist_amt
				ELSE 0
			END) 
	END
	AS '% of APPN'
FROM en_dtl

WHERE 
	en_gl_key IN ('421000', '422000', '423000', '424000', '424100', '424200', '424400', '424500', '431000')		--
	AND en_orig_fy = '2019'
	AND LEFT(en_ref,2) NOT IN ('BR', 'PR', '00')

GROUP BY
	en_gl_key
	,en_gl_obj
	,en_ref

ORDER BY 
	en_gl_key,en_gl_obj