DECLARE @TEMP AS TABLE
	(
		EntityID INT
		,Value INT
		,[date] DATETIME
	)

INSERT INTO @TEMP (EntityID, Value, [Date])
	VALUES
		(1, 10,'20140102 07:00:00 AM')
		,(1, 20,'20140102 07:15:00 AM')
		,(1, 30,'20140102 07:30:00 AM')
		,(2, 50,'20140102 07:00:00 AM')
		,(2, 20,'20140102 07:47:00 AM')
		,(3, 40,'20140102 07:00:00 AM')
		,(3, 40,'20140102 07:52:00 AM')

;

WITH X AS
	(SELECT
		EntityID 
		,(AVG(Value) OVER (PARTITION BY EntityID)) AS ybar
		,(Value) AS y
		,AVG(DATEDIFF(SECOND,'20140102 7:00:00 AM', [DATE])) OVER (PARTITION BY EntityID) AS xbar
		,(DATEDIFF(SECOND,'20140102 7:00:00 AM', [DATE])) AS x
	FROM @TEMP
	
WHERE [date] >='20140102 07:00:00 AM' AND [date]<'20140102 08:00:00 AM'
)


SELECT
	EntityID
	,SUM((x - xbar) * (y - ybar))/SUM((x - xbar)^2) AS Beta

FROM X
	
GROUP BY EntityID

--HAVING 1.0*sum((x - xbar)*(y-ybar))/sum((x-xbar)*(x-xbar))>0

	