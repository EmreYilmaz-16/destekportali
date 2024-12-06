<div class="pageContent">
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                Şirketimiz
			</div>
            <cfquery NAME="getOurCompnayEmp" datasource="#dsn#">
               SELECT EMPLOYEE_NAME,EMPLOYEE_SURNAME,EMPLOYEE_EMAIL,POSITION_NAME,EP.POSITION_ID,CASE
 WHEN EMPLOYEE_ID =9 THEN 1 
 WHEN EMPLOYEE_ID=7 THEN 2
 WHEN EMPLOYEE_ID=11 THEN 3
 WHEN EMPLOYEE_ID=6 THEN 4
 WHEN EMPLOYEE_ID=3 THEN 5
  WHEN EMPLOYEE_ID=17 THEN 6
 END AS ORDER_NO,
(SELECT PHOTO FROM #dsn#.EMPLOYEES WHERE EMPLOYEE_ID=EP.EMPLOYEE_ID) AS PHOTO,EMPLOYEE_ID FROM #dsn#.EMPLOYEE_POSITIONS AS EP 
WHERE EMPLOYEE_ID IN(3,6,7,9,11,17)
ORDER BY ORDER_NO
            </cfquery>
            <div style="clear:both"></div>
            <h3>Kadromuz</h3>
            <div class="row">
                <cfoutput query="getOurCompnayEmp">
                    <div class="col-lg-2 col-sm-3 col-xs-12 padding-0">
                        <div class="portlet light bg-grey-cararra bg-font-grey-cararra borderR-grey">
                            <!-- SIDEBAR USERPIC -->
                            <div class="profile-userpic">
                            	<cfif len(PHOTO)>
                                	<img src="documents/hr/#PHOTO#" style="width:100px;height:100px" class="img-responsive" alt="">
                                <cfelseif 0 EQ 1>
                                	Erkek
                                <cfelse>
                                	<img src="documents/hr/empty_avatar.png"  style="width:100px;height:100px"  class="img-responsive" alt="">
                                </cfif>
							</div>
                            <div class="profile-usertitle">
                                <div class="profile-usertitle-name">#EMPLOYEE_NAME# #EMPLOYEE_SURNAME#</div>
                                <div class="profile-usertitle-job">#POSITION_NAME#</div>
                            </div>
                            <div class="profile-usermenu">
                                <ul class="nav text-center">
                                    <li title="Kategori">
                                        <a style="font-size:10pt" href="mailto:#EMPLOYEE_EMAIL#" class="font-yellow-gold bold"><i class="fa fa-briefcase"></i>#EMPLOYEE_EMAIL#</a>
                                    </li>
                              
                                </ul>
                            </div>
                        </div>
                    </div>
                </cfoutput>
            </div>
            <div style="clear:both"></div>
            <h3></h3>
        </div> 
    </div>
</div>