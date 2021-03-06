<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page import="com.jey.webapp.order.dto.OrderDTO" %>
<%@ page import="com.jey.webapp.order.dto.OrderDetailDTO" %>
<%@ page import="com.jey.webapp.order.service.OrderService" %> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit | 주문서 작성</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
<c:url var="buy" value="/pay" />
<c:url var ="detail" value="/product/detail" />
<c:url var ="product" value="/product" />
<style>
.buy_btn1 {
 padding: 5px 25px;
 border: 1px solid #bac600;
 color: #263238;
 background: transparent;
 -moz-border-radius: 2px;
 -webkit-border-radius: 2px;
 border-radius: 2px;
}
.buy_btn1:hover {
  background-color: #bac600;
  color: #ffffff;
}
th, tr, th, table {
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
}
input, .address {
	width: 300px;
	border: 1px solid #e7e7e7;
	font-size: 15px;
}
</style>
</head>
<body>
<header style="padding-bottom:150px;">
	<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
</header>
<main class="cd-main-content sub-nav">
<div style="margin: 0 auto; width:63%; font-family : 'Kakao', 'sans-serif', 'normal'; font-size:13px;">
<h1 style="text-align:center; font-size: 30px; text-weight:bold; margin-bottom: 80px;">주문서 작성</h1>
<form action="${buy }" method="post">
<div style="float: center; padding-right:5px;">
<h1 style="margin-bottom: 50px;"><i class="bi bi-caret-right-fill" style="color:#e1e1e1; font-size: 20px;"> </i>주문 내역 확인</h1>
	<table border="1" id="id_cart" name="id_cart" style="text-align:center; width: 100%;">
	<tr>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">이미지</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">상품 명</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">가격</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">배송 방법</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">구독일 (기간)</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">총 주문 수량</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">금액</th>
	</tr>
		<c:forEach var="data" items="${requestScope.cartlist }">
		<tr>
		
		<td><a href="${detail}?id=${data.getPid()}">
			<img class="rounded card-img-top productImg" style="object-fit:contain;
            width:100px;
            height:100px;"
				src="${pageContext.request.contextPath}${data.getUrl()}" 
				>
		</a></td>
		<td><input name="cartid" value="${data.id }" type="hidden">${data.title }</td>
		<td>${data.price }</td>
		<td>택배</td>
		<td>${data.startdate } ~ ${data.enddate } (${data.days }일간)</td>
		<td>${data.qty * data.days}</td>
		<td>${data.money }</td>
		</tr>
		
		</c:forEach>
	</table>
		<p style="color: gray; padding-top:5px; padding-bottom: 3%;">* 상품 금액 30000원 이하는 배송비가 추가됩니다.</p>
	</div>
	<div style="float: right;">	
		<div style="width: 100%; text-align: right;">
			<label style="border-top: #e1e1e1;">총 주문 금액 : </label>
			<label style="border-top: #e1e1e1; padding-top:10px; font-size: 25px; color: #961533; font-weight:bold;"><input name="total" value="${totalMoney }" type="hidden">${totalMoney } 원</label>
		</div>
	</div>
	<div style="float:left; padding-top: 50px;">
		<h1 style="margin-bottom: 50px;"><i class="bi bi-caret-right-fill" style="color:#e1e1e1; font-size: 20px;"> </i>배송 정보</h1>
			<label for="receiver" style="margin-bottom: 20px; font-size: 15px;">받으시는 분&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 20px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input id="receiver" name="receiver" required>
		<br>
			<label for="address" style="font-size: 15px;">주소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 20px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<select name="address" id="address" class="address">
					<option >주소를 선택해 주세요</option>
				<c:forEach var="data" items="${requestScope.address_arr }">
	  				<option>${data.address }</option>
				</c:forEach>
	  				<option value="direct">직접 입력</option>
  			</select>
					<input type="text" id="dr_address" name="address">
		

		<br>
			<c:forEach var="data" items="${requestScope.cartlist }">
				<input id="aid" name="aid" value="${data.aid }" type="hidden" />
			</c:forEach>
			<input id="paytype" name="paytype" value="card" type="hidden" />
			<div style="text-align:center; margin-top:80px; margin-left: 690px;">	
			<button type="submit" class="buy_btn1">결제</button>
		</div>
	</div>
</form>
</div>
</main>
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>	
</body>
<script>
$(function(){
    //직접입력 인풋박스 기존에는 숨어있다가
$("#dr_address").hide();
$("#address").change(function() {
   //직접입력을 누를 때 나타남
		if($("#address").val() == "direct") {
			$("#dr_address").show();
			$("#dr_address").attr('required', 'required');
		}  else {
			$("#dr_address").hide();
		}
	}) 
});
</script>
</html>