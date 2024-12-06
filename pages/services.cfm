
<cfset teklif_stage_list = '125,376,375'>
<cfset servis_stage_list = '768,23,28,624,378'>
<cfset process_stage_list = '125,376,375,768,23,28,624,378'>

<cfparam name="attributes.is_submit" default="">
<cfif isdefined("attributes.start_date") and isdate(attributes.start_date)>
	<cf_date tarih = "attributes.start_date">
<cfelse>
	<cfset attributes.start_date = "">
</cfif>
<cfif isdefined("attributes.finish_date") and isdate(attributes.finish_date)>
	<cf_date tarih = "attributes.finish_date">
<cfelse>
	<cfset attributes.finish_date = "">
</cfif>
<cfset DSN="#dsn#">
<cfparam name="attributes.category" default="">
<cfparam name="attributes.keyword" default="">
<cfparam name="attributes.page" default=1>
<cfparam name="attributes.ourCompany" default="1">
<cfparam name="attributes.maxrows" default=50><!---'#session.pp.maxrows#'--->
<cfset attributes.startrow=((attributes.page-1)*attributes.maxrows)+1>

<cfset getServices = createObject('component','cfc.components')>
<cfif isdefined("attributes.is_submit") and len(attributes.is_submit)>
	<cfset GET_SERVICE = getServices.GET_SERVICE_KATALIZOR(
		ourCompany : attributes.ourCompany,
		category : attributes.category,
		keyword:attributes.keyword,
		start_date:attributes.start_date,
		finish_date:attributes.finish_date,
		process_stage:attributes.process_stage,
		process_stage_list:process_stage_list,
		startrow : attributes.startrow,
		maxrows:attributes.maxrows
	)>
	<cfset attributes.totalrecords = get_service.query_count>
<cfelse>
	<cfset attributes.totalrecords = 0>
	<cfset get_service.recordcount = 0>
</cfif>

<cfset GET_PROCESS_STAGE = getServices.GET_CURRENCY(fuse:'service.list_service')>
<cfset get_service_appcat = getServices.GET_SERVICE_APPCAT_SERVICE()>

<cfparam name="attributes.keyword" default=''>
<cfparam name="attributes.process_stage" default=''>

<div class="pageContent">
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-shopping-cart"></i>Servisler
            </div>
            <div class="tools col-md-6">
                <form name="service" method="post" action="index.cfm?pageinfo=services">
                	<input type="hidden" name="is_submit" value="1" />
                    <cfoutput>
                        <input type="hidden" name="startrow" id="startrow" value="#attributes.startrow#" />
                    </cfoutput>
                    <div class="input-group searchInput col-md-6 pull-right">
                        <cfoutput>
                            <input type="text" name="keyword" id="keyword" class="form-control" value="#attributes.keyword#" placeholder="#getLang('main',48,'filtre')#">
                  
                        </cfoutput>
                        <cf_searchButton detail="1">
                    </div>
                   
                    <div class="searchDetailContent" style="display:none;">
                        <div class="portlet light bordered">                                    
                            <div class="portlet-body form">
                                <div class="form-body form-horizontal">
                                	<cfoutput>
                                        <div class="form-group">
                                            <div class="col-sm-9 pull-right">
                                            	<cf_catalystSelectbox name="category">
                                                    <option value="">#getLang('main',1739,'Tüm Kategoriler')#</option>
                                                    <cfloop query="get_service_appcat">
                                                        <option value="#servicecat_id#" <cfif isDefined('attributes.category') and attributes.category eq get_service_appcat.servicecat_id>selected</cfif>>#servicecat#</option>
                                                    </cfloop>
                                                </cf_catalystSelectbox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-9 pull-right">
                                            	<cf_catalystSelectbox name="ourCompany">
                                                	<option value="">#getLang('main',162,'Şirket')#</option>
                                                    <option value="1" <cfif attributes.ourCompany eq 1>selected</cfif>>Partner Bilgisayar</option>
                                                    <option value="2" <cfif attributes.ourCompany eq 2>selected</cfif>>Analiz Data</option>
                                                </cf_catalystSelectbox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-9 pull-right">
                                            	<cf_catalystSelectbox name="process_stage">
                                                    <option value="">#getLang('main',70,'Aşama')#</option>
                                                    <cfloop query="get_process_stage">
                                                        <option value="#process_row_id#" <cfif attributes.process_stage eq process_row_id>selected</cfif>>#stage#</option>
                                                    </cfloop>
                                                </cf_catalystSelectbox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-3 pull-right">
	                                            <input type="text" name="finish_date" id="finish_date" class="form-control datepicker" maxlength="10" value="#dateformat(attributes.finish_date,'dd/mm/yyyy')#" validate="eurodate" placeholder="#getLang('main',288,'Bitiş Tarihi')#">
                                            </div>
                                            <div class="col-sm-3 pull-right">
                                            	<input type="text" name="start_date" id="start_date" class="form-control datepicker" maxlength="10" value="#dateformat(attributes.start_date,'dd/mm/yyyy')#" validate="eurodate" placeholder="#getLang('main',641,'Başlangıç Tarihi')#">
                                            </div>
                                        </div>
                                    </cfoutput>
                                </div>
                                <div class="form-actions right">
                                	<cf_searchButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="portlet-body">
            <div class="table-scrollable">
                <table class="table table-hover table-light">
                    <thead>
                    	<cfoutput>
                            <tr>
                                <th>##</th>
                                <th>#getLang('main',75,'No')#</th>
                                <th>#getLang('main',721,'Fatura No')#</th>
                                <th>#getLang('main',68,'Konu')#</th>                                
                                <th>#getLang('main',74,'Kategori')#</th>
                                <th>#getLang('main',70,'Aşama')#</th>
                                <th>#getLang('main',71,'Kayıt')#</th>
                                <th>#getLang('service',88,'Adam')#/#getLang('main',78,'Gün')#</th>
                                <th>#getLang('objects2',726,'İlişkili İş')#</th>
                                <th>#getLang('main',330,'Tarih')#</th>
                                <th></th>
                            </tr>
                        </cfoutput>
                    </thead>
                    <tbody>	
                    	<cfif get_service.recordcount>
                        	<cfoutput query="get_service">
                                <tr>
                                    <td>#ROWNUM#</td>				
                                    <td>
                                  	<cfif listfind(teklif_stage_list,service_status_id)>
                                        	<a href="javascript://" onclick="goToModal('index.cfm?pageinfo=servicePrint&AjaxPage=1&action_id=#service_id#&is_offer=1','Servis')">#service_no#</a>
                                        <cfelse>
	                                    	<a href="javascript://" onclick="goToModal('index.cfm?pageinfo=servicePrint&AjaxPage=1&action_id=#service_id#&is_offer=1','Servis')">#service_no#</a>
                                        </cfif>
                                    </td>	
                                    <td>#doc_no#</td>
                                    <td>#service_head#</td>
                                    <td>#servicecat#</td>
                                    <td>#stage#</td>
                                    <td>#employee_name# #employee_surname#</td>
                                    <td style="text-align:right;">#toplam_saat#</td>
                                    <td style="text-align:center;">
                                    	<cfset GET_SERVICE_WORKS = getServices.GET_SERVICE_WORKS(service_id : service_id)>
                                        <cfif GET_SERVICE_WORKS.recordcount>
                                            <cfloop query="GET_SERVICE_WORKS">
                                            	<a href="javascript://" onclick="send_work('#project_id#','#encrypt(work_id,"WORKCUBE","BLOWFISH","Hex")#','#work_id#')" class="tableyazi">#work_id#</a><br/>
                                            </cfloop>
                                        </cfif>
                                    </td>
                                    <td>#dateformat(date_add('h',session.pp.time_zone,get_service.apply_date),'dd/mm/yyyy')#</td>
                                    <td>
                                        <cfif listfind(teklif_stage_list,service_status_id)>
                                        	<a href="javascript://" onclick="windowopen('index.cfm?fuseaction=objects2.popup_dsp_service_detail_2&action_id=#service_id#&is_offer=1','wide');"><i class="icons8-document"></i></a>
                                        <cfelse>
	                                    	<a href="javascript://" onclick="windowopen('index.cfm?fuseaction=objects2.popup_dsp_service_detail_2&action_id=#service_id#','wide');"><i class="icons8-document"></i></a>
                                        </cfif>
                                    </td>
                                </tr>
                            </cfoutput>
                        <cfelse>
                            <tr>
                                <td colspan="11"><cfif len(attributes.is_submit)><cfoutput>#getLang('main',72,'Kayıt Yok')#!</cfoutput><cfelse><cfoutput>#getLang('main',289,'Filtre Ediniz')#!</cfoutput></cfif></td>
                            </tr>
                        </cfif>			
                    </tbody>
                </table>
                <cf_catalystPage formName="service" page="#attributes.page#">
            </div>
        </div>
    </div>
    <span onclick="goToModal('servicePrint?AjaxPage=1','Servis');">Servis</span>
</div>
<form name="pop_gonder"  action="work" method="post">
	<input type="hidden" name="project_id" id="project_id" value="">
    <input type="hidden" name="work_id" id="work_id" value="">
</form>

<script type="text/javascript">
function send_work(project_id,work_id)
{
	document.getElementById('project_id').value = project_id;
	document.getElementById('work_id').value = work_id;
	pop_gonder.submit();
}
</script>