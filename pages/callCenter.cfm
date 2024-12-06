
<cfif isdefined("attributes.service_id")>
	<cfset get_callCenters = createObject('component','cfc.components')>
	<cfif len(attributes.service_id)>
        <cfset getCallCenter 		= get_callCenters.getCallCenter(service_id:attributes.service_id)>
        <cfset getCallCenterPlus 	= get_callCenters.getCallCenterPlus(service_id:attributes.service_id)>
        <cfset updateType 			= 1>
    <cfelse>
    	<cfset getCallCenter 			= get_callCenters.getCallCenter(service_id:'')>
        <cfset getCallCenterCategory 	= get_callCenters.GET_SERVICE_APPCAT()>
        <cfset updateType 				= 0>
    </cfif>
<cfelse>
	<script>
		alert('Başvuru Bulunamadı');
		window.location.href = 'index.cfm?pageinfo=CallCenters';
	</script>
</cfif>
<div class="pageContent">
    <div class="row">
        <div class="col-md-12">
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                	<cfif updateType eq 1>
                    	<strong>Başvuru No : </strong><cfoutput>#GETCALLCENTER.SERVICE_NO#</cfoutput>
                    <cfelse>
                    	<strong>Başvuru Ekle </strong>
                    </cfif>
                </div>				
            </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-9 col-xs-12">
            <cfoutput query="GETCALLCENTER">                   
                <div class="well well-spacial form-horizontal">
                	<cfif updateType eq 0>
                        <div class="row">
                            <label class="col-sm-1 control-label bold text-left">Kategori</label>
                            <div class="col-sm-8">
                            	<select name="category" class="form-control">
                                	<option value="">#getLang('main',322,'Seçiniz')#</option>
                                    <cfloop query="getCallCenterCategory">
                                    	<option value="#SERVICECAT_ID#">#SERVICECAT#</option>
                                    </cfloop>

                                </select>
                              
                            </div>
                        </div>
                    </cfif>
                    <div class="row">
                        <label class="col-sm-1 control-label bold text-left">Konu</label>
                        <div class="col-sm-8">
                        	<cfif updateType eq 1>
	                            <p class="form-control-static">#SERVICE_HEAD#</p>
							<cfelse>
                            	<input name="SERVICE_HEAD" class="form-control" />
                            </cfif>
                        </div>
                    </div>
                    <div class="row seperator">
                        <label class="col-sm-1 control-label bold text-left">Açıklama</label>
                        <div class="col-sm-8">
                        	<cfif updateType eq 1>
	                            <p class="form-control-static">#SERVICE_DETAIL#</p>
                            <cfelse>
                            	<textarea name="SERVICE_DETAIL" class="form-control"></textarea>
                            </cfif>
                        </div>
                    </div>
                    <cfif updateType eq 1>
                        <div class="row">
                            <div class="col-md-4 col-xs-12">
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">#getLang('main',344)#</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static"><cfif len(ISREAD) and ISREAD eq 1>Cevaplandırıldı<cfelse>Cevaplandırılmadı</cfif></p>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">Aşama</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static">#STAGE#</p>
                                    </div>
                                </div>                                
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">Öncelik</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static">#PRIORITY#</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">Proje</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static">#PROJECT_HEAD#</p>
                                    </div>
                                </div>                          
                            </div> 
                            <div class="col-md-4 col-xs-12"> 
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">Kategori</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static">#SERVICECAT#</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">İletişim</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static">#COMMETHOD#</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">Başvuru Yapan</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static">
                                            <cfif len(service_company_id) and service_company_id neq 0>
                                                #FULLNAME#
                                                <cfif len(service_partner_id) and service_partner_id neq 0 and not len(applicator_name)>
                                                    - #PARTNER#
                                                <cfelseif len(applicator_name)>
                                                    - #APPLICATOR_NAME#
                                                </cfif>
                                            <cfelseif len(service_company_id) and service_company_id neq 0>
                                                #CONSUMER#
                                            <cfelseif len(service_employee_id) and service_employee_id neq 0>
                                                #EMPLOYEE#
                                            </cfif>
                                        </p>
                                        <!---               <a class="btn blue icn-only" onclick="saveCallCenter('#attributes.service_id#','#session.pp.name# #session.pp.surname#')">
                                        <i class="fa fa-check icon-white"></i>---->
                                    </a>
                                    
                                    </div>
                                </div>   
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">Başvuru Tarihi</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static">#dateformat(apply_date,'dd/mm/yyyy')#,#timeformat(date_add('h',session.pp.time_zone,apply_date),'HH:MM')#</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">Kabul Tarihi</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static">#dateformat(start_date,'dd/mm/yyyy')#,#timeformat(date_add('h',session.pp.time_zone,start_date),'HH:MM')#</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-4 control-label bold text-left">Bitiş Tarihi</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static"><cfif len(finish_date)>#dateformat(finish_date,'dd/mm/yyyy')#,#timeformat(date_add('h',session.pp.time_zone,finish_date),'HH:MM')#</cfif></p>
                                    </div>
                                </div>                            
                            </div>
                            
                        </div>     
                    </cfif> 
                    <div><span style="font-weight:bold" class="text-primary">Eğer İşleminiz Çözüme Ulaşmadıysa Takiplerden Bildiriminizi Yapıp Yandaki Butondan Süreci Açık Aşamasına Döndürebilirsiniz !</span>  <a class="btn btn-danger icn-only" onclick="UpdCallStatus('#attributes.service_id#')">
                                        <i class="fa fa-check icon-white"></i></a></div>                  
                </div>                      
            </cfoutput>
            <cfif updateType eq 1>
                <div class="portlet light bordered">
                    <div class="portlet-title tabbable-line">
                        <ul class="nav nav-tabs lgTabNav pull-left">					
                            <li class="active">
                                <a> Takipler </a>
                            </li>		
                        </ul>		
                    </div>
                    <div class="portlet-body" id="chats">
                        <div class="slimScrollDiv" style="position: relative;overflow: auto;width: auto;max-height: 525px;">
                            <ul class="chats">
                                <cfoutput query="getCallCenterPlus">
                                    <li class="<cfif len(record_emp)>in<cfelse>out</cfif>">
                                        <cfif len(record_emp)>
                                            <cfif len(PHOTO)>
                                            <img class="avatar" alt="" src="/documents/hr/#PHOTO#">
                                            <cfelse>
                                                <img class="avatar" alt="" src="/documents/hr/empty_avatar.png">
                                        </cfif>
                                        <cfelse>
                                            <cfif len(PHOTO_CP)>
                                                <img class="avatar" alt="" src="/documents/member/#PHOTO_CP#">
                                                <cfelse>
                                                    <img class="avatar" alt="" src="/documents/hr/empty_avatar.png">
                                            </cfif>
                                            
                                        </cfif>
                                        <div class="message">
                                            <pre>#PLUS_CONTENT#</pre>
                                            <a href="javascript:;" class="name"><cfif len(EMPLOYEE)>#EMPLOYEE#<cfelse>#PARTNER#</cfif></a>
                                            <span class="datetime">#Dateformat(record_date,'dd/mm/yyyy')# #TimeFormat(date_add('h',session.pp.time_zone,record_date),'HH:MM')#</span>
                                        </div>
                                    </li>
                                </cfoutput>					
                            </ul>
                        </div>
                        <div class="chat-form">
                            <div class="input-cont">
                                <textarea class="form-control" type="text" id="plus_content" name="plus_content" placeholder="Mesajınızı yazınız..."></textarea> </div>
                            <div class="btn-cont">
                                <span class="arrow"> </span>
                                <cfoutput>
                                    <a class="btn blue icn-only" onclick="saveCallCenter('#attributes.service_id#','#session.pp.name# #session.pp.surname#')">
                                        <i class="fa fa-check icon-white"></i>
                                    </a>
                                </cfoutput>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </cfif>
        </div>
        <div class="col-md-3 col-xs-12">
            <div class="portlet light bordered">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-paperclip"></i>Belgeler
                    </div>
                    
                    <div class="tools">
                        <a href="javascript://" onclick="windowopen('index.cfm?pageinfo=add_belge&AjaxPage=1&service_id=<cfoutput>#attributes.service_id#</cfoutput>','small')" ><img src="/images_2/add_1.gif"></a>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="scroller" style="max-height: 339px; overflow: hidden; width: auto;" data-always-visible="1" data-rail-visible="0" data-initialized="1">
                        <ul class="feeds">
                        
                        <cfquery name="GetAssets" datasource="#dsn#">
                        SELECT * FROM ASSET Where ACTION_ID=#attributes.service_id# and MODULE_ID=27
                        </cfquery>
                        <cfloop query="GetAssets">
                            <li>
                                <div class="col1">
                                    <div class="cont">
                                    <cfset cls="">
                                        <div class="cont-col1">
                                        <cfif listGetAt(ASSET_FILE_NAME, 2,'.') eq 'gif' or listGetAt(ASSET_FILE_NAME, 2,'.') eq 'png' or listGetAt(ASSET_FILE_NAME, 2,'.') eq 'jpg' or listGetAt(ASSET_FILE_NAME, 2,'.') eq 'jpeg'><cfset cls="fa-file-image-o"></cfif>
                                        <cfif listGetAt(ASSET_FILE_NAME, 2,'.') eq 'pdf'><cfset cls="file-pdf-o"></cfif>
                                        <cfif listGetAt(ASSET_FILE_NAME, 2,'.') eq 'doc' or  listGetAt(ASSET_FILE_NAME, 2,'.') eq 'docx'><cfset cls="file-word-o"></cfif>
                                        <cfif listGetAt(ASSET_FILE_NAME, 2,'.') eq 'xls' or  listGetAt(ASSET_FILE_NAME, 2,'.') eq 'xlsx'><cfset cls="fa-file-excel-o"></cfif>
                                            <div class="label label-sm label-info"><i class="fa <cfoutput>#cls#</cfoutput>"></i></div>
                                        </div>
                                        <div class="cont-col2">
                                            <div class="desc"> <cfoutput>
                                            <a onclick="windowopen('documents/service/#ASSET_FILE_NAME#','wwide1')" href="javascript://" >#GetAssets.ASSET_NAME#.#listGetAt(ASSET_FILE_NAME, 2,'.')#</a>
                                            </cfoutput></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col2">
                                    <div class="date"> <cfoutput>#dateformat(RECORD_DATE,"dd.mm.yyyy")#</cfoutput></div>
                                </div>
                            </li>
                        </cfloop>

                      
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
var UpdCallStatus = function (serviceId) {
	$.ajax({
		url: 'cfc/components.cfc?method=UpdCallStatus&service_id=' + serviceId,
		method: "post",
        succces : function(returnt){
            
                window.location.reload(forceget)
          

        }
})}

var windowopen=function(theURL,winSize) { /*v3.0*/
	//fonsiyon 3 parametrede alabiliyor 3. parametre de isim yollana bilir ozaman aynı pencere tekrar acilmaz
		if (winSize == 'page') 					{ myWidth=900 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'print_page') 		{ myWidth=750 ; myHeight=500 ; features = 'scrollbars=0, resizable=1, menubar=1' ; }
		else if (winSize == 'list') 			{ myWidth=800 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'medium') 			{ myWidth=800 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'small') 			{ myWidth=570 ; myHeight=350 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'date') 			{ myWidth=275 ; myHeight=190 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'project') 			{ myWidth=800 ; myHeight=620 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'large') 			{ myWidth=615 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'horizantal') 		{ myWidth=1600 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'list_horizantal')	{ myWidth=1100 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'wide') 			{ myWidth=980 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'wide2') 			{ myWidth=1100 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'longpage') 		{ myWidth=1200 ; myHeight=500 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'page_horizantal') 	{ myWidth=800 ; myHeight=500 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'video') 			{ myWidth=480 ; myHeight=420 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
		else if (winSize == 'online_contact') 	{ myWidth=600 ; myHeight=500 ; features = 'scrollbars=0, resizable=0, menubar=0' ; } 
		else if (winSize == 'wwide') 			{ myWidth=1600 ; myHeight=860 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }  
		else if (winSize == 'long_menu') 		{ myWidth=200 ; myHeight=500 ; features = 'scrollbars=0, resizable=0' ; }
		else if (winSize == 'adminTv') 			{ myWidth=1040 ; myHeight=870 ; features = 'scrollbars=1, resizable=1, menubar=0' ; }
		else if (winSize == 'userTv') 			{ myWidth=565 ; myHeight=487 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
		else if (winSize == 'video_conference')	{ myWidth=740 ; myHeight=610 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
		else if (winSize == 'white_board')		{ myWidth=1000 ; myHeight=730 ; features = 'scrollbars=0, resizable=1, menubar=0' ; }
		 else if (winSize == 'wwide1') 			{ myWidth=1200 ; myHeight=700 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'norm_horizontal')	{ myWidth=950 ; myHeight=300 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'page_display')		{ myWidth=1100 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'work') 			{ myWidth=950 ; myHeight=620 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else { myWidth=400 ; myHeight=400 ; features = 'scrollbars=0, resizable=0' ; }
		if(window.screen)
		{
			var myLeft = (screen.width-myWidth)/2;
			var myTop =  (screen.height-myHeight)/2;
			
			features+=(features!='')?',':''; 
			features+=',left='+myLeft+',top='+myTop; 
		}
	
		if (arguments[2]==null)
			window.open(theURL,'',features+((features!='')?',':'')+'width='+myWidth+',height='+myHeight); 
		else		
			window.open(theURL,arguments[2],features+((features!='')?',':'')+'width='+myWidth+',height='+myHeight);
	}
</script>