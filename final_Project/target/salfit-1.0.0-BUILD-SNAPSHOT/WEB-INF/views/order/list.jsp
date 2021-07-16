<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit | Order List</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<c:url var="hold" value="/ajax/order/hold" />
<c:url var="delete" value="/ajax/order/delete" />
<c:url var="update" value="/ajax/order/update" />
<c:url var="detail" value="/order/detail" />
<script type="text/javascript">
function cancel2(id3){
    
    var confirm_val = confirm("해당 상품을 구매를 삭제하시겠습니까?");
    
    if(confirm_val){
       var btnElement3 = document.getElementsByName(id3)[0];
       btnElement3.innerText = '삭제요청중';
       btnElement3.setAttribute("disabled", "disabled");
    
       var id3 = id3; //order.id
       
          $.ajax({
           url :  "${delete }",
           type : "post",
           datatype:"json",
           data : {id : id3},
           success : function(data){
           alert(data.result);
           location.href = data.redirect;
           }
          });
    }
}

 function confirmdel(id) {
    var confirm_val = confirm("배송완료 확정하시겠습니까?");
      
    if(confirm_val){
          var btnElement = document.getElementsByName(id)[0];
         
         btnElement.innerText = '배송완료';
         btnElement.setAttribute("disabled", "disabled");
         
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
         var btnElement2 = document.getElementsByName(id2)[1];
     
      
         var id2 = id2; //order.id
         
            $.ajax({
             url :  "${hold }",
             type : "post",
             datatype:"json",
             data : {id : id2},
             success : function(data){
	           alert(data.result);
	           btnElement2.setAttribute("disabled", "disabled");
	           btnElement2.innerText=data.res;
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

h3, h4, h5 {
 color: gray;
}
</style>
<body>
	<header style="padding-bottom: 130px;">
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<main class="cd-main-content sub-nav">
		<div
			style="margin: auto; width:80%; text-align: center; font-family: 'Kakao', 'sans-serif', 'normal'; font-size: 13px;">
			<h1 style="padding-bottom: 30px; font-size:30px;">${username } 님의 주문 내역  <i class="bi bi-card-checklist" style="color: #77A612"></i></h1>
			<h3 style="margin-bottom: 20px;">주문해 주셔서 감사합니다 !</h3>
			<h4>해당 상품은 <span style="color: #F08080;">결제일 기준 익일 배송</span>됩니다.</h4>
			<h4 style="margin-bottom: 50px;">구독일 아침, 문고리를 확인 해 주세요.</h4>
			<h5 style="text-align:left;"> * 주문 내역의 구매하신 날짜를 클릭하시면 주문 상세 정보를 확인하실 수 있습니다.</h5>
			<table id="orderedlist" border="1" style="width: 100%;">
				<tr>
					<th>날짜<br>(상세 주문)</th>
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
								<td><a class="list_btn" href="${pageContext.request.contextPath}/pay/later?id=${data.id }">결제하러 가기</a></td>
								<!--결제 되게 a태그 넣기-->
							</c:when>

							<c:when test="${data.status eq 'paid' }">
								<td style="color: #77A612;">결제 완료</td>
							</c:when>

							<c:when test="${data.status eq 'checked' }">
								<td style="color: #3E5902;">주문 확인 중</td>
							</c:when>

							<c:when test="${data.status eq 'shipping' }">
								<td style="color: #398860;">배송중</td>
							</c:when>

							<c:when test="${data.status eq 'delivered' }">
								<td style="color: #77A612;">결제 완료</td>
							</c:when>

							<c:when test="${data.status eq 'holding' }">
								<td>취소 요청</td>
							</c:when>

							<c:when test="${data.status eq 'canceled' }">
								<td>취소 완료</td>
							</c:when>

						</c:choose>
						
							<c:choose>
							<c:when test="${data.status eq 'delivered' }">
								<td style="color: #84CF8C;">배송 완료</td>
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
										onclick="confirmdel(${data.id });">배송 확인</button></td>
							</c:otherwise>
						</c:choose>
				
						<c:choose>
							<c:when test="${data.status  eq 'delivered'}" >
								<td style="color:#F06464;"></td>
							</c:when>
							<c:when test="${data.status eq 'holding' }">
								<td style="color:#F06464;">취소 요청 중</td>
							</c:when>
							<c:when test="${data.status eq 'canceled' }">
								<td style="color:#F06E6E;">취소 완료</td>
							</c:when>
							<c:when test="${data.status eq 'unpaid' }">
								<td><button class="list_btn" id="btn3" name="${data.id }" style="color:#FA8072;"
										onclick="cancel2(${data.id});">삭제 요청</button></td>
							</c:when>
							<c:otherwise>
								<td><button class="list_btn" id="btn2" name="${data.id }" style="color:#FA8072;"
										onclick="cancel(${data.id});">취소 요청</button></td>
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