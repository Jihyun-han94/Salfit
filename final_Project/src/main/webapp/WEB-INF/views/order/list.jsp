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
	<th>배송확인</th>
	<th>취소요청</th>
<c:url var ="detail" value="/order/detail" />
<c:forEach var="data" items="${requestScope.orderlist }" >
	<tr>
		<td><a href="${detail }?id=${data.id }">${data.pdate }</a></td>
		<td>${data.receiver }</td>
		<td>${data.address }</td>
		<td>${data.total }</td>
		<c:choose>
			<c:when  test ="${data.status eq 'unpaid' }"> <!-- unpaid로 바꾸기 -->
			<td>결제하러가기</td> <!--결제 되게 a태그 넣기-->
			</c:when>
			
			<c:when test = "${data.status eq 'paid' }">
			<td>결제완료</td>
			</c:when>
			
			<c:when test = "${data.status eq 'checked' }">
			<td>주문 확인 중</td>
			</c:when>
			
			<c:when test = "${data.status eq 'shipping' }">
			<td>배송중</td>
			</c:when>
			
			<c:when test = "${data.status eq 'delivered' }">
			<td>결제완료</td>
			</c:when>
			
			<c:when test = "${data.status eq 'holding' }">
			<td>취소요청</td>
			</c:when>
			
			<c:when test = "${data.status eq 'canceled' }">
			<td>취소완료</td>
			</c:when>
			
		</c:choose>
		
		<c:choose>
		<c:when test ="${data.status eq 'delivered' }">			
			<td>배송완료</td>
		</c:when>
		<c:when  test ="${data.status eq 'unpaid' }"> <!-- unpaid로 바꾸기 -->
			<td>-</td> <!--결제 되게 a태그 넣기-->
		</c:when>	
		<c:otherwise>
			<td><button id = "btn1" name="${data.id }">배송확인</button></td>
		</c:otherwise>
		</c:choose>
		
		<c:choose>
		<c:when test ="${data.status eq 'holding' }" >
			<td>취소요청중</td>
		</c:when>
		<c:when test ="${data.status eq 'canceled' }" >
			<td>취소완료</td>
		</c:when>
		<c:otherwise>
			<td><button id="btn2" name="${data.id }">취소요청</button></td>
		</c:otherwise>
		</c:choose>
	</tr>
</c:forEach>

</table>

<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>

</body>
<c:url var="update" value="/ajax/order/update" />
<c:url var="hold" value="/ajax/order/hold" />
<script type="text/javascript">

	$("#btn1").click(function(){
		
		var btnElement = document.getElementById('btn1');
		btnElement.innerText = '배송완료';
	
		var id = $('#btn1').attr('name'); //order.id
		
	   	$.ajax({
	    	url :  "${update }",
	    	type : "post",
	    	datatype:"json",
	    	data : {id : id},
	    	success : function(data){
	    	alert(data.result);
	    	}
	   	});
	  	
	  	});
	
</script>
<script type="text/javascript">
	
	$("#btn2").click(function(){
		
		var btnElement2 = document.getElementById('btn2');
		btnElement2.innerText = '취소요청중';
	
		var id2 = $('#btn2').attr('name'); //order.id
		
	   	$.ajax({
	    	url :  "${hold }",
	    	type : "post",
	    	datatype:"json",
	    	data : {id : id2},
	    	success : function(data){
	    	alert(data.result);
	    	}
	   	});
	  	
	  	});
	
</script>
</html>