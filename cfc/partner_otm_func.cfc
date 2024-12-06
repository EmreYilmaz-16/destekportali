<cfcomponent>
	<cfset dsn = application.systemParam.params().dsn>
    
    <!--- Genel --->
    <cffunction name="GetCuuretCurrencyVal" access="remote" returnType="string" returnFormat="JSON">
        <cfargument  name="currParam">
        <cfquery name="GetCurr" datasource="#dsn#">
        select * from #dsn#.SETUP_MONEY where RECORD_DATE =(select MAX(RECORD_DATE) from #dsn#.SETUP_MONEY WHERE MONEY='#currParam#') and  MONEY='#currParam#'
        </cfquery>

        <cfreturn "#GetCurr.RATE2#">
    </cffunction>
</cfcomponent>