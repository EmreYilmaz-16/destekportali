
<style>
    .leftcls{
        float:left;width:23%;
        padding:3%;
    }
      .rightcls{
        float:right;width:23%;
        margin-left:2%;
        padding:1%;
    }
          .centercls{
        width:48%;
        margin-left:2%;
        padding:1%;

    }
    ul{
         list-style-type: none;
    }
    </style>

<cfset getData 	= createObject('component','cfc.components').getCallCenterDashboard()>
    <div class="jumbotron">
        <div Class="pageContent">
            <div style="display:flex">
    
            
            <div class="leftcls" style="padding-left: 0px;">                        
                    <cfinclude  template="leftbar.cfm">               
                </div>
                
                <div class="centercls" >
                <h4 style="text-align: center;">Taze İçerik</h4>
                    <cfinclude  template="Center.cfm">
                </div>
                <div class="rightcls" >
                    <cfinclude  template="rightbar.cfm">
                </div>
            <div>
               <div style="clear:both"></div>
 
        </div>
     
    </div>
                <cfoutput>   
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
                                <span class="widget-thumb-subtitle smallTitle" onclick="goLocation('index.cfm?pageInfo=makecall')">Yeni başvuru oluşturmak için <abbr title="yeni başvuru ekle">tıklayınız.</abbr></span>
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
     </cfoutput>

     