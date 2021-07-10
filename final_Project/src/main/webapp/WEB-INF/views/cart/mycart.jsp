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
</style>
<body>
<header style="padding-bottom: 130px;">
	<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
</header>
<main class="cd-main-content sub-nav">
<div style="margin: 0 auto; width:87%; font-family : 'Kakao', 'sans-serif', 'normal'; font-size:13px;">

<c:if test="${empty requestScope.cartlist}" >
	<div style="text-align:center;">
		<i class="bi bi-cart-x" style="text-align:center; font-size: 250px; color: #e7e7e7;"></i>
		<h2 style="text-align:center; padding-bottom: 20px;">장바구니에 상품이 존재하지 않습니다.</h2>
		<a class="a_hover" style="padding-bottom: 20px; color:#bac600;" href="${product }">쇼핑하러 가기 <i class="bi bi-hand-index-thumb"></i></a>
	</div>
</c:if>
<c:if test="${not empty requestScope.cartlist}" >
<h1 style="text-align:center; font-size: 30px; text-weight:bold; margin-bottom: 80px;">Shopping Cart</h1>
<form>
<div style="float: left; padding-right:5px;">
	<table border="1" id="id_cart" name="id_cart" style="text-align:center;">
		<tr>
		<th style="height:50px; border-top: solid 5px #e1e1e1; padding-bottom:10px;"><div class="allCheck">
   		<input type="checkbox" name="allCheck" id="allCheck" checked="checked"/><label for="allCheck">모두 선택</label> 
  		</div></th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">이미지</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">상품 명</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">가격</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">구독일 (기간)</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">총 주문 수량</th>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">금액</th>
		</tr>
		<c:forEach var="data" items="${requestScope.cartlist }">
		<tr>
		
		<td>
		
		<div class="checkBox">
		<!--checked="checked"  -->
   		<input type="checkbox" name="chBox" class="chBox" data-cartNum="${data.id}"  checked="checked" />
  		
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
		<td><%-- ${data.qty } * ${data.days} =  --%>${data.qty * data.days}</td>
		<td>${data.money }</td>
		</tr>
		
		</c:forEach>
	</table>
	<div class="delBtn">
    	<button type="button" class="selectDelete_btn" style="border:none; color:green; background-color:#ffff; padding-left:50px; padding-top: 30px;"> 삭제</button>         
    </div>
	</div>
	<div style="float: right; padding-bottom: 200px;">
	<table border="1" id="id_price" name="id_price" style="text-align:center;">
		<tr>
		<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">총 상품 금액</th>
		<td id="id_sumMoney" style="border-top: solid 5px #e1e1e1; padding-top:10px; padding-bottom:13px; font-size: 20px; font-weight:bold;">${sumMoney }</td>
		</tr>
		<tr>
		<th style="border-top: solid 1px #e1e1e1; padding-bottom:10px;">배송비<br><span style="color:gray; font-size: 10px;">* 30000원 이상 주문 시 무료</span></th>
		<td id="id_delfee" style="border-top: solid 1px #e1e1e1; padding-bottom:10px; padding-bottom:13px; padding-top:10px; font-size: 20px; font-weight:bold;">${delfee }</td>
		</tr>
		<tr>
		<th style="border-top: solid 1px #e1e1e1; padding-bottom:10px;">결제 예정 금액</th>
		<td id="id_totalMoney" style="border-top: solid 1px #e1e1e1; padding-bottom:10px; border-bottom: #ffff; padding-bottom:13px; padding-top:10px; font-size: 20px; color:#961533; font-weight:bold;">${totalMoney }</td>
		</tr>
	</table>
	</div>
	<div style="text-align:center; padding-left:900px;">	
		<button type="button" class="buy_btn1">선택 상품주문</button>
	</div>
	
</form>
</c:if>
</div>
</main>

	
<footer>
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</footer>
</body>
<c:url var="sum" value="/ajax/cart/sum" />
<script type="text/javascript">



$(document).ready(function(){

	$("#allCheck").click(function(){
			var chk = $("#allCheck").prop("checked");
			if(chk) {
				$(".chBox").prop("checked", true);
				$('#id_sumMoney').text(${sumMoney});
				$('#id_delfee').text(${delfee});
				$('#id_totalMoney').text(${totalMoney});	
			} else {
				$(".chBox").prop("checked", false);
				$('#id_sumMoney').text(0);
				$('#id_delfee').text(0);
				$('#id_totalMoney').text(0);
			}
		});
		
	$(".chBox").click(function(){
		$("#allCheck").prop("checked", false);
		});
	
    $(".chBox").change(function(){
        if($(".chBox").is(":checked")){
           
            var buy_Arr = new Array();

    		$("input[class='chBox']:checked").each(function(){
    			buy_Arr.push($(this).attr("data-cartNum"));
    	
    		});

    		$.ajax({
    		url :  "${sum }",
    		type : "post",
    		datatype:"json",
    		data : { chbox : buy_Arr },
    		success : function(data){
    			$('#id_sumMoney').text(data.sumMoney); 
    			$('#id_delfee').text(data.delfee);
    			$('#id_totalMoney').text(data.totalMoney);
    			
    			
    		}
    	  	});    
            
        }else{
        	$('#id_sumMoney').text(0); 
			$('#id_delfee').text(0);
			$('#id_totalMoney').text(0);
			
        }
            
        
    });
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
	 		
	 		console.log(buy_Arr);
	 		
	 		const str = buy_Arr.join('&id=');
	 		console.log(str);   
	 		buy_Arr.forEach(function(element){
	 		    console.log(element); 
	 		});
		
	 		if(buy_Arr.length == 0){
	 			alert("제품을 선택해주세요!");
	 		}
	

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