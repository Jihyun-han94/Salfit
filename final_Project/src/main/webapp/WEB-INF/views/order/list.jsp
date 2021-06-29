<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<h1>최근주문내역</h1>
<table id="orderedlist">
<th>날짜</th>
<th>상품정보</th>
<th>결제금액</th>
<th>상태</th>
</table>
<c:forEach var="data" items="${requestScope.orderlist }">
<tr>
<td>${data.pdate }</td>
<td></td>
<td>${total }</td>
<td>${status }</td>
</tr>
</c:forEach>
<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>

</body>
</html>