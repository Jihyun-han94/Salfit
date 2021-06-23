<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
 <%@ include file="/WEB-INF/views/module/css_js.jsp" %>
<script type="text/javascript">
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/module/footer.jsp" %>

<h1>
장바구니
</h1>
<form>
	<table border="1" id="id_cart" name="id_cart">
		<th>이미지</th>
		<th>item</th>
		<th>수량</th>
		<th>배송수단</th>
		<th>배송비</th>
		<th>가격</th>
		<tr>
		<td>-</td>
		<td>과일샐러드</td>
		<td>1개</td>
		<td>택배</td>
		<td>3,000원</td>
		<td>1,8000원</td>
		</tr>
	</table>
	<br>
	<table border="1" id="id_price" name="id_price">
		<th>총 상품금액</th>
		<th>총 배송비</th>
		<th>결제예정금액</th>
		<tr>
		<td>18,000원</td>
		<td>3,000원</td>
		<td>21,000원</td>
		</tr>
	</table>
	<button type="button" onclick="buyall()">전체 상품주문</button>
	<button type="button">선택 상품주문</button>
</form>
</body>
</html>