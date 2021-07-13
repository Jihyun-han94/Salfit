<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit | ${item.getTitle() }</title>
<jsp:include page="/WEB-INF/views/module/detail.jsp"></jsp:include>
<c:url var="login" value="/account/login" />
<c:url var="moreReviews" value="/ajax/product/moreReviews" />
<c:url var="cart" value="/cart" />
<c:url var="ajax_cart" value="/ajax/cart" />
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
 	<div id="bodyContainer1">
      <div class="row my-10 mx-5 "> <!-- row(하나의 행)의 my(margin을 y축방향으로) 5만큼 준것 -->
      	<div class="col-1"></div>
         <div class="col-5">
 			<img class="rounded" width="500px" height="400px"
					src="${pageContext.request.contextPath}${item.getUrl()}">       
         </div>
         <div class="col-1">
         	<div class="outer">
			  <div class="inner"></div>
			</div>
		</div>
         <!-- 오른쪽 : 수량 & 장바구니에 담기  -->
         <div class="col-5" style="">
        	<div class="row g-2 align-items-left">
        		<div class="col-lg">
        			<h1 class="text-end" style="padding-bottom: 20px;">${item.getTitle() }</h1>
        		</div>
        	</div>
        	<div>
               <p class="font-weight-light" style="padding-bottom: 15px;">
               ${fn:replace(item.getContents(), newline, "<br>") }
               </p>
            </div>
            <div class="col-6 pt-5">
        			<h3 class="" style="padding-bottom: 30px; color:#677502; font-size: 24px; font-weight: bold;"> ₩ ${item.getPrice() }</h3>
        		</div>
        	<div class="row row-cols-lg-auto g-3 align-items-left">
        		<div class="col-12 mb-5">
        			<div class="row">
        			<span class="col-4 ml-4">구독 시작일 : <input type="hidden" class="datepicker" id="datepickerS" style="z-index: 98;"></span>
        			<span class="col-1"></span>
        			<span class="col-4 ml-4" >구독 종료일 : <input type="hidden" class="datepicker" id="datepickerE" style="z-index: 99;"></span>
        			</div>
        			<div class="row mt-4">
        			<span class="col-4"> <input type="text" class="alternate" id="alternateS" size="22" readonly></span>
        			<span class="col-1">~</span>
        			<span class="col-4"> <input type="text" class="alternate" id="alternateE" size="22" readonly></span>
        			</div>
        		</div>
        		<div class="col-12 mt-5">
        			<div class="row">
        			  <div class="col-sm-3 col-auto">
		                 <div class="input-group  mb-3 btn-default">
						  	<button id="minus" onclick="minus();" class="btn  border-0  font-weight-bold productQty" type="button">-</button>
						  	<input id="quantity" type="text" class="form-control border-0 text-center productQty" placeholder="" value="1" min="1">
						  	<button id="plus" onclick="plus();" class="btn  border-0 font-weight-bold productQty" type="button">+</button>
		               	</div>
					  </div>
					  <div class="col-sm-2 col-auto"></div>
					  <div class="col-sm-3 col-auto">
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
			  		</div>
        		</div>
        	</div>
       	</div>
   		</div>
   	</div>
	<div id="bodyContainer2" >
		<jsp:include page="/WEB-INF/views/product/recommend.jsp" flush="false" >
			<jsp:param name="item" value="${item}" />
			<jsp:param name="recommend" value="${recommend}" />
		</jsp:include>
	</div>
    <div id="bodyContainer3" >
		<jsp:include page="/WEB-INF/views/product/reviews.jsp" flush="false" >
			<jsp:param name="item" value="${item}" />
			<jsp:param name="reviews" value="${reviews}" />
		</jsp:include>
	</div>
	<footer class="footer_total_detail">	
		<!-- SNS 정보  -->
		<div style="text-align:center;"><img width="50px" src="${pageContext.request.contextPath}/resources/img/newicon.ico"></div>
		<div class="clearfix">
			<a href="https://www.instagram.com/" style="padding: 5px 10px; display:inline-block; margin-top: 10px; font-size: 20px; color:#475c01;" target="blank">
				<i class="bi bi-instagram"></i></a>
			<a href="https://" style="padding: 5px 10px; display:inline-block; font-size: 20px; color:#475c01;"target="blank">
				<i class="bi bi-twitter"></i></a>
			<a href="https://" style="padding: 5px 10px; display:inline-block; font-size: 20px; color:#475c01;" target="blank">
				<i class="bi bi-facebook"></i></a>
			<a href="https://www.youtube.com/" style="padding: 5px 10px; display:inline-block; font-size: 20px; color:#475c01;" target="blank">
				<i class="bi bi-youtube"></i></a>
		</div>
		
		<!-- 쇼핑몰 운영자 정보  -->
		<div class="copy-link">
			<span class="footer_span">법인명(상호) : Salfit </span> | <span class="footer_span">대표자(성명) : 김은지, 최예림, 한지현 </span> | <span class="footer_span">사업자 등록번호 안내 : 123-12-12345</span> <br>
			<span class="footer_span">전화 : 02.123.4567</span> | <span class="footer_span">팩스 : 02.890.1234</span> | <span class="footer_span">주소 : 서울특별시 강남구 역삼동 823-25</span><br>
			<span class="footer_span">Contact <strong><a href="eungeeee1002@gmail.com"></a></strong> for more information.<a href="/salfit/">[Shop admin]</a></span>
		</div>
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
	window.setTimeout(()=>{button.classList.remove('clicked')}, 5000);
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
	const bodyContainer3 = document.getElementById('bodyContainer3');
	const container = document.getElementById('reviewContainer');
	
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
				$(NodeList).appendTo(container).slideDown();
				for(i = 0; i < data.length; i++){
					// rating
					let rating ="";
					switch(data[i].rating) {
					case 1 : rating ="<i class='star'></i>"; break;
					case 2 : rating ="<i class='star'></i><i class='star'></i>";break;
					case 3 : rating ="<i class='star'></i><i class='star'></i><i class='star'></i>";break;
					case 4 : rating ="<i class='star'></i><i class='star'></i><i class='star'></i><i class='star'></i>";break;
					case 5 : rating ="<i class='star'></i><i class='star'></i><i class='star'></i><i class='star'></i><i class='star'></i>";break;
					} 
					
					/* for(var i = 1; i <= data[i].rating; i++) {
						rating +="<i class='star'></i>";
					} */
					
					
					const postElement = document.createElement('div');
					postElement.classList.add('review-post');
					postElement.innerHTML = 
						 '<div class="user-info">'
						+'	<img src="/salfit/resources'+data[i].profile_img+'" />'
						+'	<span>'+data[i].aname+'</span>'
						+'<h2 class="title">'+rating+'</h2>'
						+'</div>'
						+'<p class="text">'+data[i].contents+'</p>'
						+'	<span class="text-right text-muted">'+data[i].cdate2+'</span>'
					;
					container.appendChild(postElement);
					
				}
				$("#reviewContainer").slideDown();
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
	   	if(parseInt(qty.value) > 1) {
    		qty.value = parseInt(qty.value) - 1;
	   	}
    }
    function plus() {
    	qty.value = parseInt(qty.value) + 1;
    }
</script>
</html>