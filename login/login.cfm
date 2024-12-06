<!---
*************************************************************************
	Description : Giriş Ekranının Özelleştirmek İçin Bu Dosya Edit Edilir.
*************************************************************************
--->
<cfsetting showdebugoutput="no"><!---Debug kapalı olmasının sebebi, giriş ekranında bulunan background sabitliği ile ilgilidir. bu sayfada işlem yapmak için kaldırınız sonra tekrar açınız.--->
<div class="container">    
    <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
        <div class="panel panel-info" >
            <div class="panel-heading">
                <div class="panel-title">Sign In</div>                        
            </div>     
            <div style="padding-top:30px" class="panel-body" >
                <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                <cfform id="loginform" class="form-horizontal" role="form">
                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="fa fa-industry" aria-hidden="true"></i></span>
                        <input id="login-username" type="text" class="form-control" name="usercode" value="" placeholder="Kod">                                        
                    </div>
                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="Kullanıcı Adı">                                        
                    </div>
                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input id="login-password" type="password" class="form-control" name="password" placeholder="Şifre">
                    </div>
                    <div style="margin-top:10px" class="form-group">
                        <div class="col-sm-12 controls">
                            <a id="btn-login" href="javascript://" onClick="loginControl('loginform')" class="btn btn-success">Login  </a>
                        </div>
                    </div>
                </cfform>     
            </div>                     
        </div>  
    </div>
</div>