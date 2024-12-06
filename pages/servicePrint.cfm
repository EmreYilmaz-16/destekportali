<script type="text/javascript" src="js/printThis.js"></script>
<cfsetting showdebugoutput="no">
<cfif isdefined('session.pp.our_company_id')>
    <cfquery name="getSubs" datasource="w3Partner_1"><!--- workcube_worknet_22 --->
        SELECT SUBSCRIPTION_ID FROM SUBSCRIPTION_CONTRACT WHERE COMPANY_ID = #session.pp.company_id# AND IS_ACTIVE = 1
    </cfquery>
    <cfif getSubs.recordcount>
    	<cfset dsn3 = 'w3Partner_1'><!--- workcube_worknet_22 --->
	    <!---<cfset session.pp.our_company_id = 22>--->
		<cfelse>
		<cfset dsn3 = 'w3Partner_1'>
    </cfif>
</cfif>
<cfquery name="OUR_COMPANY" datasource="#DSN#">
	SELECT 
		ASSET_FILE_NAME3,
		ASSET_FILE_NAME3_SERVER_ID,
		COMPANY_NAME,
		TEL_CODE,
		TEL,TEL2,
		TEL3,
		TEL4,
		FAX,
		TAX_OFFICE,
		TAX_NO,
		ADDRESS,
		WEB,
		EMAIL
	FROM 
		OUR_COMPANY 
	WHERE 
		COMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.our_company_id#">
</cfquery>
<!--- worknet --->
<!--- Teklif Verildi,Teklif Onaylandı, Iptal --->
<cfset teklif_stage_list = '125,376,375'>
<!--- Teklif Verildi,Teklif Onaylandı, Iptal --->

<!--- Servis Tamamlandı,Servis Onaylandı, Faturalandı,Faturalandırılmayacak,Peşin Satış/Anahtar Teslimi --->
<cfset servis_stage_list = '768,23,28,624,378'>
<!--- Servis Tamamlandı,Servis Onaylandı, Faturalandı,Faturalandırılmayacak,Peşin Satış/Anahtar Teslimi --->

<cfset servis_tamamlandı = '768'>
<cfset iptal_edildi = '375'>
<cfset teklif_verildi = '125'>
<cfset teklif_onaylandi = '376'>
<cfset servis_onaylandi = '23'>

<!--- Teklif Verildi,Teklif Onaylandı,İptal,Servis Tamamlandı,Servis Onaylandı,Faturalandı,Faturalandırılmayacak,Peşin Satış Anahtar Teslimi --->
<cfset process_stage_list = '125,376,375,768,23,28,624,378'>
<!--- Teklif Verildi,Teklif Onaylandı,İptal,Servis Tamamlandı,Servis Onaylandı,Faturalandı,Faturalandırılmayacak,Peşin Satış Anahtar Teslimi --->


<cfset servis_stage_list = '406,135,407,405'>

<cfquery name="GET_SERVICE" datasource="#DSN3#">
	SELECT 
		S.SERVICE_COMPANY_ID,
        S.SERVICE_CONSUMER_ID,
        S.APPLICATOR_NAME,
        S.SERVICE_HEAD,
        S.SERVICE_DETAIL,
        S.START_DATE,
        S.FINISH_DATE,
        S.SERVICE_STATUS_ID,
        S.SUBSCRIPTION_ID,
        S.RECORD_DATE,
        S.PROJECT_ID,
        S.SERVICE_NO,
        S.APPLY_DATE ,
		S.SERVICECAT_ID,
        CP.COMPANY_PARTNER_NAME + ' ' + CP.COMPANY_PARTNER_SURNAME AS COMP_PARTNER
	FROM 
		SERVICE AS S 
        LEFT JOIN #dsn#.COMPANY_PARTNER AS CP ON CP.PARTNER_ID = S.SERVICE_COMPANY_ID
	WHERE 
		S.SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.action_id#">
        AND S.SERVICE_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">
        ---AND S.SERVICE_STATUS_ID IN(#servis_stage_list#)
</cfquery>

<cfif not get_service.recordcount>
	<br/><font class="txtbold">&nbsp;&nbsp;Çalıştığınız Şirkete Ait Böyle Bir Başvuru Kaydı Bulunamadı !</font>
	<cfexit method="exittemplate">
</cfif>
<!--- Cari Bilgisi --->
<cfif len(get_service.service_company_id)>
	<cfquery name="GET_ADDRESS" datasource="#DSN#">
		SELECT
			 COMPANY_ADDRESS AS ADRES,
			 SEMT AS SEMT,
			 COMPANY_TELCODE AS TELCODE,
			 COMPANY_TEL1 AS TEL,
			 TAXOFFICE AS TAX,
			 TAXNO AS TAXNO,
			 COUNTY AS COUNTY,
			 CITY AS CITY,
			 COUNTRY AS COUNTRY
		FROM  
			 COMPANY
		WHERE 
			 COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Service.Service_Company_Id#">
	</cfquery>
<cfelseif len(get_service.service_consumer_id)>
	<cfquery name="GET_ADDRESS" datasource="#DSN#">
		SELECT
			 WORKADDRESS AS ADRES,
			 WORKSEMT AS SEMT,
			 CONSUMER_WORKTELCODE AS TELCODE,
			 CONSUMER_WORKTEL AS TEL,
			 TAX_OFFICE AS TAX,
			 TAX_NO AS TAXNO,
			 WORK_COUNTY_ID AS COUNTY,
			 WORK_CITY_ID AS CITY,
			 WORK_COUNTRY_ID AS COUNTRY
		FROM  
			 CONSUMER
		WHERE 
			 CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Service.Service_Consumer_Id#">
	</cfquery>
</cfif>
<cfif len(get_address.county)>
	<cfquery name="GET_COUNTY" datasource="#DSN#">
		SELECT COUNTY_NAME FROM SETUP_COUNTY WHERE COUNTY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_address.county#">
	</cfquery>
</cfif>
<cfif len(get_address.city)>
	<cfquery name="GET_CITY" datasource="#DSN#">
		SELECT CITY_NAME FROM SETUP_CITY WHERE CITY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_address.city#">
	</cfquery> 
</cfif>
<!--- // Cari bilgisi --->
<cfif len(get_service.subscription_id)>
	<cfquery name="GET_SUBSCRIPTION" datasource="#DSN3#">
		SELECT
			SC.SUBSCRIPTION_NO
		FROM
			SUBSCRIPTION_CONTRACT SC
		WHERE
			SUBSCRIPTION_ID IS NOT NULL AND 
			SC.SUBSCRIPTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Service.Subscription_Id#">
	</cfquery>
</cfif>
<cfquery name="GET_SERVICE_PLUS" datasource="#DSN3#">
	SELECT SERVICE_ID FROM SERVICE_PLUS WHERE SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.action_id#">
</cfquery>
<cfif len(get_service.project_id)>
	<cfquery name="GET_PROJECT" datasource="#DSN#">
		SELECT 
			PROJECT_HEAD,PROJECT_ID 
		FROM 
			PRO_PROJECTS
		WHERE
			PROJECT_ID IS NOT NULL AND
			PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_service.project_id#">
	</cfquery>
</cfif>
<!--- Urun Servis Islemleri --->
<cfquery name="GET_OPERATION_ROW" datasource="#DSN3#">
	SELECT 
    	S.SERVICE_ID, 
        S.AMOUNT, 
        S.SERVICE_EMP_ID,
        E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE
	FROM 
    	SERVICE_OPERATION AS S
        LEFT JOIN #dsn#.EMPLOYEES AS E ON E.EMPLOYEE_ID = S.SERVICE_EMP_ID
    WHERE 
    	S.SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.action_id#">
</cfquery>
<cfset operation_row = get_operation_row.recordcount>
<cfset amount_total = 0>
<!--- iliskili Ajanda - Katilimcilar --->
<cfquery name="GET_EVENT_RELATED" datasource="#DSN#">
	SELECT
		ER.EVENT_ID,
		ER.RELATED_ID,
		ER.ACTION_ID,
		E.EVENT_HEAD,
		E.EVENT_TO_POS,
		E.EVENT_TO_PAR,
		E.EVENT_TO_CON
	FROM
		EVENTS_RELATED ER,
		EVENT E
	WHERE
		E.EVENT_ID = ER.EVENT_ID AND
        ER.ACTION_SECTION = 'SERVICE_ID' AND 
		ER.ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.action_id#">
</cfquery>
<cfquery name="GET_SERVICE_PLUS" datasource="#DSN3#">
	SELECT SERVICE_ID FROM SERVICE_PLUS WHERE SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.action_id#">
</cfquery>
<cfquery name="GET_SERVICE_OPERATION" datasource="#DSN3#">
	SELECT AMOUNT, TOTAL_PRICE, CURRENCY, AMOUNT FROM SERVICE_OPERATION WHERE SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.action_id#">
</cfquery>
<cfset service_operation_total = 0>
<cfset service_operation_money = ''>
<cfset adam_gun = 0>
<cfif get_service_operation.recordcount>
	<cfoutput query="get_service_operation">
		<cfset service_operation_total = service_operation_total + total_price>
		<cfset service_operation_money = currency>
		<cfset adam_gun = adam_gun + amount>
	</cfoutput>
</cfif>
<cfquery name="GET_SERVICE_OPERATION_BY_GROUP" datasource="#DSN3#">
	SELECT SUM(TOTAL_PRICE) AS TOTAL_PRICE, ISNULL(CURRENCY,'TL') AS CURRENCY FROM SERVICE_OPERATION WHERE SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.action_id#"> GROUP BY CURRENCY
</cfquery>
<cfquery name="GET_SERVICE_ASSETS" datasource="#DSN#">
	SELECT
		A.ASSET_FILE_NAME,
		A.MODULE_NAME,
		A.ASSET_ID,
        A.ACTION_ID,
		A.ASSETCAT_ID,
        A.RECORD_DATE,
		A.ASSET_NAME,
		A.IMAGE_SIZE,
		A.ASSET_FILE_SERVER_ID,
		ASSET_CAT.ASSETCAT,
		ASSET_CAT.ASSETCAT_PATH,
		CP.NAME,
		A.RECORD_PAR
	FROM
		ASSET A,
		CONTENT_PROPERTY CP,
		ASSET_CAT,
        ASSET_SITE_DOMAIN
	WHERE
        ASSET_SITE_DOMAIN.ASSET_ID = A.ASSET_ID AND
        ASSET_SITE_DOMAIN.SITE_DOMAIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.http_host#"> AND
		A.ASSETCAT_ID = ASSET_CAT.ASSETCAT_ID AND
		A.ACTION_SECTION = 'SERVICE_ID' AND
		A.ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.action_id#"> AND
		A.PROPERTY_ID = CP.CONTENT_PROPERTY_ID AND
		A.IS_SPECIAL = 0 AND
		A.IS_INTERNET = 1
	ORDER BY 
		A.RECORD_DATE DESC 
</cfquery>
<div align="center" class="printable">
<cfform name="upd_service" method="post" action=""><!--- #request.self#?fuseaction=objects2.emptypopup_deny_service --->
<input type="hidden" name="service_id" id="service_id" value="<cfoutput>#attributes.action_id#</cfoutput>">
	<!--- KATALİZOR SERVIS DESTEK FORMU --->
	<table border="0" cellpadding="1" cellspacing="1" style="width:175mm;" align="center">
		<tr>
			<td style="height:20px;" valign="top">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<cfoutput query="our_company">
					<tr>
                    	
                        <!---
						<td style="text-align:left; width:432px;">
						<cf_get_server_file 
							output_file="settings/#asset_file_name3#" 
							output_server="#asset_file_name3_server_id#" 
							output_type="5">
						</td>
                        --->
						<td style="text-align:right;">
							<table>
								<tr><td style="text-align:right;"><b>#company_name#</b></td></tr>
								<tr><td style="text-align:right;">#address#</td></tr>
								<tr><td style="text-align:right;"><cfif Len(tel)>Tel: #tel_code# #tel#</cfif> &nbsp; <cfif Len(fax)>Fax: #tel_code# #fax#</cfif></td></tr>
								<tr><td style="text-align:right;">#web#&nbsp;&nbsp;#email#</td></tr>
							</table>
						</td>
					</tr>
				</cfoutput>
				</table>
			</td>
		</tr>
		<tr><td style="height:5mm;">&nbsp;</td></tr>
		<tr>
			<td style="height:75mm;" valign="top">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
				<cfoutput query="get_service">
					<tr>
						<td style="height:10mm;" valign="top">
							<table border="1" cellpadding="3" cellspacing="0" width="100%">
								<tr>
									<td style="background-color:black;"><font color="FFFFFF" size="+2" face="Arial, Helvetica, sans-serif">Servis Destek Formu</font></td>
									<td><b>Form No:</b>&nbsp;&nbsp;#service_no#</td>
									<td style="text-align:right;"><b>Tarih:</b>&nbsp;&nbsp;#DateFormat(apply_date,'dd/mm/yyyy')#</td>
								</tr>
							</table>
						</td>
					</tr>
					 <tr>
						<td style="height:40mm;" valign="top">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td valign="top">
										<table border="0" cellpadding="1" cellspacing="1" width="100%" align="center">
											<tr><td colspan="4" style="height:5mm;">&nbsp;</td></tr>
											<tr>
												<td style="width:20mm;height:6mm;"><b>Müşteri</b></td>
												<td style="width:80mm;text-align:left;">
													<table border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td><b>:</b>&nbsp;</td>
														<td><cfif len(service_consumer_id)>#get_cons_info(service_consumer_id,0,0)#</cfif>
															<cfif len(service_company_id)>#COMP_PARTNER#</cfif>
														</td>
													</tr>
												</table>
												</td>
												<td style="width:30mm;"><b>Servis İstek Tarihi</b></td>
												<td style="width:30mm;text-align:left;"><b>:</b>&nbsp;#DateFormat(apply_date,'dd/mm/yyyy')#</td>
											</tr>
											<tr>
												<td style="height:6mm;"><b>Yetkili</b></td>
												<td><b>:</b>&nbsp;#get_service.applicator_name#</td>
												<td><b>Saat</b>	</td>
												<td>
												<cfif isdefined("session.ep.time_zone")><cfset time_zone = session.ep.time_zone><cfelse><cfset time_zone = session.pp.time_zone></cfif>
												<cfif len(apply_date)><cfset applydate = dateadd('h',time_zone,apply_date)></cfif>
													<b>:</b>&nbsp;<cfif len(apply_date)>#timeformat(applydate,'HH:MM:SS')#</cfif>
												</td>
											</tr>
											<tr>
												<td style="height:6mm;"><b>Adres</b></td>
												<td>
													<table border="0" cellpadding="0" cellspacing="0">
														<tr>
															<td><b>:</b>&nbsp;</td>
															<td>#get_address.adres#
																<cfif len(get_address.County)>#get_county.county_name#</cfif>
																<cfif len(get_address.city)>#get_city.city_name#</cfif>
															</td>
														</tr>
													</table>
												</td>
												<td><b>Workcube Seri No</b></td>
												<td><b>:</b>&nbsp;<cfif len(get_service.subscription_id)>&nbsp;#get_subscription.subscription_no#<cfelse>&nbsp;</cfif></td>
											</tr>
											<tr>
												<td style="height:6mm;"><b>Tel</b></td>
												<td><b>:</b>&nbsp;#get_address.telcode# - #get_address.tel#</td>
												<td><b>Garanti</b></td>
												<td nowrap="nowrap">
													<table border="0" cellpadding="0" cellspacing="0">
														<tr>
															<td><b>:</b>&nbsp;<input type="checkbox" style="size:5px;"> Evet</td>
															<td><input type="checkbox" style="size:5px;"> Hayır</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td style="height:6mm;"><b>Vergi Dairesi</b></td>
												<td><b>:</b>&nbsp;#get_address.tax#</td>
												<td><b>Bakım Anlaşması</b></td>
												<td nowrap="nowrap">
													<table border="0" cellpadding="0" cellspacing="0">
														<tr>
															<td><b>:</b>&nbsp;<input type="checkbox" style="size:5px;"> Var</td>
															<td><input type="checkbox" style="size:5px;"> Yok</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td style="height:6mm;"><b>Vergi No</b></td>
												<td><b>:</b>&nbsp;#get_address.taxno#</td>
												<td><b>Proje</b></td>
												<td nowrap="nowrap">
												<table border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td><b>:</b>&nbsp;</td>
														<td><cfif len(get_service.project_id)>#get_project.project_head#<cfelse>&nbsp;</cfif></td>
													</tr>
												</table>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<table border="0" cellpadding="1" cellspacing="1" width="100%">
								<tr><td style="height:5mm;">____________________________________________________________________________________________________________</td></tr>
								<tr valign="top">
									<td style="height:28mm;"><br>
										<b>Konu </b>:&nbsp;#service_head#<br />
										<cfset new_detail = replace(service_detail,'#chr(13)#','<br>','all')>
										#new_detail#
									</td>
								</tr>
                                <cfif get_service_assets.recordcount>
                                    <tr>
                                        <td>
                                            <b>İlişkili Belgeler : </b> 
                                            <cfloop query="get_service_assets"><!--- #year(get_service_assets.record_date)#/#get_service_assets.action_id#/ --->
                                                <cfif get_service_assets.currentrow neq 1>,</cfif><a href="#listfirst(fusebox.server_machine_list,';')##file_web_path##get_service_assets.module_name#/#get_service_assets.asset_file_name#" title="" class="tableyazi">#get_service_assets.asset_name#</a> 
                                            </cfloop>
                                        </td>
                                    </tr>
                                </cfif>
							</table>
						</td>
					</tr>
				</cfoutput>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
					<tr>
						<td valign="top">
							<table border="1" cellpadding="3" cellspacing="0" width="100%">
								<tr valign="top">
									<td>
									<cfoutput>
										<b>Katılımcılar :</b><br>
										<cfif Len(get_event_related.event_to_pos)>
											<cfloop list="#get_event_related.event_to_pos#" index="emp">
												<cfquery name="GET_EMPLOYEES" datasource="#DSN#">
													SELECT EMPLOYEE_ID,EMPLOYEE_NAME,EMPLOYEE_SURNAME FROM EMPLOYEES WHERE EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#emp#">
												</cfquery>
												<cfquery name="GET_EMPLOYEE_POSITION" datasource="#DSN#">
													SELECT POSITION_NAME FROM EMPLOYEE_POSITIONS WHERE EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#emp#">
												</cfquery>
												#get_employees.employee_name# #get_employees.employee_surname# (#get_employee_position.position_name#)<br>
											</cfloop>
										</cfif>
										<cfif Len(get_event_related.event_to_par)>
											<cfloop list="#get_event_related.event_to_par#" index="par">
												<cfquery name="GET_COMPANY_PARTNER" datasource="#DSN#">
													SELECT 
														COMPANY_ID,
														COMPANY_PARTNER_SURNAME,
														COMPANY_PARTNER_NAME 
													FROM 
														COMPANY_PARTNER WHERE PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#par#">
												</cfquery>
												<cfquery name="GET_COMPANY_NAME" datasource="#DSN#">
													SELECT NICKNAME FROM COMPANY WHERE COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_company_partner.company_id#">
												</cfquery>
												 #get_company_partner.company_partner_name# #get_company_partner.company_partner_surname# (#get_company_name.nickname#)<br>
											</cfloop>
										</cfif>
										<cfif Len(get_event_related.event_to_con)>
											<cfloop list="#get_event_related.event_to_con#" index="cons">
												<cfquery name="GET_CONSUMER" datasource="#DSN#">
													SELECT CONSUMER_ID,CONSUMER_NAME,CONSUMER_SURNAME FROM CONSUMER WHERE CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#cons#">
												</cfquery>                    
												#get_consumer.consumer_name# #get_consumer.consumer_surname#
											</cfloop>
										</cfif>
									</cfoutput>
									</td>
								</tr>
								<tr valign="top">
									<td height="45%">
										<br><b>Görevli :</b>
										<cfif get_operation_row.recordcount>
											<cfoutput query="get_operation_row">
												<cfset amount_total = amount_total + amount>
												#EMPLOYEE#,
											</cfoutput>
										</cfif><br><br>
										<cfoutput>
										<cfif len(get_service.start_date)>
											<cfset Startdate = dateadd("H",time_zone,get_service.start_date)>                            
											<b>Başlama Saat :</b> &nbsp;#DateFormat(get_service.start_date,'dd/mm/yyyy')#&nbsp;&nbsp;#timeformat(Startdate,'HH:MM:SS')#
										</cfif>
										<cfif Len(get_service.finish_date)>
											<cfset Finishdate = dateadd("H",time_zone,get_service.finish_date)>
											<b>Bitiş Saat :</b> &nbsp;#dateformat(get_service.finish_date,'dd/mm/yyyy')#&nbsp;&nbsp;<cfif len(get_service.finish_date)>#timeformat(Finishdate,'HH:MM:SS')#</cfif>
											<br><br>
										</cfif>
										<cfif Len(Get_Service.Start_Date) and Len(get_service.finish_date)>
											<cfset d3 = DATEDIFF('h',Startdate,Finishdate)>
											<cfset minute_ = DATEDIFF('N',Startdate,Finishdate) mod 60>
										</cfif>
											<b>Toplam Çalışma Saat :</b> <cfif Len(get_service.start_date) and len(Get_Service.Finish_Date)>#d3# Saat #minute_# dakika</cfif>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Adam Gün :</b> #Amount_Total#<br /><br />
											USD üzerinden yapılan fiyatlandırmalarda faturalandırma tarihindeki T.C.  Merkez Bankası USD Efektif Satış kuru esas alınarak faturalandırma yapılır.	
										</cfoutput>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<table border="0" cellpadding="1" cellspacing="1" width="100%" align="center">
                                <tr>
                                    <td class="txtbold" colspan="2">
                                        <cfif get_service.service_status_id eq servis_tamamlandi>
                                            10 gün içerisinde onay verilmeyen servis formları sistem tarafından onaylanmış kabul edilecektir.			
                                        </cfif>
                                    </td>
                                </tr>
								<tr><td colspan="2">&nbsp;</td></tr>
								<cfif get_service.service_status_id eq servis_tamamlandı>
                                    <tr>
                                        <td style="text-align:right;" colspan="2">
                                            <cf_workcube_buttons is_upd='1' is_cancel="0" is_delete='0' insert_info="Onaylıyorum" insert_alert="Servis Formunun Aşaması Onaylandı Olarak Değiştirilecektir. Emin misiniz?">
                                        </td>
                                    </tr>
                                </cfif>
								<tr valign="top" style="height:10mm;">
									<td width="60%"><b>Müşteri Onayı :</b></td>
									<td width="40%"><b>Not :</b></td>
								</tr>
								<tr valign="top" style="height:10mm;">
									<td><b>Müşteri Yetkili :</b></td>
									<td>&nbsp;</td>
								</tr>
								<tr valign="top" style="height:10mm;">
									<td><b>Tarih :</b></td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</cfform>
</div>

<script type="text/javascript">
	function chk_form()
	{
		document.getElementById('is_deny').value = 1;
		return true;
	}
</script>
<cfabort>