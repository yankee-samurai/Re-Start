/****** Extract Encumbrances  ******/
SELECT [en_orig_fy] [Fiscal Year]
      ,[en_post_dt] [Posted]
      ,[en_ref] [Document]
      ,SUBSTRING([en_gl_key],1,2) [Department]
      ,[en_gl_key] [GLKey]
      ,[en_gl_obj] [Object]
      ,[en_type] [Type]
      ,[en_dist_amt] [Amount]
      ,[en_desc] [Description]
      ,[en_pe_id] [Vendor No]
      ,[en_pe_name] [Vendor Name]
      ,CASE	
			WHEN [en_type] = 'PP' OR [en_type] = 'FP'
				THEN [en_dist_amt]
				ELSE 0 
				END [Payment],
		CASE 
			WHEN ([en_type] = 'EN' )
				THEN [en_dist_amt]
				ELSE 0
				END [Credit]
		
      
  FROM [Production_finance].[dbo].[en_dtl]
  
  where SUBSTRING([Production_finance].[dbo].[en_dtl].[en_gl_key],1,2) in (N'42',N'43') 
and [en_tr_format] <> '' 

and [en_dtl].[en_ref] not in (select [en_ref] from [en_dtl] where [en_type] in (N'DE',N'FP'))