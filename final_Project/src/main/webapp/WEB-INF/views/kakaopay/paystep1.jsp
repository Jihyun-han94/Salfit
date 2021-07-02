<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>paystep1</title>
</head>
<!-- jQuery -->
<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
<br>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

function iamport(){
	//가맹점 식별코드
	
	IMP.init('imp02440277');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '상품1' , //결제창에서 보여질 이름
	    amount : 100,//${ordered.total }, //실제 결제되는 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울 강남구 도곡동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
	    	var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        window.location.href = '/salfit/order/detail?id='+${ordered.id};
	        
	    } else {
	    	 var msg = '결제에 실패하였습니다.';
	         msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
}
</script>
<body>
<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
<br>
<br>
<br>
<br>
<br>
<br>
<h1>주문서 확인</h1>
		
			<table border="1" id="id_cart" name="id_ordered">
				<th>수령인</th>
				<th>주소</th>
				<th>총 금액</th>
				<tr>
					<td>${ordered.receiver }</td>
					<td>${ordered.address }</td>
					<td>${ordered.total }</td>					
				</tr>
			
		</table>
		<br>
<button type="button" onclick="iamport();">결제하기</button>

<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
</html>