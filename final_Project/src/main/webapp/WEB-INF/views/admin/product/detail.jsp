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
</head>
<body>
	<header>
		<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
	</header>
 	<div class="">
      <div class="row my-5"> <!-- row(하나의 행)의 my(margin을 y축방향으로) 5만큼 준것 -->
         <div class="col-5">
        	 <h1 style="padding-bottom: 50px;">
	             ${fn:replace(item.getTitle(), newline, "<br>") }
            </h1>
            <div>
               <h3 style="font-weight: bolder; padding-bottom: 15px;">내용</h3>
               <p class="font-weight-light" style="padding-bottom: 15px;">
                ${fn:replace(item.getContents(), newline, "<br>") }
               </p>
            </div>
         </div>
         <div class="col-2">
 			<img class="w-100 rounded card-img-top productImg" width="500px" height="400px"
				src="${pageContext.request.contextPath}${item.getUrl()}" >       
         </div>
         <div class="col-5">
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
		<div class="container">
	      <div class="row my-5">
	         <div class="col-12">
	            
	         </div>
	      </div>
		</div>
		<div class="container">
			<jsp:include page="/WEB-INF/views/product/reviews.jsp" flush="false" >
				<jsp:param name="item" value="${item}" />
			</jsp:include>
		</div>
      </div>   
   </div>
	<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
</html>