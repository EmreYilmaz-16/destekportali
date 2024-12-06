<cfset DSN="w3Partner">
<cfset DSN1="w3Partner_product">
<cfset DSN3="w3Partner_1">
<cfset DSN2="w3Partner_#session.pp.PERIOD_YEAR#_1">
<style>
.rw1{
	display:none;
}
</style>
<cfquery name="GetCats" datasource="#dsn#">
select SERVICECAT,SERVICECAT_ID from G_SERVICE_APPCAT WHERE IS_INTERNET=1
</cfquery>
    <cfquery name="getProj" datasource="#dsn#">
    SELECT * FROM w3Partner.WORK_GROUP WHERE WORKGROUP_ID IN (SELECT WORKGROUP_ID FROM w3Partner.WORKGROUP_EMP_PAR WHERE PARTNER_ID=#session.pp.userid#)
    </cfquery>
<div class="pageContent">
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                Başvuru Yap
			</div>
        </div> 
        <form method="post" action="index.cfm?pageinfo=makecall">
        <table style="width:40%">
        <tr>
        <td>Kategori: </td>
        <td>
        <select class="form-control" name="appcat_id" required>
        <option value="">Seçiniz</option>
        <cfoutput query="GetCats">
        <option value="#SERVICECAT_ID#">#SERVICECAT# - </option>
        </cfoutput>
        </select>
        </td>
        </tr>
             <tr>
        <td>Süreç :</td>
        <td>
        
       <cf_workcube_process is_upd='0' fusepath="#attributes.pageinfo#" is_detail='1'>
        </td>
        </tr>
		<tr>
		<td>Proje</td>
		<td>
		<select class="form-control" name="project_id">
		<cfoutput query="getProj">
			<option value="#PROJECT_ID#">#WORKGROUP_NAME#</option>
		</cfoutput>
		</select>
		</td>
		</tr>
		<!----<tr><td>Resim </td><td><input type="file" class="form-control" name="photo"></td></tr>---->
		<tr class="rw1"><td>Sayfa Linki :</td><td><input  type="text" class="form-control rwq" name="page_url" required></td></tr>
		<tr class="rw1"><td>Belge No :</td><td><input type="text" class="form-control rwq" name="document_nos" ></td></tr>
		<tr class="rw1"><td>Video Linki :</td><td><input type="text" class="form-control rwq" name="video_url" ></td></tr>
        <tr class="rw1"><td colspan="2"><div class="alert alert-danger">Hatanın Daha Çabuk Bir Şekilde Giderilmesi için<br>
		<ul><li>Sayfa Linki ve varsa Belge Numarası Eklenmelidir</li><li>Video Url'ini Eklemeniz Gerekmektedir</li></ul>
		<p>Loom Eklentisini Yükleme ve Kullanma <a href="#" onclick="windowopen('index.cfm?pageinfo=empty_popup_loom_kilavuz&AjaxPage=1','video')">Kılavuzu</a></p>
		</div></td></tr>
		<tr>
        <td colspan="2"><input type="text" class="form-control" placeholder="Konu" name="service_head"></td>
		
		
        </tr>
              <tr>
        <td colspan="2"><textarea  class="form-control" placeholder="Açıklama" name="service_detail" rows="6"></textarea></td>
        </tr>
		
        </table>
        <input type="hidden" name="is_submit" value="1">
        <input class="btn btn-primary" value= "Başvuru Yap" type="submit">
		
</form>
    </div>
<div style="width:55%;text-align:justify" >
                <h3>Partner Otomasyon Workcube Destek Platformu</h3>
                <p class="lead">
                    Değerli müşterimiz, <br>Bizimle iletişime geçmek için yukarıdaki formu doldurmanız yeterli. <br>Yaşadığınız problemin en hızlı şekilde çözüme kavuşturulması için lütfen bilgi aktarırken sorun yaşadığınız <br><span style="color:red">şirket, muhasebe dönemi, şube, üye, ürün, çalışan, tarih v.b. bilgileri, aldığınız hata mesajını ve yaptığınız işlemi hangi aşamalarla gerçekleştirdiğinizi </span>net biçimde ve detaylı olarak aktarınız.<br> Aldığınız hata ekranının görüntüsünü dosya alanından etkileşim formuna upload ediniz. Sorununuzu gidermek üzere en kısa sürede size geri döneceğiz.<br>Teşekkür ederiz.
                </p>
</div>

</div>
<script>
	$("#process_stage").on("change",function(){
		console.log(this)
		var vala=$(this).val();
console.log(vala)
	if(parseInt(vala)==10){
		$(".rw1").show(500);
	}else{
		$(".rw1").hide(500);
		$(".rwq").val("NULL")
	}
	})
</script>

<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
<cfif not (isdefined("attributes.service_default_no") and len(attributes.service_default_no))>
	<cftransaction>
		<cf_papers paper_type="g_service_app">
		<cfset system_paper_no=paper_code & '-' & paper_number>
		<cfset system_paper_no_add=paper_number>
		<cfquery name="UPD_GEN_PAP" datasource="#DSN#">
			UPDATE
				GENERAL_PAPERS_MAIN
			SET
				G_SERVICE_APP_NUMBER = #system_paper_no_add#
			WHERE
				G_SERVICE_APP_NUMBER IS NOT NULL
		</cfquery>
	</cftransaction>
<cfelse>

	<cfstoredproc procedure="WRK_GENERATESERVICENO" datasource="#dsn#">
		<cfprocparam TYPE="IN" cfsqltype="cf_sql_varchar" value="#attributes.service_default_no#">
		<cfprocparam TYPE="IN" cfsqltype="cf_sql_varchar" value="#session.pp.userid#">
		<cfprocresult name="get_paper_no">
	</cfstoredproc>
	<cfset system_paper_no=get_paper_no.ServiceNo>
</cfif>
<cfset company_id=session.pp.company_id>
<cfset partner_id=session.pp.USERID>
<cfset priority_id=1><cfset commethod_id=1>
<cfset member_name="#session.pp.NAME# #session.pp.SURNAME#">
<cfset attributes.apply_date='#dateTimeFormat(now(),"yyyy-MM-dd HH:NN")#'>
<div style="text-align:center"><cfdump  var="#now()#"><br>
<cfdump  var="#attributes.apply_date#"></div>
<cfif attributes.process_stage eq 10>
<cfsavecontent variable = "service_detail_2"> 
<cfoutput>
#service_detail#
<div style="border:solid 1px black;padding:5px">
	<h3>Hata Detayları</h3>
	<br>
		Belge No : <span style="color:##3598dc">#attributes.document_nos#</span>
	<br>
		Sayfa Url: <a href="#attributes.page_url#">Sayfa</a>
	<br>Video Url: <a href="#attributes.video_url#"> Video </a>
</div>
</cfoutput>
</cfsavecontent>

</cfif>

<cfquery name="ADD_SERVICE" datasource="#DSN#"  result="my_result">
	INSERT INTO
		G_SERVICE
		(
			SERVICE_ACTIVE,
			ISREAD,
			SERVICECAT_ID,
			SERVICE_STATUS_ID,
			PRIORITY_ID,
			COMMETHOD_ID,
			SERVICE_HEAD,
			SERVICE_DETAIL,
			APPLY_DATE,
			START_DATE,
			SERVICE_EMPLOYEE_ID,
			SERVICE_CONSUMER_ID,
			SERVICE_COMPANY_ID,
			SERVICE_PARTNER_ID,
			NOTIFY_PARTNER_ID,
			NOTIFY_CONSUMER_ID,
			NOTIFY_EMPLOYEE_ID,
			SERVICE_BRANCH_ID,
			APPLICATOR_NAME,
			SERVICE_NO,
			SUBSCRIPTION_ID,
			PROJECT_ID,
			REF_NO,
			CUS_HELP_ID,
			RECORD_DATE,
			RECORD_MEMBER,
			RESP_EMP_ID,
			CAMPAIGN_ID		
		)
		VALUES
		(
			1,
			0,
			<cfif len(appcat_id)>#appcat_id#<cfelse>NULL</cfif>,
			#attributes.process_stage#,
			<cfif len(priority_id)>#priority_id#<cfelse>NULL</cfif>,
			<cfif len(commethod_id)>#commethod_id#<cfelse>NULL</cfif>,
			<cfif len(service_head)>'#service_head#'<cfelse>'#system_paper_no#'</cfif>,
			<cfif attributes.process_stage eq 10><cfif len(service_detail_2)>'#service_detail_2#'<cfelse>NULL</cfif><cfelse>'#service_detail#'</cfif>,
			'<cfif len(attributes.apply_date)>#attributes.apply_date#<cfelse>NULL</cfif>',
			'<cfif isdefined("attributes.start_date1") and len(attributes.start_date1)>#attributes.start_date1#<cfelseif len(attributes.apply_date)>#attributes.apply_date#<cfelse>NULL</cfif>',
			<cfif isDefined("employee_id") and len(employee_id)>#employee_id#<cfelse>NULL</cfif>,
			<cfif isDefined("consumer_id") and len(consumer_id)>#consumer_id#<cfelse>NULL</cfif>,
			<cfif isDefined("company_id") and len(company_id)>#company_id#<cfelse>NULL</cfif>,
			<cfif isDefined("partner_id") and len(partner_id)>#partner_id#<cfelse>NULL</cfif>,
			<cfif isdefined("attributes.notify_app_type") and len(attributes.notify_app_type) and isdefined("attributes.notify_app_name") and len(attributes.notify_app_name)>
				<cfif attributes.notify_app_type is 'partner'>
					<cfif len(attributes.notify_app_id)>#attributes.notify_app_id#<cfelse>NULL</cfif>,
					NULL,
					NULL,
				<cfelseif attributes.notify_app_type is 'consumer'>
					NULL,
					<cfif len(attributes.notify_app_id)>#attributes.notify_app_id#<cfelse>NULL</cfif>,
					NULL,
				<cfelseif attributes.notify_app_type is 'employee'>
					NULL,
					NULL,
					<cfif len(attributes.notify_app_id)>#attributes.notify_app_id#<cfelse>NULL</cfif>,
				</cfif>
			<cfelse>
				NULL,
				NULL,
				NULL,
			</cfif>
			
			<cfif isDefined("service_branch_id") and len(service_branch_id)>#service_branch_id#<cfelse>NULL</cfif>,
			'#member_name#',
			'#system_paper_no#',
			<cfif isdefined("attributes.subscription_id") and len(attributes.subscription_id)>#attributes.subscription_id#<cfelse>NULL</cfif>,
			<cfif isdefined("attributes.project_id") and len(attributes.project_id)>#attributes.project_id#<cfelse>NULL</cfif>,
			<cfif isdefined("attributes.ref_no") and len(attributes.ref_no)>'#attributes.ref_no#'<cfelse>NULL</cfif>,
			<cfif isdefined("attributes.cus_help_id") and len(attributes.cus_help_id)>#attributes.cus_help_id#<cfelse>NULL</cfif>,
			#now()#,
			1,
			<cfif isdefined("attributes.resp_emp_id") and len(attributes.resp_emp_id)>#attributes.resp_emp_id#<cfelse>NULL</cfif>,
			<cfif isdefined('attributes.camp_name') and len(attributes.camp_name) and isdefined('attributes.camp_id') and Len(attributes.camp_id)>#attributes.camp_id#<cfelse>NULL</cfif>
		)
</cfquery>

<cfquery name="GET_SERVICE1" datasource="#DSN#">
	SELECT SERVICE_ID, SERVICE_NO, SERVICE_HEAD, SERVICE_DETAIL,SERVICE_PARTNER_ID FROM G_SERVICE WHERE SERVICE_PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> 
	AND SERVICE_NO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#system_paper_no#">
</cfquery>
<cfquery name="getServProc" datasource="#dsn#">
SELECT DISTINCT (CAU_POSITION_ID),PROCESS_ROW_ID
	,(
		SELECT EMPLOYEE_EMAIL
		FROM w3Partner.EMPLOYEE_POSITIONS
		WHERE POSITION_ID = CAU_POSITION_ID
		) AS MAIL
FROM w3Partner.PROCESS_TYPE_ROWS_CAUID
WHERE PROCESS_ROW_ID =#attributes.process_stage#
</cfquery>

<cfloop query="getServProc">
<cfmail
from="info@partnerbilgisayar.com"
to="#getServProc.MAIL#"
subject="Bir Başvuru Oluşturuldu"
type="HTML">
Yeni İş Başvurusu Oluşturulmuştur;<br>
Link: <a href="http://w3.partnerbilgisayar.com/index.cfm?fuseaction=call.list_service&event=upd&service_id=<cfoutput>#GET_SERVICE1.SERVICE_ID#</cfoutput>&service_no=<cfoutput>#GET_SERVICE1.SERVICE_NO#</cfoutput>"><cfoutput>#GET_SERVICE1.SERVICE_NO#</cfoutput></a><br>
Konu : <b><cfoutput><cfif len(service_head)>'#service_head#'<cfelse>'#system_paper_no#'</cfif></cfoutput></b><br>
Açıklama : <b><cfoutput><cfif len(service_detail)>'#service_detail#'<cfelse>----</cfif></cfoutput></b><br>
Firma : <cfoutput>#session.pp.COMPANY_NICK#</cfoutput><br>
Başvuruyu Yapan : <cfoutput>#session.pp.NAME# #session.pp.SURNAME#</cfoutput><br>
Başvuru Tarihi : <cfoutput>#now()#</cfoutput>
</cfmail>
</cfloop>

<cfquery name="ADD_RECORDED" datasource="#dsn#">
INSERT INTO G_SERVICE_RECORDED (G_SERVICE_ID,RECORDED_IP) VALUES(#get_service1.service_id#,'#cgi.remote_addr#')
</cfquery>


<cfquery name="ADD_HISTORY" datasource="#DSN#">
	INSERT INTO
		G_SERVICE_HISTORY
		(
			SERVICE_ACTIVE,
			SERVICECAT_ID,
			SERVICE_STATUS_ID,
			PRIORITY_ID,
			COMMETHOD_ID,
			SERVICE_HEAD,
			SERVICE_DETAIL,
			SERVICE_CONSUMER_ID,
			RECORD_DATE,
			RECORD_MEMBER,
			APPLY_DATE,
			FINISH_DATE,
			START_DATE,
			UPDATE_DATE,
			UPDATE_MEMBER,
			RECORD_PAR,
			UPDATE_PAR,
			APPLICATOR_NAME,
			SERVICE_ID,
			RESP_EMP_ID
		)
		SELECT
			SERVICE_ACTIVE,
			SERVICECAT_ID,
			SERVICE_STATUS_ID,
			PRIORITY_ID,
			COMMETHOD_ID,
			SERVICE_HEAD,
			SERVICE_DETAIL,
			SERVICE_CONSUMER_ID,
			RECORD_DATE,
			RECORD_MEMBER,
			APPLY_DATE,
			FINISH_DATE,
			START_DATE,
			UPDATE_DATE,
			UPDATE_MEMBER,
			RECORD_PAR,
			UPDATE_PAR,
			APPLICATOR_NAME,
			SERVICE_ID,
			RESP_EMP_ID
		FROM
			G_SERVICE
		WHERE
			SERVICE_ID =<cfqueryparam cfsqltype="cf_sql_integer" value="#get_service1.service_id#">
</cfquery>

<cfif 0 eq 1>
	<cfquery name="ADD_SERVICE_STATUS_ROW" datasource="#DSN#">
		INSERT INTO 
			G_SERVICE_APP_ROWS
			(
				SERVICE_ID,
				SERVICECAT_ID,
				SERVICE_SUB_CAT_ID,
				SERVICE_SUB_STATUS_ID
			)
		VALUES
			(
				#get_service1.service_id#,
				#attributes.appcat_id#,
				<cfif isdefined("attributes.servicecat_sub_id") and len(attributes.servicecat_sub_id)>#attributes.servicecat_sub_id#<cfelse>NULL</cfif>,
				<cfif isdefined("attributes.servicecat_sub_tree_id") and len(attributes.servicecat_sub_tree_id)>#attributes.servicecat_sub_tree_id#<cfelse>NULL</cfif>
			)
	</cfquery>
<cfelse>
	<cfquery name="GET_SERVICE_APPCAT_SUB" datasource="#DSN#">
		SELECT SERVICE_SUB_CAT_ID, SERVICE_SUB_CAT, SERVICECAT_ID FROM G_SERVICE_APPCAT_SUB WHERE SERVICECAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.appcat_id#">
	</cfquery>
	<cfset my_counter = 0>
	<cfoutput query="get_service_appcat_sub">
		<cfif isdefined("attributes.service_sub_cat_id_#service_sub_cat_id#") and len(evaluate("attributes.service_sub_cat_id_#service_sub_cat_id#"))>
			<cfset deger = evaluate("attributes.service_sub_cat_id_#service_sub_cat_id#")>
			<cfif len(deger)>
				<cfset my_counter = 1>
				<cfquery name="ADD_SERVICE_STATUS_ROW" datasource="#DSN#">
					INSERT INTO 
						G_SERVICE_APP_ROWS
						(
							SERVICE_ID,
							SERVICECAT_ID,
							SERVICE_SUB_CAT_ID,
							SERVICE_SUB_STATUS_ID
						)
						VALUES
						(
							#get_service1.service_id#,
							#attributes.appcat_id#,
							#get_service_appcat_sub.service_sub_cat_id#,
							#deger#
						)
				</cfquery>
			</cfif>
		</cfif>		
	</cfoutput>
	<cfif my_counter eq 0>
		<cfquery name="ADD_SERVICE_STATUS_ROW" datasource="#DSN#">
			INSERT INTO 
				G_SERVICE_APP_ROWS
				(
					SERVICE_ID,
					SERVICECAT_ID
				)
					VALUES
				(
					#get_service1.service_id#,
					#attributes.appcat_id#
				)
		</cfquery>
	</cfif>
</cfif>--->
<script>
window.location.href="index.cfm?pageinfo=callCenter&service_id=<cfoutput>#get_service1.service_id#</cfoutput>"
</script>
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