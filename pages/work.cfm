<cfset attributes.workId = decrypt('#attributes.work_id#',"WORKCUBE","BLOWFISH","Hex")>
<cfset getComponent = createObject('component','cfc.components')>
<cfset workDetail = getComponent.get_work(workId:attributes.workId)>
<div class="pageContent">
	<cfoutput query="workDetail">
        <div class="row">
            <div class="col-md-12 ">
            <div class="portlet">
                <div class="portlet-title">
                    <div class="caption">
                        <cfoutput>
                            <span onclick="send_callCenter(#G_SERVICE_ID#);" class="btnPointer"><strong>#SERVICE_NO#</strong>&nbsp;#SERVICE_HEAD#</span>
                        </cfoutput>
                    </div>				
                </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 padding-LR-30">
                <div class="row margin-0 work_detail">
                    <div class="col-lg-2 col-sm-3 col-xs-12 padding-0">
                        <div class="portlet light bg-grey-cararra bg-font-grey-cararra borderR-grey">
                            <!-- SIDEBAR USERPIC -->
                            <div class="profile-userpic">
                            	<cfif len(PHOTO)>
                                	<img src="documents/hr/#PHOTO#" class="img-responsive" alt="">
                                <cfelseif GENDER EQ 1>
                                	Erkek
                                <cfelse>
                                	Kadın
                                </cfif>
							</div>
                            <div class="profile-usertitle">
                                <div class="profile-usertitle-name">#EMPLOYEE#</div>
                                <div class="profile-usertitle-job">#POSITION#</div>
                            </div>
                            <div class="profile-usermenu">
                                <ul class="nav text-center">
                                    <li title="Kategori">
                                        <a class="font-yellow-gold bold"><i class="fa fa-briefcase"></i>#WORK_CAT#</a>
                                    </li>
                                    <li title="Aktivite Tipi">
                                        <a class="font-green-meadow bold"><i class="fa fa-cubes"></i>#ACTIVITY#</a>
                                    </li>
                                    <li title="Öncelik">
                                        <a class="font-red-pink bold"><i class="fa fa-sort-amount-asc "></i>#PRIORITY#</a>
                                    </li>
                                    <li title="Süreç">
                                        <a class="font-blue bold"><i class="fa fa-tree"></i>#STAGE#</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-10 col-sm-9 col-xs-12 padding-0">
                        <div class="portlet light bg-grey-cararra bg-font-grey-cararra margin-0">
                            <div class="portlet-title">
                                <div class="caption font-green-jungle">
                                    <strong>###attributes.workId#</strong>&nbsp;#WORK_HEAD#
                                </div>
                                <div class="tools">
                                    <a class="margin-left-8" title="Zaman Gir"><i class="fa fa-flag-checkered"></i></a>									
                                    <a class="margin-left-8" title="Form Ekle"><i class="fa fa-check-square-o"></i></a>
                                    <a class="margin-left-8" title="Belge Ekle"><i class="fa fa-paperclip"></i></a>
                                    <a class="margin-left-8" title="Görev Ver"><i class="fa fa-plus"></i></a>
                                    <a class="margin-left-8" title="Güncelle" onclick="goTo('singlePage/work_upd.php','work_detail');"><i class="fa fa-pencil"></i></a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <ul class="feeds">
                                            <li class="margin-bottom-15">										
                                                <div class="progress bg-grey-silver margin-bottom-0 ">
                                                    <div class="progress-bar progress-bar-warning" role="progressbar" <cfif len(FULL_TERMIN) and len(KULLANILAN_TERMIN)>style="width: #int(KULLANILAN_TERMIN/FULL_TERMIN*100)#%"</cfif>>
														<cfif len(FULL_TERMIN) and len(KULLANILAN_TERMIN)>
                                                            <span class="sr-only"> #tlFormat(KULLANILAN_TERMIN/FULL_TERMIN*100)#% Complete (success)</span>
                                                            #tlFormat(KULLANILAN_TERMIN/FULL_TERMIN*100)#%
                                                        </cfif>
                                                    </div>
                                                </div>
                                                <div class="desc text-center">
                                                    <cfset textTermin = ''>
                                                    <cfif len(KALAN_TERMIN)>
														<cfif int(KALAN_TERMIN/60) gt 0>
                                                            <cfset hourTimeTermin = int(KALAN_TERMIN/60)>
                                                            <cfset minuteTimeTermin = KALAN_TERMIN - (hourTimeTermin*60)>
                                                            <cfset textTermin = textTermin & hourTimeTermin & ' ' & getLang('main',79,'Saat') & ' '>
                                                            <cfset textTermin = textTermin & minuteTimeTermin & ' ' & getLang('main',1415,'Dakika') & ' '>
                                                        <cfelse>
                                                            <cfset hourTime = 0>
                                                            <cfset minuteTimeTermin = KALAN_TERMIN>
                                                            <cfset textTermin = textTermin & minuteTimeTermin & ' ' & getLang('main',1415,'Dakika') & ' '>
                                                        </cfif>
                                                        Termine #textTermin# Var
                                                    </cfif>
                                                </div>
                                            </li>
                                            <li>										
                                                <div class="progress bg-grey-silver margin-bottom-0">
                                                    <div class="progress-bar progress-bar-success" role="progressbar" style="width: 70%">
                                                        <span class="sr-only">70% Complete (success)</span>
                                                        70%
                                                    </div>
                                                </div>
                                                <div class="desc text-center">Tamamlanma Yüzdesi</span></div>
                                            </li>																							
                                        </ul>
                                    </div>
                                    <div class="col-md-3">
                                        <ul class="feeds">									
                                            <li>										
                                                <div class="desc bold font-red"><i class="fa fa-clock-o"></i>&nbsp;Planlanan</div>																			
                                            </li>
                                            <li>										
                                                <div class="desc"> Termin Tarihi <cfif len(TERMINATE_DATE)><span class="date pull-right">#dateFormat(TERMINATE_DATE,'dd/mm/yyyy')# #timeFormat(date_add('h',session.pp.time_zone,TERMINATE_DATE),'hh:mm')#</span></cfif></div>
                                            </li>
                                            <li>
                                                <div class="desc"> Hedef Başlama <cfif len(PREDICTED_START)><span class="date pull-right">#dateFormat(PREDICTED_START,'dd/mm/yyyy')# #timeFormat(date_add('h',session.pp.time_zone,PREDICTED_START),'hh:mm')#</span></cfif></div>									
                                            </li>
                                            <li class="border-bottom">
                                                <div class="desc"> Öngörülen Süre <span class="date pull-right">
                                                	<cfset text = ''>
                                                    <cfif int(ESTIMATED_TIME/60) gt 0>
                                                    	<cfset dayTime = 0>
                                                    	<cfset hourTime = int(ESTIMATED_TIME/60)>
                                                        <cfset minuteTime = ESTIMATED_TIME - (hourTime*60)>
														<cfset text = text & hourTime & ' ' & getLang('main',79,'Saat') & ' '>
                                                        <cfset text = text & minuteTime & ' ' & getLang('main',1415,'Dakika') & ' '>
                                                    <cfelse>
                                                    	<cfset dayTime = 0>
                                                    	<cfset hourTime = 0>
                                                    	<cfset minuteTime = ESTIMATED_TIME>
                                                        <cfset text = text & minuteTime & ' ' & getLang('main',1415,'Dakika') & ' '>
                                                    </cfif>
                                                	#text#
                                                </span></div>										
                                            </li>																							
                                        </ul>
                                    </div>
                                    <div class="col-md-3">
                                        <ul class="feeds">									
                                            <li>										
                                                <div class="desc bold font-purple"><i class="fa fa-clock-o"></i>&nbsp;Gerçekleşen</div>																			
                                            </li>
                                            <li>										
                                                <div class="desc"> Başlama Tarihi <span class="date pull-right"><cfif len(REAL_START)>#dateFormat(REAL_START,'dd/mm/yyyy')# #timeFormat(date_add('h',session.pp.time_zone,REAL_START),'hh:mm')#</cfif></span></div>
                                            </li>
                                            <li>
                                                <div class="desc"> Bitiş Tarihi <span class="date pull-right"><cfif len(REAL_FINISH)>#dateFormat(REAL_FINISH,'dd/mm/yyyy')# #timeFormat(date_add('h',session.pp.time_zone,REAL_FINISH),'hh:mm')#</cfif></span></div>									
                                            </li>
                                            <li class="border-bottom">
                                                <div class="desc"> Harcanan Zaman
                                                	<span class="date pull-right">
														<cfset text = ''>
                                                        <cfif int(TOTAL_SPEND_HOUR/60) gt 0>
                                                            <cfset hourTime = int(TOTAL_SPEND_HOUR/60)>
                                                            <cfset minuteTime = TOTAL_SPEND_HOUR - (hourTime*60)>
                                                            <cfset text = text & hourTime & ' ' & getLang('main',79,'Saat') & ' '>
                                                            <cfset text = text & minuteTime & ' ' & getLang('main',1415,'Dakika') & ' '>
                                                        <cfelse>
                                                            <cfset minuteTime = TOTAL_SPEND_HOUR>
                                                            <cfset text = text & minuteTime & ' ' & getLang('main',1415,'Dakika') & ' '>
                                                        </cfif>
                                                        #text#
                                                    </span>
												</div>										
                                            </li>															
                                        </ul>
                                    </div>
                                </div>	
                                <div class="note note-info workDescription">
                                    #WORK_DETAIL#
                                </div>	
                                <div class="taskDetails">
                                    <p title="Delege Eden Çalışan"><i class="icons8-gender-neutral-user"></i>&nbsp;#DELEGE#</p>
                                    <p title="Şirket ve Yetkilisi"><i class="icons8-organization"></i>&nbsp;<a>#NICKNAME#</a> / #PARTNER#</p>
                                </div>
                                <span class="bodyChatButton">							
                                    <a onclick="$(this).next('.attacmentBody').toggle();"><i class="fa fa-paperclip"></i>Ek:<span class="badge badge-danger">3</span></a>
                                    <div class="attacmentBody" style="display:none;">
                                        <ul class="attacmentList">
                                            <li title="(Emin Yaşartürk - 08.01.2017 14:45)">
                                                <i class="fa fa-file-o"></i> Analiz.docx
                                                <i class="fa fa-times"></i>
                                            </li>
                                            <li title="(Emin Yaşartürk - 08.01.2017 14:45)">
                                                <i class="fa fa-file-o"></i> Kullanılacak Pantone Renk Skalası.jpg
                                                <i class="fa fa-times"></i>
                                            </li>
                                            <li title="(Emin Yaşartürk - 08.01.2017 14:45)">
                                                <i class="fa fa-file-o"></i> Baskı Örnekleri.jpg
                                                <i class="fa fa-times"></i>
                                            </li>
                                        </ul>
                                    </div>							
                                </span>														
                            </div>							
                        </div>											
                    </div>			
                </div>
                <div class="row margin-0">
                    <div class="col-lg-2"></div>
                    <div class="col-lg-10 col-sm-12 padding-0">
                        <div class="portlet light bg-grey-cararra">
                            <div class="portlet-title tabbable-line">
                                <ul class="nav nav-tabs lgTabNav pull-left">					
                                    <li class="active">
                                        <a href="##tab_workCorrespondence" data-toggle="tab">Yorumlar</a>
                                    </li>
                                    <li>
                                        <a href="##tab_documents" data-toggle="tab">Dokümanlar</a>
                                    </li>
                                    <li>
                                        <a href="##tab_history" data-toggle="tab">Tarihçe</a>
                                    </li>			
                                </ul>		
                            </div>
                            <div class="portlet-body">
                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane active" id="tab_workCorrespondence">
                                    	<cf_commentProcess action_Section="WORK_ID" action_id="#attributes.workId#" asset_cat_id="-21">
                                    </div>
                                    <div role="tabpanel" class="tab-pane" id="tab_documents">
                                        doküman body
                                    </div>
                                    <div role="tabpanel" class="tab-pane" id="tab_history">
                                        tarihçe body
                                    </div>	
                                    												
                                </div>			
                            </div>
                        </div>
                    </div>
                </div>	
            </div>
        </div>
    </cfoutput>
</div>

<form name="pop_gonder" action="callCenter" method="post">
	<input type="hidden" name="service_id" id="service_id" value="">
</form>

<script type="text/javascript">
	function send_callCenter(degisken)
	{
		document.getElementById('service_id').value = degisken;
		pop_gonder.submit();
	}
</script>