<cfparam name="attributes.project_id" default="">
<cfif len(attributes.project_id)>
	<cfset project_detail = createObject('component','cfc.components').PROJECT_DETAIL(project_id:attributes.project_id)>
<cfelse>
	<cfset project_detail.recordcount = 0>
</cfif>
<cfif not project_detail.recordcount>
	<script language="javascript">
		alert("<cfoutput>#getLang('main',1531)#</cfoutput>!");
		window.location.href = 'projects';
	</script>
</cfif>
<cfset GET_EMPS = createObject('component','cfc.components').GET_EMPS(project_id:attributes.project_id)>
<cfset GET_PARS = createObject('component','cfc.components').GET_PARS(project_id:attributes.project_id)>
<cfset get_asset = createObject('component','cfc.components').GET_ASSET(project_id:attributes.project_id)>
<cfset GET_RELATED_EVENTS = createObject('component','cfc.components').GET_RELATED_EVENTS(project_id:attributes.project_id)>
<cfset GET_CONTENT_RELATION = createObject('component','cfc.components').GET_CONTENT_RELATION(project_id:attributes.project_id)>
<cfset GET_ONLINE_USERS = createObject('component','cfc.components').GET_ONLINE_USERS(project_id:attributes.project_id)>

<div class="pageContent">
    <div class="row">
		<cfoutput>
            <div class="portlet light">
                <div class="portlet-title tabbable-line">
                    <div class="caption">
                        <strong>#getLang('main',4)#:</strong> #project_detail.PROJECT_HEAD#
                    </div>
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="##tab_det" data-toggle="tab"> Detay </a>
                        </li>
                        <li>
                            <a href="##tab_squad" data-toggle="tab"> Ekip </a>
                        </li>
                        <li>
                            <a href="##tab_task" data-toggle="tab" onclick="goTo('index.cfm?pageinfo=projectWorks&project_id=#attributes.project_id#','projectWorks');"> Görevler </a>
                        </li>
                        <li>
                            <a href="##tab_agenda" data-toggle="tab" onclick="goTo('index.cfm?pageinfo=agenda&project_id=#attributes.project_id#','Calendar');"> Ajanda </a>
                        </li>
                        <li>
                            <a href="##tab_docs" data-toggle="tab"> Doküman </a>
                        </li>
                    </ul>
                </div>
                <div class="portlet-body">
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="tab_det">
                            <div class="row form-horizontal">
                            	<div class="col-md-9 col-xs-12">
                                	<div class="row well well-spacial">
                                    	<div class="col-md-6">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('main',217)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">#project_detail.PROJECT_DETAIL#</p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('objects2',674)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">#project_detail.project_target#</p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('main',246)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">
                                                        <cfif len(project_detail.partner_id)>
                                                            #project_detail.COMPANY_PARTNER#
                                                        <cfelseif len(project_detail.consumer_id)>
                                                            #project_detail.CONSUMER#
                                                        <cfelseif len (project_detail.company_id)>
                                                            #project_detail.FULLNAME#
                                                        </cfif>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('objects2',676)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">
                                                        <cfif len(project_detail.related_project_id)>
                                                            #project_detail.PROJECT_HEAD2#
                                                        <cfelse>
                                                            #getLang('main',1047)#
                                                        </cfif>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('objects2',677)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">
                                                        <cfset target_start = date_add('h',session.pp.time_zone,project_detail.target_start)>
                                                        #Dateformat(target_start,'dd/mm/yyyy')# #Timeformat(target_start,'HH:mm')# -
                                                        <cfset target_finish = date_add('h',session.pp.time_zone,project_detail.target_finish)>
                                                        #Dateformat(target_finish,'dd/mm/yyyy')# #Timeformat(target_finish,'HH:mm')#
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('objects2',675)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">
                                                        <cfif (project_detail.outsrc_partner_id neq 0) and len(project_detail.outsrc_partner_id)>
                                                            <cfoutput>#project_detail.COMPANY_PARTNER2#</cfoutput>
                                                        <cfelseif len(project_detail.project_emp_id)>
                                                            <cfoutput>#project_detail.EMPLOYEE#</cfoutput>
                                                        </cfif>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('main',70)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">#project_detail.STAGE#</p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('main',73)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">#project_detail.PRIORITY#</p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('objects2',116)#</label>
                                                <div class="col-sm-9">
                                                    <p class="form-control-static">
                                                        <cfset days=abs(datediff("d",project_detail.target_finish,project_detail.target_start))>
                                                        #days+1# gün
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label bold">#getLang('objects2',92)#</label>
                                                <div class="col-sm-9">
                                                    <div class="progress margin-top-7">
                                                        <cfif len(project_detail.complete_rate)>
                                                            <cfset success = Int(project_detail.complete_rate)>
                                                            <cfset warning = Int(100-project_detail.complete_rate)>
                                                        <cfelse>
                                                            <cfset success = 0>
                                                            <cfset warning = 100>
                                                        </cfif>
                                                        <div class="progress-bar progress-bar-success" style="width: #success#%">
                                                            <span class="sr-only">#success#%</span>#success#%
                                                        </div>
                                                        <div class="progress-bar progress-bar-warning progress-bar-striped" style="width: #warning#%">
                                                            <span class="sr-only">#warning#%</span>#warning#%
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>                        
                                        </div>
                                        <label class="col-md-12 portletFooter">Kayıt : #project_detail.RECORD_EMPLOYEE# <cfif len(project_detail.update_employee)>&nbsp;&nbsp;&nbsp;Güncelleme : #project_detail.UPDATE_EMPLOYEE#</cfif></label>
                                    </div>
                                </div>
                                <div class="col-md-3 col-xs-12">
                                	<div class="portlet light bordered">
                                        <div class="portlet-title">
                                            <div class="caption">
                                                <i class="fa fa-users"></i>Online Kullanıcılar
                                            </div>
                                        </div>
                                        <div class="portlet-body" style="height: auto;">
                                            <ul class="list-group">
                                                <cfloop query="GET_ONLINE_USERS">
                                                    <li class="list-group-item">#EMPLOYEE#</li>
                                                </cfloop>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>                           
                        </div>
                        <div role="tabpanel" class="tab-pane" id="tab_squad">
							<cfif get_emps.recordcount or get_pars.recordcount>
                                <div class="portlet">                                    
                                    <div class="portlet-body portlet-collapsed-on-mobile" style="height: auto;">
                                        <div class="row">
                                        	<cfloop query="GET_EMPS">
                                                <div class="col-md-6 col-xs-12">
                                                	<div class="row">
                                                        <div class="col-md-6 col-xs-12">
                                                        	<img class="img-circle" alt="" src="documents/hr/##">
                                                        </div>
                                                        <div class="col-md-6 col-xs-12">
                                                        	<a>#GET_EMPS.EMPLOYEE#</a> - #GET_EMPS.PROJECT_ROLES#
                                                        </div>
                                                    </div>
                                                </div>
                                            </cfloop>
                                            <cfloop query="GET_PARS">
                                                <div class="col-md-6 col-xs-12">
                                                	<div class="row">
                                                        <div class="col-md-6 col-xs-12">
                                                        	<img class="img-circle" alt="" src="documents/hr/##">
                                                        </div>
                                                        <div class="col-md-6 col-xs-12">
                                                        	<a>#GET_PARS.PARTNER#</a> - #GET_PARS.PROJECT_ROLES#
                                                        </div>
                                                    </div>
                                                </div>
                                            </cfloop>
                                        </div>			
                                    </div>
                                </div>
                            </cfif>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="tab_task">
							<div class="portlet-body projectWorks" style="height: auto;"></div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="tab_agenda">
                        	<div class="portlet-body Calendar" style="height: auto;"></div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="tab_docs">
							<cfif get_asset.recordcount>
                                <div class="portlet">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-gift"></i>İlişkili Belgeler
                                        </div>
                                    </div>
                                    <div class="portlet-body" style="height: auto;">
                                        <ul class="list-group">
                                            <cfloop query="get_asset">
                                                <li class="list-group-item"><a href="http://w3.partnerbilgisayar.com/documents/project/#asset_file_name#" download>#ASSET_NAME#</a><i class="icons8-refresh pull-right"></i></li>
                                            </cfloop>
                                        </ul>
                                    </div>
                                </div>
                            </cfif>
							<cfif GET_CONTENT_RELATION.recordcount>
                                <div class="portlet">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-gift"></i>Projeyle İlişkili İçerikler   
                                        </div>
                                    </div>
                                    <div class="portlet-body" style="height: auto;">
                                        <ul class="list-group">
                                            <cfloop query="get_content_relation">
                                                <li class="list-group-item"><a href="index.cfm?pageinfo=content&cid=#content_id#">#cont_head#</a></li>
                                            </cfloop>
                                        </ul>
                                    </div>
                                </div>
                            </cfif>
							<cfif GET_RELATED_EVENTS.recordcount>
                                <div class="portlet">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-gift"></i>#getLang('main',581)#
                                        </div>
                                    </div>
                                    <div class="portlet-body" style="height: auto;">
                                        <ul class="list-group">
                                            <cfloop query="get_related_events">
                                                <li class="list-group-item">#DateFormat(startdate,'dd/mm/yyyy')#- #Left(event_head,25)#<cfif len(event_head) gt 25>..</cfif>  <a href="index.cfm?pageinfo=agendaDet&eventId=#encrypt(event_id,"WORKCUBE","BLOWFISH","Hex")#" class="pull-right"><i class="icons8-refresh"></i></a></li>
                                            </cfloop>
                                        </ul>
                                    </div>
                                </div>
                            </cfif>
                        </div>
                    </div>			
                </div>
            </div>
        </cfoutput>
    </div>
</div>