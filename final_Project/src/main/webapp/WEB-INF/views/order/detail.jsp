<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>결제 화면</h1>
	<div>
		상품명 : 과일 샐러드 <br>
		수량 : 1개 <br>
		금액 : 10000원<br>
	</div>
	<div>
		<c:url var="pay" value="/resources" />
		<a><img src = "${pay_img }/img/kakaopay/payment_icon_yellow_medium.png"></a>
	</div>
	
</body>
</html>