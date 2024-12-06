<cfparam name="attributes.keyword" default="">
<cfparam name="attributes.currency" default="">
<cfparam name="attributes.priority_cat" default="">
<cfparam name="attributes.project_status" default="1">
<cfparam name="attributes.page" default=1>
<cfparam name="attributes.maxrows" default='#session.pp.maxrows#'>
<cfset get_projects_action = createObject('component','cfc.components')>
<cfif isdefined("attributes.form_submitted")>
	<cfset get_projects = get_projects_action.projects(keyword : attributes.keyword,currency:attributes.currency,priority_cat:attributes.priority_cat,project_status:attributes.project_status)>
<cfelse>
	<cfset get_projects.recordcount = 0>
</cfif>
<cfset get_procurrency = get_projects_action.GET_CURRENCY(fuse:'objects2.list_projects')>
<cfset get_cats = get_projects_action.GET_PRIORITY()>
<cfparam name="attributes.totalrecords" default="#get_projects.recordcount#">
<cfset attributes.startrow=((attributes.page-1)*attributes.maxrows)+1>

<div class="pageContent">
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                <cfoutput>#getLang('main',4)#</cfoutput>
			</div>
            <div class="tools col-md-6">
          
            	<form name="projects" action="index.cfm?pageInfo=projects" method="post" role="form">
                	<input type="hidden" name="form_submitted" value="1" />
                    <div class="input-group searchInput col-md-6 pull-right">
                    	<input type="text" class="form-control" name="keyword" id="keyword" value="<cfoutput>#attributes.keyword#</cfoutput>" maxlength="255">
                        <cf_searchButton detail="1">
                    </div>
                    <div class="searchDetailContent" style="display:none;">
                    	<cfoutput>
                            <div class="portlet light bordered">                                    
                                <div class="portlet-body form">
                                    <div class="form-body form-inline">
                                        <div class="form-group">
                                            <cf_catalystSelectbox name="priority_cat">
                                                <option value="">#getLang('main',73)#</option>
                                                <cfloop query="get_cats">
                                                    <option value="#priority_id#"<cfif isDefined("attributes.priority_cat") and (attributes.priority_cat is priority_id)>selected</cfif>>#priority#</option>
                                                </cfloop>
                                            </cf_catalystSelectbox>
                                        </div>
                                        <div class="form-group">
                                            <cf_catalystSelectbox name="currency">
                                                <option value=""><cfoutput>#getLang('main',70)#</cfoutput></option>
                                                <cfloop query="get_procurrency">
                                                    <option value="#process_row_id#"<cfif attributes.currency eq process_row_id>selected</cfif>>#stage#</option>
                                                </cfloop>
                                            </cf_catalystSelectbox>
                                        </div>
                                        <div class="form-group">
                                        	<cf_catalystSelectbox name="project_status">
                                                <option value="0" <cfif isDefined("attributes.project_status") and (attributes.project_status eq 0)>selected</cfif>>#getLang('main',296)#</option>
                                                <option value="1" <cfif isDefined("attributes.project_status") and (attributes.project_status eq 1)>selected</cfif>>#getLang('main',81)#</option>
                                                <option value="-1" <cfif isDefined("attributes.project_status") and (attributes.project_status eq -1)>selected</cfif>>#getLang('main',82)#</option>
                                            </cf_catalystSelectbox>
                                        </div>
                                    </div>
                                    <div class="form-actions right">
                                        <cf_searchButton>
                                    </div>
                                </div>
                            </div>
                        </cfoutput>
                    </div>
                </form>
            </div>
        </div>
        <div class="portlet-body">
            <div class="table-scrollable">
                <table class="table table-hover table-light">
                    <thead>
                        <tr class="uppercase">
                            <th><cfoutput>#getLang('main',75)#</cfoutput></th>
                            <th><cfoutput>#getLang('main',4)#</cfoutput></th>
                            <th><cfoutput>#getLang('main',162)#</cfoutput></th>
                            <th><cfoutput>#getLang('main',73)#</cfoutput></th>
                            <th><cfoutput>#getLang('main',288)#</cfoutput></th>
                            <th><cfoutput>#getLang('main',70)#</cfoutput></th>     
                        </tr>
                    </thead>
                    <tbody>
                    
                        <cfif get_projects.recordcount>

                            <cfoutput query="get_projects" startrow="#attributes.startrow#" maxrows="#attributes.maxrows#">
                                <tr>
                                    <td>#CurrentRow#</td>
                                    <td><a href="javascript://" onclick="sent_project(#project_id#)" class="tableyazi">&nbsp;#project_head#</a></td>
                                    <td>#FULLNAME#</td>
                                    <td><span class="label label-sm" style="background-color:###get_projects.color#;">#priority#</td>
                                    <td>#dateformat(target_finish,"dd/mm/yyyy")#</td>
                                    <td>#STAGE#</td>
                                </tr>
                            </cfoutput>
                        <cfelse>
                            <tr>
                                <td colspan="8"><cfoutput><cfif isdefined("attributes.form_submitted")>#getLang('main',72)#!<cfelse>#getLang('main',289)#</cfif></cfoutput></td>
                            </tr>
                        </cfif>                   
                    </tbody>
                </table>
                <cf_catalystPage formName="call_center" page="#attributes.page#">
            </div>
        </div>
    </div>
</div>
<form name="pop_gonder" action="index.cfm?pageinfo=projectDetail" method="post">
	<input type="hidden" name="project_id" id="project_id" value="">
</form>

<script type="text/javascript">
	function sent_project(degisken)
	{
		document.getElementById('project_id').value = degisken;
		pop_gonder.submit();
	}
</script>