<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit | Order Detail</title>
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
	<h1>주문 상세 정보</h1>
	<table border="1">
	<th>주문번호</th>
	<th>제품 이름</th>
	<th>제품 수량</th>
	<th>제품 가격</th>
	<th>주문처리상태</th>
	<th>리뷰</th>
	
	<c:url var ="review" value="/order/review/add" />
	<c:forEach var="data" items="${requestScope.orderdetaillist }" >
	<tr>
	<td>${data.oid }</td>
	<td>${data.title }</td>
	<td>${data.qty }</td>
	<td>${data.price }</td>
	<td>${data.status }</td>
	<td><a href="${review }?pid=${data.pid }">리뷰작성하기</a></td>
	</tr>
	</c:forEach>
	
	</table>
<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>	
</body>
</html>