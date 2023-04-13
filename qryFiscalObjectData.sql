SELECT 
      [glo_obj] [Object]
      ,[glo_obj_dl] [Description]
      ,[glo_bal_type] [Balance_type]
        FROM [Production_finance].[dbo].[glo_obj_mstr]
        where [glo_gr] = 'GL'