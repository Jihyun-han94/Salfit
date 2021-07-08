<%@ page language="java" contentType="text/html; charset=UTF-8"	
    pageEncoding="UTF-8"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
	<meta name="viewport" content="width=device-width, initial-scale=1">	
	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">	
	<c:url var="main" value="/" />	
	<c:url var="join" value="/account/join" />	
	<c:url var="login" value="/account/login" />	
	<c:url var="logout" value="/account/logout" />	
	<c:url var="update" value="/account/update" />	
	<c:url var="updateView" value="/account/update_view" />	
	<c:url var="product" value="/product" />	
	<c:url var="cart" value="/cart" />	
	<c:url var="about" value="/about_us" />	
	<c:url var="notice" value="/notice" />	
	<c:url var="email_write" value="/email/write" />	
	<c:url var="admin_product" value="/admin/product" />	
	<c:url var="admin_order" value="/admin/order/list" />	
	<c:url var="admin_delivery" value="/admin/order/calendar" />	
	<c:url var="admin_statistics" value="/admin/order/summary" />
	<c:url var="search" value="/admin/product" />
	<style>	
.new-order-counter {	
 position:absolute;	
 top: -7px;	
 right: -11px;	
 min-width: 8px;	
 height: 20px;	
 line-height: 20px;	
 margin-top: -11px;	
 padding: 0 6px;	
 font-weight: normal;	
 font-size: small;	
 color: white;	
 text-align: center;	
 text-shadow: 0 1px rgba(0, 0, 0, 0.2);	
 background: #e23442;	
 /* border: 1px solid #911f28; */	
 border-radius: 11px;	
 background-image: -webkit-linear-gradient(top, #e8616c, #dd202f);	
 background-image: -moz-linear-gradient(top, #e8616c, #dd202f);	
 background-image: -o-linear-gradient(top, #e8616c, #dd202f);	
 background-image: linear-gradient(to bottom, #e8616c, #dd202f);	
 -webkit-box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);	
 box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);	
}	
.delivery-counter {	
 position:absolute;	
 top: -5px;	
 right: -4px;	
 min-width: 8px;	
 height: 20px;	
 line-height: 20px;	
 margin-top: -11px;	
 padding: 0 6px;	
 font-weight: normal;	
 font-size: small;	
 color: white;	
 text-align: center;	
 text-shadow: 0 1px rgba(0, 0, 0, 0.2);	
 background: #3b8de2;	
 /* border: 1px solid #215a96; */	
 border-radius: 11px;	
 background-image: -webkit-linear-gradient(top, #67a7e9, #2580df);	
 background-image: -moz-linear-gradient(top, #67a7e9, #2580df);	
 background-image: -o-linear-gradient(top, #67a7e9, #2580df);	
 background-image: linear-gradient(to bottom, #67a7e9, #2580df);	
 -webkit-box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);	
 box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);	
}	
</style>	
	<header class="cd-auto-hide-header">	
		<div class="logo">
		<a href="${main }"><img src="/salfit/resources/img/log.png" alt="Logo" height="80px" style="float: left;"></a>
				<form id="search_form" action="${search }" method="get" style="padding-left: 50px; padding-top: 25px; float:right;">
		<c:if test="${not empty param.ptype}" >
			<input type="hidden" name="ptype" value="${param.ptype }">
		</c:if>
	    <select id="searchtype" name="searchtype" style="width:80px; color: #D3D3D3; font-size:13px; border-radius: 10px; height:30px; border-color: #ffff; text-align: center;">
	        <option>category</option>
	        <option value="t">제품 명</option>
	        <option value="c">제품 정보</option>
	    </select>
		<input type="text" name="search" style="width: 230px; height:23px; border-radius: 20px; border:1px solid #D3D3D3;">
		<button type="submit" class="btn_search" style="margin-left:-12px;"><i class="bi bi-search" style="color: #D3D3D3; font-size:7px; margin-left:-12px;"></i></button>
	</form>
			</div>
		<nav class="cd-primary-nav">	
			<a href="#cd-navigation" class="nav-trigger">	
				<span>	
					<em aria-hidden="true"></em>	
					Menu	
				</span>	
			</a> <!-- .nav-trigger -->	
		<ul id="cd-navigation">	
		<c:choose>	
			<c:when test="${sessionScope.atype == 'a' }">	
				<li><a href="${admin_product }">상품 관리</a></li>	
				<li id="neworder_nav"><a href="${admin_order }" style="position:relative;">주문 관리<span id="neworder_alert"></span></a></li>	
				<li><a href="${admin_delivery }">배송 관리</a></li>	
				<li><a href="${admin_statistics }">통계</a></li>	
				<li><a href="${logout }">Logout</a></li>	
			</c:when>	
			<c:otherwise>	
				<c:choose>	
					<c:when test="${sessionScope.logined }">	
						<li><a data-toggle="modal" href="#ModalConfirm">MyPage</a></li>	
						<li><a href="${cart }">Cart</a></li>	
						<li><a href="${logout }">Logout</a></li>	
					</c:when>	
					<c:otherwise>	
						<li><a href="${login }">Login</a></li>	
						<li><a href="${join }">Join</a></li>	
					</c:otherwise>	
				</c:choose>	
			</c:otherwise>	
		</c:choose>	
		</ul>	
		</nav> <!-- .cd-primary-nav -->	
	<nav class="cd-secondary-nav">	
		<ul>	
			<li><a href="${notice }">Notice</a></li>	
			<li><a href="${product }">Menu</a></li>	
			<li><a href="${about }">About</a></li>	
			<li><a href="mailto:salfit.contact@gmail.com?Subject=[문의 메일]%20&body=해당%20이메일%20주소로%20순차적으로%20답변을%20드립니다.
		%0D%0A%0D%0A신청하는%20분%20이름:%0D%0A신청하는%20분%20연락처:%0D%0A문의사항:%0D%0A
		(원활한%20상담을%20위해%20상품명,%20수량,%20희망시간%20등을%20적어주세요.)" target="_top">Contact Us</a></li>	
		</ul>	
	</nav> <!-- .cd-secondary-nav -->	
</header> <!-- .cd-auto-hide-header -->	
<!-- Modal -->	
<div class="modal fade" id="ModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">	
  <div class="modal-dialog modal-dialog-centered modal-40size" role="document">	
    <div class="modal-content">	
      <div class="modal-header border-bottom-0">	
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">	
          <span aria-hidden="true">×</span>	
        </button>	
      </div>	
      <div class="modal-body">	
      <div class="form-title text-center">	
        </div>	
		<div class="d-flex flex-column text-center">	
		<h2 style="margin-bottom: 10px; color: #475c01;">회원 비밀번호 확인</h2>	
		<h5>외부로부터 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</h5>	
		<h5>항상 비밀번호는 타인에게 노출되지 않도록 주의해 주세요.</h5>	
		<br>	
		<form action="${updateView}" method="POST">	
			<div class="form-group">	
				<input style="margin-bottom: 20px;" id="id_password_confirm" type="password" name="password" placeholder="password" required>	
				<div>	
					<button type="submit" class="btn_nav_confirm">확인</button>	
				</div>	
			</div>	
		</form>	
      </div>	
      <div class="modal-footer">	
      </div>	
    </div>	
  </div>	
</div>	
</div>	
<script>	
	if( !window.jQuery ) document.write('<script src="js/jquery-3.0.0.min.js"><\/script>');	
		
	var websocket;	
   	var neworder_alert = document.getElementById("neworder_alert");	
   	var neworder_nav = document.getElementById("neworder_nav");	
	var prev_val = neworder_alert.innerText; 	
   	neworder_nav.addEventListener("click", function(){	
	    	neworder_alert.classList.remove('new-order-counter');	
   	});	
    websocket = new WebSocket("ws://localhost/salfit/alert");	
    	
    websocket.onmessage = function(message) {	
    	//alert(message.data);	
    	onMessage(message); 	
    }	
    	
    function onMessage(evt) {	
    	if(!neworder_alert.classList.contains('new-order-counter')) {	
    		neworder_alert.classList.add('new-order-counter');	
	    }	
    	//var val = prev_val + 1;	
   		neworder_alert.innerText = "new";  	
}	
	    		
    var testDate ="넘겨주는 값";
</script>