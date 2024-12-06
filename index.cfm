<cfprocessingdirective suppresswhitespace="Yes">
<!DOCTYPE html>
<html lang="tr">
	<head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>Catalyst</title>
        <cfif not isdefined("attributes.AjaxPage")>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
            <link rel="stylesheet" href="css/w3PStyle.css" type="text/css">
            <link rel="stylesheet" href="css/components.css" type="text/css">
            <link rel="stylesheet" href="css/fonts/icon8/styles.min.css">
            <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
            <link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.1.0/fullcalendar.min.css' rel='stylesheet' />
            <link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.1.0/fullcalendar.print.css' rel='stylesheet' media='print' />
            <link rel="stylesheet" href="css/bootstrap-select.css">
            <link rel="stylesheet" href="css/addons/profile.css" type="text/css">
            <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
            <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
            <script src="https://use.fontawesome.com/edd93eaf8f.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
            <script src='https://momentjs.com/downloads/moment.js'></script>
            <script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.1.0/fullcalendar.min.js'></script>
            <script src='https://fullcalendar.io/js/fullcalendar-3.1.0/locale-all.js'></script>
            <script src='js/bootstrap-select.js'></script>
            <script src='js/defaults-tr_TR.js'></script>
		<script src="js/Chart.js"></script>
        </cfif>
		<script src="js/custom.js"></script>
		<script src="js/dropzone.js"></script>
        <link rel="stylesheet" href="css/dropzone.css" type="text/css">
	</head>
	<body>
    	<cfif isdefined("session.pp")>
        	<cfif isdefined("attributes.pageInfo") and len(attributes.pageInfo)>
				<cfinclude template="pages/layout.cfm">
            <cfelse>
            	<cfset attributes.pageInfo = 'welcome'>
            	<cfinclude template="pages/layout.cfm">
            </cfif>
        <cfelse>
	        <cfinclude template="login/login.cfm">
        </cfif>
      
	</body>
</html>
</cfprocessingdirective>
