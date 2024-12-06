<cfquery name="getemp" datasource="#dsn#">
SELECT COMPANY_PARTNER_NAME, COMPANY_PARTNER_SURNAME,PARTNER_ID FROM COMPANY_PARTNER WHERE COMPANY_ID=#session.pp.company_id#
</cfquery>
<div class="pageContent">
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                Çalışanlarınız
			</div>

            <div class="tools col-md-6">
                
                        	<cfif checkDenied(attributes.pageinfo,session.pp.userid) eq 0>
			<div class="alert alert-danger">Bu Sayfayı Görmeye Yetkiniz Yok</div>
			<cfabort>
			</cfif>
            
        </div>
        
    </div>  
   
    <table class="table">
    <tr>
    <th>
        Adı
    Soyadı
    </th>
    <th>
        
    </th>
    </tr>
    <cfoutput query="getemp">
    <tr>
    <td>#COMPANY_PARTNER_NAME#
            #COMPANY_PARTNER_SURNAME#</td>
    <td><a href="index.cfm?pageinfo=yetkiler&PARTNER_ID=#PARTNER_ID#">Çalışan Sayfa İzinleri</a></td>
    </tr>
    
    </cfoutput>
    </table>  
</div>    