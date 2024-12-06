<style>
.mt-element-list .list-news.ext-2.mt-list-container ul > .mt-list-item > .list-item-content > h3 {
    font-size: 14px;
}
.jumbotron p {
    margin-bottom: 15px;
    font-size:14px;
    font-weight: 200;
}.img-circle {
    border-radius: 50% !important;
}
img {
    vertical-align: middle;
}
img {
    border: 0;
}
</style>
<cfquery name="getLeftContent" datasource="#dsn#">
SELECT CONT_BODY
  FROM CONTENT

  where CONTENT_STATUS=1
  and CHAPTER_ID=3
  and INTERNET_VIEW =1
</cfquery>
<cfset dateformat_style="dd/mm/yyyy">
	<cfsetting showdebugoutput="no">
	<cfinclude template="get_homepage_news.cfm">
	<cfif 1 eq 1>
		<cfquery name="GET_CONT_IMAGES" datasource="#dsn#">
			SELECT CONTENT_ID,IMAGE_SERVER_ID,CONTIMAGE_SMALL,IMAGE_SIZE,UPDATE_DATE FROM CONTENT_IMAGE
		</cfquery>
	</cfif>

<div style="max-height:400px;
        overflow:auto;">         
	<cfif get_homepage_news.recordcount>
        <div class="mt-element-list">                                        
            <div class="mt-list-container list-news ext-2">
                <ul>
                    <cfoutput query="get_homepage_news">
                            <li class="mt-list-item text-left">
                                <div class="list-icon-container">
                                    <a href="#request.self#?pageinfo=ContentDetail&cntid=#content_id#">
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </div>
                                <cfif 1 eq 1>
                                    <cfquery name="get_cont_image" dbtype="query" maxrows="1">
                                        SELECT * FROM GET_CONT_IMAGES WHERE CONTENT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#content_id#"> AND IMAGE_SIZE = 0 ORDER BY UPDATE_DATE DESC
                                    </cfquery>
                                    <div class="list-thumb">
                                        <a href="#request.self#?pageinfo=ContentDetail&cntid=#content_id#">
                                        <cfif isdefined('get_cont_image') and len(get_cont_image.contimage_small)>
                                      
                                                <cfif 1 eq 1>
                                               
                                                    <img class="img-circle" src="/documents/content/#get_cont_image.contimage_small#">
                                                <cfelse>
                                               
                                                    <img class="img-circle" src="/images/no_photo.gif">
                                                </cfif>
                                        <cfelse>
                                                <img class="img-circle" src="/images/no_photo.gif">
                                            </cfif>   
                                        </a>
                                    </div>
                                </cfif>
                                <cfif UPDATE_DATE neq ""><cfset date=UPDATE_DATE><cfelse><cfset date=RECORD_DATE></cfif>
                                <div class="list-datetime bold uppercase font-yellow-casablanca">#DateFormat(date, dateformat_style)#</div>
                                <div class="list-item-content">
                                    <h3 class="uppercase bold">
                                        <a href="#request.self#?pageinfo=ContentDetail&cntid=#content_id#">#cont_head#</a>
                                    </h3>
                                    <cfif len (cont_summary) gte 1>
                                        <p>#cont_summary#</p>
                                        <cfelse>
                                        <p></p>
                                    </cfif>                            
                                
                                </div>
                            </li>
                    </cfoutput>
                </ul>
            </div>
        </div>
		<cfelse>
            <table class="table table-hover table-light">
                <tbody>
                    <tr>
                        <td>
                    </tr>
                </tbody>
            </table>     
		</cfif>
</div>