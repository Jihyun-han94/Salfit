<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.jey.webapp.order.dto.OrderDTO" %>
<%@ page import="com.jey.webapp.order.dto.OrderDetailDTO" %>
<%@ page import="com.jey.webapp.order.service.OrderService" %>

<c:url var ="pay" value="/pay" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

		<h1>주문서 작성</h1>
		<c:url var="buy" value="/pay" />
		<form action="${pay }" method="post">
		
			<table border="1" id="id_cart" name="id_cart">
				<th>이미지</th>
				<th>item</th>
				<th>수량</th>
				<th>배송수단</th>
				<th>배송비</th>
				<th>판매가</th>
				<th>합계</th>
			
			<c:forEach var="data" items="${requestScope.cartlist }">
				<tr>
					<td>-</td>
					<td>${data.title }</td>
					<td>${data.qty }개</td>
					<td>택배</td>
					<td>3,000원</td>
					<td>${data.price }원</td>
					<td>${data.money }원</td>
				</tr>
			</c:forEach>
		</table>
		
		<table border="1" id="id_price" name="id_price">
			<th>총 상품금액</th>
			<th>총 배송비</th>
			<th>결제예정금액</th>
			<tr>
				<td>${sumMoney }원</td>
				<td>${delfee }원</td>
				<td><input name="total" value="${totalMoney }" hidden>${totalMoney }원</td>
			</tr>
	</table>
	
	<br>
	
	<h1>배송 정보</h1>
		<label for="receiver">받으시는 분 : </label>
		<input id="receiver" name="receiver" required>
	<br>
		<label for="address">주소 : </label>
		<input id="address" name="address" required>
	<br>
		<c:forEach var="data" items="${requestScope.cartlist }">
			<input id="aid" name="aid" value="${data.aid }" hidden />
		</c:forEach>
	
	<button type="submit" >결제하기</button>
	
	</form>
<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>	
</body>
</html>