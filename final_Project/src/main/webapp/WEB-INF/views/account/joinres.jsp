<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입완료</title>
</head>
<body>
	<h1>${error}</h1>
	<h3>이메일 : ${dto.getEmail()}</h3>
	<h3>이름 : ${dto.getName()}</h3>
	<button onclick="location.href='${pageContext.request.contextPath}/account/login'">로그인 하기</button>
</body>
</html>