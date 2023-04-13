USE production_finance

SELECT
	CASE
		WHEN A.glk_grp_part01 = '10' THEN 'GF'
		WHEN A.glk_grp_part01 = '60' THEN 'NGF'
		ELSE NULL
	END AS 'GF/NGF'
	,A.glk_key AS 'G/L Key'
	,B.glk_grp_dl AS 'Department'
	,A.glk_title_dl AS 'G/L Key Description'


FROM glk_key_mstr AS A

INNER JOIN glk_grp_mstr AS B
ON A.glk_grp_part04 = B.glk_grp
AND B.glk_grp_id = 'DEPT'

WHERE 
	A.glk_grp_part01 IN ('10', '60')
	AND A.glk_end_dt >= GETDATE()
	AND A.glk_end_dt IS NOT NULL

ORDER BY
	A.glk_grp_part01
	,A.glk_key