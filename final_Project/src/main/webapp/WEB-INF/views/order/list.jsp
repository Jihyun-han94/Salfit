<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역리스트조회</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<c:url var="hold" value="/ajax/order/hold" />
<c:url var="update" value="/ajax/order/update" />
<c:url var="detail" value="/order/detail" />
<script type="text/javascript">
 function confirmdel(id) {
    var confirm_val = confirm("배송완료 확정하시겠습니까?");
      
    if(confirm_val){
          var btnElement = document.getElementsByName(id)[0];
         
         btnElement.innerText = '배송완료';
         
         var id = id //order.id
         
            $.ajax({
             url :  "${update }",
             type : "post",
             datatype:"json",
             data : {id : id},
             success : function(data){
             alert(data.result);
             }
            });     
    }   
 }
   
   function cancel(id2){
      
      var confirm_val = confirm("해당 상품을 구매를 취소하시겠습니까?");
      
      if(confirm_val){
         var btnElement2 = document.getElementsByName(id2)[0];
         btnElement2.innerText = '취소요청중';
      
         var id2 = id2; //order.id
         
            $.ajax({
             url :  "${hold }",
             type : "post",
             datatype:"json",
             data : {id : id2},
             success : function(data){
             alert(data.result);
             }
            });
      }   
   }   
</script>
<style>
th, tr, table {
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
	padding-top: 10px;
	padding-bottom: 10px;
	width: 10%;
}

th {
	border-top: solid 5px #e1e1e1;
	border-bottom: solid 5px #e1e1e1;
}

 .list_btn {
	padding: 3px 20px;
	border: 1px solid #bac600;
	color: #263238;
	background: transparent;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
}

 .list_btn:hover {
  background-color: #bac600;
  color: #ffffff;
}

.unpaid_a {
  color: #bac600; 
}

.unpaid_a:hover {
  color: #3E5902;
}
</style>
<body>

	<header style="padding-bottom: 130px;">
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<main class="cd-main-content sub-nav">
		<div
			style="margin: auto; width:80%; text-align: center; font-family: 'Kakao', 'sans-serif', 'normal'; font-size: 13px;">
			<h1 style="padding-bottom: 30px;">${username } 님의 주문 내역  <i class="bi bi-card-checklist" style="color: #77A612"></i></h1>

			<table id="orderedlist" border="1">
				<tr>
					<th>날짜</th>
					<th>수령인</th>
					<th>주소</th>
					<th>결제금액</th>
					<th>상태</th>
					<th>배송확인</th>
					<th>취소요청</th>
				</tr>
				<c:forEach var="data" items="${requestScope.orderlist }">
					<tr>
						<td><a href="${detail }?id=${data.id }">${data.pdate }</a></td>
						<td>${data.receiver }</td>
						<td>${data.address }</td>
						<td>${data.total }</td>
						<c:choose>
							<c:when test="${data.status eq 'unpaid' }">
								<!-- unpaid로 바꾸기 -->
								<td><a class="unpaid_a" href="/salfit/pay/later?id=${data.id }">결제하러 가기</a></td>
								<!--결제 되게 a태그 넣기-->
							</c:when>

							<c:when test="${data.status eq 'paid' }">
								<td>결제완료</td>
							</c:when>

							<c:when test="${data.status eq 'checked' }">
								<td>주문 확인 중</td>
							</c:when>

							<c:when test="${data.status eq 'shipping' }">
								<td>배송중</td>
							</c:when>

							<c:when test="${data.status eq 'delivered' }">
								<td>결제완료</td>
							</c:when>

							<c:when test="${data.status eq 'holding' }">
								<td>취소요청</td>
							</c:when>

							<c:when test="${data.status eq 'canceled' }">
								<td>취소완료</td>
							</c:when>

						</c:choose>

						<c:choose>
							<c:when test="${data.status eq 'delivered' }">
								<td>배송완료</td>
							</c:when>
							<c:when test="${data.status eq 'unpaid' }">
								<td>-</td>
								<!--결제 되게 a태그 넣기-->
							</c:when>
							<c:when test="${data.status eq 'holding' }">
								<td>-</td>
								<!--결제 되게 a태그 넣기-->
							</c:when>
							<c:when test="${data.status eq 'canceled' }">
								<td>-</td>
								<!--결제 되게 a태그 넣기-->
							</c:when>
							<c:otherwise>
								<td><button class="list_btn" id="btn1" name="${data.id }"
										onclick="confirmdel(${data.id });">배송확인</button></td>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${data.status eq 'holding' }">
								<td>취소요청중</td>
							</c:when>
							<c:when test="${data.status eq 'canceled' }">
								<td>취소완료</td>
							</c:when>
							<c:otherwise>
								<td><button class="list_btn" id="btn2" name="${data.id }"
										onclick="cancel(${data.id});">취소요청</button></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>

			</table>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
	</footer>
</body>




</html>