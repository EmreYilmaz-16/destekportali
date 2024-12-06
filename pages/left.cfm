<div class="menuContent">
	<cfoutput>
        <ul class="leftMenu" id="workdevmenu">
            <li title="#getLang('main',774,'başvurular')#">
                <i class="icons8-news"></i>
                <a href="index.cfm?pageInfo=callCenters"><span class="title">#getLang('main',774,'başvurular')#</span></a>
            </li>
            <li title="#getLang('product',147,'Servisler')#">
                <i class="icons8-support"></i>
                <a href="index.cfm?pageInfo=services"><span class="title">#getLang('product',147,'Servisler')#</span></a>
            </li>
            <li title="#getLang('main',603,'Projeler')#">
                <i class="icons8-parallel-tasks"></i>
                <a href="index.cfm?pageInfo=projects"><span class="title">#getLang('main',603,'Projeler')#</span></a>
            </li>
            <li title="#getLang('service',62,'Görevler')#">
                <i class="icons8-tasks"></i>
                <a href="index.cfm?pageInfo=projectWorks"><span class="title">#getLang('service',62,'Görevler')#</span></a>
            </li>
            <li title="#getLang('main',3,'Ajanda')#">
                <i class="icons8-grid"></i>
                <a href="index.cfm?pageInfo=agenda"><span class="title">#getLang('main',3,'Ajanda')#</span></a>
            </li>
            <li title="#getLang('main',2402,'Extre')#">
                <i class="icons8-calculator"></i>
                <a href="index.cfm?pageInfo=extre"><span class="title">#getLang('main',2402,'Extre')#</span></a>
            </li>
            <li onclick="goTo('');"  title="Forum">
            <i class="icons8-brush"></i>
               <a href="index.cfm?pageInfo=test_site"><span class="title">Forum</span></a>
            </li>
            <li onclick="goTo('');"  title="Sipariş">
            <i class="icons8-brush"></i>
               <a href="index.cfm?pageInfo=siparis&event=add"><span class="title">Sipariş</span></a>
            </li>
        </ul>
    </cfoutput>
</div>
