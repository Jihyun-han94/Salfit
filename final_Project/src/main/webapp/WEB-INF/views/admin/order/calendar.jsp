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
     		        {"title": "${order.getPname()} / (${order.getQty()}) ",
     		        	"id" : "${order.getOid()}",
     		        	"start": "${order.getStartdate()}",
     		        	"end":"${order.getEnddate()}", 
     		        	"color": '#ff9f89',
     		        	"extendedProps" : {
     		        		"qty" : "${order.getQty()}",
     		        		"price" : "${order.getPrice()}",
        					"period" : "${order.getStartdate()} ~ ${order.getEnddate()} (${order.getDays()} 일)",
        					"receiver" : "${order.getReceiver()}",
        					"phone" : "${order.getPhone()}",
        					"address" : "주소: ${order.getAddress()}"
      					},
     		        	"description": "${order.getId()}"}
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
       /* select: function(start, end, startStr, jsEvent, view){
    	   ot_url="${orderurl}/list?ddate=";
           window.location = root_url + info.dateStr;
       }, */
       dateClick: function(info) {
    	    info.dayEl.style.backgroundColor = 'red';
         var root_url="${orderurl}/delivery?startdate=";
         window.location = root_url + info.dateStr;
    	  },
       events: groupMap,
       eventClick:function(info) {
    	  $("#oidinmodal").html(info.event.id);
    	  $("#titleinmodal").html(info.event.title);
    	  $("#addressinmodal").html(info.event.extendedProps.address);
    	  $("#receiverinmodal").html(info.event.extendedProps.receiver);
    	  $("#phoneinmodal").html(info.event.extendedProps.phone);
    	  $("#periodinmodal").html(info.event.extendedProps.period);

    	  $('#staticBackdrop').modal('show');
       } 
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
    
    
    	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="staticBackdropLabel">주문번호 :  <span id="oidinmodal"></span></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	 <div class="row">
	      	 	  <div class="col-4 col-sm-3">
			        [상품명  / 주문 수량]
			      </div>
			      <div class="col-8 col-sm-9">
			        <span id="titleinmodal"></span>
			      </div>
			 </div><hr>
			 <div class="row">
	      	 	  <div class="col-4 col-sm-3">
			        [배송 주소]         
			      </div>
			      <div class="col-8 col-sm-9">
			        <span id="addressinmodal"></span>
			      </div>
			 </div><hr>
			 <div class="row">
	      	 	  <div class="col-4 col-sm-3">
			        [받는 사람]         
			      </div>
			      <div class="col-8 col-sm-9">
			        <span id="receiverinmodal"></span>
			      </div>
			 </div><hr>
			 <div class="row">
	      	 	  <div class="col-4 col-sm-3">
			        [전화번호]         
			      </div>
			      <div class="col-8 col-sm-9">
			        <span id="phoneinmodal"></span>
			      </div>
			 </div><hr>
			  <div class="row">
	      	 	  <div class="col-4 col-sm-3">
			        [구독 기간(일수)]  
			      </div>
			      <div class="col-8 col-sm-9">
			        <span id="periodinmodal"></span>
			      </div>
			 </div>
		      </div>
		      <div class="modal-footer">
	        <button type="button"  class="btn btn-secondary"  data-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
  </body>
</html>