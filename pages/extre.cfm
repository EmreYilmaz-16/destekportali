<cfparam name="attributes.is_date_filter" default="">
<cfparam name="attributes.due_date_1" default="">
<cfparam name="attributes.due_date_2" default="">
<cfparam name="attributes.action_date_1" default="">
<cfparam name="attributes.action_date_2" default="">
<cfparam name="attributes.other_money_2" default="">
<cfparam name="attributes.project_id" default="">
<cfparam name="attributes.project_head" default="aa">
<cfparam  name="attributes.list_type"default="	">
<cfparam  name="attributes.sirket" default="1">
<cfset session_base = session.pp>
<cfset get_extre = createObject('component','cfc.components')>
<cfset get_money = get_extre.GET_MONEY()>
<cfif isdefined("attributes.due_date_2") and isdate(attributes.due_date_2)>
	<cf_date tarih = "attributes.due_date_2">
</cfif>
<cfif isdefined("attributes.action_date_1") and isdate(attributes.action_date_1)>
	<cf_date tarih = "attributes.action_date_1">
</cfif>
<cfif isdefined("attributes.action_date_2") and isdate(attributes.action_date_2)>
	<cf_date tarih = "attributes.action_date_2">
</cfif>
<cfparam name="attributes.date1" default="#year(now())#-01-01">
<cfparam name="attributes.date2" default="#year(now())#-12-31">
<cfif isDefined('session.pp.userid')>
	<cfset invoice_partner_link = "objects.popup_detail_invoice">
</cfif>
<cfset yilbasi = createodbcdatetime('#session_base.period_year#-01-01')>
<cfparam name="attributes.ch_action_type" default="">
<cfparam name="attributes.other_money" default="">
<cfparam name="attributes.page" default=1>
<cfparam name="attributes.maxrows" default='#session.pp.maxrows#'>
<cfset attributes.startrow=((attributes.page-1)*attributes.maxrows)+1>

<div class="pageContent">
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                <cfoutput>#getLang('main',2402,'Extre')#</cfoutput>
			</div>

            <div class="tools col-md-6">
                        	<cfif checkDenied(attributes.pageinfo,session.pp.userid) eq 0>
			<div class="alert alert-danger">Bu Sayfayı Görmeye Yetkiniz Yok</div>
			<cfabort>
			</cfif>
            	<form name="list_ekstre" method="post" action="index.cfm?pageinfo=extre" role="form">
                	<input type="hidden" name="form_submitted" value="1" />
                    <input type="hidden" value="1" name="date_control" id="date_control">
                    <cfoutput>
                        <input type="hidden" name="company_id" id="company_id" value="#session.pp.company_id#">
                        <input type="hidden" name="consumer_id" id="consumer_id" value="">
                        <input type="hidden" name="employee_id" id="employee_id" value="<cfif isdefined("attributes.employee_id") and len(attributes.employee_id) and isdefined("attributes.member_type") and len(attributes.member_type) and attributes.member_type is 'employee'>#attributes.employee_id#</cfif>">
                        <input type="hidden" name="member_type" id="member_type" value="partner">
                        <input type="hidden" name="company" id="company" readonly="yes" value="#session.pp.company#">
                        <input type="hidden" name="due_date_2" id="due_date_2" value="">
                        <input type="hidden" name="is_date_filter" id="is_date_filter" value="">
                        <input type="hidden" name="due_date_1" id="due_date_1" value="">
                        <input type="hidden" name="other_money_2" id="other_money_2" value="">
                        <input type="hidden" name="action_date_1" id="action_date_1" value="">
                        <input type="hidden" name="action_date_2" id="action_date_2" value="">
                        <div class="input-group searchInput col-lg-8 col-md-12 pull-right">
                        	<select name="sirket" class="form-control" style="width:150px">
                            <option <cfif attributes.sirket eq 1>selected</cfif> value="1">Partner Otomasyon</option>
                            <option <cfif attributes.sirket eq 2>selected</cfif>  value="2">Analiz Data</option>
                            <option <cfif attributes.sirket eq 6>selected</cfif>  value="6">Partner Bilgi Sistemleri</option>
                            </select>
                            <span class="input-group-addon inputGroupSeperator"></span>
                            <input type="date" name="date1" id="date1" class="form-control" maxlength="10" value="#attributes.date1#" validate="eurodate" placeholder="#getLang('main',641,'Başlangıç Tarihi')#">
                            <span class="input-group-addon inputGroupSeperator"></span>
                            <input type="date" name="date2" id="date2" class="form-control" maxlength="10" value="#attributes.date2#" validate="eurodate" placeholder="#getLang('main',288,'Bitiş Tarihi')#">
                            <cf_searchButton detail="1">
                        </div>
                        <div class="searchDetailContent" style="display:none;">
							<div class="portlet light bordered">                                    
                                <div class="portlet-body form">
                                    <div class="form-body form-horizontal">
                                        <div class="form-group">
                                        	<div class=" col-sm-12">
                                               <select classs="custom-checkbox" name="list_type" multiple style="width:100%">
             <option value="0" <cfif listFind(attributes.list_type, 0) >selected</cfif>>Türk Lirası</option>
            <option value="1" <cfif listFind(attributes.list_type, 1) >selected</cfif>>Detaylı</option>
            <option value="2" <cfif listFind(attributes.list_type, 2) >selected</cfif>>İşlem Dövizli</option>
            <option value="4" <cfif listFind(attributes.list_type, 4) >selected</cfif>>Açıklama</option>
            <option value="3" <cfif listFind(attributes.list_type, 3) >selected</cfif>>Renkli</option>
            </select> 
                                        </div>
                                    	<div class="form-group">
                                        	<div class="col-sm-12">
												<cfset get_project = get_extre.GET_PROJECT_FOR_EXTRE()>
                                                <cf_catalystSelectbox name="project_id">
                                                    <option value="">#getLang('main',4,'Proje')#</option>
                                                    <cfloop query="get_project">
                                                        <option value="#project_id#"<cfif attributes.project_id eq project_id>selected</cfif>>#project_head#</option>
                                                    </cfloop>
                                                </cf_catalystSelectbox>
                                            </div>
                                        </div>
										<div class="form-group">
                                        	<div class="col-sm-12">
                                            	<cf_catalystSelectbox name="other_money">
                                                    <option value="">#getLang('objects2',113,'Para Birimi')#</option>
                                                    <cfloop query="get_money">
                                                        <option value="#money#" <cfif attributes.other_money eq money>selected</cfif>>#money#</option>
                                                    </cfloop>
	                                            </cf_catalystSelectbox>
                                            </div>
										</div>
										<div class="form-group">
                                        	<div class="col-sm-12">
	                                            <input type="number" class="form-control" id="maxrows" name="maxrows" value="#attributes.maxrows#">
                                            </div>
                                        </div>
									</div>
                                    <div class="form-actions right">
                                        <cf_searchButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </cfoutput>
				</form>
			</div>
		</div>
	</div>
</div>
<cfset DSN3="#dsn#_1">
<!---<cfset DSN2="#dsn#_#year(now())#_1">--->
<cfset DSN2="#dsn#_#session.pp.PERIOD_YEAR#_#attributes.sirket#">

<cfset DEVBakiye=0>
<cfset DEVDBakiye=0>
<cfset DEVBORC=0>
<cfset DEVALACAK=0>
<cfset DEVDBORC=0>
<cfset DEVDALACAK=0>
<cfset Bakiye=0>
<cfset DBakiye=0>
<cfset BORC=0>
<cfset ALACAK=0>
<cfset DBORC=0>
<cfset DALACAK=0>


<cfset attributes.comp_id=session.pp.company_id>
<!--------------------
<cfscript>
    //Use an absolute path for the files. 
       theDir=GetDirectoryFromPath(GetCurrentTemplatePath());
    theFile=theDir & "courses.xls";
    //Create two empty ColdFusion spreadsheet objects.
    theSheet = SpreadsheetNew("CourseData");
    theSecondSheet = SpreadsheetNew("CentersData");
    //Populate each object with a query. 
	SpreadsheetAddRow(theSheet,"150,ENGL,95,Poetry 1",8,1);
SpreadsheetAddRow(theSheet,"150",9,1);
SpreadsheetAddRow(theSheet,"EMRE",9,4);
</cfscript>
<cfspreadsheet action="write" filename="#theFile#" name="theSheet"
    sheetname="courses" overwrite=true>
<cfdump  var="#theDir#">

------------------------->
<div class="pageContent">
    <div class="portlet">
<table class="table table-sm" style="width:100%">
<cfif attributes.date1 gt '#year(now())#-01-01'>
<cfquery name="GetDevir" datasource="#dsn2#">
    select * from #dsn2#.CARI_ROWS
    where 1=1 <cfif isDefined("attributes.comp_id") and len(attributes.comp_id)>
    AND (TO_CMP_ID=#attributes.comp_id# or FROM_CMP_ID=#attributes.comp_id#)
    </cfif>
    AND ACTION_DATE>='#year(now())#-01-01'
    <cfif isDefined("attributes.date1") and attributes.date1 neq "">
    AND ACTION_DATE<'#attributes.date1#'
    </cfif>
    order by ACTION_DATE
</cfquery>

<cfoutput query="GetDevir">
    <cfif len(TO_CMP_ID)>
        <cfset DEVBORC=DEVBORC+ACTION_VALUE>
        <cfset DEVDBORC=DEVDBORC+ACTION_VALUE_2>
    </cfif>
    <cfif len(FROM_CMP_ID)>
        <cfset DEVALACAK=DEVALACAK+ACTION_VALUE>
        <cfset DEVDALACAK=DEVDALACAK+ACTION_VALUE_2>
    </cfif>
    <cfset DEVBakiye=DEVBORC-DEVALACAK>
    <cfset DEVDBakiye=DEVDBORC-DEVDALACAK>
</cfoutput>

</cfif>

<cfquery name="getCariRow" datasource="#dsn3#">
select * from #dsn2#.CARI_ROWS
where 1=1 <cfif isDefined("attributes.comp_id") and len(attributes.comp_id)>
AND (TO_CMP_ID=#attributes.comp_id# or FROM_CMP_ID=#attributes.comp_id#)
</cfif>
<cfif isDefined("attributes.date1") and attributes.date1 neq "">
AND ACTION_DATE>='#attributes.date1#'
</cfif>
<cfif isDefined("attributes.date2") and attributes.date2 neq "">
AND ACTION_DATE<='#attributes.date2#'
</cfif>
order by ACTION_DATE,PAPER_NO
</cfquery>

<cfset colsapn=3>
<cfif listFind(attributes.list_type, 0)>
<cfset colsapn=colsapn+3>
</cfif>
<cfif listFind(attributes.list_type, 2)>
<cfset colsapn=colsapn+3>
</cfif>
<cfif listFind(attributes.list_type, 4)>
<cfset colsapn=colsapn+1>
</cfif>

<cfif 1 eq 0 and getCariRow.recordcount eq 0 and DEVDBakiye eq 0>
<cfelse>
    <cfoutput query="getCariRow">
        <cfif len(TO_CMP_ID)>
            <cfset BORC=BORC+ACTION_VALUE>
            <cfset DBORC=DBORC+ACTION_VALUE_2>
        </cfif>
        <cfif len(FROM_CMP_ID)>
            <cfset ALACAK=ALACAK+ACTION_VALUE>
            <cfset DALACAK=DALACAK+ACTION_VALUE_2>
        </cfif>
        <cfset Bakiye=BORC-ALACAK>
        <cfset DBakiye=DBORC-DALACAK>
    </cfoutput>
    <thead>
        <tr>
            <th style="color:blue" colspan="<cfoutput>#colsapn#</cfoutput>">
                <cfquery name="getComp" datasource="#dsn#">
                    SELECT * FROM COMPANY WHERE COMPANY_ID=#attributes.comp_id#
                </cfquery>       
                <cfoutput> #getComp.FULLNAME# </cfoutput>
            </th>        
        </tr>

    <cfif attributes.date1 gt '#year(now())#-01-01'>
        <cfset Bakiye=DEVBakiye>
        <cfset DBakiye=DEVDBakiye>
        <cfset BORC=DEVBORC>
        <cfset ALACAK=DEVALACAK>
        <cfset DBORC=DEVDBORC>
        <cfset DALACAK=DEVDALACAK>
        <cfset TBORC=0>
        <cfset TDBORC=0>
        <cfset TALACAK=0>
        <cfset TDALACAK=0>
    <cfelse>
        <cfset Bakiye=0>
        <cfset DBakiye=0>
        <cfset BORC=0>
        <cfset ALACAK=0>
        <cfset DBORC=0>
        <cfset DALACAK=0>
        <cfset TBORC=0>
        <cfset TDBORC=0>
        <cfset TALACAK=0>
        <cfset TDALACAK=0>
    </cfif>
        <tr>
            <th class="b1" style="font-weight:bold;width:3%">İşlem Tarihi</th>
            <th class="b1"style="font-weight:bold;width:13%">İşlem</th>
            <th class="b1"style="font-weight:bold;width:7%;text-align:center">Evrak No</th>
                <cfif listFind(attributes.list_type, 4)><th class="b1" style="font-weight:bold;width:7%;text-align:center">Açıklama</th></cfif>
        <cfif listFind(attributes.list_type, 0)>
            <th class="b1"style="font-weight:bold;text-align:right;width:7%">BORC</th>
            <th class="b1"style="font-weight:bold;text-align:right;width:7%">ALACAK</th>
            <th class="b1"style="font-weight:bold;text-align:right;width:7%">BAKIYE</th>
        </cfif>
        <cfif listFind(attributes.list_type, 2)>
            <th class="b1"style="font-weight:bold;text-align:right;width:7%">BORC</th>
            <th class="b1"style="font-weight:bold;text-align:right;width:7%">ALACAK</th>
            <th class="b1"style="font-weight:bold;text-align:right;width:7%">Bakiye</th>
        </cfif>
               
        </tr>
    </thead>

    <tbody>
    <cfif attributes.date1 gt '#year(now())#-01-01'>
        <tr>
            <td></td>
            <td  style="font-weight:bold"><span class="tableyazi">Devir < <cfoutput>#dateformat(attributes.date1,'dd/mm/yyy')#</cfoutput> </span></td>
            <td></td>

        <cfoutput>
            <td></td>
        <cfif listFind(attributes.list_type, 0)>
            <td style="text-align:right;font-weight:bold;<cfif listFind(attributes.list_type, 3)>color:red;font-weight:bold;</cfif>">                            
                #tlformat(BORC)# TL

            </td>
            <td style="text-align:right;font-weight:bold;<cfif listFind(attributes.list_type, 3)>color:blue;font-weight:bold;</cfif>">            

                #tlformat(ALACAK)# TL
            </td>   
                 <cfset Bakiye=BORC-ALACAK>   
            <td style="font-weight:bold;text-align:right;<cfif listFind(attributes.list_type, 3)and Bakiye lt 0 >color:blue<cfelseif listFind(attributes.list_type, 3)and Bakiye gt 0 >color:red</cfif>">
           
                #tlformat(Bakiye)# TL

            </td>
        </cfif>
        <cfif listFind(attributes.list_type, 2) >
            <td style="text-align:right;<cfif listFind(attributes.list_type, 3)>color:red;font-weight:normal;text-align:right</cfif>">

                #tlformat(DBORC)# USD
            </td>
            <td style="text-align:right;<cfif listFind(attributes.list_type, 3)>color:blue;font-weight:normal;</cfif>">
                #tlformat(DALACAK)# USD

            </td>
            <cfset DBakiye=DBORC-DALACAK>
            <td style="font-weight:bold;text-align:right;<cfif listFind(attributes.list_type, 3)and DBakiye lt 0 >color:blue<cfelseif listFind(attributes.list_type, 3)and DBakiye gt 0 >color:red</cfif>">
                
                #tlformat(DBakiye)# USD

            </td>
        </cfif>

       
        </tr>
    </cfoutput>
</cfif>

<cfloop query="getCariRow">

<cfoutput>
<cfscript>
Qline=StructNew();
</cfscript>

<tr>
<td style="font-weight:bold;"><span class="tableyazi">#dateformat(ACTION_DATE,"dd/mm/yyyy")#</span></td>
     
    <td style="font-weight:bold">
    <cfif ACTION_TABLE eq "INVOICE" and listFind("63,60,49,51,59,54,55,591", ACTION_TYPE_ID) gt 0>
        <a class="tableyazi">#ACTION_NAME#<a>
    <cfelseif ACTION_TABLE eq "INVOICE" and listFind("53,120,62,58,56,48,50", ACTION_TYPE_ID) gt 0>
        <a class="tableyazi" >#ACTION_NAME#<a>
        <cfelseif ACTION_TABLE eq "BANK_ACTIONS">
        <a class="tableyazi" >#ACTION_NAME#</a>
                <cfelseif ACTION_TABLE eq "CARI_ACTIONS" and listFind("41", ACTION_TYPE_ID) gt 0>
          <a class="tableyazi" href="javascript://" onclick="windowopen('index.cfm?fuseaction=objects.popup_print_upd_debit_claim_note&period_id=#session.pp.PERIOD_ID#&ID=#ACTION_ID#','page');">#ACTION_NAME#</a>
         <cfelseif ACTION_TABLE eq "EXPENSE_ITEM_PLANS" and listFind("120", ACTION_TYPE_ID) gt 0> 
               <a class="tableyazi" href="javascript://" onclick="windowopen('index.cfm?fuseaction=objects.popup_list_cost_expense&period_id=#session.pp.PERIOD_ID#&ID=#ACTION_ID#','page');">#ACTION_NAME#</a>
     <cfelseif ACTION_TABLE eq "CHEQUE">
     #left(ACTION_NAME,9)#
    <cfelse>
        #ACTION_NAME#
    </cfif>


    </td>
    <cfset INFO = "">
    <td style="font-weight:bold;text-align:center"><span class="tableyazi">#PAPER_NO#</spab></td>
    <cfif listFind(attributes.list_type, 4)>    
    <td style="font-weight:bold;width:7%;text-align:center">
    <cfif ACTION_TABLE eq "INVOICE">
    <cfquery name="getInfo" datasource="#dsn2#">
    select NOTE AS ACIKLAMA from INVOICE  where INVOICE_ID=#ACTION_ID#
    </cfquery>
    <cfset INFO = getInfo.ACIKLAMA>
    </cfif>
     <cfif ACTION_TABLE eq "CHEQUE">
    <cfquery name="getInfo" datasource="#dsn2#">
        select CHEQUE_PURSE_NO ,CHEQUE_DUEDATE  from CHEQUE  where CHEQUE_ID=#ACTION_ID#
    </cfquery>
   <cfset INFO ="P.No: "&getInfo.CHEQUE_PURSE_NO&" V.Tar: "&dateformat(getInfo.CHEQUE_DUEDATE,"dd/mm/yyyy")>
   
    </cfif>
    <span class="tableyazi">#INFO#</span>
    </td></cfif>
       
    <cfif listFind(attributes.list_type, 0)>

            <td style="text-align:right;font-weight:bold;<cfif listFind(attributes.list_type, 3)>color:red;</cfif>">    
            <cfif len(TO_CMP_ID)>
            <cfset BORC=BORC+ACTION_VALUE>
            #tlformat(ACTION_VALUE)# #ACTION_CURRENCY_ID#
           
             </cfif>
            
            </td>
            <td style="text-align:right;font-weight:bold;<cfif listFind(attributes.list_type, 3)>color:blue;font-weight:bold;</cfif>">
            <cfif len(FROM_CMP_ID)>
                  
            #tlformat(ACTION_VALUE)# #ACTION_CURRENCY_ID#
            <cfset ALACAK=ALACAK+ACTION_VALUE>
            </cfif>
             
            </td>     
             <cfset Bakiye=BORC-ALACAK> 
            <td style="font-weight:bold;text-align:right;<cfif listFind(attributes.list_type, 3)and Bakiye lt 0 >color:blue<cfelseif listFind(attributes.list_type, 3)and Bakiye gt 0 >color:red</cfif>">
           
            #tlformat(Bakiye)# #ACTION_CURRENCY_ID#
           
            </td>
        
    </cfif>
<cfscript>

</cfscript>

        <cfif listFind(attributes.list_type, 2) >
        
    <td style="text-align:right;font-weight:bold;<cfif listFind(attributes.list_type, 3)>color:red;font-weight:bold;text-align:right</cfif>">
    <cfif len(TO_CMP_ID)>
     <cfset DBORC=DBORC+ACTION_VALUE_2>
    #tlformat(ACTION_VALUE_2)# #ACTION_CURRENCY_2#
   
    </cfif></td>
  
        <td style="text-align:right;font-weight:bold;<cfif listFind(attributes.list_type, 3)>color:bold;font-weight:bold;</cfif>">
    <cfif len(FROM_CMP_ID)>
    #tlformat(ACTION_VALUE_2)# #ACTION_CURRENCY_2#
   <cfset DALACAK=DALACAK+ACTION_VALUE_2>
   
    </cfif></td>
     
    <cfset DBakiye=DBORC-DALACAK>
    <td style="font-weight:bold;text-align:right;<cfif listFind(attributes.list_type, 3)and DBakiye lt 0 >color:blue<cfelseif listFind(attributes.list_type, 3)and DBakiye gt 0 >color:red</cfif>">
    
    #tlformat(DBakiye)# #ACTION_CURRENCY_2#
       
    </td>
    </cfif>
      
</tr>
<cfscript>

</cfscript>
<cfif ACTION_TABLE eq "INVOICE" and listFind(attributes.list_type, 1)>
<tr>
<!----CONTAINER_QUANTITY,DELIVERY_COUNTRY----->
    <td colspan="#colsapn#">
    <cfquery name="getFatura" datasource="#dsn2#">
    SELECT IR.NAME_PRODUCT,
    IR.AMOUNT,
    IR.UNIT,
    IR.PRICE_OTHER,
    IR.PRICE,
    IR.CONTAINER_QUANTITY,
    IR.DELIVERY_COUNTRY,
    IR.OTHER_MONEY_VALUE,
    IR.OTHER_MONEY as 'SATIRPARA',
    IR.NETTOTAL,
    I.OTHER_MONEY AS 'FATURAPARA'
    FROM #dsn2#.INVOICE AS I,#dsn2#.INVOICE_ROW AS IR 
    WHERE I.INVOICE_ID=IR.INVOICE_ID AND I.INVOICE_ID=#getCariRow.ACTION_ID#
    </cfquery>
        <table>
            <tr style="">
                <th class="b2" style="width:250px;max-width:250px;color:black;">Ürün Adı</th>
                <th class="b2" style="width:70px;color:black;text-align:right">Miktar</th>
                  <cfif listFind(attributes.list_type, 0)>
                <th class="b2" style="width:100px;color:black;;text-align:right;background-color:none">Fiyat</th>
                <th class="b2" style="width:100px;color:black;;text-align:right ;background-color:none">Tutar</th>
                </cfif>
                <cfif listFind(attributes.list_type, 2)>
                <th class="b2" style="width:100px;color:black;;text-align:right;background-color:none">Fiyat</th>
                <th class="b2" style="width:100px;color:black;;text-align:right;background-color:none">Tutar</th>
                </cfif>
                <th  class="b2" style="width:120px;color:black;text-align:center;background-color:none">Renk Kodu</th>
                <th  class="b2" style="width:120px;color:black;text-align:center;background-color:none">Renk</th>
            </tr>

            <cfloop query="getFatura">
                <tr>
                    <td style="   white-space: nowrap;text-overflow: ellipsis; overflow: hidden">
                        #NAME_PRODUCT#
                    </td>
                    <td style="text-align:right">
                        #AMOUNT#
                    </td>
                  
                    <cfif listFind(attributes.list_type, 0)>
                    <td style="text-align:right">
                        #tlformat(PRICE)# TL
                    </td>
                    <td style="text-align:right">
                        #tlformat(NETTOTAL)# TL
                    </td>
                    
                     
                     <cfelse>                     
                    </cfif>
                   
                     <cfif listFind(attributes.list_type, 2)>
                    <td style="text-align:right">
                        #tlformat(PRICE_OTHER)# #SATIRPARA#
                    </td>
                    <td style="text-align:right">
                        #tlformat(OTHER_MONEY_value)# #SATIRPARA#
                    </td>
                              
                     
                     <cfelse>
                     
                    </cfif>
                    
                     <td style="text-align:center;white-space: nowrap;text-overflow: ellipsis; overflow: hidden">#CONTAINER_QUANTITY#</td>
                    <td style="text-align:center;white-space: nowrap;text-overflow: ellipsis; overflow: hidden">#DELIVERY_COUNTRY#</td>
                                
                </tr>
        </cfloop>

            <tr><td colspan="6" style="height:1px;max-height:1px;background-color:black;padding:0"></td></tr>
        </table>
        </cfif>
    </td>
</tr>

</cfoutput>



</cfloop>
       
</tbody>
</cfif>
<cfoutput>
<tfoot>

<cfif listFind(attributes.list_type, 0) and listFind(attributes.list_type, 2) and listFind(attributes.list_type, 4)>
<cfset colsapn=1>
<cfelse>
<cfset colsapn=2>
</cfif>
<cfif listFind(attributes.list_type, 0)>
<cfset colsapn=colsapn+1>
</cfif>
<cfif listFind(attributes.list_type, 2)>
<cfset colsapn=colsapn+1>
</cfif>
<cfif listFind(attributes.list_type, 4)>
<cfset colsapn=colsapn+1>
</cfif>
<tr style="text-align:right;height:5px !important;pading:0"><td style="text-align:right;height:5px !important;pading:0" colspan="#colsapn#"></td><cfif listFind(attributes.list_type, 0)>
<td style="text-align:right;height:5px !important;pading:0"></td>
</cfif>
<cfif listFind(attributes.list_type, 0)>
<td style="text-align:right;height:5px !important;pading:0"></td>
</cfif>
<cfif listFind(attributes.list_type, 0)>
<td style="text-align:right;height:5px !important;pading:0"></td>
</cfif>
<cfif listFind(attributes.list_type,2)>
<td style="text-align:right;height:5px !important;pading:0"></td>
</cfif>
<cfif listFind(attributes.list_type, 2)>
<td style="text-align:right;height:5px !important;pading:0"></td>
</cfif>
<cfif listFind(attributes.list_type, 2)>
<td style="text-align:right;height:5px !important;pading:0"></td>
</cfif></tr>
<tr>
<td colspan="#colsapn#" style="text-align:left">
Toplam
</td>

<cfif listFind(attributes.list_type, 0)>
<td style="text-align:right;">#tlformat(BORC)# TL</td>
</cfif>
<cfif listFind(attributes.list_type, 0)>
<td style="text-align:right;">#tlformat(ALACAK)# TL</td>
</cfif>
<cfif listFind(attributes.list_type, 0)>
<td style="text-align:right;<cfif listFind(attributes.list_type, 3)and (BORC-ALACAK) lt 0 >color:blue<cfelseif listFind(attributes.list_type, 3)and  (BORC-ALACAK) gt 0 >color:red</cfif>">#tlformat(BORC-ALACAK)# TL</td>
</cfif>
<cfif listFind(attributes.list_type,2)>
<td style="text-align:right;">#tlformat(DBORC)# USD</td>
</cfif>
<cfif listFind(attributes.list_type, 2)>
<td style="text-align:right;">#tlformat(DALACAK)# USD</td>
</cfif>
<cfif listFind(attributes.list_type, 2)>
<td style="text-align:right;<cfif listFind(attributes.list_type, 3)and (DBORC-DALACAK) lt 0 >color:blue<cfelseif listFind(attributes.list_type, 3)and (DBORC-DALACAK) gt 0 >color:red</cfif>">#tlformat(DBORC-DALACAK)# USD</td>
</cfif>
</tr>
</tfoot>
</cfoutput>

</table>
</div>
</div>