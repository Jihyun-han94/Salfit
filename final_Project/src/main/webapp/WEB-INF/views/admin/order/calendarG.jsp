<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8' />
    <link href='/salfit/resources/static/fullcalendar/main.css' rel='stylesheet' />
    <script src='/salfit/resources/static/fullcalendar/main.js'></script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          googleCalendarApiKey: 'AIzaSyALUo_FiijVT8p4rBn-8Fo7J22_PvOuokU',
          events: 
        	  {
	            googleCalendarId: 'jv7ik7a2s5chfccnv88qrianeg@group.calendar.google.com',
	            className: 'gcal-event' // an option!
	          }, eventClick: function(info) {
	        	  info.jsEvent.stopPropagation();
	        	  info.jsEvent.preventDefault();
	          }
        });
        calendar.render();
      });
    </script>
  </head>
  <body>
    <div id='calendar'></div>
  </body>
</html>