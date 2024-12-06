<cfif (isdefined('attributes.company_id') and len(attributes.company_id)) or (isdefined('attributes.consumer_id') and len(attributes.consumer_id)) or (isdefined('attributes.employee_id') and len(attributes.employee_id))>
	<!--- Acik siparis ve irsaliyeler --->
	<cfscript>
		if( not (isdefined('attributes.company_id') and len(attributes.company_id)))
			comp_id='';
		else
			comp_id=attributes.company_id;
			
		if( not (isdefined('attributes.consumer_id') and len(attributes.consumer_id)))
			cons_id='';
		else
			cons_id=attributes.consumer_id;
			
		if( not (isdefined('attributes.employee_id') and len(attributes.employee_id)))
			emp_id='';
		else
			emp_id=attributes.employee_id;
			
		get_open_order_ships = get_extre.getCompenentFunction(company_id:comp_id,consumer_id:cons_id,employee_id:emp_id);
	</cfscript>
</cfif>
<cfif isdefined("attributes.employee_id_new") and len(attributes.employee_id_new)><cfset attributes.employee_id = attributes.employee_id_new><cfset attributes.company = attributes.employee_id_new><cfset member_type = 'employee'></cfif>
	<cfset dsn2 = "#dsn#_#session.pp.period_year#_#session.pp.our_company_id#">
    <cfquery name="GET_REMAINDER" datasource="#DSN2#">
        SELECT
            BORC,
            ALACAK,
            BAKIYE,
            ISNULL(BORC2,0) BORC2,
            ISNULL(ALACAK2,0) ALACAK2
        FROM
        <cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
            COMPANY_REMAINDER WITH (NOLOCK)
        <cfelseif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
            CONSUMER_REMAINDER WITH (NOLOCK)
        <cfelseif isdefined('attributes.employee_id') and len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
            EMPLOYEE_REMAINDER WITH (NOLOCK)
        </cfif>
        WHERE
        <cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
            COMPANY_REMAINDER.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.company_id#">
        </cfif>
        <cfif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
            CONSUMER_REMAINDER.CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.consumer_id#"> 
        </cfif>
        <cfif isdefined('attributes.employee_id') and len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
            EMPLOYEE_REMAINDER.EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.employee_id#"> 
        </cfif>
    </cfquery>
    <cfquery name="GET_REMAINDER_MONEY" datasource="#DSN2#">
        SELECT
            BORC3,
            ALACAK3,
            BAKIYE3,
            VADE_BORC3,
            VADE_ALACAK3,
            OTHER_MONEY
        FROM
        <cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
            COMPANY_REMAINDER_MONEY WITH (NOLOCK)
        <cfelseif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
            CONSUMER_REMAINDER_MONEY WITH (NOLOCK)
        <cfelseif isdefined('attributes.employee_id') and len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
            EMPLOYEE_REMAINDER_MONEY WITH (NOLOCK)
        </cfif>
        WHERE
        <cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
            COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.company_id#">
        </cfif>
        <cfif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
            CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.consumer_id#"> 
        </cfif>
        <cfif isdefined('attributes.employee_id') and len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
            EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.employee_id#">
        </cfif>
    </cfquery>
    <cfquery name="GET_PROJECT_REMAINDER" datasource="#DSN2#">
        SELECT
            BAKIYE3,
            BAKIYE2,
            BAKIYE,
            OTHER_MONEY,
            PROJECT_ID
        FROM
            <cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
                COMPANY_REMAINDER_MONEY_PROJECT WITH (NOLOCK)
            <cfelseif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
                CONSUMER_REMAINDER_MONEY_PROJECT WITH (NOLOCK)
            <cfelseif isdefined('attributes.employee_id') and len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
                EMPLOYEE_REMAINDER_MONEY_PROJECT WITH (NOLOCK)
            </cfif>
        WHERE
            <cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
                COMPANY_REMAINDER_MONEY_PROJECT.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.company_id#">
            </cfif>
            <cfif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
                CONSUMER_REMAINDER_MONEY_PROJECT.CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.consumer_id#">
            </cfif>
            <cfif isdefined('attributes.employee_id') and len(attributes.employee_id) and len(attributes.company) and member_type is 'employee'>
                EMPLOYEE_REMAINDER_MONEY_PROJECT.EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.employee_id#"> 
            </cfif>
    </cfquery>
	<cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
        <cfset member_id_ = "&company_id=#attributes.company_id#">
        <cfset member_type = 'partner'>
    <cfelseif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
        <cfset member_id_ = "&consumer_id=#attributes.consumer_id#">
        <cfset member_type = 'consumer'>
    <cfelse>
        <cfset member_id_ = "">
        <cfset member_type = 'employee'>
    </cfif>
    <cfset member_type_ = member_type>
    
<div class="pageContent">
	<div class="row">
                    <cfoutput>
                        	<cfif get_remainder.recordcount>
                                <div class="portlet box red">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            #getLang('main',454,'Borç Alacak Durumu')#
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="col-md-4">
                                                                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                                                                <h4 class="widget-thumb-heading">#getLang('main',175,'Borç')#</h4>
                                                                                <div class="widget-thumb-wrap">
                                                                                    <i class="widget-thumb-icon bg-red-mint fa fa-money"></i>
                                                                                    <div class="widget-thumb-body">
                                                                                        <div class="col-md-6 col-sm-12">
                                                                                            <span class="widget-thumb-subtitle" data-counter="counterup" data-value="#session_base.money#">(#session_base.money#)</span>
                                                                                            <span class="widget-thumb-body-stat">#TLFormat(ABS(get_remainder.borc))#</span>
                                                                                        </div>
                                                                                        <cfif len(session_base.money2)>
                                                                                            <div class="col-md-6 col-sm-12">
                                                                                                <span class="widget-thumb-subtitle" data-counter="counterup" data-value="#session_base.money2#">(#session_base.money2#)</span>
                                                                                                <span class="widget-thumb-body-stat">#TLFormat(ABS(get_remainder.borc2))#</span>
                                                                                            </div>
                                                                                        </cfif>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                        <div class="col-md-4">
                                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                                <h4 class="widget-thumb-heading">#getLang('main',176,'Alacak')#</h4>
                                                <div class="widget-thumb-wrap">
                                                    <i class="widget-thumb-icon bg-green-jungle fa fa-money"></i>
                                                    <div class="widget-thumb-body">
                                                        <div class="col-md-6 col-sm-12">
                                                            <span class="widget-thumb-subtitle" data-counter="counterup" data-value="#session_base.money#">(#session_base.money#)</span>
                                                            <span class="widget-thumb-body-stat">#TLFormat(ABS(get_remainder.alacak))#</span>
                                                        </div>
                                                        <cfif len(session_base.money2)>
                                                            <div class="col-md-6 col-sm-12">
                                                                <span class="widget-thumb-subtitle" data-counter="counterup" data-value="#session_base.money2#">(#session_base.money2#)</span>
                                                                <span class="widget-thumb-body-stat">#TLFormat(ABS(get_remainder.alacak2))#</span>
                                                            </div>
                                                        </cfif>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                                <h4 class="widget-thumb-heading">#getLang('main',177,'Bakiye')#</h4>
                                                <div class="widget-thumb-wrap">
                                                    <i class="widget-thumb-icon bg-yellow-gold fa fa-money"></i>
                                                    <div class="widget-thumb-body">
                                                        <div class="col-md-6 col-sm-12">
                                                            <span class="widget-thumb-subtitle" data-counter="counterup" data-value="#session_base.money#">(#session_base.money#)</span>
                                                            <span class="widget-thumb-body-stat">#TLFormat(get_remainder.bakiye)# <cfif get_remainder.borc gte get_remainder.alacak>(B)<cfelse>(A)</cfif></span>
                                                        </div>
                                                        <cfif len(session_base.money2)>
                                                            <div class="col-md-6 col-sm-12">
                                                                <span class="widget-thumb-subtitle" data-counter="counterup" data-value="#session_base.money2#">(#session_base.money2#)</span>
                                                                <span class="widget-thumb-body-stat">#TLFormat((ABS(get_remainder.borc2))-(ABS(get_remainder.alacak2)))# <cfif get_remainder.borc2 gte get_remainder.alacak2>(B)<cfelse>(A)</cfif></span>
                                                            </div>
                                                        </cfif>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </cfif>
        <!---            </cf_area>--->
                    <!---<cf_area>--->
                        <table>
                            <cfif get_remainder_money.recordcount>
                                <tr>
                                    <td class="txtbold" colspan="3"><u>#getLang('main',508,'Döviz Bakiyeleri')#</u></td>
                                </tr>
                                <tr>
                                    <td width="210">&nbsp;</td>
                                    <td style="text-align:right;" width="100" class="txtbold">#getLang('main',670,'Adet')#</td>
                                    <td style="text-align:right;" width="120" class="txtbold">#getLang('main',456,'Döviz Bakiye')#</td>
                                </tr>
                                <cfloop query="get_remainder_money">
                                    <tr>
                                        <td width="80">#other_money#</td>
                                        <td style="text-align:right;"><cfif abs(borc3) neq 0 or abs(alacak3) neq 0>#TLFormat(((abs(vade_borc3) * abs(borc3)) + (abs(vade_alacak3) * abs(alacak3)))/(abs(borc3)+abs(alacak3)),0)#</cfif></td>
                                        <td style="text-align:right;" nowrap="nowrap">#TLFormat(abs(bakiye3))#&nbsp;#other_money# <cfif borc3 gte alacak3>(B)<cfelse>(A)</cfif></td>
                                    </tr>
                                </cfloop>
                            </cfif>
                         </table>
                    </cfoutput>
        <!---            </cf_area>--->
                </div>
            </tr>
        </table>
    </div>
</div>
<!---
<cfif not(isdefined('attributes.employee_id') and len(attributes.employee_id) and isdefined('attributes.company') and len(attributes.company) and member_type is 'employee')>	
	<cfquery name="GET_COMPANY_RISK" datasource="#DSN2#">
		SELECT 
			BAKIYE,
			ISNULL(BAKIYE2,0) BAKIYE2,
			CEK_ODENMEDI,
			CEK_ODENMEDI2,
			CEK_KARSILIKSIZ,
			CEK_KARSILIKSIZ2,
			SENET_ODENMEDI,
			SENET_ODENMEDI2,
			SENET_KARSILIKSIZ,
			SENET_KARSILIKSIZ2,
			ISNULL(FORWARD_SALE_LIMIT,0) FORWARD_SALE_LIMIT,
			ISNULL(OPEN_ACCOUNT_RISK_LIMIT,0) OPEN_ACCOUNT_RISK_LIMIT,
			PAYMENT_BLOKAJ,
			ISNULL(TOTAL_RISK_LIMIT,0) TOTAL_RISK_LIMIT,
			SECURE_TOTAL_TAKE,
			SECURE_TOTAL_TAKE2,
			SECURE_TOTAL_GIVE,
			SECURE_TOTAL_GIVE2,
		<cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
			COMPANY_ID
		<cfelseif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
			CONSUMER_ID
		</cfif>
		FROM 
		<cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
			COMPANY_RISK WITH (NOLOCK)
		<cfelseif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
			CONSUMER_RISK WITH (NOLOCK)
		</cfif>
		WHERE 
		<cfif (isdefined('attributes.company_id') and len(attributes.company_id) and len(attributes.company) and member_type is 'partner') or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 1)>
			COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.company_id#">
		<cfelseif (isdefined('attributes.consumer_id') and len(attributes.consumer_id) and len(attributes.company) and member_type is 'consumer')or (isdefined("attributes.member_cat_type") and len(attributes.member_cat_type) and listfirst(attributes.member_cat_type,'-') eq 2)>
			CONSUMER_ID =<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.consumer_id#">
		</cfif>
	</cfquery>
	<cfif len(session_base.money2)>
		<cfquery name="GET_MONEY_INFO" datasource="#DSN2#">
			SELECT (RATE2/RATE1) RATE FROM SETUP_MONEY WITH (NOLOCK) WHERE MONEY = '#session_base.money2#'
		</cfquery>
	</cfif>
	<cfset order_amount = 0>
	<cfset ship_amount = 0>
	<cfset order_amount2 = 0>
	<cfset ship_amount2 = 0>
	<cfif isdefined("get_open_order_ships") and get_open_order_ships.recordcount and len(get_open_order_ships.order_total)>
		<cfset order_amount = get_open_order_ships.order_total>
		<cfif len(session_base.money2) and len(get_open_order_ships.order_total2)>
			<cfset order_amount2 = get_open_order_ships.order_total2>
		</cfif>
	</cfif>
	<cfif isdefined("get_open_order_ships") and get_open_order_ships.recordcount and len(get_open_order_ships.ship_total)>
		<cfset ship_amount = get_open_order_ships.ship_total>
		<cfif len(session_base.money2) and len(get_open_order_ships.ship_total2)>
			<cfset ship_amount2 = get_open_order_ships.ship_total2>
		</cfif>
	</cfif>
	<cfoutput>
		<cfif get_company_risk.recordcount>
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td width="450">
                        <table>
                            <tr>
                                <td class="txtbold" colspan="3"><u><cf_get_lang_main no='457.Risk Durumu'></u></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td style="text-align:right;" class="txtbold">(#session_base.money#)</td>
                                <td style="text-align:right;" class="txtbold"><cfif len(session_base.money2)>(#session_base.money2#)</cfif></td>
                            </tr>
                            <cfset start_date = date_add('d',1,now())>
                            <tr>
                                <td width="210"><cf_get_lang_main no='1565.Ödenmemiş Çek'></td>
                                <cfif isdefined('session.ep.user_level') and listgetat(session.ep.user_level, 21) and structkeyexists(fusebox.circuits,"cheque")>
                                    <td nowrap="nowrap" style="text-align:right;" width="100"><cfif isdefined('session.ep')><a href="#request.self#?fuseaction=cheque.list_cheques&is_form_submitted=1&member_type=#member_type#&company=#URLEncodedFormat(attributes.company)#<cfif len(member_id_)>#member_id_#</cfif><!--- &start_date=#dateformat(start_date,'dd/mm/yyyy')# --->&status=1,2,4,13" target="_blank"><font color="FF0000"></cfif>#TLFormat(get_company_risk.cek_odenmedi)#</font></a></td>
                                    <td nowrap="nowrap" style="text-align:right;" width="120"><cfif isdefined('session.ep')><a href="#request.self#?fuseaction=cheque.list_cheques&is_form_submitted=1&member_type=#member_type#&company=#URLEncodedFormat(attributes.company)#<cfif len(member_id_)>#member_id_#</cfif><!--- &start_date=#dateformat(start_date,'dd/mm/yyyy')# --->&status=1,2,4,13" target="_blank"><font color="FF0000"></cfif><cfif len(session_base.money2)>#TLFormat(get_company_risk.cek_odenmedi2)#</cfif></font></a></td>
                                <cfelse>
                                    <td nowrap="nowrap" style="text-align:right;" width="100">#TLFormat(get_company_risk.cek_odenmedi)#</td>
                                    <td nowrap="nowrap" style="text-align:right;" width="120"><cfif len(session_base.money2)>#TLFormat(get_company_risk.cek_odenmedi2)#</cfif></td>
                                </cfif>
                            </tr>
                            <tr>
                                <td width="150"><cf_get_lang_main no='1566.Ödenmemiş Senet'></td>
                                <cfif isdefined('session.ep.user_level') and listgetat(session.ep.user_level, 21) and structkeyexists(fusebox.circuits,"cheque")>
                                <td nowrap="nowrap" style="text-align:right;"><cfif isdefined('session.ep')><a href="#request.self#?fuseaction=cheque.list_vouchers&is_form_submitted=1&member_type=#member_type#&company=#URLEncodedFormat(attributes.company)#<cfif Len(member_id_)>#member_id_#</cfif><!--- &due_start_date=#dateformat(start_date,'dd/mm/yyyy')# --->&status=1,2,4,13" target="_blank"><font color="FF0000"></cfif>#TLFormat(get_company_risk.senet_odenmedi)#</font></a></td>
                                <td nowrap="nowrap" style="text-align:right;"><cfif isdefined('session.ep')><a href="#request.self#?fuseaction=cheque.list_vouchers&is_form_submitted=1&member_type=#member_type#&company=#URLEncodedFormat(attributes.company)#<cfif Len(member_id_)>#member_id_#</cfif><!--- &due_start_date=#dateformat(start_date,'dd/mm/yyyy')# --->&status=1,2,4,13" target="_blank"><font color="FF0000"></cfif><cfif len(session_base.money2)>#TLFormat(get_company_risk.senet_odenmedi2)#</cfif></font></a></td>
                                <cfelse>
                                <td nowrap="nowrap" style="text-align:right;">#TLFormat(get_company_risk.senet_odenmedi)#</td>
                                <td nowrap="nowrap" style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(get_company_risk.senet_odenmedi2)#</cfif></td>
                                </cfif>
                            </tr>
                            <tr>
                                <td><cf_get_lang_main no='1567.Karşılıksız Çek'></td>
                                <cfif isdefined('session.ep.user_level') and listgetat(session.ep.user_level, 21) and structkeyexists(fusebox.circuits,"cheque")>
                                <td style="text-align:right;"><cfif isdefined('session.ep')><a href="#request.self#?fuseaction=cheque.list_cheques&is_form_submitted=1&member_type=#member_type#&company=#URLEncodedFormat(attributes.company)#<cfif Len(member_id_)>#member_id_#</cfif>&status=5" target="_blank"><font color="FF0000"></cfif>#TLFormat(get_company_risk.cek_karsiliksiz)#</font></a></td>
                                <td style="text-align:right;"><cfif isdefined('session.ep')><a href="#request.self#?fuseaction=cheque.list_cheques&is_form_submitted=1&member_type=#member_type#&company=#URLEncodedFormat(attributes.company)#<cfif Len(member_id_)>#member_id_#</cfif>&status=5" target="_blank"><font color="FF0000"></cfif><cfif len(session_base.money2)>#TLFormat(get_company_risk.cek_karsiliksiz2)#</cfif></font></a></td>
                                <cfelse>
                                <td style="text-align:right;">#TLFormat(get_company_risk.cek_karsiliksiz)#</td>
                                <td style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(get_company_risk.cek_karsiliksiz2)#</cfif></td>
                                </cfif>
                            </tr>
                            <tr>
                                <td><cf_get_lang_main no='1568.Karşılıksız Senet'></td>
                                <cfif isdefined('session.ep.user_level') and listgetat(session.ep.user_level, 21) and structkeyexists(fusebox.circuits,"cheque")>
                                <td style="text-align:right;"><cfif isdefined('session.ep')><a href="#request.self#?fuseaction=cheque.list_vouchers&is_form_submitted=1&member_type=#member_type#&company=#URLEncodedFormat(attributes.company)#<cfif Len(member_id_)>#member_id_#</cfif>&status=5" target="_blank"><font color="FF0000"></cfif>#TLFormat(get_company_risk.senet_karsiliksiz)#</font></a></td>
                                <td style="text-align:right;"><cfif isdefined('session.ep')><a href="#request.self#?fuseaction=cheque.list_vouchers&is_form_submitted=1&member_type=#member_type#&company=#URLEncodedFormat(attributes.company)#<cfif Len(member_id_)>#member_id_#</cfif>&status=5" target="_blank"><font color="FF0000"></cfif><cfif len(session_base.money2)>#TLFormat(get_company_risk.senet_karsiliksiz2)#</cfif></font></a></td>
                                <cfelse>
                                <td style="text-align:right;">#TLFormat(get_company_risk.senet_karsiliksiz)#</td>
                                <td style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(get_company_risk.senet_karsiliksiz2)#</cfif></td>
                                </cfif>
                            </tr>
                            <tr>
                                <td><cf_get_lang_main no='1210.Açık Siparişler'></td>
                                <td style="text-align:right;">#TLFormat(order_amount)#</td>
                                <td style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(order_amount2)#</cfif></td>
                            </tr>
                            <tr>
                                <td><cf_get_lang_main no='1543.Faturalanmamış İrsaliyeler'></td>
                                <td style="text-align:right;">#TLFormat(ship_amount)#</td>
                                <td style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(ship_amount2)#</cfif></td>
                            </tr>
                            <tr>
                                <td><cf_get_lang_main no='460.Toplam Risk'></td>
                                <td style="text-align:right;">#TLFormat(get_company_risk.bakiye + ship_amount + order_amount + (get_company_risk.cek_odenmedi + get_company_risk.senet_odenmedi + get_company_risk.cek_karsiliksiz + get_company_risk.senet_karsiliksiz))#</td>
                                <td style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(get_company_risk.bakiye2 + ship_amount2 + order_amount2 + get_company_risk.cek_odenmedi2 + get_company_risk.senet_odenmedi2 + get_company_risk.cek_karsiliksiz2 + get_company_risk.senet_karsiliksiz2)#</cfif></td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap"><cf_get_lang_main no='461.Toplam Teminat(Alınan-Verilen)'></td>
                                <td style="text-align:right;"><cfif isdefined('session.ep')><a href="javascript://" onClick="windowopen('#request.self#?fuseaction=member.popup_list_securefund<cfif Len(member_id_)>#member_id_#</cfif>','list');">
                                <font color="FF0000"></cfif>#TLFormat(wrk_round(get_company_risk.secure_total_take-get_company_risk.secure_total_give))#</font></a></td>
                                <td style="text-align:right;"><cfif isdefined('session.ep')><a href="javascript://" onClick="windowopen('#request.self#?fuseaction=member.popup_list_securefund<cfif Len(member_id_)>#member_id_#</cfif>','list');">
                                <font color="FF0000"></cfif><cfif len(session_base.money2)>#TLFormat(get_company_risk.secure_total_take2-get_company_risk.secure_total_give2)#</cfif></font></a></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                       	<cf_area>
                            <table>
                                <tr>
                                    <td class="txtbold" colspan="3"><u><cf_get_lang_main no='462.Limit Durumu'></u></td>
                                </tr>
                                <tr>
                                    <td width="210"></td>
                                    <td height="20" style="text-align:right;" width="100" class="txtbold">(#session_base.money#)</td>
                                    <td style="text-align:right;" width="120" class="txtbold"><cfif len(session_base.money2)>(#session_base.money2#)</cfif></td>
                                </tr>
                                <tr>
                                    <td width="150"><cf_get_lang_main no='463.Açık Hesap Limiti'></td>
                                    <td nowrap="nowrap" style="text-align:right;">#TLFormat(get_company_risk.open_account_risk_limit)#</td>
                                    <td nowrap="nowrap" style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(get_company_risk.open_account_risk_limit/get_money_info.rate)#</cfif></td>
                                </tr>
                                <tr>
                                    <td><cf_get_lang_main no='464.Çek Senet Limiti'></td>
                                    <td style="text-align:right;">#TLFormat(get_company_risk.forward_sale_limit)#</td>
                                    <td style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(get_company_risk.forward_sale_limit/get_money_info.rate)#</cfif></td>
                                </tr>
                                <tr>
                                    <td><cf_get_lang_main no='465.Toplam Limit'></td>
                                    <td style="text-align:right;">#TLFormat(get_company_risk.total_risk_limit)#</td>
                                    <td style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(get_company_risk.total_risk_limit/get_money_info.rate)#</cfif></td>
                                </tr>
                                <tr>
                                    <td><cf_get_lang_main no='466.Kullanılabilir Limit'></td>
                                    <cfif len(session_base.money2)><cfset other_total_limit = get_company_risk.total_risk_limit/get_money_info.rate></cfif>
                                    <td style="text-align:right;">#TLFormat(get_company_risk.total_risk_limit - order_amount - ship_amount - (get_company_risk.bakiye  + (get_company_risk.cek_odenmedi + get_company_risk.senet_odenmedi + get_company_risk.cek_karsiliksiz + get_company_risk.senet_karsiliksiz)))#</td>
                                    <td style="text-align:right;"><cfif len(session_base.money2)>#TLFormat(other_total_limit - order_amount2 - ship_amount2 - (get_company_risk.bakiye2  + get_company_risk.cek_odenmedi2 + get_company_risk.senet_odenmedi2 + get_company_risk.cek_karsiliksiz2 + get_company_risk.senet_karsiliksiz2))#</cfif></td>
                                </tr>
                            </table>
                         </cf_area>
                    </td>
                </tr>
            </table>
        </cfif>
	</cfoutput>
	<cfif (isdefined("session.ep") and session.ep.our_company_info.project_followup and get_project_remainder.recordcount) or not isdefined("session.ep")>
		<cfset project_list=''>
		<cfoutput query="get_project_remainder">
			 <cfif len(project_id) and not listfind(project_list,project_id)>
				<cfset project_list=listappend(project_list,project_id)>
			 </cfif>
		</cfoutput> 
		<cfif listlen(project_list)>
			<cfset project_list=listsort(project_list,"numeric","ASC",',')>
			<cfquery name="GET_PROJECT" datasource="#DSN#">
				SELECT
					PROJECT_ID,
					PROJECT_HEAD
				FROM 
					PRO_PROJECTS  WITH (NOLOCK)
				WHERE
					PROJECT_ID IN (#project_list#)
				ORDER BY
					PROJECT_ID
			</cfquery>
			<cfset main_project_list = listsort(listdeleteduplicates(valuelist(get_project.project_id,',')),'numeric','ASC',',')>
		</cfif>
        <br />
        <table>
            <tr>
                <td class="txtbold" colspan="4"><u><cf_get_lang_main no='4.Proje'><cf_get_lang_main no='454.Borç Alacak Durumu'></u></td>
            </tr>
            <tr>
                <td width="210"><cf_get_lang_main no='4.Proje'></td>
                <td style="text-align:right;" width="100" class="txtbold"><cfoutput>#session_base.money#</cfoutput> <cf_get_lang_main no='177.Bakiye'></td>
                <cfif len(session_base.money2)><td style="text-align:right;" width="120" class="txtbold"><cfoutput>#session_base.money2#</cfoutput> <cf_get_lang_main no='177.Bakiye'></td></cfif>
                <td style="text-align:right;" nowrap="nowrap" class="txtbold"><cf_get_lang_main no='709.İşlem Dövizi'><cf_get_lang_main no='177.Bakiye'></td>
            </tr>
            <cfoutput query="get_project_remainder">
            <tr>
                <td> 
                    <cfif len(project_id) and len(project_list)>
                        #get_project.project_head[listfind(main_project_list,project_id,',')]#
                    <cfelse>
                        <cf_get_lang_main no ='1047.Projesiz'>
                    </cfif>
                </td>
                <td nowrap="nowrap" style="text-align:right;">#TLFormat(bakiye)#</td>
                <cfif len(session_base.money2)><td nowrap="nowrap" style="text-align:right;">#TLFormat(bakiye2)#</td></cfif>
                <td nowrap="nowrap" style="text-align:right;">#TLFormat(bakiye3)# #other_money# <cfif bakiye3 gt 0>(B)<cfelse>(A)</cfif></td>
            </tr>
            </cfoutput>	
        </table>
	<cfelse>
		 <table>
			<tr>
				<td colspan="3"><cf_get_lang_main no="72.Kayıt Yok">!</td>
			</tr>
		</table>
	</cfif>
</cfif>
--->