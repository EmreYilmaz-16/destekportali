<!--- bu sayfada unicodelar icin sql_unicode fonksiyonu kullanildi --->
<cflock name="#CreateUUID()#" timeout="60">
	<cftransaction>			
	<cfquery name="ADD_COMMENT" datasource="#dsn#">
		INSERT INTO CONTENT_COMMENT 
						(
							CONTENT_ID,
							CONTENT_COMMENT,
							CONTENT_COMMENT_POINT,
							<cfif isdefined("session.pp.userid")>
							PARTNER_ID,
							</cfif>
							<cfif 1 eq 0>
							CONSUMER_ID,
							</cfif>
							<cfif not isdefined("session.ww.userkey")>
							GUEST,
							</cfif>							
							NAME,
							SURNAME,
							STAGE_ID,
							MAIL_ADDRESS,						
							RECORD_DATE,
							RECORD_IP,
							EMP_ID
						)
					VALUES
						(
							#attributes.CONTENT_ID#,
							'#attributes.CONTENT_COMMENT#',
							#attributes.CONTENT_COMMENT_POINT#,
							<cfif isdefined("session.pp.userid")>
							#session.pp.userid#,
							</cfif>
							<cfif isdefined("session.ww.userkey") and session.ww.userkey contains 'C'>
							#session.ww.userid#,
							</cfif>
							<cfif not isdefined("session.ww.userkey")>
							1,
							</cfif>							
							'#attributes.NAME#',
							'#attributes.SURNAME#',
							-2,				
							'#attributes.MAIL_ADDRESS#',				
							#NOW()#,
							'#CGI.REMOTE_ADDR#',
							NULL
						)
		</cfquery>
		<!--- Mail list kayıt --->
		<cfquery name="GET_MAIL" datasource="#dsn#">
			SELECT MAILLIST_EMAIL FROM MAILLIST WHERE MAILLIST_EMAIL = '#attributes.MAIL_ADDRESS#'
		</cfquery>
		<cfif NOT GET_MAIL.RECORDCOUNT>
		<cfquery name="ADD_MAIL" datasource="#dsn#">
			INSERT INTO MAILLIST 
					   (
							MAILLIST_NAME,
							MAILLIST_SURNAME,
							MAILLIST_EMAIL,
							RECORD_DATE,
							MAILLIST_CAT_ID
						)
					VALUES
						(
							'#attributes.NAME#',
							'#attributes.SURNAME#',
							'#attributes.MAIL_ADDRESS#',				
							#NOW()#,
							-1
						)
		</cfquery>		
		</cfif>
	</cftransaction>
</cflock>
<!--- Mail list kayıt --->
<script type="text/javascript">
	window.location.href = '<cfoutput>#request.self#?pageinfo=ContentDetail&cntid=#attributes.CONTENT_ID#</cfoutput>';
</script>