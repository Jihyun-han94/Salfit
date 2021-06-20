<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
 <%@ include file="/WEB-INF/views/module/css_js.jsp" %>
</head>
<body>
<c:url var="login" value="/account/login" />
	<p style="color:red;">${param.error}</p>
	<form action="${login}" method="POST">
		<div>
			<label style="color:red;">${error != null ? error : ""}</label>
		</div>
		<div>
			<label for="id_email">이메일</label>
			<input id="id_email" type="email" name="email" required>
		</div>
		<div>
			<label for="id_password">비밀번호</label>
			<input id="id_password" type="password" name="password" required>
		</div>
		<div>
			<button type="submit">로그인</button>
			<c:url var="main" value="/product/main" />
			<button type="button" onclick="location.href='${main}'">취소</button>
		</div>
	</form>
	 <%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
</html>