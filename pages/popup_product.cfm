           <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
           <link rel="stylesheet" href="css/fonts/icon8/styles.min.css">
            <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
            <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<cfparam  name="attributes.is_submit" default="0">
<cf_prt_page_header title="Ürünler">

<cfform method="post" action="index.cfm?pageinfo=#attributes.pageInfo#&ajaxpage=1" name="popup_prod_form">
<input type="text" class="form-control" name="keyword" value="<cfif isDefined("attributes.keyword")  ><cfoutput>#attributes.keyword#</cfoutput></cfif>" placeholder="KeyWord">
<div class="input-group mb-3">
  <input type="text" name="product_cat" class="form-control" id="product_cat" placeholder="Kategori" aria-label="Kategori" aria-describedby="basic-addon2">
  <input type="hidden" name="product_catid" id="product_catid">
  <input type="hidden" name="hierarchy" id="hierarchy">
    <input type="hidden" name="is_submit"  value="1"id="is_submit">
  <div class="input-group-append">
    <button onclick="windowopen('index.cfm?pageinfo=empty_popup_product_cat&ajaxpage=1&field_catid=product_catid&field_cat=product_cat&field_hie=hierarchy','list')" class="btn btn-outline-secondary" type="button">K</button>
  <input type="hidden" value="is_submit">
  </div>
</div>
<input type="submit">
</cfform>
<cfif attributes.is_submit eq 1>
<cfquery name="fiyatdahilmi" datasource="#dsn#_1">
SELECT DISTINCT *
FROM w3Partner_1.PRICE_CAT_EXCEPTIONS AS PCE
	,w3Partner_1.PRICE_CAT AS PIR
WHERE PIR.PRICE_CATID = PCE.PRICE_CATID
	AND PIR.STARTDATE < GETDATE()
	AND (
		PIR.FINISHDATE > GETDATE()
		OR PIR.FINISHDATE IS NULL
		)
	AND COMPANY_ID = #session.pp.company_id#
</cfquery>
<cfset listeler=valueList(fiyatdahilmi.PRICE_CATID)>
<cfif fiyatdahilmi.recordcount>
<cfquery name="getProducts" datasource="#dsn#_product">
SELECT P.PRODUCT_ID
	,P.PRODUCT_NAME
	,P.PRODUCT_CODE
	,PIR.PRICE
	,P.MANUFACT_CODE
    ,PIR.MONEY AS MONEY_
FROM w3Partner_product.PRODUCT AS P
	,w3Partner_1.PRICE_CAT_EXCEPTIONS AS PCE
	,w3Partner_1.PRICE AS PIR
WHERE P.PRODUCT_ID = PIR.PRODUCT_ID
	AND PCE.PRICE_CATID = PIR.PRICE_CATID
    <cfif isDefined("attributes.keyword") and len(attributes.keyword)>  AND PRODUCT_NAME LIKE '%#attributes.keyword#%'</cfif>
        <cfif isDefined("attributes.product_cat") and len(attributes.product_cat)>
            AND PRODUCT_CODE LIKE '%#attributes.hierarchy#%'
            AND PIR.PRICE_CATID IN (#listeler#)
        </cfif>
</cfquery>
<cfelse>
    <cfquery name="getProducts" datasource="#dsn#_product">
        SELECT P.PRODUCT_NAME,P.PRODUCT_CODE,P.MANUFACT_CODE,P.TAX,P.BARCOD, (0) AS PRICE,('TL') AS MONEY_ FROM PRODUCT AS P
         WHERE 1=1  <cfif isDefined("attributes.keyword") and len(attributes.keyword)>  AND PRODUCT_NAME LIKE '%#attributes.keyword#%'</cfif>
        <cfif isDefined("attributes.product_cat") and len(attributes.product_cat)>
            AND PRODUCT_CODE LIKE '%#attributes.hierarchy#%'
        </cfif>

    </cfquery>
</cfif>    
    <table class="table">
    <cfoutput>
    
    <cfloop query="getProducts">
    <tr>
    <td>#currentrow#</td>
    <td>#PRODUCT_CODE#</td>
    <td><a onclick="SendDataToOppener('#PRODUCT_NAME#','#PRODUCT_CODE#','1','#DecimalFormat(PRICE)#','#MONEY_#')">#PRODUCT_NAME#</a></td>
    <td>#DecimalFormat(PRICE)# #MONEY_#</td>
    </tr>
    </cfloop>
    </cfoutput>
    </table>
</cfif>
<script>
function SendDataToOppener(prod,code,amount,pirce,mt){
var cat_id=window.opener.document.getElementById("basket-rows")
 var xxx=""+ pirce
 xxx=xxx.replace( ",", "");
var satsay = window.opener.getSatir();
var satiricerik="";
var curvalluea=0.1;
 var xyz=""+ pirce
 xyz=xyz.replace( ",", "");
 var totpiar=amount*xxx
$.get("/cfc/partner_otm_func.cfc?method=GetCuuretCurrencyVal&currParam="+mt, function(data, status){
console.log(data)
curvalluea=parseFloat(data);
if(mt === 'TL'){
var totpir=amount*xxx;
}else{
var totpir=amount*xxx*curvalluea;
xxx=parseFloat(xxx*curvalluea);
}

satiricerik  += "<tr id='row_"+satsay+"'>"
 satiricerik  +="<td><a onclick='dellrow("+satsay+")'><h4>-</h4></a></td>"
 satiricerik  +="<td>"+prod+"</td><td>"+code+"</td>"
 satiricerik  +="<td><input onchange='satirHesapla("+satsay+")' type='text' id='amount_"+satsay+"' class='amount' value='"+amount+"'></td>"
 satiricerik  +="<td><input onchange='satirHesapla("+satsay+")' type='text' id='price_"+satsay+"' class='price' value='"+parseFloat(xxx).toFixed(2)+"'></td><td>"+xyz+"</td><td>"+mt+"</td>"
 satiricerik  +="<td><input  type='text' id='total_"+satsay+"' class='totprice' value='"+totpir.toFixed(2)+"'></td><td>"+totpiar.toFixed(2)+"</td></tr>";
 cat_id.innerHTML+=satiricerik;
 window.opener.SetSatir();
window.opener.Hesapla();

})
console.log(xxx)
console.log(curvalluea)

console.log(curvalluea)
 
}
</script>
<script>
        var windowopen=function(theURL,winSize) { /*v3.0*/
	//fonsiyon 3 parametrede alabiliyor 3. parametre de isim yollana bilir ozaman aynı pencere tekrar acilmaz
		if (winSize == 'page') 					{ myWidth=900 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'print_page') 		{ myWidth=750 ; myHeight=500 ; features = 'scrollbars=0, resizable=1, menubar=1' ; }
		else if (winSize == 'list') 			{ myWidth=800 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'medium') 			{ myWidth=800 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'small') 			{ myWidth=570 ; myHeight=350 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'date') 			{ myWidth=275 ; myHeight=190 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'project') 			{ myWidth=800 ; myHeight=620 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'large') 			{ myWidth=615 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'horizantal') 		{ myWidth=1600 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'list_horizantal')	{ myWidth=1100 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'wide') 			{ myWidth=980 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'wide2') 			{ myWidth=1100 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'longpage') 		{ myWidth=1200 ; myHeight=500 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'page_horizantal') 	{ myWidth=800 ; myHeight=500 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'video') 			{ myWidth=480 ; myHeight=420 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
		else if (winSize == 'online_contact') 	{ myWidth=600 ; myHeight=500 ; features = 'scrollbars=0, resizable=0, menubar=0' ; } 
		else if (winSize == 'wwide') 			{ myWidth=1600 ; myHeight=860 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }  
		else if (winSize == 'long_menu') 		{ myWidth=200 ; myHeight=500 ; features = 'scrollbars=0, resizable=0' ; }
		else if (winSize == 'adminTv') 			{ myWidth=1040 ; myHeight=870 ; features = 'scrollbars=1, resizable=1, menubar=0' ; }
		else if (winSize == 'userTv') 			{ myWidth=565 ; myHeight=487 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
		else if (winSize == 'video_conference')	{ myWidth=740 ; myHeight=610 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
		else if (winSize == 'white_board')		{ myWidth=1000 ; myHeight=730 ; features = 'scrollbars=0, resizable=1, menubar=0' ; }
		 else if (winSize == 'wwide1') 			{ myWidth=1200 ; myHeight=700 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'norm_horizontal')	{ myWidth=950 ; myHeight=300 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'page_display')		{ myWidth=1100 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else if (winSize == 'work') 			{ myWidth=950 ; myHeight=620 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
		else { myWidth=400 ; myHeight=400 ; features = 'scrollbars=0, resizable=0' ; }
		if(window.screen)
		{
			var myLeft = (screen.width-myWidth)/2;
			var myTop =  (screen.height-myHeight)/2;
			
			features+=(features!='')?',':''; 
			features+=',left='+myLeft+',top='+myTop; 
		}
	
		if (arguments[2]==null)
			window.open(theURL,'',features+((features!='')?',':'')+'width='+myWidth+',height='+myHeight); 
		else		
			window.open(theURL,arguments[2],features+((features!='')?',':'')+'width='+myWidth+',height='+myHeight);
	}
</script>