<cfsetting showdebugoutput="no">
<cfset getComponent = createObject('component','cfc.components')>
<cfset pageDet = getComponent.GET_COMPONENTS(pageInfo:attributes.pageInfo)>
<cfset assetCat = getComponent.GET_ASSET_CAT()>
<cfset documentType = getComponent.GET_CONTENT_PROPERTY()>
<cfif isdefined("attributes.AjaxPage") and attributes.AjaxPage eq 1>
<cfelse>
	<cfinclude template="header.cfm">
	<cfinclude template="left.cfm">
</cfif>



<cfloop query="pageDet">

	<cfinclude template="#PATH#">
	  
</cfloop>

<script type="text/javascript">
	document.title = '<cfoutput>#pageDet.PAGE_HEAD#</cfoutput>';
</script>
