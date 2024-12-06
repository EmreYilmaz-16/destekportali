<style>
.wrk_letter {
    height: 50px !important;
    width: 50px !important;
    background-color: #e1ab22 !important;
    color: #FFFFFF !important;
    font-size: 20px !important;
    border-radius: 50px !important;
    line-height: 50px !important;
    text-align: center !important;
    float: left;
}
.badge {
    font-size: 13px !important;
    font-weight: 300;
    text-align: center;
    height: 25px;
    width: 25px;
    line-height: 25px;
    color: #fff;
    padding: 0 0 0 0;
    -webkit-border-radius: 12px !important;
    -moz-border-radius: 12px !important;
    border-radius: 12px !important;
    text-shadow: none !important;
    text-align: center;
    vertical-align: middle;
}
small{
    font-weight:bold;
}
</style>
<cfparam  name=" attributes.is_search" default="0">
<cfset colorlist="primary,danger,warning,secondary,succes">

    <div class="container-fluid w3Body">
        <div Class="pageContent">
<div class="jumbotron" style="
    padding-top: 20px;
">
        <h3 style="
    margin-top: 0px;
">Partner Forum <!-----<a href="index.cfm?pageinfo=addtopic&FORUMID=2" title="Tartışma Başlat"><i class="icons8-plus"></i></a>  ----->
<form class="form-inline" method="post" action="index.cfm?pageinfo=test_site">
    <input class="form-control mr-sm-2" type="search" placeholder="Yanıtlarda Arama" name="SearchForm" aria-label="Search" required>
    <input type="hidden" name="is_search" value="1">
    <button class="btn btn-success my-2 my-sm-0" type="submit">Ara</button>
  </form></h3>
  <cfif attributes.is_search neq 1>
  <cfquery name="GetForum" datasource="#dsn#">
select 
	(
		SELECT EMPLOYEE_NAME + ' ' + EMPLOYEE_SURNAME + ' $Partner Bilgisayar'
		FROM w3Partner.EMPLOYEES
		WHERE EMPLOYEE_ID = FR.RECORD_EMP
		) AS RECEMP
	,(
		SELECT COMPANY_PARTNER_NAME + ' ' + COMPANY_PARTNER_SURNAME + ' $' + C.NICKNAME
		FROM w3Partner.COMPANY_PARTNER AS CP
			,w3Partner.COMPANY AS C
		WHERE CP.PARTNER_ID = FR.RECORD_PAR
			AND C.COMPANY_ID = CP.COMPANY_ID
		) AS RECEPARR
,fr.* from FORUM_TOPIC as fr
where FORUMID=2
</cfquery>
<div class="list-group">
<cfoutput query="GetForum">
 <a href="index.cfm?pageinfo=TopicIn&FORUMID=#FORUMID#&topicid=#TOPICID#" class="list-group-item list-group-item-action flex-column align-items-start">
    <div  class="d-flex w-100 justify-content-between">
      <h4 class="mb-1 ">#replace(REPLACE(TOPIC,"<p>",""),"</p>","")#</h4>
     <code> <small><b>Yazar : </b><cfif len(RECEMP)> #listGetAt(RECEMP, 1,'$')# <span class="text-primary">#listGetAt(RECEMP, 2,'$')#</span>  <cfelse> 
      #listGetAt(RECEPARR, 1,'$')#
      <span class="text-primary">#listGetAt(RECEPARR, 2,'$')#</span> 
      </cfif></small>
      <small><b>Görüntüleme : </b>#VIEW_COUNT#</small>
      <small><b>Toplam Cevap :</b> #REPLY_COUNT#</small>
      <small><b>Son Cevap : </b>
   <cfif len(LAST_REPLY_DATE)>
   
   <cfif datediff('d',now(),LAST_REPLY_DATE) gt 0>
   #datediff('d',LAST_REPLY_DATE,now())# Gün önce
   <cfelseif datediff('h',LAST_REPLY_DATE,now())gt 0 >
   #datediff('h',LAST_REPLY_DATE,now())# Saat önce
   <cfelse>
    #datediff('n',LAST_REPLY_DATE,now())# Dakika önce
   </cfif>
   </cfif></small>    </code> 
    </div>
    
  </a>
</cfoutput>
</div>
<cfelse>
<cfquery name="searcTopicin" datasource="#dsn#">
select FT.TOPIC,FT.FORUMID AS forum,  FR.*
 from w3Partner.FORUM_REPLYS as fr
,w3Partner.FORUM_TOPIC AS FT	 
where (fr.REPLY LIKE '%#attributes.SearchForm#%' OR FT.TOPIC LIKE '%#attributes.SearchForm#%')
AND fr.TOPICID=FT.TOPICID
</cfquery>


<div class="list-group">
<cfoutput query="searcTopicin">

 <a href="index.cfm?pageinfo=TopicIn&forumid=#forum#&topicid=#TOPICID###rep_#REPLYID#" class="list-group-item list-group-item-action flex-column align-items-start">
    <div  class="d-flex w-100 justify-content-between">
        <h4><span class="text-warning"style="font-weight:bold">Q</span> #replace(REPLACE(TOPIC,"<p>",""),"</p>","")#</h4>
      <h5 class="mb-1 ">#replace(REPLACE(REPLY,"<p>",""),"</p>","")#</h5>
      
      <small>Tarih : #dateformat(RECORD_DATE,"dd/mm/yyyy")#
 </small>     
    </div>
    
  </a>



</cfoutput>
<a class="btn btn-link" onclick="window.location.href='index.cfm?pageinfo=test_site'">Geri Dön</a>
</div>
</cfif>
</div>
</div>
</div>
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