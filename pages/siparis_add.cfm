     
     <cfform method="POST" action="index.cfm?pageinfo=#attributes.pageinfo#&event=#attributes.event#">
           <cfoutput>
              <label>Ödeme Yöntemi :   <input type="text" class="form-control" name="paymethod" readonly></label>              
             <label display="flex">Siparişi Veren : <input type="text" name="sip_veren_firm" class="form-control" value="#session.pp.COMPANY_NICK#" readonly>   
             <input type="text" name="sip_veren" value="#session.pp.name# #session.pp.SURNAME#" class="form-control" readonly>
            
             </label>
             <label>Sipariş Tarihi :<input type="date" name="sip_date" value="#dateformat(now(),'yyyy-mm-dd')#" class="form-control" readonly></label>
             <label>Süreç :  <cf_workcube_process is_upd='0' fusepath="#attributes.pageinfo#" is_detail='1'></label>
             <label>Proje : 	
                <select class="form-control" name="project_id">
                    <cfloop query="getProj">
                        <option value="#PROJECT_ID#">#WORKGROUP_NAME#</option>
                    </cfloop>
                </select>
                </label>
            </cfoutput> <br>
			
<cfinclude  template="basket.cfm">

       
            </cfform>

        </div>
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