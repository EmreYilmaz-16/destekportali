<cfquery name="get_pages" datasource="#dsn#">
SELECT * FROM B2B2C_PAGES WHERE  PAGE_ID NOT IN(17,1)
</cfquery>
<cfquery name="getemp" datasource="#dsn#">
SELECT COMPANY_PARTNER_NAME, COMPANY_PARTNER_SURNAME,PARTNER_ID FROM COMPANY_PARTNER WHERE PARTNER_ID=#attributes.PARTNER_ID#
</cfquery>
<div class="pageContent">
    <div class="portlet">
     <div class="portlet-title">
            <div class="caption">
             <cfoutput>
             #getemp.COMPANY_PARTNER_NAME# #getemp.COMPANY_PARTNER_SURNAME#
             </cfoutput>
			</div>
    </div>
    	        <cfif checkDenied(attributes.pageinfo,session.pp.userid) eq 0>
			<div class="alert alert-danger">Bu Sayfayı Görmeye Yetkiniz Yok</div>
			<cfabort>
			</cfif>        
<table class="table table-sm">
<cfoutput query="get_pages">

<tr><td>#PAGE_HEAD#</td><td>
<cfquery name="isDenied" datasource="#dsn#">
select * from COMPANY_PARTNER_DENIED where DENIED_PAGE='#PAGE_FRIENDLY_URL#' and PARTNER_ID=#attributes.PARTNER_ID#
</cfquery>

<cfif isDenied.recordcount>
    <cfif isDenied.IS_VIEW eq 1 >
    <button class="btn btn-danger" onclick="yetkiver('#PAGE_FRIENDLY_URL#','#attributes.PARTNER_ID#','3')">Yetki Kaldır</button>
    <cfelse>
    <button class="btn btn-success" onclick="yetkiver('#PAGE_FRIENDLY_URL#','#attributes.PARTNER_ID#','1')">Yetki Ver</button>
    </cfif>
    <cfelse>
    <button class="btn btn-success" onclick="yetkiver('#PAGE_FRIENDLY_URL#','#attributes.PARTNER_ID#','2')">Yetki Ver</button>
</cfif>
</td></tr>

</cfoutput>
</table>
</div>
</div>

<script>
function yetkiver(a,b,c){
    console.log(a+'--'+b+'--'+c)	
	$.ajax({
		url: 'cfc/ajax.cfc?method=yetkiveral&pageinfo='+a+'&PARTNER_ID='+b+'&islem='+c,
          async: false, 
         success: function (res) {
			data = $.parseJSON(res);
			console.log(data);
            window.location.reload()
		}
	});
}
</script>