<cfquery name="getLeftContent" datasource="#dsn#">
SELECT CON.CONT_BODY,EMP.EMPLOYEE_NAME,EMP.EMPLOYEE_SURNAME,CON.RECORD_DATE
  FROM [#dsn#].[#dsn#].[CONTENT] as CON
  ,[#dsn#].[#dsn#].[EMPLOYEES] as EMP
  where CON.CONTENT_STATUS=1
  and CON.CHAPTER_ID=2
  and CON.INTERNET_VIEW =1
  AND CON.RECORD_MEMBER =EMP.EMPLOYEE_ID
</cfquery>
<link href="/JS/marque/example/css/themes/simple.min.css" />
 <div class="block-hdnews">

          <div class="list-wrpaaer" style="height:400px">
  <ul class="list-aggregate" id="marquee-vertical">
<cfoutput query="getLeftContent">
<li>

<a>#CONT_BODY#</a>
<code>#EMPLOYEE_NAME# #EMPLOYEE_SURNAME# #dateFormat(RECORD_DATE,"dd/mm/yyyy")# #timeFormat(RECORD_DATE,"HH:mm")#</code>

</li>
</cfoutput>
</ul>
</div>
</div>
<script src="/JS/marque/src/js/jquery.marquee.js"></script>
<script type="text/javascript">
  
  $(function(){


  $('#marquee-vertical').marquee();  
  $('#marquee-horizontal').marquee({direction:'horizontal', delay:0, timing:50});  

});

</script>