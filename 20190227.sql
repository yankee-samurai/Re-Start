USE [Production_finance]
SELECT DISTINCT
		[glb_fy] AS FY
		,[glb_key] AS GLkey
		,[glb_obj] AS GLobj
		,(CASE WHEN SUBSTRING([glb_ref],7,2) = 'LP'
			THEN [glb_amt]
			ELSE 0
		END) AS 'Proposed'

	FROM [glb_batch_dtl] AS A

	WHERE 
		[glb_key] IN ('190500', '421000', '422000')
		AND [glb_fy] >= '2019'
		AND SUBSTRING([glb_ref],7,2) = 'LP'
	
	ORDER BY
		[glb_fy]
		,[glb_key]
		,[glb_obj]