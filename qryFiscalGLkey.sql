SELECT DISTINCT
    
	  [glt_gl_key] 


      
      
  FROM [Production_finance].[dbo].[glt_trns_dtl]
  
  
  
  WHERE [glt_gl_gr]= N'GL'

  
  and SUBSTRING([glt_gl_key],1,2) IN (N'42', N'43')