
           <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
           <link rel="stylesheet" href="css/fonts/icon8/styles.min.css">
            <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
            <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<cfset dsn1="#dsn#_product">

<cf_prt_page_header title="Kategoriler">
<cfform method="POST" action="index.cfm?pageinfo=#attributes.pageinfo#&ajaxpage=1">
    <input type="text" name="keyword" value="<cfif isdefined("attributes.keyword")><cfoutput>#attributes.keyword#</cfoutput></cfif>">
</cfform>

<cfquery name="getCats" datasource="#dsn1#">
    SELECT * FROM PRODUCT_CAT WHERE 1=1
    <cfif isdefined("attributes.keyword")>
    and (
        PRODUCT_CAT LIKE '%#attributes.keyword#%' OR
        HIERARCHY LIKE '%#attributes.keyword#%' 
    )
    </cfif>

</cfquery>
<table class="table">
<cfoutput query="getCats">
<tr><td>#HIERARCHY#</td><td><a class="text-primary" onclick="SendDataToOppener('#PRODUCT_CAT#','#PRODUCT_CATID#','#HIERARCHY#')">#PRODUCT_CAT#</a></td></tr>
</cfoutput>
</table>

<script>
function SendDataToOppener(cat,catid,hie){
var cat_id=window.opener.document.getElementById("<cfoutput>#attributes.field_catid#</cfoutput>")
 cat_id.value = catid;
 var cat_=window.opener.document.getElementById("<cfoutput>#attributes.field_cat#</cfoutput>")
 cat_.value = cat;
 var hie_=window.opener.document.getElementById("<cfoutput>#attributes.field_hie#</cfoutput>")
 hie_.value = hie;
 this.close()
}
</script>