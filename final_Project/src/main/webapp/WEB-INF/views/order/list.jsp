<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역리스트조회</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
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

<h1>${username }님의 주문내역</h1>

<table id="orderedlist" border="1">
	<th>날짜</th>
	<th>수령인</th>
	<th>주소</th>
	<th>결제금액</th>
	<th>상태</th>
<c:url var ="detail" value="/order/detail" />
<c:forEach var="data" items="${requestScope.orderlist }" >
	<tr>
		<td><a href="${detail }?id=${data.id }">${data.pdate }</a></td>
		<td>${data.receiver }</td>
		<td>${data.address }</td>
		<td>${data.total }</td>
		<c:choose>
			<c:when  test ="${data.status eq 'bpayment' }">
			<td>결제 하러가기</td> <!--결제 되게 a태그 넣기-->
			</c:when>
			<c:when test = "${data.status eq 'paid' }">
			<td>결제 완료</td>
			</c:when>
			<c:when test = "${data.status eq 'paid' }">
			<td>결제 완료</td>
			</c:when>
			<c:when test = "${data.status eq 'shipping' }">
			<td>배송 중</td>
			</c:when>
			<c:when test = "${data.status eq 'delivered' }">
			<td>배송 완료</td>
			</c:when>
			<c:when test = "${data.status eq 'holding' }">
			<td>취소요청</td>
			</c:when>
			<c:when test = "${data.status eq 'canceled' }">
			<td>취소 완료</td>
			</c:when>
			
		</c:choose>
		
	</tr>
</c:forEach>

</table>

<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>

</body>
</html>