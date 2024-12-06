<cfquery name="getGroup" datasource="#dsn#">
SELECT PROJECT_ID FROM #dsn#.WORK_GROUP WHERE WORKGROUP_ID IN (SELECT WORKGROUP_ID FROM #dsn#.WORKGROUP_EMP_PAR WHERE PARTNER_ID=2053)
</cfquery>
    <div class="pageContent">
            <div class="row">
                <div class="col-md-12">
                <div class="portlet">
                    <div class="portlet-title">

                    <cfoutput>
                    #checkDenied('attributes.pageinfo',session.pp.userid)#
                    </cfoutput>
<cfdump  var="#getGroup#">
<cfset val1 =valueList(getGroup.PROJECT_ID)>
<cfdump  var="#VAL1#">
</div>
</div>
</div>
</div>
</div>