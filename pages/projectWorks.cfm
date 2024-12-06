<cfparam name="attributes.keyword" default="">
<cfparam name="attributes.currency" default="">
<cfparam name="attributes.priority_cat" default="">
<cfparam name="attributes.work_status" default="1">
<cfparam name="attributes.page" default="1">
<cfparam name="attributes.maxrows" default='#session.pp.maxrows#'>
<cfparam name="attributes.startrow" default="1">
<cfparam name="attributes.work_milestones" default="">
<cfparam name="attributes.ordertype" default="1">
<cfset attributes.startrow = ((attributes.page-1)*attributes.maxrows)+1>

<cfset getComponent = createObject('component','cfc.components')>
<cfset get_procurrency = getComponent.GET_CURRENCY(fuse:'objects2.list_projects')>
<cfset get_cats = getComponent.GET_PRIORITY()>
<cfif not isdefined("attributes.project_id")><!--- Sol Menüden tüm işleri çekmek için cağrılmıyor --->
	<cfset fullPage = 1>
	<cfset attributes.project_id = getComponent.GET_PROJECTS_AUTH()>
<cfelse>
	<cfset fullPage = 0>
</cfif>
<cfset GET_PRO_WORK = getComponent.GET_PRO_WORK(project_id:attributes.project_id,keyword:attributes.keyword,currency:attributes.currency,priority_cat:attributes.priority_cat,work_status:attributes.work_status,work_milestones:attributes.work_milestones)>
<cfparam name="attributes.totalrecords" default='#get_pro_work.recordcount#'>
<cfif fullPage eq 1>
	<div class="pageContent">
</cfif>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <cfoutput>#getLang('service',62,'Görevler')#</cfoutput>
        </div>
        <div class="tools col-md-6">
            <form class="form-inline" name="formProjectWorks" id="formProjectWorks" method="post">
                <cfoutput>
                    <input type="hidden" name="startrow" id="startrow" value="#attributes.startrow#" />
                    <div class="input-group searchInput col-md-6 pull-right">
                        <input type="text" class="form-control" name="keyword" id="keyword" value="<cfoutput>#attributes.keyword#</cfoutput>" maxlength="255">
                        <cfif fullPage eq 0>
                            <cf_searchButton detail="1" onclick="callProjectWorks()">
                         <cfelse>
                            <cf_searchButton detail="1">
                         </cfif>
                    </div>
                    <div class="searchDetailContent" style="display:none;">
                        <cfoutput>
                            <div class="portlet light bordered">                                    
                                <div class="portlet-body form">
                                    <div class="form-body form-inline">
                                        <div class="form-group">
                                        	<cf_catalystSelectbox name="currency">
                                                <option value="">#getLang('main',70,'Aşama')#</option>
                                                <cfloop query="get_procurrency">
                                                    <option value="#process_row_id#" <cfif attributes.currency eq process_row_id>selected</cfif>>#stage#</option>
                                                </cfloop>
                                            </cf_catalystSelectbox>
                                        </div>
                                        <div class="form-group">
                                        	<cf_catalystSelectbox name="priority_cat">
                                                <option value="">#getLang('main',73,'Öncelik')#</option>
                                                <cfloop query="get_cats">
                                                    <option value="#priority_id#" <cfif attributes.priority_cat eq priority_id>selected</cfif>>#priority#</option>
                                                </cfloop>
                                            </cf_catalystSelectbox>
                                        </div>
                                        <div class="form-group">
                                        	<cf_catalystSelectbox name="order_type">
                                            	<option value="">#getLang('main',1512,'Sıralama')#</option>
                                                <option value="1" <cfif attributes.ordertype eq 1>selected</cfif>>İş ID ye Göre Azalan</option>                     
                                                <option value="2" <cfif attributes.ordertype eq 2>selected</cfif>>Güncellemeye Göre Azalan</option>
                                                <option value="3" <cfif attributes.ordertype eq 3>selected</cfif>>Başlangıç Tarihine Göre Azalan</option>
                                                <option value="4" <cfif attributes.ordertype eq 4>selected</cfif>>Başlangıç Tarihine Göre Artan</option>
                                                <option value="5" <cfif attributes.ordertype eq 5>selected</cfif>>Bitiş Tarihine Göre Azalan</option>
                                                <option value="6" <cfif attributes.ordertype eq 6>selected</cfif>>Bitiş Tarihine Göre Artan</option>
                                                <option value="7" <cfif attributes.ordertype eq 7>selected</cfif>>İş Başlığına Göre Alfabetik</option>
                                            </cf_catalystSelectbox>
                                        </div>
                                        <div class="form-group">
                                        	<cf_catalystSelectbox name="work_milestones">
                                            	<option value="">Milestone</option>
                                                <option value="0" <cfif attributes.work_milestones eq 0>selected="selected"</cfif>>Milestonlar Hariç</option>
                                                <option value="1" <cfif attributes.work_milestones eq 1>selected="selected"</cfif>>Milestonelar Dahil</option>
                                            </cf_catalystSelectbox>
                                        </div>
                                        <div class="form-group">
                                        	<cf_catalystSelectbox name="work_status">
                                            	<option value="">#getLang('main',344,'Durum')#</option>
                                                <option value="1" <cfif attributes.work_status eq 1>selected="selected"</cfif>>#getLang('main',81)#</option>
                                                <option value="-1" <cfif attributes.work_status eq -1>selected="selected"</cfif>>#getLang('main',82)#</option>
                                                <option value="0" <cfif attributes.work_status eq 0>selected="selected"</cfif>>#getLang('main',296)#</option>
                                            </cf_catalystSelectbox>
                                        </div>
                                        <div class="form-group">
                                            <input type="number" class="form-control" id="maxrows" name="maxrows" value="#attributes.maxrows#">
                                        </div>
                                    </div>
                                    <div class="form-actions right">
                                    	 <cfif fullPage eq 0>
                                         	<cf_searchButton onclick="callProjectWorks()">
                                         <cfelse>
                                         	<cf_searchButton>
                                         </cfif>
                                    </div>
                                </div>
                            </div>
                        </cfoutput>
                    </div>
                </cfoutput>
            </form>
        </div>
    </div>
	<div class="portlet-body">
        <div class="table-scrollable">
            <table class="table table-hover table-light">
                <thead>
                    <cfoutput>
                        <tr class="uppercase">
                            <th>#getLang('main',75)#</th>
                            <th>#getLang('project',93)#</th>
                            <th>#getLang('main',157)#</th>
                            <th>#getLang('main',73)#</th>
                            <th>#getLang('main',1457)#</th>
                            <th>#getLang('project',334)#</th>
                            <th>#getLang('main',70)#</th>
                        </tr>
                    </cfoutput>
                </thead>
                <tbody>
                    <cfif GET_PRO_WORK.recordcount>	
                        <cfoutput query="GET_PRO_WORK" startrow="#attributes.startrow#" maxrows="#attributes.maxrows#">
                            <tr>
                                <td>#currentrow#</td>
                                <td>
                                    <a href="javascript://" onclick="send_work('#project_id#','#encrypt(work_id,"WORKCUBE","BLOWFISH","Hex")#','#work_id#')" class="tableyazi">
                                        <cfif type eq 0>
                                            <b>(M) #work_head#</b>
                                        <cfelse>
                                            <cfif len(milestone_work_id) and attributes.work_milestones neq 0>&nbsp;&nbsp;&nbsp;&nbsp;</cfif>
                                            #work_head#
                                        </cfif>
                                    </a>
                                </td>
                                <td>#employee#</td>
                                <td>#priority#</td>
                                <cfif isdefined('target_finish') and len(target_finish)>
                                    <cfset fdate_plan=date_add("h",session.pp.time_zone,target_finish)>
                                <cfelse>
                                    <cfset fdate_plan=''>
                                </cfif>
                                <cfif isdefined('target_start') and len(target_start)>
                                    <cfset sdate_plan=date_add("h",session.pp.time_zone,target_start)>
                                <cfelse>
                                    <cfset sdate_plan = ''>
                                </cfif>
                                <td>
                                    <cfif isdefined('sdate_plan') and len(sdate_plan)>
                                        <font color="#COLOR#">#dateformat(sdate_plan,'dd/mm/yyyy')#,#timeformat(sdate_plan,'HH:mm')#</font><br />
                                    </cfif>
                                    <cfif isdefined('fdate_plan') and len(fdate_plan)>
                                        <font color="#COLOR#">#dateformat(fdate_plan,'dd/mm/yyyy')#,#timeformat(fdate_plan,'HH:mm')#</font>
                                    </cfif>
                                </td>
                                <cfif isdefined('real_finish') and len(real_finish)>
                                    <cfset fdate=date_add("h",session.pp.time_zone,real_finish)>
                                <cfelse>
                                    <cfset fdate=''>
                                </cfif>
                                <cfif isdefined('real_start') and len(real_start)>
                                    <cfset sdate=date_add("h",session.pp.time_zone,real_start)>
                                <cfelse>
                                    <cfset sdate = ''>
                                </cfif>
                                <td>
                                    <cfif isdefined('sdate') and len(sdate)>
                                        <font color="#COLOR#">#dateformat(sdate,'dd/mm/yyyy')#,#timeformat(sdate,'HH:mm')#</font><br />
                                    </cfif>
                                    <cfif isdefined('fdate') and len(fdate)>
                                        <font color="#COLOR#">#dateformat(fdate,'dd/mm/yyyy')#,#timeformat(fdate,'HH:mm')#</font>
                                    </cfif>
                                </td>
                                <td>#stage#</td>
                            </tr>
                        </cfoutput>
                    <cfelse>
                        <tr>
                            <td colspan="7"></td>
                        </tr>
                    </cfif>
                </tbody>
            </table>
            <cfif fullPage eq 0>
                <cf_catalystPage formName="formProjectWorks" page="#attributes.page#" ajaxFunction="callProjectWorks(#attributes.page#)">
            <cfelse>
            	<cf_catalystPage formName="formProjectWorks" page="#attributes.page#">
            </cfif>
        </div>
    </div>
</div>
<cfif fullPage eq 1>
	</div>
</cfif>

<form name="pop_gonder" action="index.cfm?pageInfo=work" method="post">
	<input type="hidden" name="project_id" id="project_id" value="">
    <input type="hidden" name="work_id" id="work_id" value="">
</form>

<script type="text/javascript">
function callProjectWorks(page){
	<cfoutput>
		goTo('projectWorks?project_id=#attributes.project_id#&'+$("##formProjectWorks").serialize(),'projectWorks');    
	</cfoutput>
}

function send_work(project_id,work_id)
{
	document.getElementById('project_id').value = project_id;
	document.getElementById('work_id').value = work_id;
	pop_gonder.submit();
}

</script>