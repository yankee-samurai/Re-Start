SELECT glb_batch_id,
		glb_ref,
                glb_fy,
		glb_desc,
		glb_misc,
		glb_tr_type,
		glb_fund_type,
		glb_trns_acg,
		glb_version,
		CA.glb_key,
		CA.glb_obj,
		CA.glb_amt,
		CA.glb_gr
		
		 
  FROM [Production_finance].[dbo].[glb_batch_dtl]

  Cross apply
	(values (glb_batch_dtl.glb_key, glb_batch_dtl.glb_obj,glb_batch_dtl.glb_amt,glb_batch_dtl.glb_gr),
			(glb_batch_dtl.glb_from_key,glb_batch_dtl.glb_from_obj,-glb_batch_dtl.glb_amt,glb_batch_dtl.glb_from_gr))
			CA(glb_key,glb_obj,glb_amt,glb_gr)
  where glb_batch_dtl.[glb_key] LIKE '42%'  or glb_batch_dtl.[glb_key] like '43%'