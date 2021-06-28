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
<c:url var="moreReviews" value="/ajax/product/moreReviews" />
<c:url var="cart" value="/cart" />
<c:url var="ajax_cart" value="/ajax/cart" />
</head>
<body>
	<header>
		<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
	</header>
 	<div id="bodyContainer1">
      <div class="row my-10 mx-5 "> <!-- row(하나의 행)의 my(margin을 y축방향으로) 5만큼 준것 -->
         <div class="col-4">
        	<%--  <h1 style="padding-bottom: 50px;">
	            ${fn:replace(item.getTitle(), newline, "<br>") }
            </h1> --%>
            <div>
               <h3 style="font-weight: bolder; padding-bottom: 15px;">내용</h3>
               <p class="font-weight-light" style="padding-bottom: 15px;">
               ${fn:replace(item.getContents(), newline, "<br>") }
               </p>
            </div>
         </div>
         <div class="col-4">
 			<img class="w-100 rounded card-img-top productImg" width="500px" height="400px"
					src="${pageContext.request.contextPath}${item.getUrl()}">       
         </div>
         <!-- 오른쪽 : 수량 & 장바구니에 담기  -->
         <div class="col-4">
        	<div class="row g-3 align-items-center">
        		<div class="col-lg col-auto">
        			<h1 class="text-center">${item.getTitle() }</h1>
        		</div>
        	</div>
        	<div class="row row-cols-lg-auto g-3 align-items-center">
        		<div class="col-6 text-end">
        			<h3 class="text-end">추가 그림 </h3>
        		</div>
        		<div class="col-6 text-end">
        			<p>어필1</p><br>
        			<p>어필2</p><br>
        			<h3 class="text-end">₩ ${item.getPrice() }</h3>
        		</div>
        	</div>
            <div class="row g-3 align-items-center">
			  <div class="col-sm-3 col-auto">
                 <div class="input-group input-group-sm mb-3 btn-default">
				  	<button id="minus" onclick="minus();" class="btn btn-sm border-0" type="button" id="button-addon1">-</button>
				  	<input id="quantity" type="text" class="form-control border-0 text-center" placeholder="" value="1" aria-label="Example text with button addon" aria-describedby="button-addon1">
				  	<button id="plus" onclick="plus();" class="btn btn-sm border-0" type="button" id="button-addon">+</button>
               	</div>
			  </div>
			  <div class="col-sm-9">
			  	<div class="input-group input-group-sm mb-3 btn-success">
					<button type="button" class="btn btn-block badge-pill" 
					    data-toggle="modal" data-target="#staticBackdrop" onclick="addToCart(this, ${item.getId()}, document.getElementById('quantity'));" ><b>장바구니에 담기</b></button>
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
		  		</div>
		  </div>
		</div>
       	</div>
   		</div>
   	</div>
	<div id="bodyContainer2">
		<jsp:include page="/WEB-INF/views/product/recommend.jsp" flush="false" >
			<jsp:param name="item" value="${item}" />
			<jsp:param name="recommend" value="${recommend}" />
		</jsp:include>
	</div>
    <div id="bodyContainer3">
		<jsp:include page="/WEB-INF/views/product/reviews.jsp" flush="false" >
			<jsp:param name="item" value="${item}" />
			<jsp:param name="reviews" value="${reviews}" />
		</jsp:include>
	</div>
   	
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	/* 장바구니 */
	function addToCart(e, pid, quantity) {
		alert(${account.getId()});
		if(${(empty account.getId()) ? false : logined }) {
			let aid = ${account.getId()};
			let qty =  quantity.value;
			$.ajax({
				url: "${ajax_cart}/add",
				type: "post",
				async: "false",
				dataType: "json",
				data: {
					aid: aid,	
					pid: pid,
					qty: qty
				},
				success: function (data) {
					if(data.result == true) {
						// 알림창 
					} 
				}				
			});
		} else {
			alert("로그인을 해야 합니다.");
		} 
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