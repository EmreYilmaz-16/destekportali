<cfparam name="attributes.is_date_filter" default="">
<cfparam name="attributes.due_date_1" default="">
<cfparam name="attributes.due_date_2" default="">
<cfparam name="attributes.action_date_1" default="">
<cfparam name="attributes.action_date_2" default="">
<cfparam name="attributes.other_money_2" default="">
<cfparam name="attributes.project_id" default="">
<cfparam name="attributes.project_head" default="aa">
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
<cfif isdefined("attributes.date1") and isdate(attributes.date1)>
	<cf_date tarih = "attributes.date1">
<cfelse>
	<cfset date1="01/01/#session_base.period_year#">
</cfif>
<cfif isdefined('attributes.date2') and isdate(attributes.date2)>
	<cf_date tarih = "attributes.date2">
<cfelse>
	<cfset date2 = "31/12/#session_base.period_year#">
</cfif>
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
                <cfoutput>#getLang('main',2402,'Extre')# #checkDenied(attributes.pageinfo,session.pp.userid)#</cfoutput>
			</div>
			<cfif checkDenied(attributes.pageinfo,session.pp.userid) eq 0>
			<div class="alert alert-danger">Bu Sayfayı Görmeye Yetkiniz Yok</div>
			<cfabort>
			</cfif>
            <div class="tools col-md-6">
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
                        	<cf_catalystSelectbox name="ch_action_type">
                                <option value="">#getLang('main',388,'Seçiniz')#</option><!--- gruplara gore alfabetiktir, lutfen riayet ediniz --->
                                <optgroup label="#getLang('main',1505,'Faturalar')#">
                                    <option value="63" <cfif attributes.ch_action_type eq 63>selected</cfif>>#getLang('main',399,'Alınan Fiyat Farkı Fat')#</option>
                                    <option value="601" <cfif attributes.ch_action_type eq 601>selected</cfif>>#getLang('main',400,'Alınan Hakediş Faturası')#</option>
                                    <option value="60" <cfif attributes.ch_action_type eq 60> selected</cfif>>#getLang('main',401,'Alınan Hizmet Fat')#</option>
                                    <option value="61" <cfif attributes.ch_action_type eq 61>selected</cfif>>#getLang('main',402,'Alınan Proforma Fat')#</option>
                                    <option value="51" <cfif attributes.ch_action_type eq 51>selected</cfif>>#getLang('objects2',51,'Alınan Vade Farkı Fat')#</option>
                                    <option value="62" <cfif attributes.ch_action_type eq 62>selected </cfif>>#getLang('main',403,'Alınan Iade Fat')#</option>
                                    <option value="37" <cfif attributes.ch_action_type eq 37>selected</cfif>>#getLang('main',404,'Gider Pusulası')#</option>
                                    <option value="690" <cfif attributes.ch_action_type eq 690>selected</cfif>>#getLang('main',405,'Gider Pusulası (Mal)')#</option>
                                    <option value="691" <cfif attributes.ch_action_type eq 691>selected</cfif>>#getLang('main',406,'Gider Pusulası (Hizmet)')#</option>
                                    <option value="591" <cfif attributes.ch_action_type eq 591>selected</cfif>>#getLang('main',408,'İthalat Faturası')#</option>
                                    <option value="531" <cfif attributes.ch_action_type eq 531>selected</cfif>>#getLang('main',409,'İhracat Faturası')#</option>
                                    <option value="59" <cfif attributes.ch_action_type eq 59>selected</cfif>>#getLang('objects2',58,'Mal Alım Fat')#</option>
                                    <option value="64" <cfif attributes.ch_action_type eq 64> selected</cfif>>#getLang('main',411,'Müstahsil Makbuzu')#</option>
                                    <option value="52" <cfif attributes.ch_action_type eq 52>selected</cfif>>#getLang('objects2',60,'Perakende Satış Fat')#</option>
                                    <option value="54" <cfif attributes.ch_action_type eq 54>selected</cfif>>#getLang('main',412,'Per Sat İade Fat')#</option>
                                    <option value="53" <cfif attributes.ch_action_type eq 53>selected</cfif>>#getLang('main',413,'Toptan Satış Fat')#</option>
                                    <option value="55" <cfif attributes.ch_action_type eq 55>selected</cfif>>#getLang('main',414,'Topt Sat İade Fat')#</option>
                                    <option value="50" <cfif attributes.ch_action_type eq 50>selected</cfif>>#getLang('main',415,'Verilen Vade Farkı Fat')#</option>
                                    <option value="561"<cfif attributes.ch_action_type eq 561>selected</cfif>>#getLang('main',416,'Verilen Hakediş Faturası')#</option>
                                    <option value="56" <cfif attributes.ch_action_type eq 56>selected</cfif>>#getLang('main',417,'Verilen Hizmet Faturası')#</option>
                                    <option value="57" <cfif attributes.ch_action_type eq 57>selected</cfif>>#getLang('objects2',67,'Verilen Proforma Faturası')#</option>
                                    <option value="58" <cfif attributes.ch_action_type eq 58>selected</cfif>>#getLang('main',418,'Verilen Fiyat Farkı Fat')#</option>
                                </optgroup>
                                <optgroup label="#getLang('main',1484,'Banka İşlemleri')#">
                                    <option value="20" <cfif attributes.ch_action_type eq 20>selected</cfif>>#getLang('main',419,'Banka Hesap Açılış Fişi')#</option>
                                    <option value="38" <cfif attributes.ch_action_type eq 38>selected</cfif>>#getLang('main',420,'Döviz Alış')#</option>
                                    <option value="39" <cfif attributes.ch_action_type eq 39>selected</cfif>>#getLang('main',421,'Döviz Satış')#</option>
                                    <option value="24" <cfif attributes.ch_action_type eq 24>selected</cfif>>#getLang('main',422,'Gelen Havale')#</option>
                                    <option value="25" <cfif attributes.ch_action_type eq 25>selected</cfif>>#getLang('main',423,'Giden Havale')#</option>
                                    <option value="241" <cfif attributes.ch_action_type eq 241>selected</cfif>>#getLang('main',424,'Kredi Kartı Tahsilat')#</option>
                                    <option value="242" <cfif attributes.ch_action_type eq 242>selected</cfif>>#getLang('main',425,'Kredi Kartı Ödeme')#</option>
                                    <option value="291" <cfif attributes.ch_action_type eq 291>selected</cfif>>#getLang('main',426,'Kredi Ödemesi')#</option>
                                    <option value="292" <cfif attributes.ch_action_type eq 292>selected</cfif>>#getLang('main',427,'Kredi Tahsilatı')#</option>
                                    <option value="293" <cfif attributes.ch_action_type eq 293>selected</cfif>>#getLang('objects2',80,'Menkul Kıymet Alışı')#</option>
                                    <option value="294" <cfif attributes.ch_action_type eq 294>selected</cfif>>#getLang('objects2',81,'Menkul Kıymet Satışı')#</option>
                                </optgroup>
                                <optgroup label="#getLang('main',1485,'Kasa İşlemleri')#">
                                    <option value="34" <cfif attributes.ch_action_type eq 34>selected</cfif>>#getLang('main',430,'Alış Fatura Kapama')#</option>
                                    <option value="36" <cfif attributes.ch_action_type eq 36>selected</cfif>>#getLang('main',431,'Gider Ödeme')#</option>
                                    <option value="30" <cfif attributes.ch_action_type eq 30>selected</cfif>>#getLang('main',432,'Kasa Açılış Fişi')#</option>
                                    <option value="31" <cfif attributes.ch_action_type eq 31>selected</cfif>>#getLang('main',433,'Tahsilat')#</option>
                                    <option value="35" <cfif attributes.ch_action_type eq 35>selected</cfif>>#getLang('main',434,'Satış Fatura Kapama')#</option>
                                    <option value="32" <cfif attributes.ch_action_type eq 32>selected</cfif>>#getLang('main',435,'Ödeme')#</option>
                                </optgroup>
                                <optgroup label="#getLang('main',1486,'Cari İşlemleri')#">
                                    <option value="42" <cfif attributes.ch_action_type eq 42>selected</cfif>>#getLang('main',436,'Alacak Dekontu')#</option>
                                    <option value="41" <cfif attributes.ch_action_type eq 41>selected</cfif>>#getLang('main',437,'Borç Dekontu')#</option>
                                    <option value="43" <cfif attributes.ch_action_type eq 43>selected</cfif>>#getLang('main',438,'Cari Virman Fişi')#</option>
                                    <option value="40" <cfif attributes.ch_action_type eq 40>selected</cfif>>#getLang('main',439,'C/H Açılış Fişi')#</option>
                                </optgroup>
                                <optgroup label="#getLang('main',1488,'Çek Senet İşlemleri')#">
                                    <option value="90" <cfif attributes.ch_action_type eq 90>selected</cfif>>#getLang('objects2',95,'Çek Bord Girişi')#</option>
                                    <option value="92" <cfif attributes.ch_action_type eq 92>selected</cfif>>#getLang('objects2',96,'Çek Çıkış Bord (Tahsil)')#</option>
                                    <option value="93" <cfif attributes.ch_action_type eq 93>selected</cfif>>#getLang('main',442,'Çek Çıkış Bord (Banka Tem)')#</option>
                                    <option value="91" <cfif attributes.ch_action_type eq 91>selected</cfif>>#getLang('objects2',98,'Çek Çıkış Bord(Ciro)')#</option>
                                    <option value="95" <cfif attributes.ch_action_type eq 95>selected</cfif>>#getLang('objects2',99,'Çek İade Giriş Bord')#</option>
                                    <option value="94" <cfif attributes.ch_action_type eq 94>selected</cfif>>#getLang('objects2',100,'Çek İade Çıkış Bord')#</option>
                                </optgroup>
                            </cf_catalystSelectbox>
                            <span class="input-group-addon inputGroupSeperator"></span>
                            <input type="text" name="date1" id="date1" class="form-control datepicker" maxlength="10" value="#date1#" validate="eurodate" placeholder="#getLang('main',641,'Başlangıç Tarihi')#">
                            <span class="input-group-addon inputGroupSeperator"></span>
                            <input type="text" name="date2" id="date2" class="form-control datepicker" maxlength="10" value="#date2#" validate="eurodate" placeholder="#getLang('main',288,'Bitiş Tarihi')#">
                            <cf_searchButton detail="1">
                        </div>
                        <div class="searchDetailContent" style="display:none;">
							<div class="portlet light bordered">                                    
                                <div class="portlet-body form">
                                    <div class="form-body form-horizontal">
                                        <div class="form-group">
                                        	<div class="col-md-4 col-sm-12">
                                            	<label class="col-xs-12"><input type="checkbox" name="is_doviz" id="is_doviz" <cfif isdefined('attributes.is_doviz')>checked</cfif>> #getLang('main',383,'İşlem Dövizli')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_doviz2" id="is_doviz2" <cfif isdefined('attributes.is_doviz2')>checked</cfif>> 2. #getLang('main',384,'Dövizli')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_doviz2_bakiye" id="is_doviz2_bakiye" <cfif isdefined('attributes.is_doviz2_bakiye')>checked</cfif>> 2. #getLang('main',385,'Döviz Bakiyeli')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_pay_cheques" id="is_pay_cheques" <cfif isdefined('attributes.is_pay_cheques')>checked</cfif>> #getLang('main',501,'Ödenmemiş Çek/Senetleri Getirme')#</label>
                                            </div>
                                            <div class="col-md-4 col-sm-12">
                                                <label class="col-xs-12"><input type="checkbox" name="is_due" id="is_due" checked> #getLang('main',386,'Vadeli')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_color" id="is_color" <cfif isdefined('attributes.is_color')>checked</cfif>> #getLang('main',387,'Renkli')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_process_cat" id="is_process_cat" <cfif isdefined('attributes.is_process_cat')>checked</cfif>> #getLang('main',388,'İşlem Tipi')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_doviz_group" id="is_doviz_group" <cfif isdefined('attributes.is_doviz_group')>checked</cfif>> #getLang('objects2',109,'İşlem Dövizi Bazında Özet')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_project_group" id="is_project_group" <cfif isdefined('attributes.is_project_group')>checked</cfif>> #getLang('main',1519,'Proje Bazında Grupla')#</label>
                                            </div>
                                            <div class="col-md-4 col-sm-12">
                                                <label class="col-xs-12"><input type="checkbox" name="is_action_detail" id="is_action_detail" <cfif isdefined('attributes.is_action_detail')>checked</cfif>> #getLang('main',217,'Açıklama')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_make_age" id="is_make_age" <cfif isdefined('attributes.is_make_age')>checked</cfif>> #getLang('main',390,'Ödeme Performansı')#</label>
                                                <label class="col-xs-12"><input type="checkbox" name="is_inv_detail" id="is_inv_detail" <cfif isdefined('attributes.is_inv_detail')>checked</cfif>> #getLang('main',630,'Fatura Detaylı')#</label>
                                                <label class="col-xs-12"><input type="checkbox" value="1" name="is_excel" id="is_excel" <cfif isdefined('attributes.is_excel')>checked</cfif>> #getLang('main',446,'Excel Getir')#</label>
                                            </div>
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
<cfif isDefined("is_make_age")><!--- ödeme performansını getirir,bu gelirse diğer extre görüntüsü gelmeyecek --->
	<cfif isDefined("attributes.is_doviz_group")>
		<cfinclude template="extreSummary.cfm">
	</cfif>
	<!---<cfinclude template="../../../objects/display/dsp_make_age.cfm">	--->
</cfif>


      <cfabort>              
        <table cellpadding="2" width="100%" cellspacing="1" align="center">
            <input type="hidden" value="1" name="form_submit" id="form_submit">
            <input type="hidden" value="1" name="date_control" id="date_control">
            <tr>
                <td>
                    <table>
                        <cfoutput>
                            <input type="hidden" name="company_id" id="company_id" value="#session.pp.company_id#">
                            <input type="hidden" name="consumer_id" id="consumer_id" value="">
                            <input type="hidden" name="employee_id" id="employee_id" value="<cfif isdefined("attributes.employee_id") and len(attributes.employee_id) and isdefined("attributes.member_type") and len(attributes.member_type) and attributes.member_type is 'employee'>#attributes.employee_id#</cfif>">
                            <input type="hidden" name="member_type" id="member_type" value="partner">
                            <input type="hidden" name="company" id="company" readonly="yes" value="#session.pp.company#">
                            <tr>
                                <td>
                                    <select name="ch_action_type" id="ch_action_type" class="selectpicker">
                                        <option value="" selected>#getLang('main',388,'Seçiniz')#</option><!--- gruplara gore alfabetiktir, lutfen riayet ediniz --->
                                        <optgroup label="#getLang('main',1505,'Faturalar')#">
                                            <option value="63" <cfif attributes.ch_action_type eq 63>selected</cfif>>#getLang('main',399,'Alınan Fiyat Farkı Fat')#</option>
                                            <option value="601" <cfif attributes.ch_action_type eq 601>selected</cfif>>#getLang('main',400,'Alınan Hakediş Faturası')#</option>
                                            <option value="60" <cfif attributes.ch_action_type eq 60> selected</cfif>>#getLang('main',401,'Alınan Hizmet Fat')#</option>
                                            <option value="61" <cfif attributes.ch_action_type eq 61>selected</cfif>>#getLang('main',402,'Alınan Proforma Fat')#</option>
                                            <option value="51" <cfif attributes.ch_action_type eq 51>selected</cfif>>#getLang('objects2',51,'Alınan Vade Farkı Fat')#</option>
                                            <option value="62" <cfif attributes.ch_action_type eq 62>selected </cfif>>#getLang('main',403,'Alınan Iade Fat')#</option>
                                            <option value="37" <cfif attributes.ch_action_type eq 37>selected</cfif>>#getLang('main',404,'Gider Pusulası')#</option>
                                            <option value="690" <cfif attributes.ch_action_type eq 690>selected</cfif>>#getLang('main',405,'Gider Pusulası (Mal)')#</option>
                                            <option value="691" <cfif attributes.ch_action_type eq 691>selected</cfif>>#getLang('main',406,'Gider Pusulası (Hizmet)')#</option>
                                            <option value="591" <cfif attributes.ch_action_type eq 591>selected</cfif>>#getLang('main',408,'İthalat Faturası')#</option>
                                            <option value="531" <cfif attributes.ch_action_type eq 531>selected</cfif>>#getLang('main',409,'İhracat Faturası')#</option>
                                            <option value="59" <cfif attributes.ch_action_type eq 59>selected</cfif>>#getLang('objects2',58,'Mal Alım Fat')#</option>
                                            <option value="64" <cfif attributes.ch_action_type eq 64> selected</cfif>>#getLang('main',411,'Müstahsil Makbuzu')#</option>
                                            <option value="52" <cfif attributes.ch_action_type eq 52>selected</cfif>>#getLang('objects2',60,'Perakende Satış Fat')#</option>
                                            <option value="54" <cfif attributes.ch_action_type eq 54>selected</cfif>>#getLang('main',412,'Per Sat İade Fat')#</option>
                                            <option value="53" <cfif attributes.ch_action_type eq 53>selected</cfif>>#getLang('main',413,'Toptan Satış Fat')#</option>
                                            <option value="55" <cfif attributes.ch_action_type eq 55>selected</cfif>>#getLang('main',414,'Topt Sat İade Fat')#</option>
                                            <option value="50" <cfif attributes.ch_action_type eq 50>selected</cfif>>#getLang('main',415,'Verilen Vade Farkı Fat')#</option>
                                            <option value="561"<cfif attributes.ch_action_type eq 561>selected</cfif>>#getLang('main',416,'Verilen Hakediş Faturası')#</option>
                                            <option value="56" <cfif attributes.ch_action_type eq 56>selected</cfif>>#getLang('main',417,'Verilen Hizmet Faturası')#</option>
                                            <option value="57" <cfif attributes.ch_action_type eq 57>selected</cfif>>#getLang('objects2',67,'Verilen Proforma Faturası')#</option>
                                            <option value="58" <cfif attributes.ch_action_type eq 58>selected</cfif>>#getLang('main',418,'Verilen Fiyat Farkı Fat')#</option>
                                        </optgroup>
                                        <optgroup label="#getLang('main',1484,'Banka İşlemleri')#">
                                            <option value="20" <cfif attributes.ch_action_type eq 20>selected</cfif>>#getLang('main',419,'Banka Hesap Açılış Fişi')#</option>
                                            <option value="38" <cfif attributes.ch_action_type eq 38>selected</cfif>>#getLang('main',420,'Döviz Alış')#</option>
                                            <option value="39" <cfif attributes.ch_action_type eq 39>selected</cfif>>#getLang('main',421,'Döviz Satış')#</option>
                                            <option value="24" <cfif attributes.ch_action_type eq 24>selected</cfif>>#getLang('main',422,'Gelen Havale')#</option>
                                            <option value="25" <cfif attributes.ch_action_type eq 25>selected</cfif>>#getLang('main',423,'Giden Havale')#</option>
                                            <option value="241" <cfif attributes.ch_action_type eq 241>selected</cfif>>#getLang('main',424,'Kredi Kartı Tahsilat')#</option>
                                            <option value="242" <cfif attributes.ch_action_type eq 242>selected</cfif>>#getLang('main',425,'Kredi Kartı Ödeme')#</option>
                                            <option value="291" <cfif attributes.ch_action_type eq 291>selected</cfif>>#getLang('main',426,'Kredi Ödemesi')#</option>
                                            <option value="292" <cfif attributes.ch_action_type eq 292>selected</cfif>>#getLang('main',427,'Kredi Tahsilatı')#</option>
                                            <option value="293" <cfif attributes.ch_action_type eq 293>selected</cfif>>#getLang('objects2',80,'Menkul Kıymet Alışı')#</option>
                                            <option value="294" <cfif attributes.ch_action_type eq 294>selected</cfif>>#getLang('objects2',81,'Menkul Kıymet Satışı')#</option>
                                        </optgroup>
                                        <optgroup label="#getLang('main',1485,'Kasa İşlemleri')#">
                                            <option value="34" <cfif attributes.ch_action_type eq 34>selected</cfif>>#getLang('main',430,'Alış Fatura Kapama')#</option>
                                            <option value="36" <cfif attributes.ch_action_type eq 36>selected</cfif>>#getLang('main',431,'Gider Ödeme')#</option>
                                            <option value="30" <cfif attributes.ch_action_type eq 30>selected</cfif>>#getLang('main',432,'Kasa Açılış Fişi')#</option>
                                            <option value="31" <cfif attributes.ch_action_type eq 31>selected</cfif>>#getLang('main',433,'Tahsilat')#</option>
                                            <option value="35" <cfif attributes.ch_action_type eq 35>selected</cfif>>#getLang('main',434,'Satış Fatura Kapama')#</option>
                                            <option value="32" <cfif attributes.ch_action_type eq 32>selected</cfif>>#getLang('main',435,'Ödeme')#</option>
                                        </optgroup>
                                        <optgroup label="#getLang('main',1486,'Cari İşlemleri')#">
                                            <option value="42" <cfif attributes.ch_action_type eq 42>selected</cfif>>#getLang('main',436,'Alacak Dekontu')#</option>
                                            <option value="41" <cfif attributes.ch_action_type eq 41>selected</cfif>>#getLang('main',437,'Borç Dekontu')#</option>
                                            <option value="43" <cfif attributes.ch_action_type eq 43>selected</cfif>>#getLang('main',438,'Cari Virman Fişi')#</option>
                                            <option value="40" <cfif attributes.ch_action_type eq 40>selected</cfif>>#getLang('main',439,'C/H Açılış Fişi')#</option>
                                        </optgroup>
                                        <optgroup label="#getLang('main',1488,'Çek Senet İşlemleri')#">
                                            <option value="90" <cfif attributes.ch_action_type eq 90>selected</cfif>>#getLang('objects2',95,'Çek Bord Girişi')#</option>
                                            <option value="92" <cfif attributes.ch_action_type eq 92>selected</cfif>>#getLang('objects2',96,'Çek Çıkış Bord (Tahsil)')#</option>
                                            <option value="93" <cfif attributes.ch_action_type eq 93>selected</cfif>>#getLang('main',442,'Çek Çıkış Bord (Banka Tem)')#</option>
                                            <option value="91" <cfif attributes.ch_action_type eq 91>selected</cfif>>#getLang('objects2',98,'Çek Çıkış Bord(Ciro)')#</option>
                                            <option value="95" <cfif attributes.ch_action_type eq 95>selected</cfif>>#getLang('objects2',99,'Çek İade Giriş Bord')#</option>
                                            <option value="94" <cfif attributes.ch_action_type eq 94>selected</cfif>>#getLang('objects2',100,'Çek İade Çıkış Bord')#</option>
                                        </optgroup>
                                    </select>
                                </td>
                                <cfabort>
                                <td>
                                    <cfsavecontent variable="message"><cf_get_lang no='101.Baslangiç Tarihi Girmelisiniz !'></cfsavecontent>
                                    <cfinput type="text" name="date1" value="#date1#" required="yes" validate="eurodate" message="#message#" style="width:65px;" maxlength="10">
                                    <cf_wrk_date_image date_field="date1">
                                </td>
                                <td>
                                    <cfsavecontent variable="message"><cf_get_lang_main no='327.Bitiş Tarihi Girmelisiniz !'></cfsavecontent>
                                    <cfinput type="text" name="date2" value="#date2#" required="yes" validate="eurodate" message="#message#" style="width:65px;" maxlength="10">
                                    <cf_wrk_date_image date_field="date2">
                                </td>
                            </tr>
                        </cfoutput>
                    </table>
                    <!---
                    <table>
                        <cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>
                            <cfquery name="GET_PROJECT_" datasource="#DSN#">
                                SELECT 
                                    PROJECT_ID,
                                    PROJECT_HEAD 
                                FROM 
                                    PRO_PROJECTS 
                                WHERE 
                                    COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">
                            </cfquery>
                            <tr>
                                <td width="45"><cf_get_lang_main no='4.Proje'></td>
                                <td> 
                                    <select name="project_id" id="project_id" style="width:250px;">
                                        <option value=""><cf_get_lang_main no='322.Seçiniz'></option>
                                        <cfoutput query="get_project_">
                                            <option value="#project_id#"<cfif attributes.project_id eq project_id>selected</cfif>>#project_head#</option>
                                        </cfoutput>
                                    </select>
                                </td>
                            </tr>
                        </cfif>
                     </table>
                    <table style="width:60%;">
                        <tr>
                            <td width="45"></td>
                            <td valign="top">
                                <input type="checkbox" name="is_doviz" id="is_doviz" <cfif isdefined('attributes.is_doviz')>checked</cfif>> <cf_get_lang_main no='383.İşlem Dövizli'><br />
                                <input type="checkbox" name="is_doviz2" id="is_doviz2" <cfif isdefined('attributes.is_doviz2')>checked</cfif>> 2. <cf_get_lang_main no='384.Dövizli'><br />
                                <input type="checkbox" name="is_doviz2_bakiye" id="is_doviz2_bakiye" <cfif isdefined('attributes.is_doviz2_bakiye')>checked</cfif>> 2. <cf_get_lang_main no='385.Döviz Bakiyeli'><br />
                                <input type="checkbox" name="is_pay_cheques" id="is_pay_cheques" <cfif isdefined('attributes.is_pay_cheques')>checked</cfif>> <cf_get_lang_main no='501.Ödenmemiş Çek/Senetleri Getirme'>
                            </td>
                            <td valign="top">
                                <input type="checkbox" name="is_due" id="is_due" checked><cf_get_lang_main no='386.Vadeli'><br />
                                <input type="checkbox" name="is_color" id="is_color" <cfif isdefined('attributes.is_color')>checked</cfif>> <cf_get_lang_main no='387.Renkli'><br />
                                <input type="checkbox" name="is_process_cat" id="is_process_cat" <cfif isdefined('attributes.is_process_cat')>checked</cfif>> <cf_get_lang_main no='388.İşlem Tipi'><br />
                                <input type="checkbox" name="is_doviz_group" id="is_doviz_group" <cfif isdefined('attributes.is_doviz_group')>checked</cfif>> <cf_get_lang no='109.İşlem Dövizi Bazında Özet'><br />
                                <input type="checkbox" name="is_project_group" id="is_project_group" <cfif isdefined('attributes.is_project_group')>checked</cfif>> <cf_get_lang_main no='1519.Proje Bazında Grupla'>
                            </td>
                            <td valign="top">
                                <input type="checkbox" name="is_action_detail" id="is_action_detail" <cfif isdefined('attributes.is_action_detail')>checked</cfif>> <cf_get_lang_main no='217.Açıklama'><br />
                                <input type="checkbox" name="is_make_age" id="is_make_age" <cfif isdefined('attributes.is_make_age')>checked</cfif>> <cf_get_lang_main no='390.Ödeme Performansı'><br />
                                <input type="checkbox" name="is_inv_detail" id="is_inv_detail" <cfif isdefined('attributes.is_inv_detail')>checked</cfif>> <cf_get_lang_main no='630.Fatura Detaylı'><br />
                                <input type="checkbox" value="1" name="is_excel" id="is_excel" <cfif isdefined('attributes.is_excel')>checked</cfif>> <cf_get_lang_main no='446.Excel Getir'>
                            </td>
                         </tr>
                     </table>
                    <table style="text-align:right;" style="width:25%;">
                        <tr>
                            <td style="text-align:right" valign="bottom">
                                <select name="other_money" id="other_money" style="width:62px;">
                                    <option value=""><cf_get_lang no='113.Para Br.'></option>
                                    <cfoutput query="get_money">
                                        <option value="#money#" <cfif attributes.other_money eq money>selected</cfif>>#money#</option>
                                    </cfoutput>
                                </select>
                            </td>
                            <td valign="bottom">
                                <input type="hidden" name="due_date_2" id="due_date_2" value="">
                                <input type="hidden" name="is_date_filter" id="is_date_filter" value="">
                                <input type="hidden" name="due_date_1" id="due_date_1" value="">
                                <input type="hidden" name="other_money_2" id="other_money_2" value="">
                                <input type="hidden" name="action_date_1" id="action_date_1" value="">
                                <input type="hidden" name="action_date_2" id="action_date_2" value="">
                                <cfsavecontent variable="message"><cf_get_lang_main no='125.Sayi_Hatasi_Mesaj'></cfsavecontent>
                                <cfinput type="text" name="maxrows" value="#attributes.maxrows#" required="yes" validate="integer" range="1,500" message="#message#" maxlength="3" style="width:25px;">
                            </td>
                            <td valign="bottom">
                                <cfsavecontent variable="message"><cf_get_lang_main no='238.Dök'></cfsavecontent>
                                <cf_workcube_buttons is_upd='0' insert_alert='' insert_info='#message#' add_function='kontrol()' type_format="1">
                            </td>
                        </tr>
                    </table>
               </td>
            </tr>
        </table>
    </cfform>
</div>


--->
<!-- sil -->
<cfif isDefined("is_make_age")><!--- ödeme performansını getirir,bu gelirse diğer extre görüntüsü gelmeyecek --->
	<cfif isDefined("attributes.is_doviz_group")>
		<table cellpadding="2" cellspacing="1" border="0" width="98%" align="center" class="color-border">
			<tr class="color-row">
				<td> 
					<cfinclude template="../../../objects/display/dsp_extre_summary.cfm">				
				</td>
			</tr>
		</table>
	</cfif>
	<cfinclude template="../../../objects/display/dsp_make_age.cfm">	
<cfelse>
	<cfif isdefined('attributes.form_submit')>	
		<cfquery name="GET_PERIODS" datasource="#DSN#">
			SELECT 
				PERIOD_YEAR,
				PERIOD_ID,
				OUR_COMPANY_ID
			FROM 
				SETUP_PERIOD 
			WHERE 
				OUR_COMPANY_ID = <cfif isDefined("session.pp")><cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.our_company_id#"><cfelse> <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ww.our_company_id#"></cfif> AND
				PERIOD_YEAR >= <cfqueryparam cfsqltype="cf_sql_integer" value="#dateformat(attributes.date1,'yyyy')#"> 
				AND PERIOD_YEAR <= <cfqueryparam cfsqltype="cf_sql_integer" value="#dateformat(attributes.date2,'yyyy')#">
			ORDER BY 
				OUR_COMPANY_ID,
				PERIOD_YEAR 
		</cfquery>
		<cfif not get_periods.recordcount>
			<script type="text/javascript">
				alert("<cf_get_lang_main no ='447.Dönem Kaydı Bulunmamaktadır'>!");
				history.back();	
			</script>
			<cfabort>
		</cfif>
		<cfloop query="get_periods">
			<cfif get_periods.period_year lt year(now())>
				<cfset new_date = createodbcdatetime('31/12/#get_periods.period_year#')>
			<cfelse>
				<cfset new_date = now()>
			</cfif>
			<cfset new_period = get_periods.period_id>
			<cfset new_dsn = '#dsn#_#get_periods.PERIOD_YEAR#_#get_periods.OUR_COMPANY_ID#'>
			<cfif isdefined('attributes.form_submit')>
				<cfif isdefined('attributes.is_due')><!--- Vadeli secili ise --->
					<cfquery name="GET_PAYMETHOD" datasource="#DSN#">
						SELECT PAYMETHOD_ID,DUE_DAY,DUE_MONTH FROM SETUP_PAYMETHOD ORDER BY PAYMETHOD_ID
					</cfquery>
					<cfset pay_method_id_list = ''>
					<cfset pay_method_gun_list = ''>
					<cfoutput query="GET_PAYMETHOD">
						<cfif len(DUE_DAY)>
							<cfset pay_method_id_list = listappend(pay_method_id_list,PAYMETHOD_ID,',')>
							<cfset pay_method_gun_list = listappend(pay_method_gun_list,DUE_DAY,',')>
						<cfelseif len(DUE_MONTH)><!--- aylik taksitler icin ortalama vade aliniyor --->
							<cfset pay_method_id_list = listappend(pay_method_id_list,PAYMETHOD_ID,',')>
							<cfset pay_method_gun_list = listappend(pay_method_gun_list,(DUE_MONTH*30)/2,',')>
						</cfif>
					</cfoutput>
				</cfif>
			    <cfquery name="CARI_ROWS" datasource="#new_dsn#">
					SELECT 
						CR.ACTION_ID,
						CR.CARI_ACTION_ID,
						CR.ACTION_TYPE_ID,
						CR.ACTION_TABLE,
						CR.OTHER_MONEY,
						CR.PAPER_NO,
						CR.ACTION_NAME,
						CR.PROCESS_CAT,
						ISNULL(CR.PROJECT_ID,0) PROJECT_ID,
						CR.TO_CMP_ID,
						CR.TO_CONSUMER_ID,
						CR.TO_EMPLOYEE_ID,
						CR.FROM_CMP_ID,
						CR.FROM_CONSUMER_ID,
						CR.FROM_EMPLOYEE_ID,
						CR.DUE_DATE,
						CR.ACTION_DETAIL,
						CR.ACTION_DATE AS ACTION_DATE, 
						0 AS BORC, 
						0 AS BORC2,
						0 AS BORC_OTHER,
						CR.ACTION_VALUE AS ALACAK,
						CR.ACTION_VALUE_2 AS ALACAK2,
						CR.OTHER_CASH_ACT_VALUE AS ALACAK_OTHER,
						0 AS PAY_METHOD,
						CR.IS_PROCESSED,
						0 DETAIL_TYPE,
						'' STOCK_CODE,
						'' NAME_PRODUCT,
						0 AMOUNT,
						'' UNIT,
						0 PRICE,
						0 TAX,
						0 GROSSTOTAL,
						0 PRICE_OTHER,
						0 OTHER_MONEY_GROSS_TOTAL,
						'' ROW_MONEY,
						'' EXP_DETAIL,
						'' EXPENSE_ITEM_NAME,
						'' EXPENSE_CENTER,
						0 OTV_RATE,
						'' ROW_PROJECT_ID,
						'' SPECT_VAR_NAME,
						'' DISCOUNT1,
						'' DISCOUNT2,
						'' DISCOUNT3,
						'' DISCOUNT4,
						'' DISCOUNT5,
						'' DISCOUNT6,
						'' DISCOUNT7,
						'' DISCOUNT8,
						'' DISCOUNT9,
						'' DISCOUNT10
					FROM 
						CARI_ROWS CR
					WHERE 
						<cfif isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner'>
							CR.FROM_CMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.COMPANY_ID#">
						<cfelseif isdefined('attributes.consumer_id') and  len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer'>
							CR.FROM_CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.consumer_id#">
						<cfelseif isdefined('attributes.employee_id') and  len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
							CR.FROM_EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.employee_id#">
						</cfif>
						<cfif len(attributes.project_id)>
							AND CR.PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.project_id#">
						</cfif>
						<cfif isDefined("attributes.ch_action_type") and len(attributes.ch_action_type)>
							AND ACTION_TYPE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.ch_action_type#"> 
						</cfif>
						<cfif isDefined("attributes.other_money") and len(attributes.other_money)>
							AND OTHER_MONEY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.other_money#">
						</cfif>
						<cfif isdefined("attributes.is_pay_cheques")>
							AND
							(
							(CR.ACTION_TABLE = 'CHEQUE' AND CR.ACTION_ID IN (SELECT CHEQUE_ID FROM CHEQUE WHERE CHEQUE_ID = CR.ACTION_ID AND (CHEQUE_STATUS_ID IN (3,7) OR (CHEQUE_STATUS_ID = 4 AND CHEQUE_DUEDATE <= #new_date#))))
							OR	
							(CR.ACTION_TABLE = 'PAYROLL' AND CR.ACTION_ID IN (SELECT CH.PAYROLL_ID FROM CHEQUE C,CHEQUE_HISTORY CH WHERE CH.PAYROLL_ID = CR.ACTION_ID AND C.CHEQUE_ID = CH.CHEQUE_ID AND  (C.CHEQUE_STATUS_ID IN (3,7) OR (C.CHEQUE_STATUS_ID = 4 AND C.CHEQUE_DUEDATE <= #new_date#))))
							OR 
							(CR.ACTION_TABLE = 'VOUCHER' AND CR.ACTION_ID IN (SELECT VOUCHER_ID FROM VOUCHER WHERE VOUCHER_ID = CR.ACTION_ID AND (VOUCHER_STATUS_ID IN (3,7) OR (VOUCHER_STATUS_ID = 4 AND VOUCHER_DUEDATE < #new_date#))))
							OR	
							(CR.ACTION_TABLE = 'VOUCHER_PAYROLL' AND CR.ACTION_ID IN (SELECT VH.PAYROLL_ID FROM VOUCHER V,VOUCHER_HISTORY VH WHERE VH.PAYROLL_ID = CR.ACTION_ID AND V.VOUCHER_ID = VH.VOUCHER_ID AND  (V.VOUCHER_STATUS_ID IN (3,7) OR( V.VOUCHER_STATUS_ID = 4 AND V.VOUCHER_DUEDATE < #new_date#))))
							OR 
							(CR.ACTION_TABLE <> 'PAYROLL' AND CR.ACTION_TABLE <> 'CHEQUE' AND CR.ACTION_TABLE <> 'VOUCHER' AND CR.ACTION_TABLE <> 'VOUCHER_PAYROLL')
							)			
						</cfif>
				UNION
					SELECT
						CR.ACTION_ID,
						CR.CARI_ACTION_ID,
						CR.ACTION_TYPE_ID,
						CR.ACTION_TABLE,
						CR.OTHER_MONEY,
						CR.PAPER_NO,
						CR.ACTION_NAME,
						CR.PROCESS_CAT,
						ISNULL(CR.PROJECT_ID,0) PROJECT_ID,
						CR.TO_CMP_ID,
						CR.TO_CONSUMER_ID,
						CR.TO_EMPLOYEE_ID,
						CR.FROM_CMP_ID,
						CR.FROM_CONSUMER_ID,
						CR.FROM_EMPLOYEE_ID,
						CR.DUE_DATE,
						CR.ACTION_DETAIL,
						CR.ACTION_DATE AS ACTION_DATE, 
						CR.ACTION_VALUE AS BORC,
						CR.ACTION_VALUE_2 AS BORC2,
						CR.OTHER_CASH_ACT_VALUE AS BORC_OTHER,
						0 AS ALACAK,
						0 AS ALACAK2,
						0 AS ALACAK_OTHER,
						0 AS PAY_METHOD,
						CR.IS_PROCESSED,
						0 DETAIL_TYPE,
						'' STOCK_CODE,
						'' NAME_PRODUCT,
						0 AMOUNT,
						'' UNIT,
						0 PRICE,
						0 TAX,
						0 GROSSTOTAL,
						0 PRICE_OTHER,
						0 OTHER_MONEY_GROSS_TOTAL,
						'' ROW_MONEY,
						'' EXP_DETAIL,
						'' EXPENSE_ITEM_NAME,
						'' EXPENSE_CENTER,
						0 OTV_RATE,
						'' ROW_PROJECT_ID,
						'' SPECT_VAR_NAME,
						'' DISCOUNT1,
						'' DISCOUNT2,
						'' DISCOUNT3,
						'' DISCOUNT4,
						'' DISCOUNT5,
						'' DISCOUNT6,
						'' DISCOUNT7,
						'' DISCOUNT8,
						'' DISCOUNT9,
						'' DISCOUNT10
					FROM 
						CARI_ROWS CR
					WHERE
						<cfif isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner'>
							CR.TO_CMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.COMPANY_ID#">
						<cfelseif isdefined('attributes.consumer_id') and  len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer'>
							CR.TO_CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.consumer_id#">
						<cfelseif isdefined('attributes.employee_id') and  len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
							CR.TO_EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.employee_id#">
						</cfif>
						<cfif len(attributes.project_id)>
							AND CR.PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.project_id#">
						</cfif>
						<cfif isDefined("attributes.ch_action_type") and len(attributes.ch_action_type)>
							AND ACTION_TYPE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.ch_action_type#"> 
						</cfif>
						<cfif isDefined("attributes.other_money") and len(attributes.other_money)>
							AND OTHER_MONEY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.other_money#"> 
						</cfif>
						<cfif isdefined("attributes.is_pay_cheques")>
							AND
							(
							(CR.ACTION_TABLE = 'CHEQUE' AND CR.ACTION_ID IN (SELECT CHEQUE_ID FROM CHEQUE WHERE CHEQUE_ID = CR.ACTION_ID AND (CHEQUE_STATUS_ID IN (3,7) OR (CHEQUE_STATUS_ID = 4 AND CHEQUE_DUEDATE <= #new_date#))))
							OR	
							(CR.ACTION_TABLE = 'PAYROLL' AND CR.ACTION_ID IN (SELECT CH.PAYROLL_ID FROM CHEQUE C,CHEQUE_HISTORY CH WHERE CH.PAYROLL_ID = CR.ACTION_ID AND C.CHEQUE_ID = CH.CHEQUE_ID AND  (C.CHEQUE_STATUS_ID IN (3,7) OR (C.CHEQUE_STATUS_ID = 4 AND C.CHEQUE_DUEDATE <= #new_date#))))
							OR 
							(CR.ACTION_TABLE = 'VOUCHER' AND CR.ACTION_ID IN (SELECT VOUCHER_ID FROM VOUCHER WHERE VOUCHER_ID = CR.ACTION_ID AND (VOUCHER_STATUS_ID IN (3,7) OR (VOUCHER_STATUS_ID = 4 AND VOUCHER_DUEDATE < #new_date#))))
							OR	
							(CR.ACTION_TABLE = 'VOUCHER_PAYROLL' AND CR.ACTION_ID IN (SELECT VH.PAYROLL_ID FROM VOUCHER V,VOUCHER_HISTORY VH WHERE VH.PAYROLL_ID = CR.ACTION_ID AND V.VOUCHER_ID = VH.VOUCHER_ID AND  (V.VOUCHER_STATUS_ID IN (3,7) OR( V.VOUCHER_STATUS_ID = 4 AND V.VOUCHER_DUEDATE < #new_date#))))
							OR 
							(CR.ACTION_TABLE <> 'PAYROLL' AND CR.ACTION_TABLE <> 'CHEQUE' AND CR.ACTION_TABLE <> 'VOUCHER' AND CR.ACTION_TABLE <> 'VOUCHER_PAYROLL')
							)
						</cfif>
				<cfif isdefined("attributes.is_inv_detail")><!--- stoklu extre için --->
					UNION ALL
						SELECT
							CR.ACTION_ID,
							CR.CARI_ACTION_ID,
							CR.ACTION_TYPE_ID,
							CR.ACTION_TABLE,
							CR.OTHER_MONEY,
							CR.PAPER_NO,
							CR.ACTION_NAME,
							CR.PROCESS_CAT,
							ISNULL(CR.PROJECT_ID,0) PROJECT_ID,
							CR.TO_CMP_ID,
							CR.TO_CONSUMER_ID,
							CR.TO_EMPLOYEE_ID,
							CR.FROM_CMP_ID,
							CR.FROM_CONSUMER_ID,
							CR.FROM_EMPLOYEE_ID,
							CR.DUE_DATE,
							CR.ACTION_DETAIL,
							CR.ACTION_DATE, 
							0 BORC,
							0 BORC2,
							0 BORC_OTHER,
							0 ALACAK,
							0 ALACAK2,
							0 ALACAK_OTHER,
							0 PAY_METHOD,
							0 IS_PROCESSED,
							1 DETAIL_TYPE,<!--- STOKLU EXTRE tipi için ve altta gerekli alanlar var --->
							S.STOCK_CODE,
							INVOICE_ROW.NAME_PRODUCT,
							INVOICE_ROW.AMOUNT,
							INVOICE_ROW.UNIT,
							INVOICE_ROW.PRICE,
							INVOICE_ROW.TAX,
							INVOICE_ROW.GROSSTOTAL,
							INVOICE_ROW.PRICE_OTHER,
							INVOICE_ROW.OTHER_MONEY_GROSS_TOTAL,
							INVOICE_ROW.OTHER_MONEY ROW_MONEY,
							'' EXP_DETAIL,
							'' EXPENSE_ITEM_NAME,
							'' EXPENSE_CENTER,
							0 OTV_RATE,
							'' ROW_PROJECT_ID,
							ISNULL(INVOICE_ROW.SPECT_VAR_NAME,' ') SPECT_VAR_NAME,
							INVOICE_ROW.DISCOUNT1,
							INVOICE_ROW.DISCOUNT2,
							INVOICE_ROW.DISCOUNT3,
							INVOICE_ROW.DISCOUNT4,
							INVOICE_ROW.DISCOUNT5,
							INVOICE_ROW.DISCOUNT6,
							INVOICE_ROW.DISCOUNT7,
							INVOICE_ROW.DISCOUNT8,
							INVOICE_ROW.DISCOUNT9,
							INVOICE_ROW.DISCOUNT10
						FROM 
							CARI_ROWS CR,
							INVOICE,
							INVOICE_ROW,
							#dsn3_alias#.STOCKS S
						WHERE
							INVOICE.INVOICE_ID = INVOICE_ROW.INVOICE_ID AND
							INVOICE.INVOICE_ID = CR.ACTION_ID AND
							INVOICE.INVOICE_CAT = CR.ACTION_TYPE_ID AND
							CR.ACTION_TABLE = 'INVOICE' AND
							S.STOCK_ID = INVOICE_ROW.STOCK_ID AND
							S.PRODUCT_ID = INVOICE_ROW.PRODUCT_ID
							AND
							(
								((SELECT COUNT(CRR.ACTION_ID) FROM CARI_ROWS CRR WHERE CRR.ACTION_TYPE_ID = INVOICE.INVOICE_CAT AND CRR.ACTION_ID = INVOICE.INVOICE_ID)  > 1 AND DATEADD(day,INVOICE_ROW.DUE_DATE,INVOICE.INVOICE_DATE) = CR.DUE_DATE AND INVOICE_ROW.OTHER_MONEY = CR.OTHER_MONEY)
								OR 
								(SELECT COUNT(CRR.ACTION_ID) FROM CARI_ROWS CRR WHERE CRR.ACTION_TYPE_ID = INVOICE.INVOICE_CAT AND CRR.ACTION_ID = INVOICE.INVOICE_ID) = 1
							)			
						<cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1) or (isdefined("attributes.pos_code") and len(attributes.pos_code) and len(attributes.pos_code_text))>
							AND (CR.TO_CMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.COMPANY_ID#"> OR CR.FROM_CMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.COMPANY_ID#">)
						<cfelseif (isdefined('attributes.consumer_id') and  len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
							AND (CR.TO_CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.consumer_id#"> OR CR.FROM_CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.consumer_id#">)
						<cfelseif isdefined('attributes.employee_id') and  len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
							AND (CR.TO_EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.employee_id#"> OR CR.FROM_EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.employee_id#">)
						</cfif>
						<cfif isdefined("attributes.asset_id") and len(attributes.asset_id) and len(attributes.asset_name)>
							AND CR.ASSETP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.asset_id#">
						</cfif>
						<cfif isDefined("attributes.ch_action_type") and len(attributes.ch_action_type)>
							AND CR.ACTION_TYPE_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.ch_action_type#">)
						</cfif>
						<cfif isDefined("attributes.other_money") and len(attributes.other_money)>
							<cfif attributes.other_money is 'YTL' or attributes.other_money is 'TL'>
								AND (CR.OTHER_MONEY = 'YTL' OR CR.OTHER_MONEY = 'TL')
							<cfelse>
								AND CR.OTHER_MONEY = '#attributes.other_money#'
							</cfif>
						</cfif>
						<cfif listgetat(attributes.fuseaction,1,'.') is 'store' or isdefined("is_store_module")>
							AND	(CR.FROM_BRANCH_ID = #listgetat(session.ep.user_location,2,'-')# OR CR.TO_BRANCH_ID = #listgetat(session.ep.user_location,2,'-')#)
						</cfif>
						<cfif isdefined('attributes.project_id') and len(attributes.project_head) and len(attributes.project_id)>
							AND CR.PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.project_id#">
						</cfif>
						<cfif isdefined("attributes.is_pay_cheques")>
							AND
							(
							(CR.ACTION_TABLE = 'CHEQUE' AND CR.ACTION_ID IN (SELECT CHEQUE_ID FROM CHEQUE WHERE CHEQUE_ID = CR.ACTION_ID AND (CHEQUE_STATUS_ID IN (3,7) OR (CHEQUE_STATUS_ID = 4 AND CHEQUE_DUEDATE <= #new_date#))))
							OR	
							(CR.ACTION_TABLE = 'PAYROLL' AND CR.ACTION_ID IN (SELECT CH.PAYROLL_ID FROM CHEQUE C,CHEQUE_HISTORY CH WHERE CH.PAYROLL_ID = CR.ACTION_ID AND C.CHEQUE_ID = CH.CHEQUE_ID AND  (C.CHEQUE_STATUS_ID IN (3,7) OR (C.CHEQUE_STATUS_ID = 4 AND C.CHEQUE_DUEDATE <= #new_date#))))
							OR 
							(CR.ACTION_TABLE = 'VOUCHER' AND CR.ACTION_ID IN (SELECT VOUCHER_ID FROM VOUCHER WHERE VOUCHER_ID = CR.ACTION_ID AND (VOUCHER_STATUS_ID IN (3,7) OR (VOUCHER_STATUS_ID = 4 AND VOUCHER_DUEDATE < #new_date#))))
							OR	
							(CR.ACTION_TABLE = 'VOUCHER_PAYROLL' AND CR.ACTION_ID IN (SELECT VH.PAYROLL_ID FROM VOUCHER V,VOUCHER_HISTORY VH WHERE VH.PAYROLL_ID = CR.ACTION_ID AND V.VOUCHER_ID = VH.VOUCHER_ID AND  (V.VOUCHER_STATUS_ID IN (3,7) OR (V.VOUCHER_STATUS_ID = 4 AND V.VOUCHER_DUEDATE < #new_date#))))
							OR 
							(CR.ACTION_TABLE <> 'PAYROLL' AND CR.ACTION_TABLE <> 'CHEQUE' AND CR.ACTION_TABLE <> 'VOUCHER' AND CR.ACTION_TABLE <> 'VOUCHER_PAYROLL')
							)			
						</cfif>
						<cfif isdefined("attributes.is_pay_bankorders")>
							AND
							(
								CR.ACTION_TYPE_ID IN (250,251) AND CR.ACTION_ID IN (SELECT BANK_ORDER_ID FROM BANK_ORDERS WHERE IS_PAID = 1) OR
								CR.ACTION_TYPE_ID NOT IN (250,251)
							)
						</cfif>
						UNION ALL
							SELECT
								CR.ACTION_ID,
								CR.CARI_ACTION_ID,
								CR.ACTION_TYPE_ID,
								CR.ACTION_TABLE,
								CR.OTHER_MONEY,
								CR.PAPER_NO,
								CR.ACTION_NAME,
								CR.PROCESS_CAT,
								ISNULL(CR.PROJECT_ID,0) PROJECT_ID,
								CR.TO_CMP_ID,
								CR.TO_CONSUMER_ID,
								CR.TO_EMPLOYEE_ID,
								CR.FROM_CMP_ID,
								CR.FROM_CONSUMER_ID,
								CR.FROM_EMPLOYEE_ID,
								CR.DUE_DATE,
								CR.ACTION_DETAIL,
								CR.ACTION_DATE, 
								0 BORC,
								0 BORC2,
								0 BORC_OTHER,
								0 ALACAK,
								0 ALACAK2,
								0 ALACAK_OTHER,
								0 PAY_METHOD,
								0 IS_PROCESSED,
								2 DETAIL_TYPE,<!--- masraftan gelenler için --->
								'' STOCK_CODE,
								'' NAME_PRODUCT,
								EXPENSE_ITEMS_ROWS.QUANTITY AMOUNT,
								'' UNIT,
								EXPENSE_ITEMS_ROWS.AMOUNT PRICE,
								EXPENSE_ITEMS_ROWS.KDV_RATE TAX,
								EXPENSE_ITEMS_ROWS.TOTAL_AMOUNT GROSSTOTAL,
								0 PRICE_OTHER,
								EXPENSE_ITEMS_ROWS.OTHER_MONEY_GROSS_TOTAL,
								EXPENSE_ITEMS_ROWS.MONEY_CURRENCY_ID ROW_MONEY,
								EXPENSE_ITEMS_ROWS.DETAIL EXP_DETAIL,
								EXPENSE_ITEMS.EXPENSE_ITEM_NAME,
								EXPENSE_CENTER.EXPENSE EXPENSE_CENTER,
								EXPENSE_ITEMS_ROWS.OTV_RATE,
								EXPENSE_ITEMS_ROWS.PROJECT_ID AS ROW_PROJECT_ID,
								'' SPECT_VAR_NAME,
								'' DISCOUNT1,
								'' DISCOUNT2,
								'' DISCOUNT3,
								'' DISCOUNT4,
								'' DISCOUNT5,
								'' DISCOUNT6,
								'' DISCOUNT7,
								'' DISCOUNT8,
								'' DISCOUNT9,
								'' DISCOUNT10
							FROM 
								CARI_ROWS CR,
								EXPENSE_ITEM_PLANS,
								EXPENSE_ITEMS_ROWS,
								EXPENSE_ITEMS,
								EXPENSE_CENTER
							WHERE
								EXPENSE_ITEMS.EXPENSE_ITEM_ID = EXPENSE_ITEMS_ROWS.EXPENSE_ITEM_ID AND
								EXPENSE_CENTER.EXPENSE_ID = EXPENSE_ITEMS_ROWS.EXPENSE_CENTER_ID AND
								EXPENSE_ITEM_PLANS.EXPENSE_ID = EXPENSE_ITEMS_ROWS.EXPENSE_ID AND
								EXPENSE_ITEM_PLANS.EXPENSE_ID = CR.ACTION_ID AND
								EXPENSE_ITEM_PLANS.ACTION_TYPE = CR.ACTION_TYPE_ID AND
								CR.ACTION_TABLE = 'EXPENSE_ITEM_PLANS'
							<cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1) or (isdefined("attributes.pos_code") and len(attributes.pos_code) and len(attributes.pos_code_text))>
								AND (CR.TO_CMP_ID = #attributes.COMPANY_ID# OR CR.FROM_CMP_ID = #attributes.COMPANY_ID#)
							<cfelseif (isdefined('attributes.consumer_id') and  len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
								AND (CR.TO_CONSUMER_ID = #attributes.consumer_id# OR CR.FROM_CONSUMER_ID = #attributes.consumer_id#)
							<cfelseif isdefined('attributes.employee_id') and  len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
								AND (CR.TO_EMPLOYEE_ID = #attributes.employee_id# OR CR.FROM_EMPLOYEE_ID = #attributes.employee_id#)
							</cfif>
							<cfif isdefined("attributes.asset_id") and len(attributes.asset_id) and len(attributes.asset_name)>
								AND CR.ASSETP_ID = #attributes.asset_id#
							</cfif>
							<cfif isDefined("attributes.ch_action_type") and len(attributes.ch_action_type)>
								AND CR.ACTION_TYPE_ID IN (#attributes.ch_action_type#)
							</cfif>
							<cfif isDefined("attributes.other_money") and len(attributes.other_money)>
								<cfif attributes.other_money is 'YTL' or attributes.other_money is 'TL'>
									AND (CR.OTHER_MONEY = 'YTL' OR CR.OTHER_MONEY = 'TL')
								<cfelse>
									AND CR.OTHER_MONEY = '#attributes.other_money#'
								</cfif>
							</cfif>
							<cfif listgetat(attributes.fuseaction,1,'.') is 'store' or isdefined("is_store_module")>
								AND	(CR.FROM_BRANCH_ID = #listgetat(session.ep.user_location,2,'-')# OR CR.TO_BRANCH_ID = #listgetat(session.ep.user_location,2,'-')#)
							</cfif>
							<cfif isdefined('attributes.project_id') and len(attributes.project_head) and len(attributes.project_id)>
								AND CR.PROJECT_ID = #attributes.project_id#
							</cfif>
							<cfif isdefined("attributes.is_pay_cheques")>
								AND
								(
								(CR.ACTION_TABLE = 'CHEQUE' AND CR.ACTION_ID IN (SELECT CHEQUE_ID FROM CHEQUE WHERE CHEQUE_ID = CR.ACTION_ID AND (CHEQUE_STATUS_ID IN (3,7) OR (CHEQUE_STATUS_ID = 4 AND CHEQUE_DUEDATE <= #new_date#))))
								OR	
								(CR.ACTION_TABLE = 'PAYROLL' AND CR.ACTION_ID IN (SELECT CH.PAYROLL_ID FROM CHEQUE C,CHEQUE_HISTORY CH WHERE CH.PAYROLL_ID = CR.ACTION_ID AND C.CHEQUE_ID = CH.CHEQUE_ID AND  (C.CHEQUE_STATUS_ID IN (3,7) OR (C.CHEQUE_STATUS_ID = 4 AND C.CHEQUE_DUEDATE <= #new_date#))))
								OR 
								(CR.ACTION_TABLE = 'VOUCHER' AND CR.ACTION_ID IN (SELECT VOUCHER_ID FROM VOUCHER WHERE VOUCHER_ID = CR.ACTION_ID AND (VOUCHER_STATUS_ID IN (3,7) OR (VOUCHER_STATUS_ID = 4 AND VOUCHER_DUEDATE < #new_date#))))
								OR	
								(CR.ACTION_TABLE = 'VOUCHER_PAYROLL' AND CR.ACTION_ID IN (SELECT VH.PAYROLL_ID FROM VOUCHER V,VOUCHER_HISTORY VH WHERE VH.PAYROLL_ID = CR.ACTION_ID AND V.VOUCHER_ID = VH.VOUCHER_ID AND  (V.VOUCHER_STATUS_ID IN (3,7) OR (V.VOUCHER_STATUS_ID = 4 AND V.VOUCHER_DUEDATE < #new_date#))))
								OR 
								(CR.ACTION_TABLE <> 'PAYROLL' AND CR.ACTION_TABLE <> 'CHEQUE' AND CR.ACTION_TABLE <> 'VOUCHER' AND CR.ACTION_TABLE <> 'VOUCHER_PAYROLL')
								)			
							</cfif>
							<cfif isdefined("attributes.is_pay_bankorders")>
								AND
								(
									CR.ACTION_TYPE_ID IN (250,251) AND CR.ACTION_ID IN (SELECT BANK_ORDER_ID FROM BANK_ORDERS WHERE IS_PAID = 1) OR
									CR.ACTION_TYPE_ID NOT IN (250,251)
								)
							</cfif>
						</cfif>
					ORDER BY
						<cfif isdefined("attributes.is_project_group")>
							PROJECT_ID,
						</cfif>
						ACTION_DATE,
						ACTION_ID,
						DETAIL_TYPE
				</cfquery>
				<cfquery name="CARI_ROWS_ALL" dbtype="query">
					SELECT
						ACTION_ID,
						CARI_ACTION_ID,
						ACTION_TYPE_ID,
						ACTION_TABLE,
						OTHER_MONEY,
						PAPER_NO,
						ACTION_NAME,
						PROCESS_CAT,
						PROJECT_ID,
						TO_CMP_ID,
						TO_CONSUMER_ID,
						TO_EMPLOYEE_ID,
						FROM_CMP_ID,
						FROM_CONSUMER_ID,
						FROM_EMPLOYEE_ID,
						DUE_DATE,
						ACTION_DETAIL,
						ACTION_DATE, 
						BORC, 
						BORC2,
						BORC_OTHER,
						ALACAK,
						ALACAK2,
						ALACAK_OTHER,
						PAY_METHOD,
						IS_PROCESSED,
						DETAIL_TYPE,
						STOCK_CODE,
						NAME_PRODUCT,
						AMOUNT,
						UNIT,
						PRICE,
						TAX,
						GROSSTOTAL,
						PRICE_OTHER,
						OTHER_MONEY_GROSS_TOTAL,
						ROW_MONEY,
						EXP_DETAIL,
						EXPENSE_ITEM_NAME,
						EXPENSE_CENTER,
						OTV_RATE,
						ROW_PROJECT_ID,
						SPECT_VAR_NAME,
						DISCOUNT1,
						DISCOUNT2,
						DISCOUNT3,
						DISCOUNT4,
						DISCOUNT5,
						DISCOUNT6,
						DISCOUNT7,
						DISCOUNT8,
						DISCOUNT9,
						DISCOUNT10
					FROM 
						CARI_ROWS
					WHERE
						ACTION_DATE >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#attributes.date1#"> 
					<cfif isdefined("attributes.date2") and isdate(attributes.date2)>
						AND ACTION_DATE <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#attributes.date2#">
					</cfif>
				</cfquery>
			<cfelse>
				<cfset CARI_ROWS_ALL.recordcount = 0>
			</cfif>
			<cfif isdefined('attributes.is_excel')>
				<cfset attributes.startrow=1>
				<cfset attributes.maxrows=CARI_ROWS_ALL.recordcount>
			</cfif>	
			<cfparam name="attributes.page" default = "1">
			<cfparam name="attributes.totalrecords" default = "#CARI_ROWS_ALL.recordcount#">
			<cfset attributes.startrow=((attributes.page-1)*attributes.maxrows)+1>
			<br>
			<!--- <cfif isdefined('attributes.is_excel')>
				<cfset filename = "#createuuid()#">
				<cfheader name="Expires" value="#Now()#">
				<cfcontent type="application/vnd.msexcel;charset=utf-8">
				<cfheader name="Content-Disposition" value="attachment; filename=#filename#.xls">
				<meta http-equiv="content-type" content="text/plain; charset=utf-8">
			</cfif>	 --->
		 	<table cellpadding="5" cellspacing="1" border="0" width="100%" align="center" class="color-border">
				<tr class="color-list">
					<td colspan="15" class="txtbold" height="20"><cfoutput><cfif isdefined ('attributes.company') and len(attributes.company)>#attributes.company#</cfif> #get_periods.period_year#</cfoutput> <cf_get_lang no='114.Dönemi'> <cf_get_lang_main no='397.Hesap Ekstresi'></td>
				</tr>
		    </table>
			<cfif isDefined("attributes.is_doviz_group")>
				<table cellpadding="2" cellspacing="1" border="0" width="98%" align="center" class="color-border">
					<tr class="color-row">
						<td> 
							<cfinclude template="../../../objects/display/dsp_extre_summary.cfm">
						</td>
					</tr>
				</table>
			 </cfif><br>
		  	<table cellpadding="2" cellspacing="1" border="0" width="100%" align="center" class="color-border">
				<tr height="22" class="color-header">
					<td class="form-title"><cf_get_lang_main no='75.No'></td>
					<td class="form-title"><cf_get_lang_main no='330.Tarih'></td>
					<cfif isdefined('attributes.is_due')>
					<td class="form-title" width="90"><cf_get_lang no='117.Ortalama'><cf_get_lang_main no='228.Vade'></td>
					<td class="form-title"><cf_get_lang_main no='78.Gün'></td>
					</cfif> 
					<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>
						<td class="form-title"><cf_get_lang_main no='4.Proje'></td>
					</cfif>
				   <!--- <cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>--->
					<td class="form-title"><cf_get_lang_main no='56.Belge'></td>
				   <!--- </cfif>--->
					<td class="form-title"><cf_get_lang_main no='280.İşlem'></td>
					<cfif isdefined('attributes.is_action_detail')><td class="form-title"><cf_get_lang_main no='217.Açıklama'></td></cfif>
					<td  class="form-title" style="text-align:right;"><cf_get_lang_main no='175.Borç'></td>
					<td  class="form-title" style="text-align:right;"><cf_get_lang_main no='176.Alacak'></td>
					<cfif isdefined('attributes.is_doviz2')>		
					<td  class="form-title" style="text-align:right;">2.<cf_get_lang_main no='175.Borç'></td>
					<td  class="form-title" style="text-align:right;">2.<cf_get_lang_main no='176.Alacak'></td>
					</cfif>
					<cfif isdefined('attributes.is_doviz') or isDefined("attributes.is_doviz_group")>	
					<td  class="form-title" style="text-align:right;"><cf_get_lang_main no='709.İşlem Dövizi'><cf_get_lang_main no='175.Borç'></td>
					<td  class="form-title" style="text-align:right;"><cf_get_lang_main no='709.İşlem Dövizi'><cf_get_lang_main no='176.Alacak'></td>
					<td  class="form-title" style="text-align:right;"><cf_get_lang_main no ='236.Kur'></td>
					</cfif>
					<td  class="form-title" style="text-align:right;"><cf_get_lang_main no='177.Bakiye'></td>
					<cfif isdefined('attributes.is_doviz2_bakiye')><td width="100"  class="form-title" style="text-align:right;">2.<cf_get_lang_main no='265.Döviz'><cf_get_lang_main no='177.Bakiye'></td></cfif>
				</tr>
			    <cfset money_list_borc_2 = ''>
			    <cfset money_list_borc_1 = ''>
			    <cfset money_list_alacak_2 = ''>
			    <cfset money_list_alacak_1 = ''>
				<cfset row_money_list_borc_2 = ''>
				<cfset row_money_list_alacak_2 = ''>
				<cfscript>
					devir_total = 0;
					devir_total_other = 0;
					devir_borc = 0;
					devir_alacak = 0;
					devir_borc_other = 0;
					devir_alacak_other = 0;
					bakiye = 0;
					devir_total_2 = 0;
					devir_borc_2 = 0;
					devir_alacak_2 = 0;
					devir_alacak_other_pro= 0;
					devir_borc_other_pro = 0;
					bakiye_2 = 0;
					gen_borc_top = 0;
					gen_ala_top = 0;
					gen_bak_top = 0;
					gen_bak_top_2 = 0;
					gen_bak_top_other = 0;
					gen_borc_top_2 = 0;
					gen_ala_top_2 = 0;
					gen_borc_top_other = 0;
					gen_ala_top_other = 0;
					devir_total_pro = 0;
					devir_total_other_pro = 0;
					devir_borc_pro = 0;
					devir_alacak_pro= 0;
					devir_borc_other_pro = 0;
					devir_alacak_other_pro= 0;
					row_bakiye_2 = 0;
					row_gen_borc_top = 0;
					row_gen_ala_top = 0;
					row_gen_bak_top = 0;
					row_gen_bak_top_other = 0;
					row_gen_bak_top_2 = 0;
					row_gen_borc_top_2 = 0;
					row_gen_ala_top_2 = 0;
					row_gen_borc_top_other = 0;
					row_gen_ala_top_other = 0;
				</cfscript>
				<cfoutput query="get_money">
					<cfset 'devir_borc_#money#' = 0>
					<cfset 'devir_alacak_#money#' = 0>
				</cfoutput>
				<!---()---><cfloop query="get_money">
					<cfset 'devir_borc_pro_#money#' = 0>
					<cfset 'devir_alacak_pro_#money#' = 0>
				</cfloop><!------>
				<cfif datediff('d',yilbasi,date1) neq 0>
					<cfquery name="GET_TARIH_DEVIR" dbtype="query">
						SELECT
							SUM(BORC) BORC,
							SUM(ALACAK) ALACAK,
							SUM(BORC-ALACAK) DEVIR_TOTAL,
							SUM(BORC2) BORC2,
							SUM(ALACAK2) ALACAK2,
							SUM(BORC2-ALACAK2) DEVIR_TOTAL2
						FROM
							CARI_ROWS
						 WHERE
							ACTION_DATE < <cfqueryparam cfsqltype="cf_sql_timestamp" value="#attributes.date1#">
							<cfif isdefined("attributes.is_project_group")>
								AND PROJECT_ID = 0
							</cfif>
					</cfquery>
					<cfquery name="GET_TARIH_DEVIR_OTHER" dbtype="query">
						SELECT
							SUM(BORC_OTHER) BORC_OTHER,
							SUM(ALACAK_OTHER) ALACAK_OTHER,
							OTHER_MONEY
							<cfif isdefined("attributes.is_doviz") and len(attributes.other_money)>
								,SUM(BORC_OTHER-ALACAK_OTHER) DEVIR_TOTAL_OTHER
							</cfif>
						FROM
							CARI_ROWS
						WHERE
							ACTION_DATE < <cfqueryparam cfsqltype="cf_sql_timestamp" value="#attributes.date1#">

							<cfif isdefined("attributes.is_doviz") and len(attributes.other_money)>
								<cfif attributes.other_money is 'YTL' or attributes.other_money is 'TL'>
									AND (OTHER_MONEY = 'YTL' OR OTHER_MONEY = 'TL')
								<cfelse>
									AND OTHER_MONEY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.other_money#">
								</cfif>
							</cfif>
							<cfif isdefined("attributes.is_project_group")>
								AND PROJECT_ID = 0
							</cfif>
						GROUP BY
							OTHER_MONEY
					</cfquery><!------><!------>
					<cfif get_tarih_devir.recordcount>
						<cfset devir_borc = get_tarih_devir.BORC>
						<cfset devir_alacak = get_tarih_devir.ALACAK>
						<!------><cfset devir_borc_other = get_tarih_devir_other.BORC_OTHER>
						<cfset devir_alacak_other = get_tarih_devir_other.ALACAK_OTHER><!------>
						<cfset devir_total = get_tarih_devir.DEVIR_TOTAL>
						<!------><cfif isdefined("attributes.is_doviz") and len(attributes.other_money)>
							<cfset devir_total_other = get_tarih_devir_other.DEVIR_TOTAL_OTHER>
						</cfif><!------>
						<cfset devir_borc_2 = get_tarih_devir.BORC2>
						<cfset devir_alacak_2 = get_tarih_devir.ALACAK2>
						<cfset devir_total_2 = get_tarih_devir.DEVIR_TOTAL2>
					</cfif>
					<!------><cfif get_tarih_devir_other.recordcount>
						<cfoutput query="get_tarih_devir_other">
							<cfset 'devir_borc_#other_money#' = evaluate('devir_borc_#other_money#') +borc_other>
							<cfset 'devir_alacak_#other_money#' = evaluate('devir_alacak_#other_money#') +alacak_other><!------>
						</cfoutput>
					</cfif><!------>
				</cfif>
				<cfif attributes.page gt 1>
					<cfset max_=(attributes.page-1)*attributes.maxrows>
					<cfoutput query="CARI_ROWS_ALL" startrow="1" maxrows="#max_#">
						<cfset devir_borc = devir_borc + borc>
						<cfset devir_alacak = devir_alacak + alacak>
						<!------><cfset devir_borc_other = devir_borc_other + borc_other>
						<cfset devir_alacak_other = devir_alacak_other + alacak_other><!------>
						<cfset devir_total = devir_borc - devir_alacak>
						<!------><cfset devir_total_other = devir_borc_other - devir_alacak_other><!------>
						<cfif len(borc2)><cfset devir_borc_2 = devir_borc_2 + borc2></cfif>
						<cfif len(alacak2)><cfset devir_alacak_2 = devir_alacak_2 + alacak2></cfif>
						<cfset devir_total_2 = devir_borc_2 - devir_alacak_2>
						<cfset 'devir_borc_#other_money#' = evaluate('devir_borc_#other_money#') +borc_other>
						<cfset 'devir_alacak_#other_money#' = evaluate('devir_alacak_#other_money#') +alacak_other>
					</cfoutput>
				</cfif>
				<cfoutput>
					<tr height="20" class="color-row">
						<td colspan="
						<cfif isdefined('attributes.is_due')>
							<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>7<cfelse>6</cfif>
						<cfelse>
							<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>5<cfelse>4</cfif>
						</cfif>"  style="text-align:right;"><b><cf_get_lang_main no='452.Devir'></b></td>
						<cfif isdefined('attributes.is_action_detail')><td>&nbsp;</td></cfif>
						<td  style="text-align:right;">#TLFormat(devir_borc)# #session_base.money#</td>
						<td  style="text-align:right;">#TLFormat(devir_alacak)# #session_base.money#</td>
						<cfif isdefined('attributes.is_doviz') or isDefined("attributes.is_doviz_group")>
							<td  style="text-align:right;">
								<cfloop query="get_money">
									<cfif evaluate('devir_borc_#get_money.money#') gt 0>#TLFormat(evaluate('devir_borc_#get_money.money#'))# #get_money.money#<br></cfif>
								</cfloop>
							</td>
							<td  style="text-align:right;">
								<cfloop query="get_money">
									<cfif evaluate('devir_alacak_#get_money.money#') gt 0>#TLFormat(evaluate('devir_alacak_#get_money.money#'))# #get_money.money#<br></cfif>
								</cfloop>
							</td>
							<td></td>
						</cfif>
						<cfif isDefined("attributes.is_doviz2")>
							<td colspan="2"></td>
						</cfif>
						<td  style="text-align:right;">#TLFormat(ABS(devir_total))# #session_base.money# <cfif devir_borc gt devir_alacak>-B<cfelseif devir_borc lt devir_alacak>-A</cfif></td> 
						<cfif isdefined('attributes.is_doviz2_bakiye')><td  style="text-align:right;">#TLFormat(ABS(devir_total_2))# #session_base.money2# <cfif devir_borc_2 gt devir_alacak_2>-B<cfelseif devir_borc_2 lt devir_alacak_2>-A</cfif></td></cfif> 
					</tr>
				</cfoutput>
			<cfif CARI_ROWS_ALL.recordcount>
				<cfset bank_order_list="">
				<cfset project_id_list = "">
				<cfoutput query="CARI_ROWS_ALL">
					<cfif (CARI_ROWS_ALL.ACTION_TYPE_ID eq 250)>
						<cfset bank_order_list=listappend(bank_order_list,CARI_ROWS_ALL.ACTION_ID)>
					</cfif>
					
					<cfif len(project_id) and project_id neq 0 and not listfind(project_id_list,project_id)>
						<cfset project_id_list = Listappend(project_id_list,project_id)>
					</cfif>
					
				</cfoutput>
				<cfif len(bank_order_list)>
					<cfset bank_order_list=listsort(bank_order_list,"numeric","desc",",")>
					<cfquery name="GET_BANK_ORDER" datasource="#new_dsn#">
						SELECT 
							BANK_ORDER_ID,
							PAYMENT_DATE
						FROM
							BANK_ORDERS
						WHERE
							BANK_ORDER_ID IN (#bank_order_list#)
						ORDER BY
							BANK_ORDER_ID DESC
					</cfquery>
				</cfif>
				<cfif len(project_id_list)>
					<cfset project_id_list=listsort(project_id_list,"numeric","ASC",",")>			
					<cfquery name="get_project_name" datasource="#dsn#">
						SELECT PROJECT_ID,PROJECT_HEAD FROM PRO_PROJECTS WHERE PROJECT_ID IN (#project_id_list#) ORDER BY PROJECT_ID
					</cfquery>
					<cfset project_id_list = listsort(listdeleteduplicates(valuelist(get_project_name.project_id,',')),'numeric','ASC',',')>
				</cfif>
				<cfset process_cat_id_list = ''><!--- islem tipi  --->
				<cfif isdefined('attributes.is_process_cat')><!--- islem tipi seçilmişse --->
					<cfoutput query="CARI_ROWS_ALL" startrow="#attributes.startrow#" maxrows="#attributes.maxrows#">
						<cfif len(process_cat) and process_cat neq 0 and not listfind(process_cat_id_list,process_cat)>
							<cfset process_cat_id_list = Listappend(process_cat_id_list,process_cat)>
						</cfif>
					</cfoutput>		  	
					<cfif len(process_cat_id_list)>
						<cfset process_cat_id_list=listsort(process_cat_id_list,"numeric","ASC",",")>			
						<cfquery name="get_process_cat" datasource="#DSN3#">
							SELECT PROCESS_CAT_ID,PROCESS_CAT FROM SETUP_PROCESS_CAT WHERE PROCESS_CAT_ID IN (#process_cat_id_list#) ORDER BY PROCESS_CAT_ID
						</cfquery>
						<cfset process_cat_id_list = listsort(listdeleteduplicates(valuelist(get_process_cat.PROCESS_CAT_ID,',')),'numeric','ASC',',')>
					</cfif>
				</cfif>
				<cfoutput query="CARI_ROWS_ALL" startrow="#attributes.startrow#" maxrows="#attributes.maxrows#">
					<cfif len(borc_other)>
						<cfset bakiye_borc_2 = borc_other>
						<cfset bakiye_borc_1 = borc>
					<cfelse>
						<cfset bakiye_borc_2 = 0>
						<cfset bakiye_borc_1 = 0>
					</cfif>
					<cfif len(alacak_other)>
						<cfset bakiye_alacak_2 = alacak_other>
						<cfset bakiye_alacak_1 = alacak>
					<cfelse>
						<cfset bakiye_alacak_2 = 0>
						<cfset bakiye_alacak_1 = 0>
					</cfif>
					<cfset money_2 = other_money>
					<cfset money_1 = session_base.money>
					<cfif bakiye_borc_2 gt 0>
						<cfset money_list_borc_2 = listappend(money_list_borc_2,'#bakiye_borc_2#;#money_2#',',')>
						<cfset money_list_borc_1 = listappend(money_list_borc_1,'#bakiye_borc_1#;#money_1#',',')>
						<cfset row_money_list_borc_2 = listappend(row_money_list_borc_2,'#bakiye_borc_2#;#money_2#',',')>
					</cfif>	
					<cfif bakiye_alacak_2 gt 0>
						<cfset money_list_alacak_2 = listappend(money_list_alacak_2,'#bakiye_alacak_2#;#money_2#',',')>
						<cfset money_list_alacak_1 = listappend(money_list_alacak_1,'#bakiye_alacak_1#;#money_1#',',')>
						<cfset row_money_list_alacak_2 = listappend(row_money_list_alacak_2,'#bakiye_alacak_2#;#money_2#',',')>
					</cfif>
					<cfset type="">
					<cfswitch expression = "#ACTION_TYPE_ID#">
						<cfcase value="40"><!--- cari acilis fisi --->
							<cfset type="objects2.popup_dsp_account_open&period_id=#encrypt(get_periods.period_id,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="24"><!--- gelen havale --->
							<cfset type="objects2.popup_dsp_gelenh&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="25"><!--- giden havale --->
							<cfset type="objects2.popup_dsp_gidenh&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="34"><!---alış f. kapama--->
							<cfset type="objects2.popup_dsp_alisf_kapa&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="35"><!---satış f. kapama--->
							<cfset type="objects2.popup_dsp_satisf_kapa&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="241"><!--- kredi kartı tahsilat --->
							<cfset type="objects2.popup_dsp_credit_card_payment_type">
						</cfcase>
						<cfcase value="242"><!--- kredi karti odeme --->
							<cfset type="objects2.popup_dsp_credit_card_pay&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="245"><!--- kredi kartı tahsilat --->
							<cfset type="objects2.popup_dsp_credit_card_payment_type">
						</cfcase>
						<cfcase value="31"><!---tahsilat--->
							<cfset type="objects2.popup_dsp_cash_revenue&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="32"><!---ödeme--->
							<cfset type="objects2.popup_dsp_cash_payment&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="36">
							<cfset type="objects2.popup_list_cash_expense&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>	
						<cfcase value="41,42"><!--- borc/alacak dekontu --->
							<cfset type="objects2.popup_dsp_debt_claim_note&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="43"><!--- cari virman --->
							<cfset type="objects2.popup_dsp_cari_to_cari&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="90"><!--- çek giriş bordrosu --->
							<cfset type="objects2.popup_dsp_payroll_entry&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="91"><!--- çek çıkış bordrosu(ciro) --->
							<cfset type="objects2.popup_dsp_payroll_endorsement&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="94"><!--- Çek İade çıkış bordrosu --->
							<cfset type="objects2.popup_dsp_payroll_endor_return&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="95"><!--- Çek iade giriş bordrosu --->
							<cfset type="objects2.popup_dsp_payroll_entry_return&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="98,101,97,108"><!--- Senet Çıkış bordrosu --->
							<cfset type="objects2.popup_dsp_voucher_endorsement&type=#ACTION_TYPE_ID#&period_id=#new_period#">
						</cfcase>
						<cfcase value="120"><!--- masraf fisi --->
							<cfset type="objects2.popup_list_cost_expense&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="121"><!--- gelir fisi --->
							<cfset type="objects2.popup_list_cost_expense&is_income=1&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<cfcase value="50,51,52,53,531,54,55,56,57,58,59,591,60,61,62,63,64,65,66,690,601,561,48,49">
							<cfset type="objects2.popup_detail_invoice&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
						<!--- Gelen ve Giden Banka Talimatı --->
						<cfcase value="250,251">
							<cfset type="objects2.popup_dsp_assign_order&period_id=#encrypt(new_period,session_base.userid,"CFMX_COMPAT","Hex")#">
						</cfcase>
					</cfswitch>		
					<cfif listfind('24,25,26,27,31,32,34,35,36,40,41,42,43,241,242,177,245,250,251',ACTION_TYPE_ID,',')>
						<cfset page_type = 'small'>
					<cfelse>
						<cfset page_type = 'page'>
					</cfif>
					<cfif isdefined('attributes.is_project_group') and len(CARI_ROWS_ALL.PROJECT_ID[currentrow]) and CARI_ROWS_ALL.PROJECT_ID[currentrow] gt 0 and (CARI_ROWS_ALL.PROJECT_ID[currentrow] neq CARI_ROWS_ALL.PROJECT_ID[currentrow-1] or (attributes.page gt 1 and currentrow mod attributes.maxrows eq 1))>
						<!---<cfif len(project_id) and project_id neq 0>--->
						<cfif isdefined('attributes.is_due')>
							<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>
								<cfset colspan_info = 7>
							<cfelse>
								<cfset colspan_info = 6>
							</cfif>
						<cfelse>
							<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>
								<cfset colspan_info = 5>
							<cfelse>
								<cfset colspan_info = 4>
							</cfif>
						</cfif>
						<cfif len(project_id) and project_id neq 0>
							<cfset row_colspan = colspan_info+3>
						<cfif isdefined('attributes.is_action_detail')>
							<cfset row_colspan = row_colspan+1> 
						</cfif>
						<cfif isdefined('attributes.is_doviz2')>
							<cfset row_colspan = row_colspan+2> 
						</cfif>
						<cfif isdefined('attributes.is_doviz') or isDefined("attributes.is_doviz_group")>
							<cfset row_colspan = row_colspan+4> 
						</cfif>
						<cfif isdefined('attributes.is_doviz2_bakiye')>
							<cfset row_colspan = row_colspan+1> 
						</cfif>
						<tr height="20" <cfif isdefined("is_from_report")>class="css1"<cfelse>class="color-row"</cfif>>
							<td colspan="#row_colspan#" class="txtbold">
								#get_project_name.project_head[listfind(project_id_list,project_id,',')]#<cfelse>&nbsp;</td></cfif>
							</td>
						</tr>
					</td>
					<cfquery name="GET_TARIH_DEVIR_PRO" dbtype="query">
						SELECT
							SUM(BORC) BORC,
							SUM(ALACAK) ALACAK,
							SUM(BORC-ALACAK) DEVIR_TOTAL,
							SUM(BORC2) BORC2,
							SUM(ALACAK2) ALACAK2,
							SUM(BORC2-ALACAK2) DEVIR_TOTAL2
						FROM
							CARI_ROWS
						WHERE
							ACTION_DATE < <cfqueryparam cfsqltype="cf_sql_timestamp" value="#attributes.date1#">
							AND PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#CARI_ROWS_ALL.PROJECT_ID#">
					</cfquery>
					<cfquery name="GET_TARIH_DEVIR_OTHER_PRO" dbtype="query">
						SELECT
							SUM(BORC_OTHER) BORC_OTHER,
							SUM(ALACAK_OTHER) ALACAK_OTHER,
							OTHER_MONEY
							<cfif isdefined("attributes.is_doviz") and len(attributes.other_money)>
								,SUM(BORC_OTHER-ALACAK_OTHER) DEVIR_TOTAL_OTHER
							</cfif>
						FROM
							CARI_ROWS
						WHERE
							ACTION_DATE < <cfqueryparam cfsqltype="cf_sql_timestamp" value="#attributes.date1#">
							<cfif isdefined("attributes.is_doviz") and len(attributes.other_money)>
								<cfif attributes.other_money is 'YTL' or attributes.other_money is 'TL'>
									AND (OTHER_MONEY = 'YTL' OR OTHER_MONEY = 'TL')
								<cfelse>
									AND OTHER_MONEY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.other_money#">
								</cfif>
							</cfif>
							AND PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#CARI_ROWS_ALL.PROJECT_ID#">
						GROUP BY
							OTHER_MONEY
					</cfquery>
					<cfif get_tarih_devir_pro.recordcount>
						<cfset devir_borc_pro = get_tarih_devir_pro.BORC>
						<cfset devir_alacak_pro = get_tarih_devir_pro.ALACAK>
						<cfset devir_borc_other_pro = get_tarih_devir_other_pro.BORC_OTHER>
						<cfset devir_alacak_other_pro = get_tarih_devir_other_pro.ALACAK_OTHER>
						<cfset devir_total_pro = get_tarih_devir_pro.DEVIR_TOTAL>
						<cfif isdefined("attributes.is_doviz") and len(attributes.other_money)>
							<cfset devir_total_other_pro = get_tarih_devir_other_pro.DEVIR_TOTAL_OTHER>
						</cfif>
						<cfset devir_borc_2_pro = get_tarih_devir_pro.BORC2>
						<cfset devir_alacak_2_pro = get_tarih_devir_pro.ALACAK2>
						<cfset devir_total_2_pro = get_tarih_devir_pro.DEVIR_TOTAL2>
						
						<cfset gen_borc_top = gen_borc_top + get_tarih_devir_pro.BORC>
						<cfset gen_ala_top = gen_ala_top + get_tarih_devir_pro.ALACAK>
						<cfset gen_bak_top = gen_bak_top + (get_tarih_devir_pro.BORC-get_tarih_devir_pro.ALACAK)>
						<cfset gen_bak_top_other = gen_bak_top_other + (get_tarih_devir_other_pro.BORC_OTHER-get_tarih_devir_other_pro.ALACAK_OTHER)>
						<cfset gen_bak_top_2 = gen_bak_top_2 + (get_tarih_devir_pro.BORC2-get_tarih_devir_pro.ALACAK2)>
					</cfif>
					<cfif get_tarih_devir_other_pro.recordcount>
						<cfloop query="get_tarih_devir_other_pro">
							<cfset 'devir_borc_pro_#other_money#' = evaluate('devir_borc_pro_#other_money#') +borc_other>
							<cfset 'devir_alacak_pro_#other_money#' = evaluate('devir_alacak_pro_#other_money#') +alacak_other>
						</cfloop>
					</cfif>
					<cfif get_tarih_devir_pro.recordcount>
						<cfset row_gen_borc_top = devir_borc_pro+row_gen_borc_top>
						<cfset row_gen_ala_top = devir_alacak_other_pro+row_gen_ala_top>
						<cfset row_gen_borc_top_2 = devir_borc_2_pro+row_gen_borc_top_2>
						<cfset row_gen_ala_top_2 = devir_alacak_2_pro+row_gen_ala_top_2 >
						<cfset row_gen_bak_top = (devir_borc_pro-devir_alacak_pro)+row_gen_bak_top>	
						<cfset row_gen_bak_top_2 = (devir_borc_2_pro-devir_alacak_2_pro)+row_gen_bak_top_2>		
						<cfset row_gen_bak_top_other = (devir_borc_other_pro-devir_alacak_other_pro)+row_gen_bak_top_other>	
						<tr height="20"  <cfif isdefined("is_from_report")>class="css1"<cfelse>class="color-row"</cfif>>
							<td colspan="#colspan_info#"  style="text-align:right;"><b><cf_get_lang_main no='452.Devir'></b></td>
							<cfif isdefined('attributes.is_action_detail')><td>&nbsp;</td></cfif>
							<td  style="text-align:right;">#TLFormat(devir_borc_pro)# #session_base.money#</td>
							<td  style="text-align:right;">#TLFormat(devir_alacak_pro)# #session_base.money#</td>
							<cfif isdefined('attributes.is_doviz2')>
								<td  style="text-align:right;">#TLFormat(devir_borc_pro_2)# #session_base.money2#</td>
								<td  style="text-align:right;">#TLFormat(devir_alacak_pro_2)# #session_base.money2#</td>
							</cfif>	
							<cfif isdefined('attributes.is_doviz') or isDefined("attributes.is_doviz_group")>	
								<td  style="text-align:right;">
									<cfloop query="get_money">
										<cfif evaluate('devir_borc_pro_#get_money.money#') gt 0>#TLFormat(evaluate('devir_borc_pro_#get_money.money#'))# #get_money.money#<br></cfif>
									</cfloop>
								</td>
								<td  style="text-align:right;">
									<cfloop query="get_money">
										<cfif evaluate('devir_alacak_pro_#get_money.money#') gt 0>#TLFormat(evaluate('devir_alacak_pro_#get_money.money#'))# #get_money.money#<br></cfif>
									</cfloop>
								</td>
								<td></td>
								<td></td>
							</cfif>
							<td  style="text-align:right;">#TLFormat(ABS(devir_total_pro))# #session_base.money# <cfif devir_borc_pro gt devir_alacak_pro>-B<cfelseif devir_borc_pro lt devir_alacak_pro>-A</cfif></td> 
							<cfif isdefined('attributes.is_doviz2_bakiye')><td  style="text-align:right;">#TLFormat(ABS(devir_total_2_pro))# #session_base.money2# <cfif devir_borc_2_pro gt devir_alacak_2_pro>-B<cfelseif devir_borc_2_pro lt devir_alacak_2_pro>-A</cfif></td></cfif> 
							<cfif isdefined("attributes.is_doviz") and len(attributes.other_money)><td  style="text-align:right;">#TLFormat(ABS(devir_total_other_pro))# #attributes.other_money# <cfif devir_borc_other_pro gt devir_alacak_other_pro>-B<cfelseif devir_borc_other_pro lt devir_alacak_other_pro>-A</cfif></td></cfif>
						</tr>
					</cfif>
					</cfif>
					
					<cfif DETAIL_TYPE eq 0>
						<tr height="20" onMouseOver="this.className='color-light';" onMouseOut="this.className='color-row';" class="color-row">
							<td>
								<cfif isdefined('attributes.is_color')><!--- Renkli secili ise --->
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#currentrow#</font><!--- Borc ise kirmizi alacak ise mavi renk yapiliyor--->
								<cfelse>
									#currentrow#
								</cfif>
							</td>
							<td>
								<cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#dateformat(action_date,'dd/mm/yyyy')#</font>
								<cfelse>
									#dateformat(action_date,'dd/mm/yyyy')#
								</cfif>
							</td>
							<cfif isdefined('attributes.is_due')>
								<cfif len(due_date)>
									<td>#dateformat(due_date,'dd/mm/yyyy')#</td>
									<td>#datediff('d',action_date,due_date)#</td>
								<cfelseif len(pay_method) and pay_method neq 0 and ListFind(pay_method_id_list,pay_method,',')>
									<td>#dateformat(date_add('d', listgetat(pay_method_gun_list,listfind(pay_method_id_list,pay_method,','),','), action_date),'dd/mm/yyyy')#</td>
									<td>#listgetat(pay_method_gun_list,ListFind(pay_method_id_list,pay_method,','),',')#</td>
								<cfelseif listfind(bank_order_list,action_id)>
									<td>#dateformat(get_bank_order.payment_date[listfind(bank_order_list,action_id)],"dd/mm/yyyy")#</td>
									<td>#datediff('d',action_date,get_bank_order.payment_date[listfind(bank_order_list,action_id)])#</td>					
								<cfelse>
									<td></td>
									<td></td>
								</cfif>
							</cfif> 
							<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>
								<cfif len(project_id)>
									<cfquery name="GET_PROJECT_EXTRE" datasource="#DSN#">
										SELECT PROJECT_HEAD FROM PRO_PROJECTS WHERE PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#cari_rows_all.project_id#">
									</cfquery>
									<td>#get_project_extre.project_head#</td>
								<cfelse>
									<td></td>
								</cfif>
							</cfif>
							<td>
								<cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#paper_no#</font>
								<cfelse>
									#paper_no#
								</cfif>
							</td>
						 	<td>
								<cfif not len(type)><!--- display sayfası olmayan tipler için --->
									<cfif isdefined('attributes.is_color')>
										<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#action_name#</font>
									<cfelse>
										#action_name#
									</cfif>
									<cfif isdefined('attributes.is_action_detail')><td>#action_detail#</td></cfif>
								<cfelse>
									<cfif listfind("291,292",action_type_id)><!--- Kredi Odemesi ,Kredi Tahsilat --->
										<a class="tableyazi" href="javascript://" onclick="windowopen('#request.self#?fuseaction=#type#&id=#encrypt(action_id,session_base.userid,"CFMX_COMPAT","Hex")#&period_id=#session.pp.period_id#&our_company_id=#session.ep.company_id#','#page_type#');">
									<cfelseif ACTION_TABLE is 'CHEQUE'>
										<a class="tableyazi" href="javascript://" onclick="windowopen('#request.self#?fuseaction=objects2.popup_cheque_det&id=#encrypt(action_id,session_base.userid,"CFMX_COMPAT","Hex")#&period_id=#get_periods.period_id#','small');">
									<cfelseif ACTION_TABLE is 'VOUCHER'>
										<a class="tableyazi" href="javascript://" onclick="windowopen('#request.self#?fuseaction=objects2.popup_voucher_det&id=#encrypt(action_id,session_base.userid,"CFMX_COMPAT","Hex")#&period_id=#get_periods.period_id#','small');">
									<cfelse>
										<a class="tableyazi" href="javascript://" onClick="javascript:windowopen('#request.self#?fuseaction=#type#&id=#encrypt(action_id,session_base.userid,"CFMX_COMPAT","Hex")#&cari_act_id=#encrypt(cari_action_id,session_base.userid,"CFMX_COMPAT","Hex")#&table_name=#ACTION_TABLE#','#page_type#');">
									</cfif>
									<cfif isdefined('attributes.is_process_cat')>
										<cfif listfind(process_cat_id_list,process_cat,',')>
											<cfif isdefined('attributes.is_color')>
												<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#get_process_cat.process_cat[listfind(process_cat_id_list,process_cat,',')]#</font>
											<cfelse>
												#get_process_cat.process_cat[listfind(process_cat_id_list,process_cat,',')]#
											</cfif>
										<cfelse>
											<cfif isdefined('attributes.is_color')>
												<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#action_name#</font>
											<cfelse>
												#action_name#
											</cfif>
										</cfif>					
									<cfelse>
										<cfif isdefined('attributes.is_color')>
											<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#action_name#</font>
										<cfelse>
											#action_name#
										</cfif>
									</cfif>
									</a>
									<cfif isdefined('attributes.is_action_detail')>
										<td>
											#action_detail#
											<cfif isdefined('attributes.is_due')>
												<cfif ACTION_TYPE_ID eq 250 and len(bank_order_list)>
													(#dateformat(GET_BANK_ORDER.PAYMENT_DATE[listfind(bank_order_list,ACTION_ID)],"dd/mm/yyyy")#)
													<cfif IS_PROCESSED eq 1>(Havale Oluşturulmuş)</cfif>
												</cfif>
											<cfelse>
												<cfif ACTION_TYPE_ID eq 250 and IS_PROCESSED eq 1>(<cf_get_lang no ='1240.Havale Oluşturulmuş'>)</cfif>
											</cfif>
										</td>
									</cfif>
								</cfif>
							</td>
							<td  style="text-align:right;">
								<cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(borc)# #session_base.money#</font>
								<cfelse>
									#TLFormat(borc)# #session_base.money#
								</cfif>
							</td>
							<td  style="text-align:right;">
								<cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(alacak)# #session_base.money#</font>
								<cfelse>
									#TLFormat(alacak)# #session_base.money#
								</cfif>
							</td>
							<cfif isdefined('attributes.is_doviz2')><!--- Dovizli secili --->
							<td  style="text-align:right;">
								<cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(borc2)# #session_base.money2#</font>
								<cfelse>
									#TLFormat(borc2)# #session_base.money2#
								</cfif>
							</td>
							<td  style="text-align:right;">
								<cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(alacak2)# #session_base.money2#</font>
								<cfelse>
									#TLFormat(alacak2)# #session_base.money2#
								</cfif>
							</td>
							</cfif>
							<cfif isdefined('attributes.is_doviz') or isDefined("attributes.is_doviz_group")><!--- Dovizli secili --->	
							<td  style="text-align:right;">
								<cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(borc_other)# #other_money#</font>
								<cfelse>
									#TLFormat(borc_other)# #other_money#
								</cfif>
							</td>
							<td  style="text-align:right;">
								<cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(alacak_other)# #other_money#</font>
								<cfelse>
									#TLFormat(alacak_other)# #other_money#
								</cfif>
							</td>
							<cfif (borc_other gt 0 or alacak_other gt 0)>
								<cfif borc_other gt 0>
									<cfset other_tutar = borc_other>
									<cfset tutar = borc>
								<cfelse>
									<cfset other_tutar = alacak_other>
									<cfset tutar = alacak>
								</cfif>
								<td  style="text-align:right;">
								<cfif other_money neq session_base.money>
									<cfif isdefined('attributes.is_color')>
										<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(tutar/other_tutar,4)#</font>
									<cfelse>
										#TLFormat(tutar/other_tutar,4)#
									</cfif>
								<cfelse>
								&nbsp;
								</cfif>
								</td>
							</cfif>
							</cfif><!--- //dovizli --->
							<td  style="text-align:right;">
							  <cfif (currentrow mod attributes.maxrows) eq 1>

								<cfset bakiye = devir_total + borc - alacak>
								<cfset gen_borc_top = devir_borc + borc + gen_borc_top>
								<cfset gen_ala_top = devir_alacak + alacak + gen_ala_top>
								<cfif len(borc2) and len(alacak2)><cfset bakiye_2 = devir_total_2 + borc2 - alacak2></cfif>
								<cfif len(borc2)><cfset gen_borc_top_2 = devir_borc_2 + borc2 + gen_borc_top_2></cfif>
								<cfif len(alacak2)><cfset gen_ala_top_2 = devir_alacak_2 + alacak2 + gen_ala_top_2></cfif>
							  <cfelse>
								<cfset bakiye = borc - alacak >
								<cfset gen_borc_top = borc + gen_borc_top>
								<cfset gen_ala_top = alacak + gen_ala_top>
								<cfif len(borc2) and len(alacak2)><cfset bakiye_2 = borc2 - alacak2></cfif>
								<cfif len(borc2)><cfset gen_borc_top_2 = borc2 + gen_borc_top_2></cfif>
								<cfif len(alacak2)><cfset gen_ala_top_2 = alacak2 + gen_ala_top_2></cfif>
							  </cfif>
							  <cfif isdefined("attributes.is_project_group")>
								<cfset row_gen_borc_top = row_gen_borc_top + borc>
								<cfset row_gen_ala_top = row_gen_ala_top + alacak>
								<cfset row_gen_borc_top_2 = row_gen_borc_top_2 + borc2>
								<cfset row_gen_ala_top_2 = row_gen_ala_top_2 + alacak2>
								<cfset row_gen_bak_top = row_gen_bak_top + (borc - alacak)>		
								<cfset row_gen_bak_top_2 = row_gen_bak_top_2 + bakiye_2>		
								<cfset row_gen_bak_top_other = row_gen_bak_top_other + (borc_other - alacak_other)>		 
							</cfif>
							  <cfset gen_bak_top = bakiye + gen_bak_top>
							  <cfset gen_bak_top_2 = bakiye_2 + gen_bak_top_2>
							  <cfif isdefined("attributes.is_project_group")>
								  <cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(abs(gen_bak_top))# #session_base.money# <cfif gen_bak_top gt 0>- B<cfelse>- A</cfif></font>
								  <cfelse>
									#TLFormat(abs(row_gen_bak_top))# #session_base.money# <cfif row_gen_bak_top gt 0>- B<cfelse>- A</cfif>
								  </cfif>
							  <cfelse>
								  <cfif isdefined('attributes.is_color')>
									<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(abs(gen_bak_top))# #session_base.money# <cfif gen_bak_top gt 0>- B<cfelse>- A</cfif></font>
								  <cfelse>
									#TLFormat(abs(gen_bak_top))# #session_base.money# <cfif gen_bak_top gt 0>- B<cfelse>- A</cfif>
								  </cfif>
							  </cfif>
							</td>
							<cfif isdefined("attributes.is_project_group")>
								<cfif isdefined('attributes.is_doviz2_bakiye')>
								<td  style="text-align:right;">
									<cfif isdefined('attributes.is_color')>
										<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(abs(gen_bak_top_2))# #session_base.money2# <cfif gen_bak_top_2 gt 0>- B<cfelse>- A</cfif></font>
									<cfelse>
										#TLFormat(abs(row_gen_bak_top_2))# #session_base.money2# <cfif row_gen_bak_top_2 gt 0>- B<cfelse>- A</cfif>
									</cfif>
								</td>
								</cfif>
							<cfelse>
								<cfif isdefined('attributes.is_doviz2_bakiye')>
								<td  style="text-align:right;">
									<cfif isdefined('attributes.is_color')>
										<cfif len(to_cmp_id) or len(to_consumer_id)><font color="red"><cfelse><font color="0033CC"></cfif>#TLFormat(abs(gen_bak_top_2))# #session_base.money2# <cfif gen_bak_top_2 gt 0>- B<cfelse>- A</cfif></font>
									<cfelse>
										#TLFormat(abs(gen_bak_top_2))# #session_base.money2# <cfif gen_bak_top_2 gt 0>- B<cfelse>- A</cfif>
									</cfif>
								</td>
								</cfif>
							</cfif>
						</tr>
				<cfelse>
					<tr class="color-row">
						<td colspan="20">
							<table cellpadding="2" cellspacing="1">
								<cfif DETAIL_TYPE[currentrow-1] eq 0><!--- BAŞLIKLAR 1KERE OLUŞSN DİYE --->
									<cfif DETAIL_TYPE eq 1><!--- fatura detaylı gösterim için --->
										<tr <cfif isdefined("is_from_report")>class="css1"<cfelse>class="color-list"</cfif>>
											<td class="txtboldblue" width="100"><cf_get_lang_main no ='106.Stok Kodu'></td>
											<td class="txtboldblue" width="150"><cf_get_lang_main no ='217.Açıklama'></td>
											<cfif isdefined("attributes.is_show_spect_name") and attributes.is_show_spect_name eq 1>
												<td class="txtboldblue" width="150">Spec</td>
											</cfif>
											<td width="60"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='223.Miktar'></td>
											<td class="txtboldblue" width="40"><cf_get_lang_main no ='224.Birim'></td>
											<td width="80"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='226.Birim Fiyat'></td>
											<td width="120"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='757.İşlem Dövizi Fiyat'></td>
											<td width="80"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='77.Para Birimi'></td>
											<td width="40"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='227.KDV'></td>
											<cfif isdefined("attributes.is_show_discount") and attributes.is_show_discount eq 1>
												<cfloop from="1" to="#attributes.discount_count#" index="dis_indx">
													<td width="40"  class="txtboldblue" style="text-align:right;">ISK #dis_indx#</td>
												</cfloop>
											</cfif>
											<td width="100"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='758.Satır Toplamı'></td>
											<td width="120"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='759.İşlem Dövizi Toplam'></td>
										</tr>
									<cfelseif DETAIL_TYPE eq 2><!--- masraf fişi detaylı gösterim için --->
										<tr <cfif isdefined("is_from_report")>class="css1"<cfelse>class="color-list"</cfif>>
											<td class="txtboldblue" width="150"><cf_get_lang_main no ='217.Açıklama'></td>
											<td class="txtboldblue" width="150"><cfif ACTION_TYPE_ID eq 121><cf_get_lang_main no ='760.Gelir Merkezi'><cfelse><cf_get_lang_main no ='1048.Masraf Merkezi'></cfif></td>
											<td class="txtboldblue" width="150"><cfif ACTION_TYPE_ID eq 121><cf_get_lang_main no ='761.Gelir Kalemi'><cfelse><cf_get_lang_main no ='1139.Gider Kalemi'></cfif></td>
											<td class="txtboldblue" width="150">Proje</td>
											<td width="40"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='223.Miktar'></td>
											<td width="90"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='261.Tutar'></td>
											<td width="40"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='227.KDV'></td>
											<td width="40"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='609.ÖTV'></td>
											<td width="90"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='758.Satır Toplam'></td>
											<td width="100"  class="txtboldblue" style="text-align:right;"><cf_get_lang_main no ='712.Döviz Toplam'></td>
										</tr>
									</cfif>
								</cfif>
								<cfif DETAIL_TYPE eq 1><!--- fatura detaylı gösterim için --->
									<tr>
										<td width="100">#STOCK_CODE#</td>
										<td width="150">#NAME_PRODUCT#</td>
										<cfif isdefined("attributes.is_show_spect_name") and attributes.is_show_spect_name eq 1>
											<td width="150"><cfif SPECT_VAR_NAME neq NAME_PRODUCT>#SPECT_VAR_NAME#<cfelse>&nbsp;</cfif></td>	
										</cfif>
										<td width="60"   style="text-align:right;">#AMOUNT#</td>
										<td width="40">#UNIT#</td>
										<td width="80"  style="text-align:right;">#TLFormat(PRICE)#</td>
										<td width="120"  style="text-align:right;">#TLFormat(PRICE_OTHER)#</td>
										<td width="80"  style="text-align:right;">#ROW_MONEY#</td>
										<td width="40"  style="text-align:right;">#TAX#</td>
										<cfif isdefined("attributes.is_show_discount") and attributes.is_show_discount eq 1>
											<cfloop from="1" to="#attributes.discount_count#" index="dis_indx">
												<td width="40"  style="text-align:right;"><cfif len(evaluate("DISCOUNT#dis_indx#"))>#tlformat(evaluate("DISCOUNT#dis_indx#"))#</cfif></td>
											</cfloop>
										</cfif>
										<td width="100"  style="text-align:right;">#TLFormat(GROSSTOTAL)#</td>
										<td width="120"  style="text-align:right;">#TLFormat(OTHER_MONEY_GROSS_TOTAL)#</td>
									</tr>
								<cfelseif DETAIL_TYPE eq 2><!--- masraf fişi detaylı gösterim için --->
									<tr>
										<td width="150">#EXP_DETAIL#</td>
										<td width="150">#EXPENSE_CENTER#</td>
										<td width="150">#EXPENSE_ITEM_NAME#</td>
										<td width="150"><cfif len(row_project_id)>#get_project_name_row.project_head[listfind(row_project_id_list,row_project_id,',')]#<cfelse>&nbsp;</cfif></td>
										<td width="40"  style="text-align:right;">#AMOUNT#</td>
										<td width="90"  style="text-align:right;">#TLFormat(PRICE)#</td>
										<td width="40"  style="text-align:right;">#TAX#</td>
										<td width="40"  style="text-align:right;">#OTV_RATE#</td>
										<td width="90"  style="text-align:right;">#TLFormat(GROSSTOTAL)#</td>
										<td width="100"  style="text-align:right;">#TLFormat(OTHER_MONEY_GROSS_TOTAL)# #ROW_MONEY#</td>
									</tr>
								</cfif>
							</table>
						</td>
					</tr>
				 </cfif>
				 <!------>
				 <cfif isdefined("attributes.is_project_group") and ((CARI_ROWS_ALL.PROJECT_ID[currentrow] neq CARI_ROWS_ALL.PROJECT_ID[currentrow+1]) or currentrow/attributes.page eq attributes.maxrows)>
					<tr height="20" <cfif isdefined("is_from_report")>class="css1"<cfelse>class="color-row"</cfif>>
				 	<cfif isdefined('attributes.is_due')>
						<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>
							<cfset colspan_info = 7>
						<cfelse>
							<cfset colspan_info = 6>
						</cfif>
					<cfelse>
						<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>
							<cfset colspan_info = 5>
						<cfelse>
							<cfset colspan_info = 4>
						</cfif>
					</cfif>
					<td colspan="#colspan_info#"  class="txtbold" style="text-align:right;">Proje Toplam</td>
					<cfif isdefined('attributes.is_action_detail')><td>&nbsp;</td></cfif>	
					<td  class="txtbold" style="text-align:right;">#TLFormat(row_gen_borc_top)# #session_base.money#</td>
					<td  class="txtbold" style="text-align:right;">#TLFormat(row_gen_ala_top)# #session_base.money#</td>
					<cfif isdefined('attributes.is_doviz2')>
						<td  class="txtbold" style="text-align:right;">#TLFormat(row_gen_borc_top_2)# #session_base.money2#</td>
						<td  class="txtbold" style="text-align:right;">#TLFormat(row_gen_ala_top_2)# #session_base.money2#</td>
					</cfif>
					<cfif isdefined('attributes.is_doviz') or isDefined("attributes.is_doviz_group")>
						<td style="width:125px;"  class="txtbold">
							<cfloop query="get_money">
							  <cfset toplam_ara_2 = 0>
							  <cfif len(row_money_list_borc_2)>
								  <cfloop list="#row_money_list_borc_2#" index="i">
									  <cfset tutar_ = listfirst(i,';')>
									 <cfset money_ = listgetat(i,2,';')>
									<cfif money_ eq money>
									  <cfset toplam_ara_2 = toplam_ara_2 + tutar_>
									</cfif>
								  </cfloop> 
							  </cfif>
							  <cfset toplam_ara_2 = toplam_ara_2 + evaluate('devir_borc_pro_#money#')>
							  <cfif toplam_ara_2 neq 0>
								#TLFormat(ABS(toplam_ara_2))# #money#<br>
							  </cfif>
							</cfloop>  
						</td>
						<td style="width:125px;"  class="txtbold">
							<cfloop query="get_money">
							  <cfset toplam_ara_2 = 0>
							 <cfif len(row_money_list_alacak_2)>
								 <cfloop list="#row_money_list_alacak_2#" index="i">
									  <cfset tutar_ = listfirst(i,';')>
									  <cfset money_ = listgetat(i,2,';')>
									<cfif money_ eq money>
									  <cfset toplam_ara_2 = toplam_ara_2 + tutar_>
									</cfif>
							   </cfloop> 
							  </cfif>
							  <cfset toplam_ara_2 = toplam_ara_2 + evaluate('devir_alacak_pro_#money#') >
							  <cfif toplam_ara_2 neq 0>
								#TLFormat(ABS(toplam_ara_2))# #money#<br>
							  </cfif> 
							</cfloop>  
						</td>
						<td>&nbsp;</td><!---<td>&nbsp;</td>--->
					</cfif>
					<td  class="txtbold" style="text-align:right;"> 
						#TLFormat(abs(row_gen_bak_top))# #session_base.money# <cfif row_gen_bak_top gt 0> -B<cfelse> -A</cfif>
					</td>
					<cfif isdefined('attributes.is_doviz2_bakiye')>
						<td  class="txtbold" style="text-align:right;"> 
							#TLFormat(abs(row_gen_bak_top_2))# #session_base.money2# <cfif row_gen_bak_top_2 gt 0> -B<cfelse> -A</cfif>
						</td>
					</cfif>
					<cfif isdefined("attributes.is_doviz") and len(attributes.other_money)>
						<td  class="txtbold" style="text-align:right;">
							#TLFormat(abs(row_gen_bak_top_other))# #attributes.other_money# <cfif row_gen_bak_top_other gt 0> -B<cfelse> -A</cfif>
						</td>
					</cfif>
				</tr>
				<cfset row_gen_borc_top = 0>	
				<cfset row_gen_ala_top = 0>	
				<cfset row_gen_borc_top_2 = 0>		
				<cfset row_gen_ala_top_2 = 0>		
				<cfset row_gen_bak_top = 0>		
				<cfset row_gen_bak_top_2 = 0>		
				<cfset row_gen_bak_top_other = 0>		
				<cfset row_money_list_borc_2 = ''>
				<cfset row_money_list_borc_1 = ''>
				<cfset row_money_list_alacak_2 = ''>
				<cfset row_money_list_alacak_1 = ''>
				<cfloop query="get_money">
					<cfset 'devir_borc_pro_#money#' = 0>
					<cfset 'devir_alacak_pro_#money#' = 0>
				</cfloop>
				 	</cfif>
				 <!------>
			 </cfoutput>
			<tr height="20" class="color-row">
				<td colspan="
                	<cfif isdefined('attributes.is_due')>
						<cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>7<cfelse>6</cfif>
                    <cfelse>
                        <cfif isdefined('session.pp') and isdefined('attributes.is_extre_project') and attributes.is_extre_project eq 1>5<cfelse>4</cfif>
                	</cfif>
                "  style="text-align:right;"><b><cf_get_lang_main no='268.Genel Toplam'></b></td>
				<cfif isdefined('attributes.is_action_detail')><td>&nbsp;</td></cfif>	
				<td  style="text-align:right;"><cfoutput>#TLFormat(gen_borc_top)# #session_base.money#</cfoutput></td>
				<td  style="text-align:right;"><cfoutput>#TLFormat(gen_ala_top)# #session_base.money#</cfoutput></td>
				<cfif isdefined('attributes.is_doviz2')>
					<td  style="text-align:right;"><cfoutput>#TLFormat(gen_borc_top_2)# #session_base.money2#</cfoutput></td>
					<td  style="text-align:right;"><cfoutput>#TLFormat(gen_ala_top_2)# #session_base.money2#</cfoutput></td>
				</cfif>
				<cfif isdefined('attributes.is_doviz') or  isDefined("attributes.is_doviz_group")>
					<cfquery name="GET_MONEY_RATE" datasource="#DSN#">
						SELECT * FROM SETUP_MONEY WHERE PERIOD_ID = <cfif isDefined("session.pp")><cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.period_id#"><cfelse><cfqueryparam cfsqltype="cf_sql_integer" value="#session.ww.period_id#"></cfif> AND MONEY_STATUS = 1
					</cfquery>
					<td style="width:125px;" style="text-align:right;">
						<cfoutput query="get_money_rate">
						  <cfset toplam_ara_2 = 0>
						  <cfloop list="#money_list_borc_2#" index="i">
							  <cfset tutar_ = listfirst(i,';')>
							 <cfset money_ = listgetat(i,2,';')>
							<cfif money_ eq money>
							  <cfset toplam_ara_2 = toplam_ara_2 + tutar_>
							</cfif>
						  </cfloop>
						  <cfset toplam_ara_2 = toplam_ara_2 + evaluate('devir_borc_#money#')>
						  <cfif toplam_ara_2 neq 0>
							#TLFormat(ABS(toplam_ara_2))# #money#<br>
						  </cfif>
						</cfoutput>  
					</td>
					<td style="width:125px;" style="text-align:right;">
						<cfoutput query="get_money_rate">
						  <cfset toplam_ara_2 = 0>
						  <cfloop list="#money_list_alacak_2#" index="i">
							  <cfset tutar_ = listfirst(i,';')>
							  <cfset money_ = listgetat(i,2,';')>
							<cfif money_ eq money>
							  <cfset toplam_ara_2 = toplam_ara_2 + tutar_>
							</cfif>
						  </cfloop>
						  <cfset toplam_ara_2 = toplam_ara_2 + evaluate('devir_alacak_#money#') >
						  <cfif toplam_ara_2 neq 0>
							#TLFormat(ABS(toplam_ara_2))# #money#<br>
						  </cfif>
						</cfoutput>  
					</td>
					<td>&nbsp;</td>
				</cfif>
				<td  style="text-align:right;"> 
				<cfoutput>
					#TLFormat(abs(gen_bak_top))# #session_base.money# <cfif gen_bak_top gt 0> -B<cfelse> -A</cfif>
				</cfoutput>
				</td>
				<cfif isdefined('attributes.is_doviz2_bakiye')>
				<td  style="text-align:right;"> 
				<cfoutput>
					#TLFormat(abs(gen_bak_top_2))# #session_base.money2# <cfif gen_bak_top_2 gt 0> -B<cfelse> -A</cfif>
				</cfoutput>
				</td>
				</cfif>	
						
			  </tr>		  	       
			</cfif>
			</table>
		</cfloop>
	</cfif>
	<cfif isDefined("attributes.totalrecords") and attributes.totalrecords gt attributes.maxrows and get_periods.recordcount eq 1>
	<table cellpadding="0" cellspacing="0" border="0" width="98%" height="35" align="center">
	  <tr> 
		<td>
			<cfset adres="objects2.list_extre">
			<cfset adres = adres & "&date1=#dateformat(attributes.date1,'dd/mm/yyyy')#">					
			<cfset adres = "#adres#&date2=#dateformat(attributes.date2,'dd/mm/yyyy')#">
			<cfif isdefined("attributes.company_id")>
				<cfset adres = adres & "&company_id=#attributes.company_id#">					
			</cfif>
			<cfif isdefined("attributes.consumer_id")>
				<cfset adres = adres & "&consumer_id=#attributes.consumer_id#">					
			</cfif>
			<cfif isdefined("attributes.is_doviz")>
				<cfset adres = "#adres#&is_doviz=#attributes.is_doviz#">
			</cfif>
			<cfif isdefined("attributes.is_doviz2")>
				<cfset adres = "#adres#&is_doviz2=#attributes.is_doviz2#">
			</cfif>
			<cfif isdefined("attributes.is_doviz_group")>
				<cfset adres = "#adres#&is_doviz_group=#attributes.is_doviz_group#">
			</cfif>
			<cfif isdefined("attributes.is_doviz2_bakiye")>
				<cfset adres = "#adres#&is_doviz2_bakiye=#attributes.is_doviz2_bakiye#">
			</cfif>
			<cfif isdefined("attributes.form_submit")>
				<cfset adres = "#adres#&form_submit=#attributes.form_submit#">
			</cfif>
			<cfif isdefined("attributes.company") and len(attributes.company)>
				<cfset adres = "#adres#&company=#attributes.company#">
			</cfif>
			<cfif isdefined("attributes.employee_id") and len(attributes.employee_id)>
				<cfset adres = "#adres#&employee_id=#attributes.employee_id#">
			</cfif>
			<cfif isdefined("attributes.member_type") and len(attributes.member_type)>
				<cfset adres = "#adres#&member_type=#attributes.member_type#">
			</cfif>
			<cfif isdefined("attributes.is_due")>
				<cfset adres = "#adres#&is_due=#attributes.is_due#">
			</cfif>
			<cfif isdefined("attributes.is_color")>
				<cfset adres = "#adres#&is_color=#attributes.is_color#">
			</cfif>
			<cfif isdefined("attributes.is_process_cat")>
				<cfset adres = "#adres#&is_process_cat=#attributes.is_process_cat#">
			</cfif>
			<cfif isdefined("attributes.ch_action_type") and len(attributes.ch_action_type)>
				<cfset adres = "#adres#&action_type=#attributes.ch_action_type#">
			</cfif>
			<cfif isdefined("attributes.other_money")>
				<cfset adres = "#adres#&other_money=#attributes.other_money#">
			</cfif>
			<cfif isdefined("attributes.is_action_detail")>
				<cfset adres = "#adres#&is_action_detail=#attributes.is_action_detail#">
			</cfif>
			<cfif isdefined("attributes.is_inv_detail")>
				<cfset adres = "#adres#&is_inv_detail=#attributes.is_inv_detail#">
			</cfif>
			<cfif isdefined("attributes.is_project_group")>
				<cfset adres = "#adres#&is_project_group=#attributes.is_project_group#">
			</cfif>
			<cf_pages page="#attributes.page#" 
				maxrows="#attributes.maxrows#"
				totalrecords="#attributes.totalrecords#"
				startrow="#attributes.startrow#"
				adres="#adres#"> 
		</td>
		<!-- sil --><td  style="text-align:right;"><cfoutput><cf_get_lang_main no='128.Toplam Kayıt'>:#attributes.totalrecords#&nbsp;-&nbsp;<cf_get_lang_main no='169.Sayfa'>:#attributes.page#/#lastpage#</cfoutput></td><!-- sil -->
	  </tr>
	 </table>
	</cfif> 
<br>
</cfif>
<script type="text/javascript">
	function kontrol()
	{	
		if((document.list_ekstre.company.value.length == 0))
			{
				document.list_ekstre.company_id.value = '';
				document.list_ekstre.consumer_id.value = '';
				document.list_ekstre.employee_id.value = '';
			}
		if( (document.list_ekstre.company_id.value == "")&&(document.list_ekstre.consumer_id.value == "") && (document.list_ekstre.company.value == "") &&(document.list_ekstre.employee_id.value == ""))
			{ 
			alert ("<cf_get_lang no='122.Cari Hesap Seçiniz veya Çalışan Hesap Seçiniz'>!");
			return false;
			}
		
		if(document.list_ekstre.is_excel.checked==false)
		{
			document.list_ekstre.action="<cfoutput>#request.self#?fuseaction=objects2.list_extre</cfoutput>"
		}
		else
		{
			document.list_ekstre.action="<cfoutput>#request.self#?fuseaction=objects2.autoexcelpopuppage_list_extre&action_type=1</cfoutput>"
		}	
		return date_diff(document.list_ekstre.date1,document.list_ekstre.date2,1,"<cf_get_lang_main no ='394.Tarih Aralığını Kontrol Ediniz'>");
	}
</script>