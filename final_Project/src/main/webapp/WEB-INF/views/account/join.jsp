<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
 <%@ include file="/WEB-INF/views/module/css_js.jsp" %>
<c:url var="email_check" value="/ajax/account/email" />
<script type="text/javascript">
</script>
</head>
<body>
<nav>
	<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
</nav>
<section class="body_class">
<h1 class="first_class">Join 회원가입</h1>
	<c:url var="join" value="/account/join" />
	<form name="account_form" action="${join}" method="POST">
		<div>
			<label for="id_email">* 이메일</label>
			<input id="id_email" type="email" name="email" oninput="emailCheck('${email_check}', this.value);" required>
			<label id="email_check_res"></label>
		</div>
		<div>
			<label for="id_password">* 비밀번호</label>
			<input id="id_password" type="password" name="password" required>
		</div>
		<div>
			<label for="id_username">* 이름</label>
			<input id="id_username" type="text" name="name" required>
		</div>
		<div>
			<label for="id_phnumber">* 전화번호</label>
			<input id="id_phnumber" type="text" name="phone" required>
		</div>
		<div>
			<button type="submit">가입</button>
			<button type="button" onclick="history.back();">취소</button>
		</div>
	</form>
	
</section>
<footer>
  <%@ include file="/WEB-INF/views/module/footer.jsp" %>
</footer>
</body>
</html>