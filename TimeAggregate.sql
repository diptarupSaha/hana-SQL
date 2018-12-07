/*
	Scenario:
				
				
		Sample Table
		---------------------------------------------------
		ID   |       STATE	|     ELECTRICAL_OUTAGE
		---------------------------------------------------
		1    |	Karnataka	|      4316:52:00
		2    |	Karnataka	|        16:01:00
		3    |	Karnataka	|       345:23:00
		4    |	Rajasthan	|        56:23:00
		5    |	Rajasthan	|	 12:00:00
		6    |	Rajasthan	|	 32:00:00
		---------------------------------------------------
		
		
		Find the Total Hours & Minutes of Electrical Outage for the each state
		As seconds value as 00 here I have considered only HH:MM
*/

SELECT
      "STATE",
      COUNT("ID") AS COUNT_OUTAGE,

      /* TIME CALCULATION STARTS HERE */
			
      (CAST(SUM(CAST(SUBSTR_AFTER(LEFT(LPAD("ELECTRICAL_OUTAGE",10,'0'),7),':') as integer))/60 AS INTEGER) 
      + CAST(SUM(CAST(SUBSTR_BEFORE("ELECTRICAL_OUTAGE",':') AS INTEGER)) AS INTEGER)) AS "OUTAGE_DURATION_HOUR",
			
      MOD(SUM(CAST(SUBSTR_AFTER(LEFT(LPAD("ELECTRICAL_OUTAGE",10,'0'),7),':') as integer)),60) as "OUTAGE_DURATION_MIN"
			
      /*TIME CALCULATION ENDS HERE */

FROM 
      "SCHEMA"."TABLE_NAME"
group by "STATE";
