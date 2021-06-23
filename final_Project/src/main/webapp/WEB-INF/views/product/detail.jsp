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
<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
<style>

#bodyContainer1 {
	height: 50rem;
	background-color: red; 
	color: #fff;
}
#bodyContainer2 {
	height: 20rem;
	background-color: yellow; 
}
#bodyContainer3 {
	height: 40rem;
	background-color: green; 
}


.btn-default {
  font-family: Raleway-SemiBold;
  font-size: 13px;
  color: rgba(108, 88, 179, 0.75);
  letter-spacing: 1px;
  line-height: 15px;
  border: 2px solid #FFF;
  border-radius: 40px;
  background: transparent;
  transition: all 0.3s ease 0s;
}

.btn-default:hover {
  color: #FFF;
  background: rgba(108, 88, 179, 0.75);
  border: 2px solid rgba(108, 89, 179, 0.75);
}
.btn-success {
  font-family: Raleway-SemiBold;
  font-size: 13px;
  letter-spacing: 1px;
  border-radius: 40px;
  transition: all 0.3s ease 0s;
  color: #FFF;
  background: rgb(103, 192, 103, 0.75);
  border: 2px solid rgb(103, 192, 103, 0.75);
}

.btn-success:hover {
  color: rgba(103, 192, 103, 0.75);
  background: transparent;
  border: 2px solid rgba(103, 192, 103, 0.75);
}

.recommend-image {
  width: 50%;
  border-radius: 100%;
  
}

.carousel-control-prev { left: -7rem; }
.carousel-control-next { right: -7rem; }

</style>
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
				  	<button class="btn btn-sm border-0" type="button" id="button-addon1">-</button>
				  	<input type="text" class="form-control border-0 text-center" placeholder="" value="1" aria-label="Example text with button addon" aria-describedby="button-addon1">
				  	<button class="btn btn-sm border-0" type="button" id="button-addon">+</button>
               	</div>
			  </div>
			  <div class="col-sm-9">
			  	<div class="input-group input-group-sm mb-3 btn-success">
					<button type="button" class="btn btn-block badge-pill" 
					    data-toggle="modal" data-target="#staticBackdrop" ><b>장바구니에 담기</b></button>
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
					         <form action="${pageContext.request.contextPath}/cart" method="POST">
					            <%-- <input type="hidden" name="" value="${pageContext.request.session }"> --%>
					            <button type="submit" class="btn btn-outline-dark">내 장바구니로 가기</button>
					         </form>
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
   	
	<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
</html>