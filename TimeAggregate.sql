/*
	Scenario:
				
				
		Sample Table: ELECTRICAL_OUTAGE
		----------------------------------------------------------------------
		ID   |	CITY		|  STATE		|     OUTAGE_DURATION
		----------------------------------------------------------------------
		1    |	Hubli		|	Karnataka	|      4316:52:00
		2    |	Belagavi	|	Karnataka	|        16:01:00
		3    |	Belgaum		|	Karnataka	|       345:23:00
		4    |	Jaipur		|	Rajasthan	|        56:23:00
		5    |	Jodhpur		|	Rajasthan	|	 12:00:00
		6    |	Jaisalmer	|	Rajasthan	|	 32:00:00
		----------------------------------------------------------------------
		
		
		Find the Total Hours & Minutes of Electrical Outage for the each state
		As seconds value are 00 here I have considered only HH:MM
*/

SELECT
      "STATE",
      COUNT("ID") AS COUNT_OUTAGE,

      /* TIME CALCULATION STARTS HERE */
			
      (CAST(SUM(CAST(SUBSTR_AFTER(LEFT(LPAD("ELECTRICAL_OUTAGE",10,'0'),7),':') AS INTEGER))/60 AS INTEGER) 
      + CAST(SUM(CAST(SUBSTR_BEFORE("ELECTRICAL_OUTAGE",':') AS INTEGER)) AS INTEGER)) AS "OUTAGE_DURATION_HOUR",
			
      MOD(SUM(CAST(SUBSTR_AFTER(LEFT(LPAD("ELECTRICAL_OUTAGE",10,'0'),7),':') AS INTEGER)),60) as "OUTAGE_DURATION_MIN"
			
      /*TIME CALCULATION ENDS HERE */

FROM 
      "<SCHEMA>"."ELECTRICAL_OUTAGE"
GROUP BY "STATE";
