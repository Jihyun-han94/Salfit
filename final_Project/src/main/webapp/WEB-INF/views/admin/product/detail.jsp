<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품 상세 정보</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>

<c:url var="moreReviews" value="/ajax/product/moreReviews" />
</head>
<body>
	<header style="padding-bottom:200px;">
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	
	<div id="updateOK" class="alert alert-success collapse text-center" role="alert">상품 정보를 수정했습니다.</div>
 	<div id="bodyContainer1">
      <div class="row my-10 mx-5 "> <!-- row(하나의 행)의 my(margin을 y축방향으로) 5만큼 준것 -->
         <div class="col-1">
        	<%--  <h1 style="padding-bottom: 50px;">
	            ${fn:replace(item.getTitle(), newline, "<br>") }
            </h1> --%>
            
         </div>
         
         <div class="col-4">
 			<img class="rounded" width="500px" height="400px"
					src="${pageContext.request.contextPath}${item.getUrl()}">       
         </div>
         <div class="col-1"></div>
         <!-- 오른쪽 : 수정  -->
         <div class="col-4">
        	<div class="row g-3 align-items-center">
        		<div class="col-lg col-auto">
        			<h1 class="text-center">${item.getTitle() }</h1>
        		</div>
        	<div>
            	<c:url var="update" value="/admin/product/update" />
	            <form action="${update}?id=${item.getId()}" method="GET">
					<input type="hidden" name="id" value="${item.getId()}" readonly>
					<button class="btn btn-light btn-block badge-pill" style="margin-top:30px;" type="submit">
						<i class="bi bi-pencil"></i>상품 정보 수정하기</button>
				</form>
				<br>
            </div>
        	</div>
        	<div style="padding-left:90px;">
               <h3 style="font-weight: bolder; padding-bottom: 15px; padding-top: 30px;">등록된 상품 설명</h3>
               <p class="font-weight-light" style="padding-bottom: 15px;">
               ${fn:replace(item.getContents(), newline, "<br>") }
               </p>
            </div>
            <div class="row g-3 align-items-center">
			</div>
       	</div>
		</div>
   	</div>
    <div id="bodyContainer3" style="padding-top:90px;">
		<jsp:include page="/WEB-INF/views/admin/product/reviews.jsp" flush="false" >
			<jsp:param name="item" value="${item}" />
			<jsp:param name="reviews" value="${reviews}" />
		</jsp:include>
	</div>
   	
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
$(function(){
	//등록, 삭제 후 문구 처리
	
	function getSearchParams(k){
		 var p={};
		 location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi,function(s,k,v){p[k]=v});
		 return k?p[k]:p;
		}
	var result = getSearchParams("result");
	if(result != null) {
		
		$(function(){
			if(result === 'updateOK'){
				$('#updateOK').show();
				setTimeout(function() { 
				       $('#updateOK').fadeOut(1000); 
				   }, 5000);
			}
		})
	}
})
	
	
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
	
</script>
</html>