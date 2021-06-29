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
<jsp:include page="/WEB-INF/views/module/fullcalendar.jsp"></jsp:include>

<c:url var="orderurl" value="/admin/order" />
<script>
   
   document.addEventListener('DOMContentLoaded', function() {
       var groupMap = [
     		    <c:forEach items="${orderdetaillist}" var="order" varStatus="loop">
     		        {"title": "${order.getPname()} / ${order.getQty()}", "start": "${order.getStartdate()}", "end":"${order.getEnddate()}", "color": '#ff9f89', "url": '${orderurl}/list'}
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
       select: function(start, end, startStr, jsEvent, view){
       },
       dateClick: function(info) {
    	    alert('Clicked on: ' + info.dateStr);
    	    // change the day's background color just for fun
    	    info.dayEl.style.backgroundColor = 'red';
         var root_url="${orderurl}/list";
         window.location = root_url;
    	  },
       events: groupMap
     });
     calendar.render();
   });
   
 </script>
  </head>
  <body id="calendarBody">
  <header>
<%-- 		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include> --%>
	</header>
	<div class="bodyContainer">
		<h1 class="corpBoardTitle">배송 관리</h1>
    <div id='calendar'></div>
  </body>
</html>