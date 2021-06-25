<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
</head>
<c:url var ="delete" value="/ajax/cart/delete" />
<script type="text/javascript">


</script>
<body>
<%@ include file="/WEB-INF/views/module/footer.jsp" %>

<h1>
장바구니
</h1>
<c:url var="order" value="/order" />
<form action="${order }" method="post">
	<table border="1" id="id_cart" name="id_cart">
		<th><div class="allCheck">
   		<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label> 
  		<script>
  		$("#allCheck").click(function(){
 		var chk = $("#allCheck").prop("checked");
 		if(chk) {
  		$(".chBox").prop("checked", true);
 		} else {
  		$(".chBox").prop("checked", false);
 		}
		});
  		</script>
  		</div></th>
		<th>이미지</th>
		<th>item</th>
		<th>수량</th>
		<th>배송수단</th>
		<th>배송비</th>
		<th>판매가</th>
		<th>합계</th>
		<c:forEach var="data" items="${requestScope.cartlist }">
		<tr>
		<td>
		<div class="checkBox">
   		<input type="checkbox" name="chBox" class="chBox" data-cartNum="${data.id}" />
  		<script>
		$(".chBox").click(function(){
 		$("#allCheck").prop("checked", false);
		});
  		</script>
  		</div>
  		</td>
		<!-- 
		<td><input type='checkbox' class='check' value="${data.id }" /><input value="${data.id }" hidden></td>
		 -->
		<td>-</td>
		<td>${data.title }</td>
		<td>${data.qty }</td>
		<td>택배</td>
		<td>3,000원</td>
		<td>${data.price }</td>
		<td>${data.money }</td>
		</tr>
		
		</c:forEach>
	</table>
	<div class="delBtn">
    <button type="button" class="selectDelete_btn">선택 삭제</button> 
    <script type="text/javascript">
 	$(".selectDelete_btn").click(function(){
  	var confirm_val = confirm("정말 삭제하시겠습니까?");
  
  	if(confirm_val) {
   	var checkArr = new Array();
   
  	 $("input[class='chBox']:checked").each(function(){
    	checkArr.push($(this).attr("data-cartNum"));
   	});
    
   	$.ajax({
    	url :  "${delete }",
    	type : "post",
    	datatype:"json",
    	data : { chbox : checkArr },
    	success : function(data){
    	alert(data.result);
     	location.href = data.redirect;
    	}
   	});
  	} 
 	});
	</script>
    </div>
	
	<br>
	<table border="1" id="id_price" name="id_price">
		<th>총 상품금액</th>
		<th>총 배송비</th>
		<th>결제예정금액</th>
		<tr>
		<td>${sumMoney }</td>
		<td>${delfee }</td>
		<td>${totalMoney }</td>
		</tr>
	</table>
	<button type="button">전체 상품주문</button>
	<button type="button">선택 상품주문</button>
</form>
</body>
</html>