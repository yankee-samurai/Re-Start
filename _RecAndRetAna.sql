:CONNECT sczsq31.co.santa-cruz.ca.us

DECLARE @PER_CODE AS TABLE
	(Code VARCHAR(2)
	,Dscr VARCHAR(128))

INSERT INTO @PER_CODE
	SELECT		 '01', 'Left of own accord, no reason given'
	UNION SELECT '02', 'To seek other employment'
	UNION SELECT '03', 'To accept other employment (employment ready and waiting)'
	UNION SELECT '04', 'Dissatisfaction with job (salary, hours, duties, etc.)'
	UNION SELECT '05', 'To get married'
	UNION SELECT '06', 'Left of own accord/personal domestic reasons'
	UNION SELECT '07', 'Left area/changed residence'
	UNION SELECT '08', 'To attend school'
	UNION SELECT '09', 'Mental/physical condition other than pregnancy'
	UNION SELECT '10', 'Pregnancy'
	UNION SELECT '11', 'Transportation difficulties'
	UNION SELECT '12', 'Voluntary retirement'
	UNION SELECT '13', 'Failed to appear or call'
	UNION SELECT '14', 'Failed to return from leave of absence'
	UNION SELECT '15', 'Voluntary quit - other reason'
	UNION SELECT '16', 'Extra help - resign'
	UNION SELECT '17', 'Quit after reduction of hours'
	UNION SELECT '18', 'Failed to maintain license required by job'
	UNION SELECT '20', 'Violation of County rule or policy'
	UNION SELECT '21', 'Excessive absenteeism/tardiness'
	UNION SELECT '24', 'Deliberate unsatisfactory performance'
	UNION SELECT '25', 'Unsatisfactory performance/not qualified'
	UNION SELECT '26', 'Falsified records'
	UNION SELECT '27', 'Mental/physical condition other than pregnancy'
	UNION SELECT '29', 'Discharge - other reason'
	UNION SELECT '30', 'Refused to follow instructions'
	UNION SELECT '31', 'Intoxication and/or use of drugs'
	UNION SELECT '32', 'Immoral conduct'
	UNION SELECT '33', 'Refusal to accept transfer'
	UNION SELECT '34', 'Permanent lack of work/layoff'
	UNION SELECT '36', 'Wasteful or unauthorized use of funds, supplies, equipment'
	UNION SELECT '37', 'Conviction of felony or misdemeanor involving moral turpitude'
	UNION SELECT '38', 'Negligent or willful damage to public property'
	UNION SELECT '39', 'Extra help – discharge'
	UNION SELECT '40', 'Compulsory or disability retirement'
	UNION SELECT '44', 'Industrial controversy'
	UNION SELECT '45', 'Extra help - reached 999 hours'
	UNION SELECT '46', 'Extra help - position or funding ended'
	UNION SELECT '49', 'Death'

SELECT A.[EmpIndex]
      ,A.[EmpNo]
	  ,B.[JobClass]
	  ,B.[JobClassDesc]
	  ,B.[PosNo]
	  ,B.[StepNo]
      ,A.[BenStat]
	  ,A.[CoLevel]
      ,A.[LastName]
      ,A.[FirstName]
      ,A.[MiddleName]
      --,[FirstInit]
      --,[MiddleInit]
      --,[Suffix]
      ,A.[StatusCode]
      ,A.[OriginalHireDate]
	  --,B.[Seq]
	  ,B.[ActionCode]
	  --,B.[TerminationActionCode]
	  --,C.Dscr
	  ,B.[ActionCodeDate]
	 -- ,CASE
		--WHEN B.[TerminationActionCode] != ''
		--	THEN B.[ActionCodeDate]
		--	ELSE ''
		--END AS TermDate
      
  FROM [Payroll2].[dbo].[EmpKey] AS A

  INNER JOIN [Payroll2].[dbo].[EmpHist] AS B
	ON A.EmpNo = B.EmpNo

--INNER JOIN @PER_CODE AS C
--	ON C.CODE = B.TerminationActionCode

  WHERE
	B.[JobClass] IN ('DD1', 'DD2', 'DD3', 'DD4', 'HH1', 'HH2', 'HH3', 'HH4', 'TT1', 'TT2', 'TT3', 'TT4', 'TT6'
					,'UM2', 'UM3', 'UM4', 'UM5', 'UM6', 'UM8', 'UN4', 'UN5', 'UN6', 'UO2', 'UO3', 'GG1', 'GG2', 'GG3'
					,'NN1', 'NN2', 'NN3', 'NN4', 'UP3', 'UP7', 'UP8', 'UP9', 'UJ1', 'UJ3', 'UJ4', 'UJ5', 'UJ6', 'UU5', 'UU7'
					, 'CV3', 'CV7', 'XC5', 'XC7', 'UL1', 'UK7')
	--AND CASE
	--	WHEN B.[TerminationActionCode] != ''
	--		THEN B.[ActionCodeDate]
	--		ELSE ''
	--	END != 0
	--AND YEAR(CASE
	--	WHEN B.[TerminationActionCode] != ''
	--		THEN B.[ActionCodeDate]
	--		ELSE ''
	--	END) > 2009
	AND LEFT(A.[EmpIndex],2) in ('42','43')
	--AND StatusCode = '1'
GROUP BY
	EmpIndex
	,A.EmpNo
	,B.[JobClass]
	,B.[JobClassDesc]
	,B.[PosNo]
	,B.[StepNo]
    ,A.[BenStat]
	,A.[CoLevel]
    ,A.[LastName]
    ,A.[FirstName]
    ,A.[MiddleName]
      --,[FirstInit]
      --,[MiddleInit]
      --,[Suffix]
    ,A.[StatusCode]
    ,A.[OriginalHireDate]
	  --,B.[Seq]
	  ,B.[ActionCode]
	--  ,B.[TerminationActionCode]
	--  ,C.Dscr
	  ,B.[ActionCodeDate]
	--,CASE
	--	WHEN B.[TerminationActionCode] != ''
	--		THEN B.[ActionCodeDate]
	--		ELSE ''
	--	END

ORDER BY
	EmpIndex
	,A.EmpNo
	,B.[JobClass]