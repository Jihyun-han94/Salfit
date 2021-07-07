<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
<c:url var="login" value="/account/login" />
<c:url var="moreReviews" value="/ajax/product/moreReviews" />
<c:url var="cart" value="/cart" />
<c:url var="ajax_cart" value="/ajax/cart" />
</head>
<style>
.buttons {
    margin: 0;
    padding: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center
}

.cart-button {
    position: relative;
    outline: 0;
    background-color: #bac600;
    color: #fff;
    border: none;
    height: 48px;
    width: 200px;
    padding: 10px;
    border-radius: 10px;
    line-height: 0px;
    overflow: hidden;
    cursor: pointer
}

.cart-button:focus {
    outline: none !important
}

.cart-button .fa-shopping-cart {
    position: absolute;
    z-index: 2;
    top: 50%;
    left: -20%;
    font-size: 1.8em;
    transform: translate(-50%, -50%)
}

.cart-button .fa-square {
    position: absolute;
    z-index: 1;
    top: -20%;
    left: 53%;
    font-size: 0.8em;
    transform: translate(-50%, -50%)
}

.cart-button span {
    position: absolute;
    left: 50%;
    top: 50%;
    color: #fff;
    transform: translate(-50%, -50%)
}

.cart-button span.added {
    opacity: 0
}

.cart-button.clicked .fa-shopping-cart {
    animation: cart 2s ease-in forwards
}

.cart-button.clicked .fa-square {
    animation: box 2s ease-in forwards
}

.cart-button.clicked span.add-to-cart {
    animation: addcart 2s ease-in forwards
}

.cart-button.clicked span.added {
    animation: added 2s ease-in forwards
}

@keyframes cart {
    0% {left: -10%}
    40%,60% {left: 50%}
    100% {left: 110%}
}

@keyframes box {
    0%,40% {top: -20%}
    60% {top: 36%; left: 53%}
    100% {top: 40%; left: 112%}
}

@keyframes addcart {
    0%, 30% {opacity: 1}
    30%,100% {opacity: 0}
}

@keyframes added {
    0%, 80% {opacity: 0}
    100% {opacity: 1}
}
</style>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<br><br><br><br><br><br><br><br><br><br>
 	<div id="bodyContainer1">
      <div class="row my-10 mx-5 "> <!-- row(하나의 행)의 my(margin을 y축방향으로) 5만큼 준것 -->
      	<div class="col-1"></div>
         <div class="col-5">
 			<img class="w-100 rounded card-img-top productImg" width="500px" height="1000px"
					src="${pageContext.request.contextPath}${item.getUrl()}">       
         </div>
         <div class="col-1"></div>
         <!-- 오른쪽 : 수량 & 장바구니에 담기  -->
         <div class="col-5" style="">
        	<div class="row g-2 align-items-left">
        		<div class="col-lg">
        			<h1 class="text-end" style="padding-bottom: 20px;">${item.getTitle() }</h1>
        		</div>
        	</div>
        	<div>
               <!-- <h3 style="font-weight: bolder; padding-bottom: 15px;">상품 설명</h3> -->
               <p class="font-weight-light" style="padding-bottom: 15px;">
               ${fn:replace(item.getContents(), newline, "<br>") }
               </p>
            </div>
            <div class="col-6 text-end">
        			<h3 class="text-end" style="padding-bottom: 30px;">₩ ${item.getPrice() }</h3>
        		</div>
        	<div class="row row-cols-lg-auto g-3 align-items-center">
        		<div>
        			<label style="display: inline-block; margin-right: 120px;">
        				구독 시작일 선택:<input type="hidden" class="datepicker" id="datepickerS"></label>
        				<label style="display: inline-block;">
        				구독 종일 선택:<input type="hidden" class="datepicker" id="datepickerE"></label>
        			<p> <input style="margin-right: 30px;" type="text" class="alternate" id="alternateS" size="25" readonly>~<input type="text" style="margin-left: 30px;"class="alternate" id="alternateE" size="25" readonly></p><br>

        		</div>
        	</div>
            <div class="row g-3 align-items-center" style="margin-top: -300px; margin-right: 100px;">
			  <div class="col-sm-3 col-auto">
                 <div class="input-group input-group-sm mb-3 btn-default">
				  	<button id="minus" onclick="minus();" class="btn btn-sm border-0" type="button" id="button-addon1">-</button>
				  	<input id="quantity" type="text" class="form-control border-0 text-center" placeholder="" value="1" aria-label="Example text with button addon" aria-describedby="button-addon1">
				  	<button id="plus" onclick="plus();" class="btn btn-sm border-0" type="button" id="button-addon">+</button>
               	</div>
			  </div>
			  <div class="col-sm-9">
			  
			  <div class="buttons">
			  	<button class="cart-button" type="button" onclick="addToCart(this, ${item.getId()}
					    , document.getElementById('quantity')
					    , document.getElementById('datepickerS')
					    , document.getElementById('datepickerE')
					    , ${account.getId()}
					    );" >
			  		<span class="add-to-cart">Add to cart</span>
			  		<span class="added">Item added</span>
			  		<i class="fa fa-shopping-cart"></i>
			  		<i class="fa fa-square"></i>
			  	</button>
			  </div>
			  	<%-- <div class="input-group input-group-sm mb-3 btn-success">
					<button type="button" class="btn btn-block badge-pill" 
					    onclick="addToCart(this, ${item.getId()}
					    , document.getElementById('quantity')
					    , document.getElementById('datepickerS')
					    , document.getElementById('datepickerE')
					    , ${account.getId()}
					    );" ><b>장바구니에 담기</b></button>
					<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					   <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
					      <div class="modal-content">
					         <div class="modal-header">
					            <h5 class="modal-title" id="staticBackdropLabel">상품 담기 성공!</h5>
					            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					
					            </button>
					         </div>
					      <div class="modal-body">
					      	${item.getTitle()} 상품을 장바구니에 추가했습니다. 
					      </div>
					      <div class="modal-footer">
					         <button type="button" class="btn btn-outline-dark" data-dismiss="modal">계속 쇼핑하기</button>
					            <button type="button" onclick="location.href='${cart}'" class="btn btn-outline-dark">내 장바구니로 가기</button>
					      </div>
			      		</div>
			   		</div>
				</div>
		  		</div> --%>
		  </div>
		</div>
       	</div>
   		</div>
   	</div>
	<div id="bodyContainer2" style="margin-top: -250px;">
		<jsp:include page="/WEB-INF/views/product/recommend.jsp" flush="false" >
			<jsp:param name="item" value="${item}" />
			<jsp:param name="recommend" value="${recommend}" />
		</jsp:include>
	</div>
    <div id="bodyContainer3" style="margin-top: 50px;">
		<jsp:include page="/WEB-INF/views/product/reviews.jsp" flush="false" >
			<jsp:param name="item" value="${item}" />
			<jsp:param name="reviews" value="${reviews}" />
		</jsp:include>
	</div>
   	<div id="loginModal">
		<jsp:include page="/WEB-INF/views/module/login_modal.jsp" flush="false" >
			<jsp:param name="item" value="${item}" />
		</jsp:include>
	</div>
	<footer>	
		<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
	</footer>
</body>
<script>
	document.addEventListener("DOMContentLoaded", function(event) {
	const cartButtons = document.querySelectorAll('.cart-button');
	cartButtons.forEach(button => {
	button.addEventListener('click',cartClick);
	});
	function cartClick(){
	let button =this;
	button.classList.add('clicked');
	}
	});
	
	/* 날짜선택 */
	$( function() {
		$( "#datepickerS" ).datepicker({
		      altField: "#alternateS",
		      altFormat: "yy 년 MM d 일, DD",
		      showOn: "button",
		      buttonImage: "/salfit/resources/upload/product/calendar.png",
		      buttonImageOnly: true,
		      buttonText: "구독기간"
		      
		    });
		$( "#datepickerE" ).datepicker({
		      altField: "#alternateE",
		      altFormat: "yy 년 MM d 일, DD",
		      showOn: "button",
		      buttonImage: "/salfit/resources/upload/product/calendar.png",
		      buttonImageOnly: true,
		      buttonText: "구독기간"
		    });
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
		$('.datepicker').datepicker('setDate', '+1D');
		
	    $('#datepickerS').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#datepickerE").datepicker( "option", "minDate", selectedDate );
	    });

	    $('#datepickerE').datepicker("option", "minDate", $("#datepickerS").val());
	    $('#datepickerE').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#datepickerS").datepicker( "option", "maxDate", selectedDate );
	    });
		
  	} );

	/* 장바구니 */
	function addToCart(e, pid, quantity, sd, ed, aid) {
	    var start = $('#datepickerS').datepicker('getDate');
	    var end   = $('#datepickerE').datepicker('getDate');
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
					 $('#staticBackdrop').modal('show');
				} else if(data.res == "no_login") {
					/* $('#loginModal').modal('show'); */
					location.href = data.redirect;
				}
			}				
		});
	}


	/* 리뷰 */
	
	var oldListCnt = "${oldListCnt}";

	var startIndex = 1;	// 인덱스 초기값
	var searchStep = 3;	// 3개씩 로딩
		
	readOldNotify(startIndex);
	
	function pressSearchMoreBtn() {
		startIndex += searchStep;
		readOldNotify(startIndex);
	}
	
	function readOldNotify(index){
		let _endIndex = index+searchStep-1;
		$.ajax({
			url: "${moreReviews}",
			type: "post",
			async: "true",
			dataType: "json",
			data: {
				pid: "${item.getId()}",
				startIndex: index,
				endIndex: _endIndex,
				oldListCnt : oldListCnt
			},
			success: function (data) {
				let NodeList = "";
				if(data.length == 0) {
					let node = "<div class='col-12 text-center'><p>댓글이 존재하지 않습니다.</p></div>";
					NodeList += node; 
				}
				for(i = 0; i < data.length; i++){
					let newNode = "<div style='display: none;' class='card form-group col-sm-12 mx-auto p-0' onClick='window.open('"+data[i].id+"')>";
					newNode += "<div class='card-body pt-3'><div class='row px-3 mb-2'>";
					newNode += "<strong class='d-block text-gray-dark'>"+data[i].aname+"</strong>";
					newNode += "<img src='/salfit/resources"+data[i].profile_img+"' width='30px'></strong>";
					newNode += "<span class='text-muted ml-auto'>"+data[i].cdate2+"</span>";
					newNode += "</div><span>"+data[i].contents+"</span></div></div>";
					NodeList += newNode;
				}
				$(NodeList).appendTo($("#oldList")).slideDown();
				
				// 더보기 버튼 삭제
				if(_endIndex >= oldListCnt){
					$('#searchMoreNotify').remove();
				}				
			}
		});
	}
	
	// 장바구니 수량 조정 
    var qty = document.getElementById('quantity');

    function minus() {
    	qty.value = parseInt(qty.value) - 1;
    }
    function plus() {
    	qty.value = parseInt(qty.value) + 1;
    }
</script>
</html>