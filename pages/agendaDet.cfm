<cfset attributes.eventId = decrypt('#attributes.eventId#',"WORKCUBE","BLOWFISH","Hex")>
<cfif len(attributes.eventId)>
	<cfset getComponent = createObject('component','cfc.components')>
	<cfset agenda = getComponent.GET_AGENDA(eventId:attributes.eventId)>
    <cfset agendaTo = getComponent.GET_AGENDA_TO(eventId:attributes.eventId)>
    <cfset agendaCC = getComponent.GET_AGENDA_CC(eventId:attributes.eventId)>
    <cfoutput query="agenda">
        <div class="pageContent">
            <div class="row">
                <div class="col-md-12">
                <div class="portlet">
                    <div class="portlet-title">
                        <div class="caption">
                            <strong>#getLang('main',3,'Ajanda')# : <a href="agenda?date=#dateFormat(STARTDATE,'yyyy-mm-dd')#" class="tableyazi">#EVENT_HEAD#</a></strong>
                        </div>				
                    </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-9 col-xs-12 well well-spacial">
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label class="control-label col-md-3 bold">#getLang('main',1447,'Süreç')#</label>
                                <div class="col-sm-9">
                                    <p class="form-control-static">#STAGE#</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 bold">#getLang('main',74,'Kategori')#</label>
                                <div class="col-md-9">
                                    <p class="form-control-static">#EVENTCAT#</p>
                                </div>
                            </div>                            
                        </div><!--- row --->
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label class="control-label col-md-3 bold">#getLang('main',89,'Başlangıç')#</label>
                                <div class="col-md-9">
                                	<p class="form-control-static">#dateFormat(STARTDATE,'dd/mm/yyyy')# #TimeFormat(dateAdd('h',session.pp.time_zone,STARTDATE),'hh:mm')#</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 bold">#getLang('main',90,'Bitiş')#</label>
                                <div class="col-md-9">
                                	<p class="form-control-static">#dateFormat(FINISHDATE,'dd/mm/yyyy')# #TimeFormat(dateAdd('h',session.pp.time_zone,FINISHDATE),'hh:mm')#</p>
                                </div>
                            </div>       
                        </div><!--- row --->
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                        	<div class="form-group">
                                <label class="control-label col-md-3 bold">#getLang('main',68,'Konu')#</label>
                                <div class="col-md-9">
                                    <p class="form-control-static">#EVENT_HEAD#</p>
                                </div>
                            </div>
                         </div>
                         <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-3 bold">#getLang('main',217,'Açıklama')#</label>
                                <div class="col-md-12" id="test">
                                    <pre class="maxHeight">#EVENT_DETAIL#</pre>
                                </div>
                            </div>
                         </div>
                    </div>
                    <label class="col-md-12 portletFooter">Kayıt : #RECORD# - #dateformat(RECORD_DATE,"dd/mm/yyyy (HH:mm)")# &nbsp;&nbsp;&nbsp;Güncelleme : #UPD# - #dateformat(UPDATE_DATE,"dd/mm/yyyy (HH:mm)")#</label>
                </div>
                <div class="col-md-3 col-xs-12">
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-users"></i>Katılımcılar
                            </div>
                        </div>
                        <div class="portlet-body" style="height: auto;">
                            <ul class="list-group">
                            	<cfloop query="agendaTo">
                                	<li class="row">
                                    	<div class="col-md-6"><a>#EMPLOYEE#</a></div>
                                        <div class="col-md-6">#FULLNAME#</div>
                                    </li>
                                </cfloop>
                            </ul>
                        </div>
                    </div>
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-info"></i>Bilgi Verilecekler
                            </div>
                        </div>
                        <div class="portlet-body" style="height: auto;">
                            <ul class="list-group">
                            	<cfloop query="agendaCC">
	                                <li class="row">
                                    	<div class="col-md-6"><a>#EMPLOYEE#</a></div>
                                        <div class="col-md-6">#FULLNAME#</div>
                                    </li>
                                </cfloop>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
</cfif>

<!---
<script>
$("#test").val("<pre>"+JSON.stringify(<cfoutput>#Replace(eventDetail_#</cfoutput>)+"</pre>");
</script>
--->