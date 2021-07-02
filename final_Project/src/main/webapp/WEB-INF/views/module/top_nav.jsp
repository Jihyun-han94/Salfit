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
	<c:url var="admin_product" value="/admin/product" />
	<c:url var="admin_order" value="/admin/order/list" />
	<c:url var="admin_delivery" value="/admin/order/calendar" />
	<c:url var="admin_statistics" value="/admin/order/summary" />

	<header class="cd-auto-hide-header">
		<div class="logo"><a href="${main }"><img src="/salfit/resources/img/log.png" alt="Logo" height="80px"></a></div>
	
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
				<li><a href="${admin_order }">주문 관리</a></li>
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
						<li><a href="#0">Contact Us</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${login }">Login</a></li>
						<li><a href="${join }">Join</a></li>
						<li><a href="#0">Contact Us</a></li>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
		</ul>
		</nav> <!-- .cd-primary-nav -->

	<nav class="cd-secondary-nav">
		<ul>
			<li><a href="#0">Notice</a></li>
			<li><a href="${product }">Menu</a></li>
			<li><a href="#0">Buy</a></li>
			<li><a href="#0">Review</a></li>
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
</script>
