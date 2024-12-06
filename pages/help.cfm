<cfset getComponent = createObject('component','cfc.components')>
<cfset GET_SERVICE_APPCAT = getComponent.GET_SERVICE_APPCAT()>
<cfparam name="attributes.app_name" default="">
<cfparam name="attributes.email" default="">
<cfparam name="attributes.workcube_id" default="">
<cfparam name="attributes.company_id" default="">
<cfparam name="attributes.pid" default="">
<cfparam name="attributes.file_name" default="">
<cfparam name="attributes.is_elect_asset_cat" default="">
<cfparam name="attributes.is_cont_doc_type" default="">
<cfparam name="attributes.interaction_cat" default="">
<cfparam name="attributes.commethod_id" default="6">
<cfset session.pp.language = attributes.language>
<nav class="navbar navbar-default navbar-fixed-top">
<div class="container-fluid">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
    <div class="navbar-header">
        <a class="navbar-brand" href="#">
            <img alt="Brand" src="images/w3-white.png">
        </a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-left">
            <li><a href="#about"><cfoutput>#attributes.COMPANY# - #attributes.app_name#</cfoutput></a></li>
        </ul>
    </div><!--/.navbar-collapse -->
  </div>
</nav>
<div class="container-fluid w3Body">        
    <div Class="pageContent">
        <div class="jumbotron jb-sm">
            <h3 class="text-info">Workcube Online Destek Platformuna Hoş Geldiniz</h3>
            <p class="lead">
            Değerli müşterimiz, <br>Bizimle iletişime geçmek için aşağıdaki formu doldurmanız yeterli. Yaşadığınız problemin en hızlı şekilde çözüme kavuşturulması için lütfen bilgi aktarırken sorun yaşadığınız şirket, muhasebe dönemi, şube, üye, ürün, çalışan, tarih v.b. bilgileri, aldığınız hata mesajını ve yaptığınız işlemi hangi aşamalarla gerçekleştirdiğinizi net biçimde ve detaylı olarak aktarınız. Aldığınız hata ekranının görüntüsünü dosya alanından etkileşim formuna upload ediniz.<br>Teşekkür ederiz.</p>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="portlet">
                    <div class="portlet-title">
                        <div class="caption text-danger">                                
                            Bizimle iletişime geçmek için aşağıdaki formu doldurmanız yeterli...
                        </div>				
                    </div>
                </div>
            </div>
        </div>
    
        <div class="row">
            <form class="form-horizontal" name="helpForm" id="helpForm">
            	<cfoutput>
                    <input type="hidden" name="is_popup" id="is_popup" value="1">
                    <input type="hidden" name="app_name" id="app_name" value="#attributes.app_name#">
                    <input type="hidden" name="app_cat" id="app_cat" value="#attributes.commethod_id#">
                    <input type="hidden" name="company_id" id="company_id" value="#attributes.company_id#">
                    <input type="hidden" name="pid" id="pid" value="#attributes.pid#">
                    <input type="hidden" name="workcube_id" id="workcube_id" value="#attributes.workcube_id#">
                    <input type="hidden" name="is_security" id="is_security" value="0" />
                	<div class="col-md-6 col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">#getLang('main',74,'Kategori')# <small class="text-danger">*</small></label>
                            <div class="col-sm-10">
                                <select name="appcat_id" id="appcat_id" class="form-control" required>
                                    <option value="">#getLang('main',322,'Seçiniz')#</option>
                                    <cfloop query="get_service_appcat">
                                        <option value="#servicecat_id#" >#servicecat#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">#getLang('main',1408,'Başlık')# <small class="text-danger">*</small></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="service_head" placeholder="Başlık Giriniz" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">#getLang('main',68,'Konu')# <small class="text-danger">*</small></label>
                            <div class="col-sm-10">
                                <textarea class="form-control" required name="service_detail" id="service_detail"  maxlength="1000" 
                                onchange="counter();" 
                                onkeyup="counter();" rows="5"></textarea>
                                <span class="pull-right detailLen">1000</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">#getLang('main',158,'Ad Soyad')# <small class="text-danger">*</small></label>
                            <div class="col-sm-10">
                            	<input type="text" class="form-control" name="member_name" id="member_name" value="#attributes.app_name#" placeholder="Ad Soyad Giriniz" readonly maxlength="255">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">#getLang('main',16,'e-mail')# <small class="text-danger">*</small></label>
                            <div class="col-sm-10">
                            	<input type="email" class="form-control"  placeholder="E-Posta Giriniz" name="applicant_mail" id="applicant_mail" value="#attributes.email#" required="yes">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-10 col-sm-offset-2 text-info"><em>#getLang('objects2',41,'İletişim talebinize mutlaka cevap verilecektir.')#</em></label>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12 text-right">
                                <div class="input-group searchInput col-md-12">
                                    <div class="input-group-btn">
                                        <button type="button" class="btn default" onclick="fileUploadModal(this);">
                                            <i class="fa fa-paperclip icon-white"> Belge</i><span class="badge"></span>
                                        </button>
                                        <button type="button" class="btn btn-info" onclick="saveHelpDesk(this)">
                                            <i class="fa fa-check icon-white"> Kaydet</i>
                                        </button>	
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </cfoutput>
            </form>
        </div>
    </div>        
</div>
    <footer class="footer">
        <p class="text-muted">Powered by W3</p>
    </footer>
<script type="text/javascript">
$(function(){
	//$("#modalWarning").modal('show');
	})
var counter = function(){
	var element = $("#service_detail");
	if($(element).val().length > 1000)
		$(element).val($(element).val().substring(0,1000));
	else
		$("span.detailLen").html(1000-$(element).val().length);
}
var saveHelpDesk = function(obj){
	dataForm = $("#helpForm").serialize();
	attachment = 0;
	files = [];
	myDropzone.processQueue();
	attachmentReturn = '';
	fileRealNameList = '';
	fileRealNameFullList = '';
	fileSystemNameList = '';
	myDropzone.on("queuecomplete", function() {
		try{
			attachmentReturn = $.parseJSON( returningValue );
			for(k=0;k<attachmentReturn.length;k++)
			{
				if(fileRealNameList.length)
				{
					fileRealNameList = fileRealNameList + ',' + myDropzone.files[k]._newFileName.value;
					if(myDropzone.files[k]._newFileName.value.indexOf(attachmentReturn[k]['ext']) != -1)
						fileRealNameFullList = fileRealNameFullList + ',' + myDropzone.files[k]._newFileName.value;
					else
						fileRealNameFullList = fileRealNameFullList + ',' + myDropzone.files[k]._newFileName.value+'.'+attachmentReturn[k]['ext'];
					fileSystemNameList = fileSystemNameList + ',' + attachmentReturn[k]['systemName'];
				}
				else
				{
					fileRealNameList = myDropzone.files[k]._newFileName.value;
					if(myDropzone.files[k]._newFileName.value.indexOf(attachmentReturn[k]['ext']) != -1)
						fileRealNameFullList = myDropzone.files[k]._newFileName.value;
					else
						fileRealNameFullList = myDropzone.files[k]._newFileName.value+'.'+attachmentReturn[k]['ext'];
					fileSystemNameList = attachmentReturn[k]['systemName'];
				}	
			}
			
			$.ajax({ url :'cfc/components.cfc?method=SAVEHELPDESK', data : {dataForm : dataForm, fileRealNameList:fileRealNameList, fileRealNameFullList:fileRealNameFullList,fileSystemNameList:fileSystemNameList}, async:false,success : function(res){ 
				data = $.parseJSON( res );


				} 
			});
		}
		catch(e){
			try{
				$.ajax({ url :'cfc/components.cfc?method=SAVEHELPDESK', data : {dataForm : dataForm, fileRealNameList:fileRealNameList, fileRealNameFullList:fileRealNameFullList,fileSystemNameList:fileSystemNameList}, async:false,success : function(res){ 
				debugger;
					data = $.parseJSON( res );
	
	
					} 
				});
			}
			catch(e){alert('Bir Hata oluştu');}
			}		
	});

}
</script>


<div class="modal fade" id="modalWarning" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title text-danger">Workcube Online Destek Platformuna Hoş Geldiniz</h4>
      </div>
      <div class="modal-body">
        <p>Değerli müşterimiz, <br>Bizimle iletişime geçmek için aşağıdaki formu doldurmanız yeterli. Yaşadığınız problemin en hızlı şekilde çözüme kavuşturulması için lütfen bilgi aktarırken sorun yaşadığınız şirket, muhasebe dönemi, şube, üye, ürün, çalışan, tarih v.b. bilgileri, aldığınız hata mesajını ve yaptığınız işlemi hangi aşamalarla gerçekleştirdiğinizi net biçimde ve detaylı olarak aktarınız. Aldığınız hata ekranının görüntüsünü dosya alanından etkileşim formuna upload ediniz. Sorununuzu gidermek üzere en kısa sürede size geri döneceğiz.<br>Teşekkür ederiz.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-dismiss="modal">Tamam</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->