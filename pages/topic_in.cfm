
<cfparam  name="attributes.sendrepply"default="0">
<cfif attributes.sendrepply eq 0>
                <cfquery name="UPD_TOPIC_LAST_REPLY_DATE" datasource="#dsn#">
                    UPDATE
                        FORUM_TOPIC
                    SET
                        VIEW_COUNT = VIEW_COUNT + 1
                    WHERE
                    TOPICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.TOPICID#">
                </cfquery>
               
</cfif>
<cfquery name="gettopicname" datasource="#dsn#" >
Select TOPIC FROM FORUM_TOPIC WHERE TOPICID=#attributes.TOPICID#

</cfquery>
<div class="container-fluid w3Body">
    <div Class="pageContent">
      <div class="jumbotron" style="
    padding-top: 10px;
">
        <div><a href="index.cfm?pageinfo=test_site"><i class="icons8-left-round"></i>Forum Ana Sayfası</a></div>
        <p><span class="text-warning">Q</span><cfoutput>#replace(REPLACE(gettopicname.TOPIC,"<p>",""),"</p>","")#</cfoutput></P>
            <cfquery name="searcTopicin" datasource="#dsn#">
SELECT REPLY,REPLYID
	,RECORD_DATE
	,(
		SELECT EMPLOYEE_NAME + ' ' + EMPLOYEE_SURNAME + ' $Partner Bilgisayar'
		FROM w3Partner.EMPLOYEES
		WHERE EMPLOYEE_ID = FR.RECORD_EMP
		) AS RECEMP
	,(
		SELECT COMPANY_PARTNER_NAME + ' ' + COMPANY_PARTNER_SURNAME + ' ' + C.NICKNAME
		FROM w3Partner.COMPANY_PARTNER AS CP
			,w3Partner.COMPANY AS C
		WHERE CP.PARTNER_ID = FR.RECORD_PAR
			AND C.COMPANY_ID = CP.COMPANY_ID
		) AS RECEPARR
FROM w3Partner.FORUM_REPLYS AS FR
WHERE TOPICID = #attributes.topicid#
            </cfquery>
            <div style="height:30rem;  overflow: auto;">
            <div class="list-group">
                <cfoutput query="searcTopicin">
                <a  class="list-group-item list-group-item-action flex-column align-items-start">
                <div id="rep_#REPLYID#"  class="d-flex w-100 justify-content-between">
                <h4 class="mb-1 ">#replace(REPLACE(REPLY,"<p>",""),"</p>","")#</h4>
                <small><b>Kayıt Tarih: </b> #dateformat(RECORD_DATE,"dd/mm/yyyy")# <b> Kaydeden:</b> <cfif len(RECEMP)> #listGetAt(RECEMP, 1,'$')# <span class="text-danger">#listGetAt(RECEMP, 2,'$')#</span>  <cfelse>#RECEPARR#</cfif>

                </small>     
                </div>
                </a>
                </cfoutput>
                </div>

           
        </div>
            </div>
            <div class="portlet light bordered">
    <div class="portlet-title tabbable-line">
        <ul class="nav nav-tabs lgTabNav pull-left">					
            <li class="active">
                <a> Yant Ekle </a>
            </li>		
        </ul>		
    </div>
    <div class="portlet-body" id="chats">
        <div class="slimScrollDiv" style="position: relative;overflow: auto;width: auto;max-height: 525px;">
        </div>
        <div class="chat-form">
            <div class="input-cont">
            <form method="post" action="index.cfm?pageinfo=TopicIn">
                <textarea class="form-control" type="text" id="plus_content" name="plus_content" placeholder="Mesajınızı yazınız..."></textarea> 
                       <cfoutput>      <input type="hidden" name="topicid" value="#attributes.topicid#">
                       <input type="hidden" name="FORUMID" value="#attributes.FORUMID#">
                <input type="hidden" name="sendrepply" value="1"> </cfoutput>
            </div>
            <div class="btn-cont">
                <span class="arrow"> </span>
               
                <button class="btn blue icn-only" type="submit">
                    <i class="fa fa-check icon-white"></i>
                </button>

              
               
  </form>
            </div>          
        </div>
    </div>
</div>
        </div>
        
        
    </div>
</div>

<cfif attributes.sendrepply eq 1>
     
        
<cftransaction>
                <cfquery name="ADD_REPLY" datasource="#variables.dsn#" result="MAX_ID">
                    INSERT INTO 
                        FORUM_REPLYS 
                        (
                            TOPICID,                            
                            REPLY,
                            VERIFIED,
                            SPECIAL_DEFINITION_ID,
                            IS_ACTIVE,
                            RECORD_DATE,
                            RECORD_IP,
                            RECORD_PAR,
                            UPDATE_DATE,
                            UPDATE_IP,
                            UPDATE_PAR
                        )
                        VALUES  
                        (
                            #attributes.topicid#,
                           
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.plus_content#">,
                            0,
                            <!---<cfif isDefined('arguments.special_definition') and len(arguments.special_definition)>#arguments.special_definition#<cfelse>NULL</cfif>--->NULL,
                            1,
                            #now()#,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
                            #session.pp.userid#,
                            #now()#,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
                            #session.pp.userid#
                        )
                </cfquery>
                          <cfquery name="UPD_" datasource="#dsn#">
                    UPDATE
                        FORUM_REPLYS
                    SET
                        <cfif isdefined("arguments.first_hie") and len(arguments.first_hie)>
                            HIERARCHY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_hie#.#max_id.identitycol#">,
                            MAIN_HIERARCHY = #listfirst(arguments.first_hie,'.')#
                        <cfelse>
                            HIERARCHY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#max_id.identitycol#">,
                            MAIN_HIERARCHY = #max_id.identitycol#
                        </cfif>
                    WHERE
                        REPLYID = <cfqueryparam cfsqltype="cf_sql_integer" value="#max_id.identitycol#">
                </cfquery>              
                <!--- listede varsa çıkar --->
                <cfquery name="UPD_FORUM_LAST_MSG_DATE" datasource="#dsn#">
                    UPDATE
                        FORUM_MAIN
                    SET
                        LAST_MSG_DATE = #now()#,
                        LAST_MSG_USERKEY = 'CP-#session.pp.userid#',
                        REPLY_COUNT = REPLY_COUNT + 1
                    WHERE
                        FORUMID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.FORUMID#">
                </cfquery>
                <cfquery name="UPD_TOPIC_LAST_REPLY_DATE" datasource="#dsn#">
                    UPDATE
                        FORUM_TOPIC
                    SET
                        LAST_REPLY_DATE = #now()#,
                        LAST_REPLY_USERKEY = 'CP-#session.pp.userid#',
                        REPLY_COUNT = REPLY_COUNT + 1
                    WHERE
                        TOPICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.TOPICID#">
                </cfquery>
               
            
            </cftransaction>
</cfif>            