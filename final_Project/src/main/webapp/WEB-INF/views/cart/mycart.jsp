<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<c:url var ="delete" value="/ajax/cart/delete" />
<c:url var ="buy" value="/ajax/cart/buy" />
<c:url var ="detail" value="/product/detail" />
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
<h1>
장바구니
</h1>

<form>
	<table border="1" id="id_cart" name="id_cart">
		<th><div class="allCheck">
   		<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label> 
  		</div></th>
		<th>이미지</th>
		<th>상품 명</th>
		<th>가격</th>
		<th>구독일 (기간)</th>
		<th>총 주문 수량</th>
		<th>총 금액</th>
		
		<c:forEach var="data" items="${requestScope.cartlist }">
		<tr>
		
		<td>
		
		<div class="checkBox">
   		<input type="checkbox" name="chBox" class="chBox" data-cartNum="${data.id}" />
  		
  		</div>
  		
  		</td>
		
		<td><a href="${detail}?id=${data.getPid()}">
			<img class="rounded card-img-top productImg" style="object-fit:contain;
            width:100px;
            height:100px;"
				src="${pageContext.request.contextPath}${data.getUrl()}" 
				>
		</a></td>
		<td>${data.title }</td>
		<td>${data.price }</td>
		<td>${data.startdate } ~ ${data.enddate } (${data.days }일간)</td>
		<td>${data.qty } * ${data.days} = ${data.qty * data.days}</td>
		<td>${data.money }</td>
		</tr>
		
		</c:forEach>
	</table>
	
	<div class="delBtn">
    
    <button type="button" class="selectDelete_btn">삭제하기</button> 
    
    </div>
	
	<br>
	<p> * 배송비 : 30000원 이상 주문 시 무료</p>
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

	<button type="button" class="buy_btn1">선택 상품주문</button>
	
</form>

	

<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">

$("#allCheck").click(function(){
		var chk = $("#allCheck").prop("checked");
		if(chk) {
		$(".chBox").prop("checked", true);
		} else {
		$(".chBox").prop("checked", false);
		}
	});
	
$(".chBox").click(function(){
		$("#allCheck").prop("checked", false);
	});
	
	
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

$(".buy_btn1").click(function(){
		var confirm_val = confirm("해당 상품을 구매하시겠습니까?");

		if(confirm_val) {
			var buy_Arr = new Array();

	 		$("input[class='chBox']:checked").each(function(){
			buy_Arr.push($(this).attr("data-cartNum"));
			});
		
	 		
	 		
	 		const str = buy_Arr.join('&id=');
	 		console.log(str);   
	 		buy_Arr.forEach(function(element){
	 		    console.log(element); 
	 		});
		

		$.ajax({
		url :  "${buy }",
		type : "post",
		datatype:"json",
		data : { chbox : buy_Arr },
		success : function(data){
			location.href = "<%=request.getContextPath() %>/pay?id="+str;
		}
	  	});
	  		} 
	 	});
</script>
</html>