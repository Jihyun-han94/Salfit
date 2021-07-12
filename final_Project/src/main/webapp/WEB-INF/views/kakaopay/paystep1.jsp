<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>paystep1</title>
</head>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
<!-- jQuery -->
<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
<br>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script text="text/javascript">
window.onload = function iamport(){
	var title = '${detail_arr.get(0).getTitle() }';
	
	IMP.init('imp02440277');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : title , //결제창에서 보여질 이름
	    amount : ${ordered.total }, //실제 결제되는 가격
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
	        msg += 'pay provider' + rsp.pg_provider;
	        msg += 'pay method : ' + rsp.pay_method;
	        
	        window.location.href = '/salfit/pay/confirm?paymethod='+rsp.pay_method+"&id="+${ordered.id};
	        
	        //관리자 주문알림 
	    } else {
	    	 var msg = '결제에 실패하였습니다.';
	         /* msg += '에러내용 : ' + rsp.error_msg; */
	         window.location.href = '/salfit';
		        
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
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


		
		


<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
</html>