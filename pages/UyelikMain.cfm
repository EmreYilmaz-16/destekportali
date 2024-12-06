<cfparam name="attributes.is_submit" default="0">
<cfparam name="attributes.is_active" default="0">
<cfparam name="attributes.password1" default="">
<cfparam name="attributes.password2" default="">

<div class="pageContent">
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                Üyelik
			</div>
        </div>
<div class="panel-group" id="accordion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">
        Şifre Değiştir</a>
      </h4>
    </div>
    <div id="collapse1" class="panel-collapse collapse <cfif attributes.is_active eq 1>in</cfif>">
      <div class="panel-body">
      <cfform method="post" action="index.cfm?pageinfo=UyelikMain" id="frmPass">
      <input type="hidden" name="is_submit" value="1">
      <input type="hidden" name="is_active" value="1">
      <input class="form-control" style="width:300px" placeholder="Şifre" id="password1"  type="password" name="password1" value="<cfoutput>#attributes.password1#</cfoutput>"><br>
      <input class="form-control" style="width:300px" placeholder="Şifre"  id="password2" type="password" name="password2" value="<cfoutput>#attributes.password2#</cfoutput>">
    
      <div style="width:300px;<cfif isdefined("attributes.is_passok") and  attributes.is_passok eq 0>display:block<cfelse>display:none</cfif>" id="hata" class="alert alert-danger"><cfif isdefined("attributes.is_passok") and attributes.is_passok eq 0>Şifreler Eşleşmiyor</cfif></div>
      <cfif isdefined("attributes.is_passok") and attributes.is_passok eq 1><div style="width:300px;display:block"  class="alert alert-succes">Şifreniz Değiştirilmiştir</div></cfif>     
      </cfform>      
       <button onclick="ChangePass()" class="btn btn-success">Şifre Değiştir</button>
      </div>
    </div>
  </div>
  <!----
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
        Collapsible Group 2</a>
      </h4>
    </div>
    <div id="collapse2" class="panel-collapse collapse">
      <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit,
      sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
      minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
      commodo consequat.</div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">
        Collapsible Group 3</a>
      </h4>
    </div>
    <div id="collapse3" class="panel-collapse collapse">
      <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit,
      sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
      minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
      commodo consequat.</div>
    </div>
  </div>---->
</div>
    </div>

<cfif attributes.is_submit eq 1>
    <cfif attributes.password1 eq attributes.password2>
        <cfscript>
            temp = attributes.password2
            cryptedPassword = hash(temp);
            password = cryptedPassword;
        </cfscript> 
        <cfquery name="updatePass" datasource="#dsn#">
            UPDATE #dsn#.COMPANY_PARTNER SET COMPANY_PARTNER_PASSWORD ='#password#' WHERE PARTNER_ID=#session.pp.userid#
        </cfquery>
        <cfset attributes.is_passok =1>
    </cfif>        
</cfif>     
</div>   
<script>
function ChangePass(){
    $("#hata").hide();
    var pw1=$("#password1").val()
    var pw2=$("#password2").val()
    if(pw1==pw2){
        $("#frmPass").submit();
    }else{
        $("#hata").show();
        $("#hata").html("Şifreler Eşleşmiyor")
    }
}
</script>