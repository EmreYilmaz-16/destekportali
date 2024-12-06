    <style>
        .tbl-basket  th, .tbl-basket td{
            border-left:3px solid green;
            border-bottom:3px solid green;
            font-size:8pt;
        }
        .tbl-basket h4{
            margin-top:2px;
            margin-bottom:2px;
        }
    </style>
    <cfquery name="getProj" datasource="#dsn#">
    SELECT * FROM w3Partner.WORK_GROUP WHERE WORKGROUP_ID IN (SELECT WORKGROUP_ID FROM w3Partner.WORKGROUP_EMP_PAR WHERE PARTNER_ID=#session.pp.userid#)
    </cfquery>
<div class="pageContent">
    <div class="row">
        <div class="col">
            <cfif checkDenied(attributes.pageinfo,session.pp.userid) eq 0>
                <div class="alert alert-danger">Bu Sayfayı Görmeye Yetkiniz Yok</div>
                <cfabort>
            </cfif>
            <cfif attributes.event eq 'add'><cfinclude  template="siparis_add.cfm"></cfif>
    </div>
</div>
