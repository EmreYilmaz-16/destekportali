    <style>
    span.ltCommentsHead {
    display: block;
    color: #4CAF50;
    font-size: 20px;
    font-weight: 500;
    margin: 20px 0;
    padding: 7px 0;
    border-bottom: 2px solid #4CAF50;
}
span.ltCommentAddHead {
    display: block;
    color: #00BCD4;
    font-size: 20px;
    font-weight: 500;
    margin: 20px 0;
    padding: 7px 0;
    border-bottom: 2px solid #00BCD4;
}
span.ltCommentName {
    font-size: 13px;
    color: #E91E63;
    font-weight: 500;
}
.img-circle {
    border-radius: 50% !important;
}
ul.ltCommentList {
    list-style: none;
    padding: 0;
}
ul.ltCommentList li .catalyst-star {
    color: #FFC107;
    margin-right: 3px;
}
.catalyst-user-female, .catalyst-user-follow, .catalyst-user-following, .catalyst-user-unfollow, .catalyst-trophy, .catalyst-screen-smartphone, .catalyst-screen-desktop, .catalyst-plane, .catalyst-notebook, .catalyst-moustache, .catalyst-mouse, .catalyst-magnet, .catalyst-energy, .catalyst-emotcatalyst-smile, .catalyst-disc, .catalyst-cursor-move, .catalyst-crop, .catalyst-credit-card, .catalyst-chemistry, .catalyst-user, .catalyst-speedometer, .catalyst-social-youtube, .catalyst-social-twitter, .catalyst-social-tumblr, .catalyst-social-facebook, .catalyst-social-dropbox, .catalyst-social-dribbble, .catalyst-shield, .catalyst-screen-tablet, .catalyst-magic-wand, .catalyst-hourglass, .catalyst-graduation, .catalyst-ghost, .catalyst-game-controller, .catalyst-fire, .catalyst-eyeglasses, .catalyst-envelope-open, .catalyst-envelope-letter, .catalyst-bell, .catalyst-badge, .catalyst-anchor, .catalyst-wallet, .catalyst-vector, .catalyst-speech, .catalyst-puzzle, .catalyst-printer, .catalyst-present, .catalyst-playlist, .catalyst-pin, .catalyst-picture, .catalyst-map, .catalyst-layers, .catalyst-handbag, .catalyst-globe-alt, .catalyst-globe, .catalyst-frame, .catalyst-folder-alt, .catalyst-film, .catalyst-feed, .catalyst-earphones-alt, .catalyst-earphones, .catalyst-drop, .catalyst-drawer, .catalyst-docs, .catalyst-directions, .catalyst-direction, .catalyst-diamond, .catalyst-cup, .catalyst-compass, .catalyst-call-out, .catalyst-call-in, .catalyst-call-end, .catalyst-calculator, .catalyst-bubbles, .catalyst-briefcase, .catalyst-book-open, .catalyst-basket-loaded, .catalyst-basket, .catalyst-bag, .catalyst-action-undo, .catalyst-action-redo, .catalyst-wrench, .catalyst-umbrella, .catalyst-trash, .catalyst-tag, .catalyst-support, .catalyst-size-fullscreen, .catalyst-size-actual, .catalyst-shuffle, .catalyst-share-alt, .catalyst-share, .catalyst-rocket, .catalyst-question, .catalyst-pie-chart, .catalyst-pencil, .catalyst-note, .catalyst-music-tone-alt, .catalyst-music-tone, .catalyst-microphone, .catalyst-loop, .catalyst-logout, .catalyst-login, .catalyst-list, .catalyst-like, .catalyst-home, .catalyst-grid, .catalyst-graph, .catalyst-equalizer, .catalyst-dislike, .catalyst-cursor, .catalyst-control-start, .catalyst-control-rewind, .catalyst-control-play, .catalyst-control-pause, .catalyst-control-forward, .catalyst-control-end, .catalyst-calendar, .catalyst-bulb, .catalyst-bar-chart, .catalyst-arrow-up, .catalyst-arrow-right, .catalyst-arrow-left, .catalyst-arrow-down, .catalyst-ban, .catalyst-bubble, .catalyst-camcorder, .catalyst-camera, .catalyst-check, .catalyst-clock, .catalyst-close, .catalyst-cloud-download, .catalyst-cloud-upload, .catalyst-doc, .catalyst-envelope, .catalyst-eye, .catalyst-flag, .catalyst-folder, .catalyst-heart, .catalyst-info, .catalyst-key, .catalyst-link, .catalyst-lock, .catalyst-lock-open, .catalyst-magnifier, .catalyst-magnifier-add, .catalyst-magnifier-remove, .catalyst-paper-clip, .catalyst-paper-plane, .catalyst-plus, .catalyst-pointer, .catalyst-power, .catalyst-refresh, .catalyst-reload, .catalyst-settings, .catalyst-star, .catalyst-symbol-female, .catalyst-symbol-male, .catalyst-target, .catalyst-volume-1, .catalyst-volume-2, .catalyst-volume-off, .catalyst-users {
    font-family: 'Simple-Line-icons';
    speak: none;
    font-style: normal;
    font-weight: normal;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
}
span.ltColHead {
    font-size: 15px;
    font-weight: 500;
    color: #00BCD4;
    display: block;
    padding: 10px 10px;
    margin: 10px 0;
    border-bottom: 1px solid #d5d5d5;
    background: #EEEEEE;
}
ul.ltList li:first-child {
    list-style: none;
}
ul.ltList li {
    list-style: none;
    margin: 6px 0px;
    border-bottom: 1px dotted #9E9E9E;
}
ul.ltList li a {
    font-size: 12px;
    color: #757575;
    display: block;
    line-height: 25px;
}
.ltTextHead {
    font-size: 25px;
    font-weight: 500;
    color: #E53935;
    display: block;
    margin-bottom: 20px;
}
.ltTextSummary {
    font-size: 16px;
    font-weight: 400;
    color: #9E9E9E;
    display: block;
    margin-bottom: 26px;
    line-height: inherit !important;
    border-left: 3px solid #00BCD4;
    margin-left: 9px;
    background: #FAFAFA;
    padding: 10px;
}
.ltCCol {
    border-right: 1px dotted #9E9E9E;
    border-left: 1px dotted #9E9E9E;
    padding: 0 20px;
}
label {
    display: inline-block;
    max-width: 100%;
    margin-bottom: 3px;
    margin-top: 3px;
    line-height: 12px !important;
    vertical-align: text-top;
}

.border-left-no {
    border-left: 0;
}

    </style>
    <div class="container-fluid w3Body">
        <div Class="pageContent">
<div class="jumbotron" style="">
<script type="text/javascript">
	function connectAjax()
	{
		var bb = "<cfoutput>#request.self#?fuseaction=objects2.emptypopup_get_body_query&content_id=#attributes.cntid#&is_body=1</cfoutput>";
		AjaxPageLoad(bb,'content_body_place',0);
	}
</script>
<cfset dateformat_style="dd/mm/yyy">
<cfset timeformat_style="hh:nn">
<!--- bu sayfa birde Doruk için add_options altında vardır,yapılan genel değişiklik ordada yapılmalıdır AE20060621--->
<cfinclude template="../query/get_content.cfm">
<cfinclude template="../query/get_company_cat.cfm">
<cfinclude template="../query/get_chapter_menu.cfm">
<cfinclude template="../query/get_content_cat.cfm">
<cfinclude template="../query/get_customer_cat.cfm">
<cfquery name="GET_ASSET_CATS" datasource="#DSN#">
	SELECT ASSETCAT_ID,ASSETCAT_PATH FROM ASSET_CAT
</cfquery>
<cfquery name="GET_OUR_COMPANY_INFO" datasource="#DSN#">
	SELECT IS_CONTENT_FOLLOW FROM OUR_COMPANY_INFO WHERE COMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
</cfquery>
<cfif get_content.recordcount>
	<cfinclude template="../query/get_content_property.cfm">
	<cfinclude template="../query/get_content_file.cfm">
	<cfinclude template="../query/get_related_cont.cfm">
	<cfif len(get_content.HIT_PARTNER)>
		<cfset hit_employee = get_content.HIT_PARTNER + 1>
	<cfelse>
		<cfset hit_employee = 1>
	</cfif>
	<cfquery name="HIT_UPDATE" datasource="#DSN#">
		UPDATE CONTENT SET HIT_PARTNER = #hit_employee#, LASTVISIT = #now()# WHERE CONTENT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.cntid#">
	</cfquery>
<cfelse>
	<script type="text/javascript">
		alert('İçerik Bulunamadı!');
		history.back();
	</script>
	<cfabort>
</cfif>
<input type="hidden" name="cntid" id="cntid" value="<cfoutput>#attributes.cntid#</cfoutput>">
<cfset attributes.is_home = 1>

<div class="row">
    <div class="col col-12">
       
    </div>
</div>
<div class="row">
    <div class="col col-9 col-md-10 col-sm-12 ltCCol border-left-no" >
        <div class="row"><label class="col col-12 pb-4">
                            <cfoutput query="get_chapter_menu"> 
                                <cfif get_content.chapter_id is chapter_id>#chapter#</cfif> 
                            </cfoutput>	
              </label>
        </div>
        <cfif get_content.is_dsp_header eq 0>
            <div class="row">
                <label class="col col-12 ltTextHead"><cfoutput>#get_content.cont_head#</cfoutput></label>
            </div>
        </cfif>
        <cfif get_our_company_info.is_content_follow eq 1>
            <div class="row">
                <div class="col col-12 ltTextBody"  id="content_body_place">            
                </div>
                <script type="text/javascript">connectAjax();</script>
            </div>
        <cfelse>
            <cfif get_content.is_dsp_summary eq 0>
                <div class="row">
                    <label class="col col-12 ltTextSummary"><cfoutput>#get_content.cont_summary#</cfoutput></label>
                </div>
            </cfif>
            <div class="row">
                <div class="col col-12 ltTextBody">
                    <cfoutput>#get_content.cont_body#</cfoutput>        
                </div>
            </div>
        </cfif>
            <div class="row">
                <label style="width:20% !important" class="col col-3"><i class="icons8-pencil"></i> <cfoutput>#get_content.employee_name# #get_content.employee_surname# -  <cfif len(get_content.record_date)>#dateformat(date_add('h',2,get_content.record_date),'dd/mm/yy')# #timeformat(date_add('h',2,get_content.record_date),"hh:nn")#</cfif></cfoutput></label>                
                    <cfif get_content.recordcount and len(get_content.upd_count) and len(get_content.update_date) and len(get_content.update_member)>
					<label style="width:20% !important" class="col col-3"><i class="icons8-refresh"></i>
						<cfset tarih=date_add('h',2,get_content.update_date)>
						<cfset attributes.employee_id = get_content.update_member>
						<cfinclude template="../query/get_employee_name.cfm">
						<cfoutput>#get_employee_name.employee_name# #get_employee_name.employee_surname# - #dateformat(tarih,dateformat_style)# #timeformat(tarih,timeformat_style)# </cfoutput>
					</label>
                    <label style="width:20% !important" class="col col-3">V.<cfoutput>#get_content.upd_count#</cfoutput></label>
                    </cfif>
                 <label style="width:20% !important" class="col col-3"><i class="icon8-student"></i><cfoutput> E: #get_content.hit_employee# / P:#get_content.hit_partner# / I:#get_content.hit#</cfoutput></label>
			</div>
            <cfset attributes.content_id = attributes.cntid>
            <cfquery name="GET_PRODUCT_COMMENT" datasource="#DSN#">
            SELECT CC.*
                ,(
                    SELECT PHOTO
                    FROM #dsn#.COMPANY_PARTNER AS CP
                    WHERE CP.PARTNER_ID = CC.PARTNER_ID
                    ) AS PARTNER_FOTO
                ,(
                    SELECT PHOTO
                    FROM #dsn#.EMPLOYEES AS EMP
                    
                    WHERE EMP.EMPLOYEE_ID = CC.EMP_ID
                      
                    ) AS EMPLOYEE_PHOTO
            FROM #dsn#.CONTENT_COMMENT AS CC
                            WHERE
                                CC.CONTENT_ID = #attributes.CONTENT_ID#
                                AND CC.STAGE_ID = -2 
            </cfquery>
            <cfinclude template="../query/get_content_head.cfm">
             <div class="row">
                <div class="col col-12">
                   
                <div class="portlet   ">
                        <div class="portlet-title tabbable-line">
<span class="ltCommentAddHead">Yorum Ekle</span>		
                    </div>
                    <div class="portlet-body" id="chats">
                        <div class="slimScrollDiv" style="position: relative;overflow: auto;width: auto;max-height: 525px;">
                            <ul class="chats">
                                <cfoutput query="GET_PRODUCT_COMMENT">
                                    <li class="<cfif len(EMP_ID)>in<cfelse>out</cfif>">
                                        <cfif len(EMP_ID) and len(EMPLOYEE_PHOTO)>
                                            <img class="avatar" alt="" src="/documents/hr/#EMPLOYEE_PHOTO#">
                                        <cfelseif len(PARTNER_ID) and len(PARTNER_FOTO)>
                                         <img class="avatar" alt="" src="/documents/member/#PARTNER_FOTO#">
                                        <cfelse>
                                        	<img src="../images/no_photo.gif" class="avatar" alt="" width="30" style="padding-right:5px">
                                        </cfif>
                                     
                                        <div class="message">
                                                <span class="ltCommentPoint" id="point#CurrentRow#"></span>                                        
                                                                      
                                        <script>
                                            for (var i = 0; i < #content_comment_point#; i++) {
                                                $('##point#CurrentRow#').append('<i class="fa fa-star"></i>');
                                            }
                                        </script>
                                            <pre>#content_comment#</pre>
                                            <a href="javascript:;" class="name">#name# #surname#</a>
                                            <span class="datetime">#Dateformat(record_date,'dd/mm/yyyy')# #TimeFormat(date_add('h',session.pp.time_zone,record_date),'HH:MM')#<a class="text-primary" href="mailto:#mail_address#" class="label"><i class="fa fa-envelope"></i></a></span>
                                        </div>
                                    </li>
                                </cfoutput>					
                            </ul>
                        </div>
                                             <cfquery name="get_employee_email" datasource="#dsn#">
                            SELECT EMPLOYEE_EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID = #session.pp.userid#
                        </cfquery>
                        <cfsavecontent variable="message">Eksik Veri Email !</cfsavecontent>
                        <cfform name="employe_detail" method="post" action="#request.self#?pageinfo=emptypopup_add_content_comment">
                        <div class="chat-form">
                            <div class="input-cont">
                                             <div class="row" style="display:flex">
                                    <div class="col col-5 col-xs-12">
                                        <div class="form-group">
                                            <label for="" class="col col-3 col-xs-12">Email *</label>
                                            <div class="col col-9 col-xs-12"><cfinput type="text" name="MAIL_ADDRESS" maxlength="100" value="#get_employee_email.employee_email#" required="yes" message="#MESSAGE#"></div>
                                        </div>
                                    </div>
                                    <div class="col col-3 col-xs-12">
                                        <div class="form-group">
                                            <label for="" class="col col-3 col-xs-12">Puan</label>
                                            <div class="col col-9 col-xs-12">
                                                <label><input name="CONTENT_COMMENT_POINT" id="CONTENT_COMMENT_POINT" type="radio" value="1"> 1</label>
                                                <label><input name="CONTENT_COMMENT_POINT" id="CONTENT_COMMENT_POINT" type="radio" value="2"> 2</label>
                                                <label><input name="CONTENT_COMMENT_POINT" id="CONTENT_COMMENT_POINT" type="radio" value="3"> 3</label>
                                                <label><input name="CONTENT_COMMENT_POINT" id="CONTENT_COMMENT_POINT" type="radio" value="4"> 4</label>
                                                <label><input name="CONTENT_COMMENT_POINT" id="CONTENT_COMMENT_POINT" type="radio" value="5" checked> 5</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="clear:both"></div>
                                <textarea class="form-control" type="text" id="plus_content" name="CONTENT_COMMENT" placeholder="Mesajınızı yazınız..."></textarea> </div>
                            <div class="btn-cont">
                                <span class="arrow"> </span>
               
                                <cfoutput>
                            <input type="hidden" name="content_id" id="content_id" value="<cfoutput>#attributes.content_id#</cfoutput>">
                            <input type="hidden" name="name" id="name" maxlength="50" readonly value="<cfoutput>#session.pp.name#</cfoutput>">
                            <input type="hidden" name="surname" id="surname" maxlength="50" readonly value="<cfoutput>#session.pp.surname#</cfoutput>">
                            
                                    <button type="submit" class="btn blue icn-only" >
                                        <i class="fa fa-check icon-white"></i>
                                    </button>
                                </cfoutput>
                                
                            </div>
                        </div>
                    </div>
                    </cfform>
                </div>
                </div>
                </div>
                </div>
              <cfset file_web_path="/documents/">
          
 <div class="col col-3 col-md-2 col-sm-12 ltRCol">
        <div class="ltSearchArea">
            
            <div class="ltDetailSearch hide">
               
            </div>        
        </div>      
        <div class="row">
            <div class="col col-12 ltExternalButton">
                <cfoutput>
                    <!---
                    <cfif not listfindnocase(denied_pages,'rule.popup_add_content_comment')><a href="javascript://" onclick="windowopen('#request.self#?fuseaction=rule.popup_add_content_comment&content_id=#attributes.cntid#','large');"><img src="/images/add_not.gif" title="<cf_get_lang no='28.Yorum Ekle'>" border="0"></a></cfif>
                    <cfif not listfindnocase(denied_pages,'rule.popup_view_content_comment')><a href="javascript://" onclick="windowopen('#request.self#?fuseaction=rule.popup_view_content_comment&content_id=#attributes.cntid#','medium');"><img src="/images/im.gif" border="0" title="<cf_get_lang no='30.Yorum Oku'>"></a></cfif>
                    --->
                    <cfset userlev="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,19,20,21,23,24,25,26,27,28,29,30,32,33,34,35,39,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,87,88,300,301">
                    <cfif listFindNoCase(userlev,2,',')>
                       
                    </cfif>
                    
                    </cfoutput>
            </div>
        </div>
        <!-- Ilişkiler -->
        <span class="ltColHead">İlişkiler</span>
        <ul class="ltList">
            <cfoutput query="get_related_cont">
                <li>
                    <a href="#request.self#?pageinfo=ContentDetail&cntid=#content_id#">#cont_head#</a>
                </li>
            </cfoutput>
        </ul> 
        
        <cfif get_asset.recordcount>
                <cfquery name="GET_ASSETS" dbtype="query">
                    SELECT * FROM GET_ASSET WHERE ASSET_FILE_NAME NOT LIKE '%.flv%' AND ASSET_FILE_NAME NOT LIKE '%.swf%'
                </cfquery>
                
                <cfif get_assets.recordcount>
                    <span class="ltColHead"><cfoutput>#getLang('main',156,'belgeler')#</cfoutput></span>
                    <ul class="ltList">
                        <cfoutput query="get_assets">
                            <cfquery name="GET_ASSET_CAT" dbtype="query">
                                SELECT ASSETCAT_ID,ASSETCAT_PATH FROM GET_ASSET_CATS WHERE ASSETCAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#assetcat_id#">
                            </cfquery>
                            <cfif not len(asset_file_path_name)>
                                <cfif assetcat_id gte 0>
                                    <cfset folder="asset/#get_asset_cat.assetcat_path#">
                                <cfelse>
                                    <cfset folder="#get_asset_cat.assetcat_path#">
                                </cfif>
                            </cfif>
                                <li><a href="javascript:windowopen('#file_web_path##folder#/#asset_file_name#','small');" title="#asset_detail#"><i class="catalyst-paper-clip"></i>&nbsp;#asset_name# (#name#)</a></li>
                        </cfoutput>
                    </ul>
                </cfif>
                
                <cfquery name="GET_VIDEOS" dbtype="query">
                    SELECT * FROM GET_ASSET WHERE ASSET_FILE_NAME LIKE '%.flv%' OR ASSET_FILE_NAME LIKE '%.swf%' ORDER BY ASSET_NAME
                </cfquery>
                <cfif get_videos.recordcount>
                    <span class="ltColHead"><cfoutput>#getLang('rule',3,'videolar')#</cfoutput></span>
                    <ul class="ltList">
                        <cfoutput query="get_videos">
                            <cfquery name="GET_ASSET_CAT" dbtype="query">
                                SELECT ASSETCAT_ID,ASSETCAT_PATH FROM GET_ASSET_CATS WHERE ASSETCAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#assetcat_id#">
                            </cfquery>
                            <cfif not len(asset_file_path_name)>
                                <cfif assetcat_id gte 0>
                                    <cfset folder="asset/#get_asset_cat.assetcat_path#">
                                <cfelse>
                                    <cfset folder="#get_asset_cat.assetcat_path#">
                                </cfif>
                            </cfif>
                            <li><a href="javascript:windowopen('#file_web_path##folder#/#asset_file_name#','small');" title="#asset_detail#"><i class="catalyst-paper-clip"></i>&nbsp;#asset_name# (#name#)</a></li>
                        </cfoutput>
                    </ul>
                </cfif>              	
        </cfif> 
        <cfinclude template="../query/get_image_cont.cfm">
        <ul class="ltList">
            <cfoutput query="get_image_cont">
                <li><a href="javascript://" onclick="windowopen('#file_web_path#content/#contimage_small#','small');" title="#detail#"><img src="#file_web_path#content/#contimage_small#" border="0" title="Orjinal Resim İçin Tıklayınız..." width="190" height="150"></a></li>
            </cfoutput> 
        </ul>
    </div>

<cfif get_our_company_info.is_content_follow eq 1> <!--- bu kontrol icerik detayli takibi yapilabilmesi ve icerik kopyalama engeli icin konuldu 30062007 FS --->
	<cfquery name="ADD_CONTENT_FOLLOWS" datasource="#DSN#">
		INSERT INTO CONTENT_FOLLOWS 
		(
            CONTENT_ID,
            EMPLOYEE_ID,
            READ_DATE,
            READ_IP
		)
		VALUES
		(
            #attributes.cntid#,
            #session.ep.userid#,
            #now()#,
            '#CGI.REMOTE_ADDR#'
		)
	</cfquery>
</cfif>
<script>
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