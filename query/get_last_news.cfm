﻿<cfquery name="GET_LAST_NEWS" datasource="#DSN#" maxrows="10">
	SELECT 
		C.CONTENT_ID,
		C.CONT_HEAD
	  FROM 
		CONTENT C,
		CONTENT_CAT CC, 
		CONTENT_CHAPTER CCH
	  WHERE 	
		C.EMPLOYEE_VIEW = 1 AND	
		C.CHAPTER_ID = CCH.CHAPTER_ID AND	
		CCH.CONTENTCAT_ID = CC.CONTENTCAT_ID AND
		CC.LANGUAGE_ID = '#session.ep.language#' AND 
		C.STAGE_ID = -2 AND
		C.CONTENT_STATUS = 1 AND
		C.IS_DSP_HEADER = 0 AND
		CAST(C.CONT_POSITION AS CHAR(6)) LIKE '%2%'
	ORDER BY 
		C.CONTENT_ID DESC	
</cfquery>