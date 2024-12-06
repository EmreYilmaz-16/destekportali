<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.cfm?pageInfo=welcome">
                <img alt="Brand" src="images/w3-white.png">
            </a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="#about"><cfoutput>#session.pp.COMPANY_NICK# - #session.pp.name# #session.pp.surname#</cfoutput></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="index.cfm?pageinfo=your_employees" title="Kullanıcılarınız"><i class="glyphicon glyphicon-user"></i></a></li>
                <li><a href="index.cfm?pageinfo=UyelikMain" title="Üyelik"><i class="glyphicon glyphicon-copy"></i></a></li>
                <li><a href="javascript://" title="Çıkış" onclick="logOut()"><i class="glyphicon glyphicon-log-out"></i></a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">My W3<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="index.cfm?pageInfo=our_company"><cfoutput>#getLang('member',313,'Şirketimiz')#</cfoutput></a></li>
                        <li><a href="index.cfm?pageinfo=your_employees"><cfoutput>#getLang('agenda',64,'Kullanıcı Yönetimi')#</cfoutput></a></li>
                    </ul>
                </li>
            </ul>
        </div>
      </div>
</nav>