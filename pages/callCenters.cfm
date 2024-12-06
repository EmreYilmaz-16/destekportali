
<cfparam name="attributes.keyword" default="">
<cfparam name="attributes.subscription_id" default="">
<cfparam name="attributes.subscription_no" default="">
<cfparam name="attributes.consumer_id" default="">
<cfparam name="attributes.company_id" default="">
<cfparam name="attributes.company_name" default="">
<cfparam name="attributes.process_stage" default="">
<cfparam name="attributes.appcat_id" default="">
<cfparam name="attributes.CT" default="">
<cfparam name="attributes.getUpdate" default="">
<cfparam name="attributes.service_id" default="">
<!---
<cfparam name="attributes.appcat_sub_id" default="">
<cfparam name="attributes.appcat_sub_tree_id" default="">
--->
<cfparam name="attributes.start_date_" default="">
<cfparam name="attributes.finish_date_" default="">
<cfparam name="attributes.is_only_me" default="0">
<cfparam name="attributes.page" default=1>
<cfparam name="attributes.maxrows" default='#session.pp.maxrows#'>


<cfset attributes.startrow = ((attributes.page-1)*attributes.maxrows)+1>

<cfif isdefined("attributes.start_date_") and isdate(attributes.start_date_)>
	<cf_date tarih = "attributes.start_date_">
</cfif>
<cfif isdefined("attributes.finish_date_") and isdate(attributes.finish_date_)>
	<cf_date tarih = "attributes.finish_date_">
</cfif>

<cfset get_callCenters = createObject('component','cfc.components')>
<cfif isdefined("attributes.workcube_id") and len(attributes.workcube_id)>
	<cfset get_callCenters = get_callCenters.GET_SUBSCRIPTION(workcube_id:attributes.workcube_id)>
    <cfset attributes.subscription_id = get_callCenters.SUBSCRIPTION_ID>
    <cfset attributes.subscription_no = get_callCenters.SUBSCRIPTION_NO>
</cfif>
<cfset get_process_types = get_callCenters.GET_CURRENCY(fuse:'call.list_service')>
<cfset get_service_appcat = get_callCenters.GET_SERVICE_APPCAT()>
<cfparam name="attributes.totalrecords" default="">
<cfif isdefined("attributes.form_submitted")>
	<cfset GET_SERVICE = get_callCenters.GET_SERVICE(
		keyword : attributes.keyword,
		subscription_id:attributes.subscription_id,
		subscription_no:attributes.subscription_no,
		consumer_id:attributes.consumer_id,
		company_id:attributes.company_id,
		company_name:attributes.company_name,
		process_stage:attributes.process_stage,
		appcat_id:attributes.appcat_id,
        service_id:attributes.service_id,
		start_date_:attributes.start_date_,
		finish_date_:attributes.finish_date_,
        is_only_me:attributes.is_only_me
	)>
    <cfset attributes.totalrecords = GET_SERVICE.RECORDCOUNT>
<cfelse>
	<cfset GET_SERVICE.recordcount = 0>
</cfif>

<cfset attributes.startrow=((attributes.page-1)*attributes.maxrows)+1>

<div class="pageContent">

    <div class="portlet">

        <div class="portlet-title">
            <div class="caption">
                <cfoutput>#getLang('main',774,'başvurular')#</cfoutput>
            </div>
            <div class="tools col-md-6">
                <form name="call_center" method="post" action="index.cfm?pageinfo=callCenters" role="form">
                    <input type="hidden" name="form_submitted" id="form_submitted" value="1">
                    <input type="hidden" name="workcube_id" id="workcube_id" value="<cfif isdefined("attributes.workcube_id") and len(attributes.workcube_id)><cfoutput>#attributes.workcube_id#</cfoutput></cfif>">
                    <cfoutput>
                        <input type="hidden" name="startrow" id="startrow" value="#attributes.startrow#" />
                    </cfoutput>
                    <div class="input-group searchInput col-md-6 pull-right">
                        <cfoutput>
                            <input type="text" class="form-control" placeholder="#getLang('main',48)#" name="keyword" id="keyword" value="#attributes.keyword#">
                        </cfoutput>
						<cf_searchButton detail="1">
                    </div>
                    <div class="searchDetailContent" style="display:none;">
                        <div class="portlet light bordered">                                    
                            <div class="portlet-body form ">
                                <div class="form-body form-horizontal">  
									<cfoutput>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">#getLang('main',1420)#</label>
                                            <div class="col-sm-9">
                                                <input type="hidden" name="subscription_id" id="subscription_id" value="<cfif len(attributes.subscription_id)>#attributes.subscription_id#</cfif>">
                                                <input type="text" class="form-control" name="subscription_no" id="subscription_no" value="<cfif len(attributes.subscription_no)>#attributes.subscription_no#</cfif>">
                                                <cfset str_subscription_link="field_partner=&field_id=call_center.subscription_id&field_no=call_center.subscription_no">                                                    
                                                <!---
                                                <span class="input-group-addon" onClick="windowopen('<cfoutput>#request.self#?fuseaction=objects2.popup_list_subscription&#str_subscription_link#'</cfoutput>,'list','popup_list_subscription');">
                                                    <span class="glyphicon glyphicon-option-vertical"></span>
                                                </span>
                                                --->
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">#getLang('main',780)#</label>
                                            <div class="col-sm-9">
                                                <input type="hidden" name="consumer_id" id="consumer_id" value="<cfif len(attributes.consumer_id)>#attributes.consumer_id#</cfif>">
                                                <input type="hidden" name="company_id" id="company_id" value="<cfif len(attributes.company_id)>#attributes.company_id#</cfif>">								  
                                                <input type="text" name="company_name" id="company_name" class="form-control" value="<cfif len(attributes.company_name)>#attributes.company_name#</cfif>" onFocus="AutoComplete_Create('company_name','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_NAME,MEMBER_PARTNER_NAME','get_relation_member_objects2','\'1,2\',0,0,0','CONSUMER_ID,COMPANY_ID','consumer_id,company_id','call_center','3','250');" autocomplete="off">
                                            </div>
                                        </div>
                                    </cfoutput>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><cfoutput>#getLang('main',70)#</cfoutput></label>
                                        <div class="col-sm-9">
                                            <select name="process_stage" id="process_stage" class="form-control">
                                                <option value="" selected><cfoutput>#getLang('main',70)#</cfoutput></option>
                                                <cfoutput query="get_process_types">
                                                    <option value="#process_row_id#" <cfif attributes.process_stage eq process_row_id>selected</cfif>>#stage#</option>
                                                </cfoutput>
                                            </select>
                                        </div>
                                    </div>                                    
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><cfoutput>#getLang('main',74)#</cfoutput></label>
                                        <div class="col-sm-9">
                                            <select name="appcat_id" id="appcat_id" class="form-control"><!---  onchange="fillSelectbox(this,'GET_APPCAT_SUB','appcat_sub_id')" --->
                                                <option value=""><cfoutput>#getLang('main',74)#</cfoutput></option>
                                                <cfoutput query="get_service_appcat">
                                                    <option value="#servicecat_id#" <cfif listlen(attributes.appcat_id,'-') eq 1 and attributes.appcat_id eq servicecat_id>selected</cfif>>#servicecat#</option>
                                                </cfoutput>
                                            </select>
                                        </div>
                                    </div>
                                  
                                    <div class="form-group">
                                        <label>Yanlızca Kendi Başvurularımı Getir</label>
                                            <input type="checkbox" name="is_only_me" value="1"> 
                                    </div>
                                  <!--------------------------------------- onclick="send_callCenter('1')"
                                    <div class="form-group">
                                        <label><cfoutput>#getLang('service',66)#</cfoutput></label>
                                        <select name="appcat_sub_tree_id" id="appcat_sub_tree_id" class="form-control">
                                            <option value=""><cfoutput>#getLang('service',66)#</cfoutput></option>
                                        </select>
                                    </div>
									--->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><cfoutput>#getLang('main',641)#</cfoutput></label>
                                        <div class="col-sm-3">
                                            <input type="text" name="start_date_" id="start_date_" class="datepicker form-control" maxlength="10" value="<cfoutput>#dateformat(attributes.start_date_,'dd/mm/yyyy')#</cfoutput>">                                    
                                        </div>
                                        <label class="col-sm-3 control-label"><cfoutput>#getLang('main',288)#</cfoutput></label>
                                        <div class="col-sm-3">
                                            <input type="text" name="finish_date_" id="finish_date_" class="datepicker form-control" maxlength="10" value="<cfoutput>#dateformat(attributes.finish_date_,'dd/mm/yyyy')#</cfoutput>">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    	<cfoutput>
                                        	<label class="col-sm-3 control-label">#getLang('main',1417)#</label>
                                            <div class="col-sm-3">
                                        	    <input type="text" name="maxrows" id="maxrows" class="form-control" value="#attributes.maxrows#" required="yes" validate="integer" range="1,999" message="#getLang('main',125)#" maxlength="3">
                                            </div>
                                        </cfoutput>
                                    </div>
                                      <div class="form-group">
                                    	<cfoutput>
                                        	<label class="col-sm-3 control-label">Excell</label>
                                            <div class="col-sm-3">
                                        	 <input type="checkbox" name="is_excel">
                                            </div>
                                        </cfoutput>
                                </div>
                                <div class="form-actions text-right">
                                    <cf_searchButton>
                                </div>
                            </div>
                        </div>
                    </div>
            	</form>
            </div>
        </div>
        <div class="portlet-body">
            <div class="table-scrollable padding-15">
                <table class="table table-hover table-light">
                    <thead>
                    	<cfoutput>
                            <tr class="uppercase">
                            	<th>##</th>
                                <th>#getLang('main',75,'No')#</th>
                                <th>#getLang('main',330,'Tarih')#</th>
                                <th>#getLang('main',68,'Konu')#</th>
								<th>#getLang('main',1717,'Başvuru Yapan')#</th>
                                <th>#getLang('main',74,'Kategori')#</th>
<!---                                <th>#getLang('objects2',1639,'Alt Kategori')#</th>--->
<!---                                <th>#getLang('service',66,'Alt Tree Kategori')#</th>--->
                                <th>#getLang('main',70,'Aşama')#</th>
<!---                                <th style="text-align:center">Durum</th> ------>
                                <th>Bitiş Tarihi</th>
                               <th></th>
                                <th><a href="index.cfm?pageinfo=makecall"><img src="/images_2/add_1.gif"></a></th>
                            </tr>
                        </cfoutput>
                    </thead>
                    <cfif isDefined("attributes.is_excel")>
                        <cfscript>
                                thesheet=spreadsheetNew("Çek Analizi");
                                satir=1;
                                kolon=1;
                                spreadsheetAddRow(thesheet,"Başvuru No,Tarih,Konu,Başvuruyu Yapan,Kategori,Aşama,Bitiş Tarihi",satir);
                                 satir=satir+1;
                        </cfscript>
                    </cfif>
                    <tbody>
                    	<cfif GET_SERVICE.recordcount>
                        	<cfoutput query="get_service" startrow="#attributes.startrow#" maxrows="#attributes.maxrows#">
                                <cfquery name="getUpdate" datasource="#DSN#">
                                    SELECT ISNULL(UPDATE_DATE, (
                                            SELECT TOP 1 RECORD_DATE
                                            FROM #DSN#.G_SERVICE_PLUS AS GSP
                                            WHERE SERVICE_ID = GS.SERVICE_ID
                                            ORDER BY RECORD_DATE DESC
                                            )) AS CT
                                    FROM #DSN#.G_SERVICE AS GS
                                    WHERE 1=1 AND GS.SERVICE_ID=#SERVICE_ID#
                                </cfquery>
                                <tr>
                                	<td>#currentrow# </td>
                                    <td><a href="javascript://" onclick="send_callCenter(#service_id#)" class="tableyazi">#service_no#</a></td>
                                    <td><cfif len(apply_date)>#dateformat(apply_date,'dd/mm/yyyy')#,#timeformat(date_add('h',session.pp.time_zone,APPLY_DATE),'HH:MM')#</cfif></td>
                                    <td>#service_head#</td>
                                    <td>
                                    <cfset Cal="">
                                    	<cfif len(service_company_id) and service_company_id neq 0>
                                       <cfset Cal=FULLNAME>
                                        	<cfif len(service_partner_id) and service_partner_id neq 0 and not len(applicator_name)>
                                        	<cfset Cal="#CAL#-#PARTNER#">
                                            <cfelseif len(applicator_name)>
                                            	<cfset Cal="#CAL#-#APPLICATOR_NAME#">                                                
                                        	</cfif>
										<cfelseif len(service_company_id) and service_company_id neq 0>
                                        <cfset Cal="#CAL#-#CONSUMER#">                                                
                                        <cfelseif len(service_employee_id) and service_employee_id neq 0>
                                        <cfset Cal="#CAL#-#EMPLOYEE#">       	                                        
                                        </cfif>
                                        #CAL#
                                    </td>
                                     
                                    <td>#servicecat#</td>
                                    <td>#stage#</td>
                                    <td>#dateFormat(getUpdate.CT,"dd/mm/yyyy")#</td>
                                  <cfif isDefined("attributes.is_excel")>
                                <cfscript>                            
                                        spreadsheetAddRow(thesheet,"#service_no#,#apply_date#,#service_head#,#CAL#,#servicecat#,#stage#,#getUpdate.CT#",satir);
                                        satir=satir+1;
                                </cfscript>
                             </cfif>
                                    <cfquery name="getLastMessage" datasource="#dsn#">
                                    SELECT  RECORD_EMP,PLUS_CONTENT FROM G_SERVICE_PLUS WHERE 1=1 AND SERVICE_PLUS_ID=(SELECT MAX(SERVICE_PLUS_ID) FROM G_SERVICE_PLUS WHERE SERVICE_ID=#service_id#)
                                    </cfquery>
                                    <td>
                                    <cfif len(getLastMessage.RECORD_EMP)>
                                    <cfset mmcontent=replace(getLastMessage.PLUS_CONTENT,'"',"'")>
                                   <i class="fa fa-envelope-o"></i>

         </cfif>                           </td>
                                    <td><img src="/images_2/update_list.gif" onclick="send_callCenter(#service_id#)"> </td>
                                </tr>
                            </cfoutput>
                            <cfif isDefined("attributes.is_excel")>
                            <cfset file_name = "#createUUID()#.xls">
    <cfset drc_name_ = "#dateformat(now(),'yyyymmdd')#">
    <cfset upload_folder="">
    <cfset dir_seperator="\">
   
      <cfspreadsheet action="write" filename="#expandPath("reserve_files")#/#file_name#" name="theSheet" sheetname="CariEkstre" overwrite=true>
       <!---  <cfhttp method="get" url="destek.partnerbilgisayar.com/reserve_files/#file_name#" path="#expandPath("reserve_files")#/#file_name#" file="#file_name#" result="res"/>--->
       <cflocation  url="/reserve_files/#file_name#">
   
       
    </cfif>
    
    
                        <cfelse>
                        	<tr>
                            	<cfoutput>
	                        		<td colspan="10"><cfif isdefined("attributes.form_submitted")>#getLang('main',72)#!<cfelse>#getLang('main',289)#</cfif></td>
                                </cfoutput>
                            </tr>
                        </cfif>
                    </tbody>
                </table>
                <cf_catalystPage formName="call_center" page="#attributes.page#">
            </div>
        </div>
    </div>
</div>

<form name="pop_gonder" action="index.cfm?pageinfo=callCenter" method="post">
	<input type="hidden" name="service_id" id="service_id" value="">
</form>

<script type="text/javascript">
$(document).ready(function(){
    $('.tltiiip').tooltip({ boundary: 'window' })
})
	function send_callCenter(degisken)
	{
		document.getElementById('service_id').value = degisken;
		pop_gonder.submit();
	}
</script>