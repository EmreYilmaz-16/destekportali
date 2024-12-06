<cfparam  name="attributes.is_submit" default="0">
<div class="container-fluid w3Body">
    <div Class="pageContent">
    <form id="TopicForm" method="POST" >
        <input name="topic" type="text" class="form-control" placeholder="Tartışma Başlığı">
        <br>
        Açıklama
        <br>
        <textarea name="plus_content" rows="10" class="form-control"></textarea>
        <br>
        <div style="text-align:right !important;"><button class="btn btn-success">
        Konu Oluştur
        </button></div>
        <input type="hidden" value="1" name="is_submit">
        <input type="hidden" value="<cfoutput>#attributes.FORUMID#</cfoutput>" name="FORUMID">
    </form>
    </div>
</div>


<cfif attributes.is_submit eq 1>

    <cftransaction>
        <cfquery name="ADD_TOPIC" datasource="#dsn#" result="MAX_ID_TOPIC">
            INSERT INTO 
            FORUM_TOPIC 
                (
                    USERKEY,
                    <!---IMAGEID,--->
                    TOPIC,
                    VERIFIED,
                    LOCKED,
                    FORUMID,
                    TOPIC_STATUS,
                    EMAIL_EMPS,
                    RECORD_DATE,
                    RECORD_PAR,
                    RECORD_IP,
                    UPDATE_DATE,
                    UPDATE_PAR,
                    UPDATE_IP   
                )
            VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="CP-#SESSION.PP.USERID#">,
                    <!---#IMAGEID#,--->
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.topic#">,
                    1,
                    1,
                    #attributes.FORUMID#,
                    1,
                    0,
                    #now()#,
                    #SESSION.PP.USERID#,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
                    #now()#,
                    #SESSION.PP.USERID#,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">
                )						
            </cfquery>
            <cfquery name="UPD_FORUM_LAST_MSG_DATE" datasource="#dsn#">
            UPDATE
            FORUM_MAIN
            SET
            LAST_MSG_DATE = #now()#,
            LAST_MSG_USERKEY = <cfqueryparam cfsqltype="cf_sql_varchar" value="CP-#SESSION.pp.USERID#">,
            TOPIC_COUNT = TOPIC_COUNT+1
            WHERE
            FORUMID = #attributes.FORUMID#
        </cfquery>
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
                            #MAX_ID_TOPIC.identitycol#,
                           
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
                        TOPICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#MAX_ID_TOPIC.identitycol#">
                </cfquery>

    </cftransaction>         
<script>window.location.href="<cfoutput>index.cfm?pageinfo=TopicIn&FORUMID=#attributes.FORUMID#&topicid=#MAX_ID_TOPIC.identitycol#</cfoutput>"  </script>
</cfif>