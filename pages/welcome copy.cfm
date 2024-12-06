<cfset getData 	= createObject('component','cfc.components').getCallCenterDashboard()>
<cfoutput>
    <div class="container-fluid w3Body">
        <div Class="pageContent">
            <div class="jumbotron">
                <h3>Workcube Destek Platformu</h3>
                <p class="lead">
                    Değerli müşterimiz, <br>Bizimle iletişime geçmek için aşağıdaki formu doldurmanız yeterli. Yaşadığınız problemin en hızlı şekilde çözüme kavuşturulması için lütfen bilgi aktarırken sorun yaşadığınız şirket, muhasebe dönemi, şube, üye, ürün, çalışan, tarih v.b. bilgileri, aldığınız hata mesajını ve yaptığınız işlemi hangi aşamalarla gerçekleştirdiğinizi net biçimde ve detaylı olarak aktarınız. Aldığınız hata ekranının görüntüsünü dosya alanından etkileşim formuna upload ediniz. Sorununuzu gidermek üzere en kısa sürede size geri döneceğiz.<br>Teşekkür ederiz.
                </p>
            </div>
            <div class="row widget-row">
                <div class="col-md-3">
                    <!-- BEGIN WIDGET THUMB -->
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                        <h4 class="widget-thumb-heading">Toplam Başvuru</h4>
                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-green icons8-advertising"></i>
                            <div class="widget-thumb-body">                                            
                                <span class="widget-thumb-body-stat">#getData['callCenterAll']#</span>
                                <span class="widget-thumb-subtitle">Bekleyen: #getData['callCenterOpen']#</span>
                            </div>
                        </div>
                    </div>
                    <!-- END WIDGET THUMB -->
                </div>
                <div class="col-md-3">
                    <!-- BEGIN WIDGET THUMB -->
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                        <h4 class="widget-thumb-heading">Proje</h4>
                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-red icons8-powerpoint"></i>
                            <div class="widget-thumb-body">
                                <span class="widget-thumb-body-stat">#getData['project']#</span>
                            </div>
                        </div>
                    </div>
                    <!-- END WIDGET THUMB -->
                </div>
                <div class="col-md-3">
                    <!-- BEGIN WIDGET THUMB -->
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                        <h4 class="widget-thumb-heading">Görevler</h4>
                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-purple icons8-todo-list"></i>
                            <div class="widget-thumb-body">
                                <span class="widget-thumb-body-stat">#getData['workAll']#</span>
                                <span class="widget-thumb-subtitle">Bekleyen: #getData['workOpen']#</span>
                            </div>
                        </div>
                    </div>
                    <!-- END WIDGET THUMB -->
                    <!-- END WIDGET THUMB -->
                </div>
                <div class="col-md-3">
                    <!-- BEGIN WIDGET THUMB -->
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                        <h4 class="widget-thumb-heading">Yeni Başvuru</h4>
                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-blue icons8-question-mark"></i>
                            <div class="widget-thumb-body">
                                <span class="widget-thumb-subtitle smallTitle" onclick="goLocation('callCenter?service_id=')">Yeni başvuru oluşturmak için <abbr title="yeni başvuru ekle">tıklayınız.</abbr></span>
                                <span class="widget-thumb-body-stat"></span>
                            </div>
                        </div>
                    </div>
                    <!-- END WIDGET THUMB -->
                </div>
            </div>
            <div class="row widget-row">
            	<div class="col-md-3">
                    <label for = "myChart" class="text-center">
                    	<h4 class="widget-thumb-heading">Başvurular</h4>
                        <canvas id="myChart"></canvas>
                    <div id="legend"></div>
                    </label>
					<script>
						wrkChart(
							'myChart',
							'pie', // pie - donut - polar
							'',
							[									
								['#getData["callCenterAll"]#','','Tamamlanan'],
								['#getData["callCenterOpen"]#','','Bekleyen']
							]);	
                    </script> 
                </div>
            	<div class="col-md-3">
                    <label for = "myChart2" class="text-center">
                    	<h4 class="widget-thumb-heading">Tüm işler</h4>
                        <canvas id="myChart2"></canvas>
                    <div id="legend"></div>
                    </label>
                    <cfset dataCount = StructCount(getData['works'])>
                    <cfset proList = ''>
                    <cfset projectIdList = StructKeyList(getData['works'])>
                    <cfloop from="1" to="#dataCount#" index="ind">
                    	<cfset proList = listAppend(proList,getData['works'][listGetAt(projectIdList,ind,',')]['projectHead'])>
                    </cfloop>
					<script>
						wrkChart(
							'myChart2',//canvas id
							'pie', // line - bar - hbar - radar
							'', //label
							[
								<cfloop index="ind" from="1" to="#dataCount#">
									['#getData["works"][listGetAt(projectIdList,ind,',')]["all"]#','','#getData["works"][listGetAt(projectIdList,ind,',')]["projectHead"]#'],
								</cfloop>
							]);
                    </script> 
                </div>
            	<div class="col-md-3">
                    <label for = "myChart3" class="text-center">
                    	<h4 class="widget-thumb-heading">Açık İşler</h4>
                        <canvas id="myChart3"></canvas>
                    <div id="legend"></div>
                    </label>
                    <cfset dataCount = StructCount(getData['works'])>
                    <cfset proList = ''>
                    <cfset projectIdList = StructKeyList(getData['works'])>
                    <cfloop from="1" to="#dataCount#" index="ind">
                    	<cfset proList = listAppend(proList,getData['works'][listGetAt(projectIdList,ind,',')]['projectHead'])>
                    </cfloop>
					<script>
						wrkChart(
							'myChart3',//canvas id
							'pie', // line - bar - hbar - radar
							'', //label
							[
								<cfloop index="ind" from="1" to="#dataCount#">
									['#getData["works"][listGetAt(projectIdList,ind,',')]["open"]#','','#getData["works"][listGetAt(projectIdList,ind,',')]["projectHead"]#'],
								</cfloop>
							]);
                    </script> 
                </div>
            </div>
        </div>        
    </div>
</cfoutput>
