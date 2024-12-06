
<style>
.input-group-btn>.btn+.btn {
    margin-left: -1px;
}
.input-group .form-control:last-child, .input-group-addon:last-child, .input-group-btn:first-child>.btn-group:not(:first-child)>.btn, .input-group-btn:first-child>.btn:not(:first-child), .input-group-btn:last-child>.btn, .input-group-btn:last-child>.btn-group>.btn, .input-group-btn:last-child>.dropdown-toggle {
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}
.input-group-btn>.btn {
    position: relative;
}
.btn {
    outline: none !important;
    box-shadow: none !important;
}
.btn-info {
    color: #fff;
    background-color: #5bc0de;
    border-color: #46b8da;
}
.btn {
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
}
.form-control {
    outline: none !important;
    box-shadow: none !important;
}
.form-control {
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
div, svg, input, select, textarea, span, img, table, label, td, th, p, a, button, ul, code, pre, li {
    -webkit-border-radius: 0 !important;
    -moz-border-radius: 0 !important;
    border-radius: 0 !important;
}
button, input, select, textarea {
    font-family: inherit;
    font-size: inherit;
    line-height: inherit;
}
button, select {
    text-transform: none;
}
button, input, optgroup, select, textarea {
    margin: 0;
    font: inherit;
    color: inherit;
}

body{
  font-family:arial
}
</style>
<div class="pageContent">
          <div class="portlet-title">
            <div class="caption">
                <h3>Belge Yükle<h3>
            </div>
            </div>
<cfform method="post" enctype="multipart/form-data" action="#request.self#?pageinfo=#attributes.pageinfo#&service_id=#attributes.service_id#">
<table style="width:90%">
<tr><td style="width:25%">Belge Kategorisi</td><td>
<cfquery name="getContent" datasource="#dsn#">
select  CONTENT_PROPERTY_ID,NAME from CONTENT_PROPERTY
</cfquery>
<select class="form-control" name="PROPERTY_ID">
<cfoutput query="getContent">
<option value="#CONTENT_PROPERTY_ID#">#NAME#</option>
</cfoutput>
</select>
</td></tr>
<tr><td >Dosya Adı</td><td><input class="form-control" type="text" name="ASSET_NAME"></td></tr>
<tr><td colspan="2">Açıklama</td></tr>
<tr><td colspan="2"><textarea style="resize: none;" class="form-control" name="ASSET_DESCRIPTION"></textarea></td></tr>
</table>
<input type="file" name="FileContents">
<input class="btn btn-info" type="submit">
<input type="hidden" name="issub" value="1">
</cfform>
<cfif isDefined("attributes.issub")>

<cfoutput>                    
<cfset emre= CreateUUID()>
<cfdump  var="#emre#">
</cfoutput>
 <cfif isDefined("Form.FileContents") > 
  <cffile action = "upload" fileField = "FileContents" destination = "#expandPath("../WORKCUBE_DOSYA/LIVE/Documents/service")#" nameConflict = "Overwrite" result="aaaa">
  </cfif>

  <cffile action="rename" source="#aaaa.SERVERDIRECTORY#/#aaaa.CLIENTFILE#" destination="#aaaa.SERVERDIRECTORY#/#emre#.#aaaa.CLIENTFILEEXT#" result="nbbb">

<cfquery name="INSERT_ASSET" datasource="#DSN#">
                	INSERT INTO ASSET
                    	(
                        	MODULE_NAME,                          
                            IS_ACTIVE,
                            ACTION_ID,
                            ACTION_SECTION,
                            RECORD_DATE,
                            ASSET_NAME,
                            ASSET_FILE_NAME,
                            RECORD_PAR,
                            ASSETCAT_ID,
                            PROPERTY_ID,
                            ASSET_DESCRIPTION,
                            ASSET_DETAIL,
                            COMPANY_ID,
                            ASSET_FILE_SERVER_ID,
                            MODULE_ID
                        )
                    VALUES
                    	(
                        	<cfqueryparam cfsqltype="cf_sql_varchar" value="call">,
                            1,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.service_id#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="G_SERVICE_ID">,
                            #now()#,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.ASSET_NAME#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#emre#.#aaaa.CLIENTFILEEXT#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="-5">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.property_id#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.ASSET_DESCRIPTION#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="7">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="27">
                        )
                </cfquery>
                <script>
                window.opener.location.reload();
                window.self.close();
                </script>
</cfif>
</div> 

