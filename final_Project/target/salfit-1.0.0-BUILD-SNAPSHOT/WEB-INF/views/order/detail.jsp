<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit | Order Detail</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<style>
tr, th, table {
	border-right: #ffff;
	border-left: #ffff;
	border-top: #e1e1e1;
	border-bottom: #e1e1e1;
	padding-right: 30px;
	padding-left: 30px;
	padding-bottom: 20px;
	padding-top: 20px;
}

td {
	border-right: #ffff;
	border-left: #ffff;
	width: 150px;
	padding-top: 20px;
	padding-bottom: 20px;
}

h3, h4, h5 {
	color: gray;
}

th {
	border-top: solid 5px #e1e1e1;
	border-bottom: solid 5px #e1e1e1;
	padding-bottom: 10px;
}
</style>
<body>
	<header style="padding-bottom: 130px;">
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<div class="row">
		<div class="col-2"></div>
		<div class="text-center col-8  justify-content-center align-items-center">
			<main class="cd-main-content sub-nav" style="font-family: 'Kakao', 'sans-serif', 'normal';">
				<h1 style="padding-bottom: 50px;">주문 상세 정보</h1>
				<h4>리뷰를 작성해 주세요</h4>
				<h4 style="margin-bottom: 50px;">샐핏러들의 소중한 목소리를 기다립니다. <i class="bi bi-suit-heart-fill" style="color: #F07878;"></i></h4>
				<table border="1" style="text-align: center; font-family: 'Kakao', 'sans-serif', 'normal'; font-size: 13px; width: 100%;">
					<tr>
						<th>주문번호</th>
						<th>제품 이름</th>
						<th>제품 수량</th>
						<th>제품 가격</th>
						<th>주문 처리 상태</th>
						<th>리뷰</th>
					</tr>
					<c:url var="review" value="/order/review/add" />
					<c:forEach var="data" items="${requestScope.orderdetaillist }">
						<tr>
							<td>${data.oid }</td>
							<td>${data.title }</td>
							<td>${data.qty }</td>
							<td>${data.price }</td>
							<td>${data.status }</td>
							<td><c:if test="${data.status eq 'delivered'}">
									<a href="${review }?pid=${data.pid }"><i class="bi bi-chat-right-text-fill" style="color: #77A612;"></i></a>
								</c:if></td>
						</tr>
					</c:forEach>

				</table>
			</main>
		</div>
		<div class="col-2"></div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
	</footer>
</body>
</html>

