<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">

	<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
	<c:url var="main" value="/" />
	<c:url var="join" value="/account/join" />
	<c:url var="login" value="/account/login" />
	<c:url var="update" value="/account/update" />
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
			<c:when test="${sessionScope.logined }">
				<li><a href="${update }">MyPage</a></li>
				<li><a href="#0">Cart</a></li>
				<li><a href="${logout }">Logout</a></li>
				<li><a href="#0">Contact Us</a></li>
			</c:when>
			<c:otherwise>
				<li><a data-toggle="modal" href="#myModal">Login</a></li>
				<li><a href="${join }">Join</a></li>
				<li><a href="#0">Contact Us</a></li>
			</c:otherwise>
		</c:choose>
		</ul>
		</nav> <!-- .cd-primary-nav -->

	<nav class="cd-secondary-nav">
		<ul>
			<li><a href="#0">Notice</a></li>
			<li><a href="#0">Menu</a></li>
			<li><a href="#0">Buy</a></li>
			<li><a href="#0">Review</a></li>
		</ul>
	</nav> <!-- .cd-secondary-nav -->
</header> <!-- .cd-auto-hide-header -->
	
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
		<%-- <p style="color:red;">${param.error}</p> --%>
		<div class="d-flex flex-column text-center">
		<form action="${login}" method="POST">
			<%-- <div>
				<label style="color:red;">${error != null ? error : ""}</label>
			</div> --%>
			<div class="form-group">
				<label for="id_email">이메일</label>
				<input id="id_email" type="email" name="email" placeholder="email" required>
			</div>
			<div class="form-group">
				<label for="id_password">비밀번호</label>
				<input id="id_password" type="password" name="password" placeholder="password" required>
			</div>
			<div>
				<button type="submit" class="btn btn-info btn-block btn-round">로그인</button>
				<c:url var="main" value="/product/main" />
				<%-- <button type="button" class="btn btn-info btn-block btn-round" onclick="location.href='${main}'">취소</button> --%>
			</div>
		</form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
</div>
	
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	if( !window.jQuery ) document.write('<script src="js/jquery-3.0.0.min.js"><\/script>');
</script>
<script src="/webapp/resources/js/main.js"></script> <!-- Resource jQuery -->>
</body>
</html>