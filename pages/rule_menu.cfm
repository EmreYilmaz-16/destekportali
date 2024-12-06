<cfset modul = attributes.CIRCUIT>
<cfset pageAddress = listgetat(attributes.fuseaction,"2",".")>

<div class="w3-menu scrollİntranetMenu col col-12 col-xs-12" <cfif isDefined('attributes.event') and attributes.event eq "updPopup"> style="display:none;" </cfif>>
    <ul class="d-flex">
        <li class="navLite" <cfif modul eq "rule" and pageAddress neq "list_hr">style="border-color: #13be54;"</cfif>><a href="?fuseaction=rule.welcome"><cfoutput>#getLang('main',6)#</cfoutput></a>  
            <div class="menuDropdown">
                <div class="container-fluid">
                    
                    <div class="mrow">                       
                        <cfinclude template="list_cat_chapter_home.cfm">                     
                    </div>
                </div>
            </div>
        </li>
        
        <li class="navFor" <cfif modul eq "forum">style="border-color: #009688;" <cfset color = "##009688"></cfif>><a href="?fuseaction=forum.list_forum"><cfoutput>#getLang('main',9)#</cfoutput></a></li> 
        <li class="navDij" <cfif modul eq "asset">style="border-color: #fd950f;" <cfset color = "##fd950f"></cfif>><a href="?fuseaction=asset.list_asset"><cfoutput>#getLang('agenda',56)#</cfoutput></a></li>
        <li class="navEgi" <cfif modul eq "training">style="border-color: #f5cc0f;" <cfset color = "##f5cc0f"></cfif>><a href="?fuseaction=training.welcome"><cfoutput>#getLang('main',7)#</cfoutput></a></li> 
        <li class="navKim" <cfif modul eq "rule" and pageAddress eq "list_hr">style="border-color: #9c44c5;" <cfset color = "##9c44c5"></cfif>><a href="?fuseaction=rule.list_hr"><cfoutput>#getLang('rule',8)#</cfoutput></a></li>
        <li class="navSos" <cfif modul eq "worknet">style="border-color: #4889f4;" <cfset color = "##4889f4"></cfif>><a href="?fuseaction=worknet.list_social_media"><cfoutput>#getLang('hr',263)#</cfoutput></a></li>
        <li class="navDig" <cfif modul eq "myhome">style="border-color: #f64b4b;" <cfset color = "##f64b4b"></cfif>><a href="?fuseaction=myhome.other_hr"><cfoutput>#getLang('main',744)#</cfoutput></a></li>
        
    </ul>
</div>