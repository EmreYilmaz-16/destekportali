﻿<cfquery name="GET_CONTENT_CAT" datasource="#DSN#">
	SELECT 
		CONTENTCAT_ID,
		CONTENTCAT 
	FROM 
		CONTENT_CAT 
	WHERE
		CONTENTCAT_ID IN 
		(
			SELECT
				CONTENTCAT_ID
			FROM
				CONTENT_CAT
			WHERE
				CONTENTCAT_ID <> 0 AND
				LANGUAGE_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="tr">
		)
</cfquery>