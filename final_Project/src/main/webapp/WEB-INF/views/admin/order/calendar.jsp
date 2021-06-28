<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='utf-8' />
<title>관리자 주문 관리</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
<link href='/salfit/resources/static/fullcalendar/main.css' rel='stylesheet' />
<!-- Fullcalendar Starts -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://momentjs.com/downloads/moment.min.js"></script>

<script src='/salfit/resources/static/fullcalendar/main.js'></script>

<c:url var="orderurl" value="/admin/order" />
<script>
   
   document.addEventListener('DOMContentLoaded', function() {
       var groupMap = [
     		    <c:forEach items="${orderlist}" var="order" varStatus="loop">
     		        {"title": "${order.getId()}", "start": "${order.getPdate()}", "end":"${order.getDdate()}", "color": '#ff9f89', "url": '${orderurl}/list'}
     		        ${!loop.last ? ',' : ''}
     		    </c:forEach>
     		];  
     
 	var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	  headerToolbar: {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek,dayGridDay,listMonth'
          },
       navLinks: true,
       dayMaxEvents: true, 
       initialView: 'dayGridMonth',
       selectable: true,
       selectHelper: true,
       select: function(start, end, jsEvent, view){
         //wrtie your redirection code here
         var root_url="${orderurl}/list";
         window.location = root_url;
       },
       events: groupMap
     });
     calendar.render();
   });

 </script>
 <style>

body {
  margin: 40px 10px;
  padding: 0;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}

#calendar {
  max-width: 1100px;
  margin: 0 auto;
}

</style>
  </head>
  <body>
    <div id='calendar'></div>
    <!-- <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	<div class="modal-content">
	<div class="modal-body">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	<span aria-hidden="true">&times;</span>
	</button>
	<p></p>
	</div>
	</div>
	</div>
	</div> -->
  </body>
</html>