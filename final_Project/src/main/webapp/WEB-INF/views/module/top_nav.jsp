<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- google 로그인 -->
	<meta name ="google-signin-client_id" content="1082904925061-uort5h8csjfdcshpe89qs881hjdbfhfg.apps.googleusercontent.com">
	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">

	<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
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
	
</head>
<body>
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
<%-- 	
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="form-title text-center">
          <h4>Login</h4>
        </div>
		<p style="color:red;">${param.error}</p>
		<div class="d-flex flex-column text-center">
		<form action="${login}" method="POST">
			<div>
				<label style="color:red;">${error != null ? error : ""}</label>
			</div>
			<div class="form-group">
				<label for="id_email">이메일</label>
				<input id="id_email" type="email" name="email" placeholder="email" required>
			</div>
			<div class="form-group">
				<label for="id_password">비밀번호</label>
				<input id="id_password" type="password" name="password" placeholder="password" required>
			</div>
			<div class="g-signin2" data-onsuccess="onSignIn"><a href="${google_url}">구글 로그인</a></div>
			<div>
				<button type="submit" class="btn btn-info btn-block btn-round">로그인</button>
				<c:url var="main" value="/product/main" />
				<button type="button" class="btn btn-info btn-block btn-round" onclick="location.href='${main}'">취소</button>
			</div>
		</form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
</div> --%>

<!-- Modal -->
<div class="modal fade" id="ModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="form-title text-center">
        </div>
		<%-- <p style="color:red;">${param.error}</p> --%>
		<div class="d-flex flex-column text-center">
		<form action="${updateView}" method="POST">
			<div class="form-group">
			<%-- <input type="hidden" name="id" id="id" value="${requestScope.account.getId() }"> --%>
				<%-- <label for="id_email">이메일</label>
				<input id="id_email" type="email" name="email" value="${requestScope.account.getEmail() }" disabled> --%>
			</div>
			<div class="form-group">
				<label for="id_password">비밀번호 확인</label>
				<input id="id_password" type="password" name="password" placeholder="password" required>
				<button type="submit" class="btn btn-info btn-block btn-round">확인</button>
			</div>
		</form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
</div>

<script type="text/javascript">

	  function onSignIn(googleUser) {
		  var profile = googleUser.getBasicProfile();
		  var id_token = googleUser.getAuthResponse().id_token;
		  var xhr = new XMLHttpRequest();
		  xhr.open('POST', 'http://localhost/google_login');
		  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		  xhr.onload = function() {
		    console.log('Signed in as: ' + xhr.responseText);
		  };
		  xhr.send('idtoken=' + id_token);
	}//onSignIn
	
function onSignInFailure(t){		
	console.log(t);
}
</script>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	if( !window.jQuery ) document.write('<script src="js/jquery-3.0.0.min.js"><\/script>');
</script>
<script src="/webapp/resources/js/main.js"></script> <!-- Resource jQuery -->>
<!-- 구글 api 사용을 위한 스크립트 -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
</body>
</html>