<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit | pay completed!</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<style>
.order_btn {
 padding: 5px 25px;
 border: 1px solid #bac600;
 color: #263238;
 background: transparent;
 -moz-border-radius: 2px;
 -webkit-border-radius: 2px;
 border-radius: 2px;
}
.order_btn:hover {
  background-color: #bac600;
  color: #ffffff;
}
</style>
<body>
<header style="padding-bottom: 100px;">
	<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
</header>
<fmt:parseDate value="${orderDTO.ddate }" var="dateFmt" pattern="yyyy-MM-dd"/>
<fmt:formatDate value="${dateFmt }" pattern="M월 dd일" var="date"/>
<c:url var="order" value="/order" />

<main class="cd-main-content sub-nav">
<div style="margin: 0 auto; width:86%; text-align: center; font-family: 'Kakao', 'sans-serif', 'normal'; font-size: 15px;">
<i style="font-size: 180px; color: #bac600;" class="bi bi-check-circle-fill"></i>
<h1 style="font-size: 30px; padding-bottom: 20px;">${orderDTO.total } 원 결제 완료 !</h1>
<h2 style="padding-bottom: 30px;">${date } 아침 문고리를 확인해 주세요 <i class="bi bi-suit-heart-fill" style="color: #EF7B96;"></i></h2>
<button type="button" class="order_btn" onclick="location='${order }'">내 주문 확인하러 가기</button>
</div>
</main>
<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
</html>