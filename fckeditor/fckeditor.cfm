<cfparam name="attributes.instanceName" type="string">
<cfparam name="attributes.width" 		type="string" default="">
<cfparam name="attributes.height" 		type="string" default="200">
<cfparam name="attributes.toolbarSet" 	type="string" default="WRKContent">
<cfparam name="attributes.value" 		type="string" default="">
<cfparam name="attributes.checkBrowser" type="boolean" default="true">
<cfparam name="attributes.cssFontTags" type="boolean" default="true">
<cfparam name="attributes.config" 		type="struct" default="#structNew()#">
<cfparam name="attributes.label" type="string" default="Editör">

<cfif isdefined('session.ep')>
	<cfset temp_language = left(session.ep.language,2)>
<cfelseif isdefined('session.pp')>
	<cfset temp_language = left(session.pp.language,2)>
<cfelseif isdefined('session.ww')>
	<cfset temp_language = left(session.ww.language,2)>
<cfelseif isdefined('session.cp')>
	<cfset temp_language = left(session.cp.language,2)>	
</cfif>

<cfinclude template="fckutils.cfm">

<cfset server_machine_list = application.systemParam.systemParam().fusebox.server_machine_list>
<cfset server_machine = application.systemParam.systemParam().fusebox.server_machine>


<cfset doc_url_ = replace(listgetat(server_machine_list,server_machine,';'),"http://","","all")>
<cfset wrk_fck_add_url_ = doc_url_>
<!--- ::
	 * check browser compatibility via HTTP_USER_AGENT, if checkBrowser is true
	:: --->

<cfscript>
if(attributes.checkBrowser)
{
	isCompatibleBrowser = FCKeditor_IsCompatibleBrowser();
}
else
{
	// If we should not check browser compatibility, assume true
	isCompatibleBrowser = true;
}
</cfscript>
<!---
<cfif browserDetect() contains 'iPad' or browserDetect() contains 'iPhone' or browserDetect() contains 'iPod' or browserDetect() contains 'Android' or browserDetect() contains 'Safari 4'>
	<cfset isCompatibleBrowser = false>
</cfif>
--->

<cfif isCompatibleBrowser>
    <cfoutput>
    
    <div class="form-group" id="item-#attributes.instanceName#">
    <div class="col col-12">
        <textarea name="#attributes.instanceName#" style="display:none;" id="#attributes.instanceName#">#HTMLEditFormat(attributes.value)#</textarea>
        <div id="#attributes.instanceName#div" style="display:none;"></div>
	</div>
    </div>
        <script type="text/javascript">
		$(document).ready(function(){
				initialize_#attributes.instanceName#();
			});
			  
			function initialize_#attributes.instanceName#()
				{
					CKEDITOR.replace('#attributes.instanceName#',
					{
						height: '#attributes.height#',
						width: ''<!---#attributes.width# responsive olmasi icin 100% yapildi SA 19.08.2016 15:20--->,
						language: '#temp_language#',
						allowedContent:true,
						extraAllowedContent: 'b i span span(*) span{*}',
						fillEmptyBlocks : false,	
						customConfig: '/fckeditor/CK_config.js'
					});
					CKEDITOR.dtd.$removeEmpty['span'] = false;
					// temp_language parametresi sessionda bulunan dil degerinin ilk iki hadri alinir BK 20130805

					
				}
				
    </cfoutput>
			function getUIColor ()
			{
				<cfif isDefined('session.ep.design_color')>
					<cfif session.ep.design_color eq 1>
						return '#aabcc4';
					<cfelseif session.ep.design_color eq 2>
						return '#beb8b3';
					<cfelseif session.ep.design_color eq 3>
						return '#e7d9c3';
					<cfelseif session.ep.design_color eq 4>
						return '#cbcba7';
					<cfelseif session.ep.design_color eq 5>
						return '#becbd7';
					<cfelseif session.ep.design_color eq 6>
						return '#87c1ca';
					<cfelseif session.ep.design_color eq 7>
						return '#aabd96';				
					</cfif>
				</cfif>
			}
			function getPlugins ()
			{
				return 'video,Media,contextmenu';	
			}
			<!---			function IncludeCustomTags()
			{
				<cfif attributes.cssFontTags>
					return true;
				<cfelse>
					return false;
				</cfif>	
			}
			---> 
		</script>
<cfelse>
<!--- ::
		 * show	plain textarea for non compatible browser
		:: --->
	<cfscript>
		// append unit "px" for numeric width and/or height values
		if( isNumeric( attributes.width ) )
			attributes.width = attributes.width & "px";
		if( isNumeric( attributes.height ) )
			attributes.height = attributes.height & "px";
	</cfscript>

	<!--- Fixed Bug ##1075166. hk@lwd.de 20041206 --->
	<cfoutput>
		<textarea name="#attributes.instanceName#" id="#attributes.instanceName#" rows="4" cols="40" style="width: #attributes.width#; height: #attributes.height#">#HTMLEditFormat(attributes.value)#</textarea>
	</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="No">
<cfexit method="exittag">