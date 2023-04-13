USE Production_finance

SELECT 
      [glt_gl_fy] [Year]
      ,DATENAME(month,[glt_date]) [MonthName]
      ,substring([glt_gl_key],1,2) [Department]
      ,[glt_date] [Date]
      ,[glt_per] [Quarter]
      ,[glt_desc] [Description]
      ,[glt_ref] [Document]
	  ,pe.pe_name [Vendor Name]
	  ,[glt_pe_id] [Vendor No]
	  ,[glt_gl_key] [GLKey]
	  ,[glt_gl_obj] [GL Obj]
	  ,[glt_dr] [Debit]
	  ,ABS([glt_cr]) [Credit]
	  ,([glt_dr] - ABS([glt_cr]) ) [Balance]
	  ,ob.glo_bal_type [ObjectType]
            
  FROM [Production_finance].[dbo].[glt_trns_dtl]
  
  LEFT JOIN [Production_finance].[dbo]. [pe_name_mstr]pe on pe.pe_id = [glt_pe_id]

  
  LEFT JOIN [Production_finance].[dbo].[glo_obj_mstr] ob on ob.glo_obj = [glt_gl_obj]  and [glo_gr] = 'GL'
  
  WHERE [glt_gl_gr]= N'GL'
  
  and SUBSTRING([glt_gl_key],1,2) IN (N'42', N'43')
