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
<c:url var="producturl" value="/admin/product/detail" />
<c:url var="orderurl" value="/admin/order" />
<script>
   document.addEventListener('DOMContentLoaded', function() {
       var groupMap = [
     		    <c:forEach items="${orderdetaillist}" var="order" varStatus="loop">
     		        {"title": "상품명 : ${order.getPname()} / 수량 : ${order.getQty()} 개 / 주소: ${order.getAddress()} ", "start": "${order.getStartdate()}", "end":"${order.getEnddate()}", "color": '#ff9f89', "url": '${producturl}?id=${order.getPid()}'}
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
       selectable: false,
       selectHelper: true,
       select: function(start, end, startStr, jsEvent, view){
       },
       dateClick: function(info) {
    	    info.dayEl.style.backgroundColor = 'red';
         var root_url="${orderurl}/list?ddate=";
         window.location = root_url + info.dateStr;
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
		<div class="row">
		    <div class="col-xs-12">
		        <div class="text-right">
					<a href="${orderurl}/list" class="btn btn-default float-right">주문 관리</a>
		        </div>
		    </div>
		</div>
    <div id='calendar'></div>
  </body>
</html>