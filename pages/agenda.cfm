<cfset getQueryAgendaData = createObject('component','cfc.components')>
<cfif not isdefined("attributes.project_id")>
	<cfset attributes.project_id = ''>
	<cfset getQueryAgenda = getQueryAgendaData.GET_QUERY_AGENDA()>
<cfelse>
	<cfset getQueryAgenda = getQueryAgendaData.GET_QUERY_AGENDA(project_id:attributes.project_id)>
</cfif>

<script>
$( function() {
	<cfif not isdefined("attributes.date")>
		var date = new Date();
	<cfelse>
		var date = '<cfoutput>#attributes.date#</cfoutput>';
	</cfif>
	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'year,month,agendaWeek,agendaDay,listWeek'
		},
		defaultDate: date,
		locale: 'tr',
		buttonIcons: false, // show the prev/next text
		weekNumbers: false,
		navLinks: true, // can click day/week names to navigate views
		//editable: true,
		eventLimit: true, // allow "more" link when too many events
		
		events: [			
			<cfoutput query="getQueryAgenda"> 
				{
					title: '#EVENT_HEAD#',
					start: '#DateFormat(STARTDATE, "yyyy-mm-dd")#T#TimeFormat(dateAdd("h",session.pp.time_zone,STARTDATE),"hh:mm:ss")#',
					end: '#DateFormat(FINISHDATE, "yyyy-mm-dd")#T#TimeFormat(dateAdd("h",session.pp.time_zone,FINISHDATE),"hh:mm:ss")#',
					color: '#COLOUR#',
					url : 'index.cfm?pageinfo=agendaDet&eventId=#encrypt(EVENT_ID,"WORKCUBE","BLOWFISH","Hex")#'
				},
			</cfoutput> 
		]
	});
});
</script>
<cfif not len(attributes.project_id)>
	<div class="pageContent">
</cfif>
	<div id='calendar'></div>
<cfif not len(attributes.project_id)>
	</div>
</cfif>
