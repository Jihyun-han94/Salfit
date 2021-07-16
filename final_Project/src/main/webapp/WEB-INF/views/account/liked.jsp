<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit | wish list</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<c:url var ="product" value="/product" />
<c:url var ="detail" value="/product/detail" />
<c:url var="like" value="/ajax/product/like" />
<c:url var="cart" value="/cart" />
<c:url var="ajax_cart" value="/ajax/cart" />
<style>
.center {
  margin-left: auto;
  margin-right: auto;
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
    width: 150px;
    padding-top: 20px;
    padding-bottom: 20px;
}
</style>
<body>
<header style="padding-bottom: 130px;">
	<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
</header>
<main class="cd-main-content sub-nav">
<div style="margin: 0 auto; width:87%; font-family : 'Kakao', 'sans-serif', 'normal'; font-size:13px;">

<c:if test="${empty requestScope.likedProduct}" >
	<div style="text-align:center;">
		<i class="bi bi-cart-x" style="text-align:center; font-size: 250px; color: #e7e7e7;"></i>
		<h2 style="text-align:center; padding-bottom: 20px;">찜한 상품이 없습니다.</h2>
		<a class="a_hover" style="padding-bottom: 20px; color:#bac600;" href="${product}">쇼핑하러 가기 <i class="bi bi-hand-index-thumb"></i></a>
	</div>
</c:if>
<c:if test="${not empty requestScope.likedProduct}" >
<h1 style="text-align:center; font-size: 30px; text-weight:bold; margin-bottom: 80px;">찜한 상품 목록 <i class="bi bi-bookmark-heart" style="color: #ff7493;"></i></h1>
<form>
<div >
	<table border="1" id="id_cart" name="id_cart" style="text-align:center;" class="center">
		<tr>
			<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">이미지</th>
			<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">상품 명</th>
			<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">가격</th>
			<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">기간/ 수량 선택</th>
			<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">담기</th>
			<th style="border-top: solid 5px #e1e1e1; padding-bottom:10px;">삭제</th>
		</tr>
		<c:forEach var="data" items="${requestScope.likedProduct}">
		<tr>
		<td>
			<a href="${detail}?id=${data.getId()}">
				<img class="rounded card-img-top productImg" style="object-fit:contain;
	            width:100px;
	            height:100px;"
					src="${pageContext.request.contextPath}${data.getUrl()}" >
			</a>
		</td>
		<td>${data.getTitle() }</td>
		<td>${data.getPrice() }</td>
		<td id="td${data.getId() }">
			<div class="row">
				<div id="pickBtn${data.getId()}" onclick="openCalendar(${data.getId()}, this);"  style="color:#bac600; padding-left:6rem;">Click! <i class="bi bi-calendar-plus-fill" style="cursor: pointer; color:#77A612;"></i></div>
				<div id="hide${data.getId() }" style="display:none;">
					<div class="row d-flex justify-content-center">
	       			<span class="col-3 col-auto" >구독 시작일 선택 : <input type="text" class="datepicker text-center" id="datepickerS${data.getId()}" onclick="generateDP(this.id, ${data.getId()}, 'start');" ></span>
	       			<span class="col-1">~</span>
	       			<span class="col-3" >구독 종료일 선택 : <input type="text" class="datepicker text-center" id="datepickerE${data.getId()}" onclick="generateDP(this.id, ${data.getId()}, 'end');" ></span>
					<span class="col-1"></span>
					<div class="col-2" style="">
		            	<div class="input-group  mb-3 btn-default">
						 	<button id="minus${data.getId()}" onclick="minus(${data.getId()});" class="btn  border-0  font-weight-bold productQty" type="button">-</button>
						 	<input id="quantity${data.getId()}" type="text" class="form-control border-0 text-center productQty" placeholder="" value="1" min="1">
						 	<button id="plus${data.getId()}" onclick="plus(${data.getId()});" class="btn  border-0 font-weight-bold productQty" type="button">+</button>
		              	</div>
					</div>
					</div>
				</div>
   			</div>
		</td>
		<td>
			<button class="cart-button" type="button" onclick="addToCart(this, ${data.getId()}
							    , document.getElementById('quantity${data.getId()}')
							    , document.getElementById('datepickerS${data.getId()}')
							    , document.getElementById('datepickerE${data.getId()}')
							    , ${account.getId()}
							    );"  style="border:none; color:green; background-color:#ffff;" >
		 		<i class="bi bi-cart3" style="font-size: 2rem; color: #93A603;"></i>
	 		</button>
		</td>
		<td>
			<button type="button" class="" id="delBtn${data.getId()}" onclick="likedDel(${data.getId()}, this, ${account.getId()});" style="border:none; color:green; background-color:#ffff;" >
			 <i class="bi bi-trash" style="font-size: 1.5rem; color: red;"></i>
			 </button>
		</td>
		</tr>
		
		</c:forEach>
	</table>
	</div>
	
</form>
</c:if>
</div>
</main>

	
<footer>
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</footer>
</body>
<script type="text/javascript">
/* 찜한상품 삭제 */
function likedDel(pid, e, aid) {
	$.ajax({
		url: "${like}",
		type: "post",
		async: "false",
		dataType: "json",
		data: {
			aid: aid,		 
			pid: pid,
			cancel : "true"
		},
		success: function (data) {
			if(data.res == true) {
				e.closest('tr').innerHTML = "<td colspan='6' style='color:red; text-align:center;'>삭제된 상품입니다.</td>";
			} else if(data.res == "no_login") {
				location.href = data.redirect; 
			}
		}		
	});
} 
/* 날짜 생성 */
function openCalendar(id, obj) {
	$('#hide'+id).attr('style', "display:inline;width:70rem;");
	$('#pickBtn'+id).attr('style', "display:none;");
	generateDP('datepickerS'+id, id, 'start'); 
}
	function generateDP(id, pid, type) {
		if($('#'+id).val() == "")  {
			
			$('#datepickerS'+pid).datepicker();
			$('#datepickerE'+pid).datepicker();
			
			$.datepicker.regional['kr'] = {
				    closeText: '닫기', 
				    currentText: '오늘', 
				    monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], 
				    monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], 
				    dayNames: ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'], 
				    dayNamesMin: ['월','화','수','목','금','토','일'], 
				    dateFormat: 'yy-mm-dd',
				    minDate: 1, maxDate: "+2M +1D"
			};
			
			$.datepicker.setDefaults($.datepicker.regional['kr']);
			$('#datepickerS'+pid).datepicker('setDate', '+1D');
			$('#datepickerE'+pid).datepicker('setDate', '+1D');
			
			$('#datepickerS'+pid).datepicker("option", "onClose", function ( selectedDate ) {
		       $('#datepickerE'+pid).datepicker( "option", "minDate", selectedDate );
		    });
	
		    $('#datepickerE'+pid).datepicker("option", "minDate", $("#datepickerS"+pid).val());
		}
	}
//장바구니 수량 조정 
function minus(id) {
	var qty = document.getElementById('quantity'+id);
   	if(parseInt(qty.value) > 1) {
		qty.value = parseInt(qty.value) - 1;
   	}
}
function plus(id) {
	var qty = document.getElementById('quantity'+id);
	qty.value = parseInt(qty.value) + 1;
}
/* 장바구니 */
function addToCart(e, pid, quantity, sd, ed, aid) {
    if($('#datepickerS'+pid).datepicker('getDate') == null) {
    	let NodeList = "";
		let newNode = "<a id='qoo"+pid+"' data-toggle='popover' data-placement='top' data-trigger='hover' data-content='구독 기간을 선택해주세요.'></a>";
		NodeList += newNode;
		$(NodeList).appendTo(e);
		
		$('#qoo'+pid).popover('show');
		$('#qoo'+pid).on('shown.bs.popover', function() {
		    setTimeout(function() {
		        $('#qoo'+pid).popover('hide');
		    }, 3000);
		});
    }
	
	
	var start = $('#datepickerS'+pid).datepicker('getDate');
    var end   = $('#datepickerE'+pid).datepicker('getDate');
    var days   = (end - start)/1000/60/60/24 + 1;
	
	let qty =  quantity.value;
	$.ajax({
		url: "${ajax_cart}/add",
		type: "post",
		async: "false",
		dataType: "json",
		data: {
			aid: aid,	
			pid: pid,
			qty: qty,
			startdate: sd.value,
			enddate: ed.value,
			days: days
		},
		success: function (data) {
			if(data.result == true) {
				// 알림창 
				alert("상품을 장바구니에 담았습니다."); 
			} else if(data.res == "no_login") {
				location.href = data.redirect;
			}
		}				
	});
}
</script>
</html>