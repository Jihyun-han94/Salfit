<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="container text-center">
 	<div class="recommenddiv mb-5 pt-5" style="">
 	<span class="recommendline"></span>
	  <span class="recommenddot"></span>
	  <span class="recommendtitle">
	    Similar Products
	  </span>
	  <span class="recommenddot"></span>
	  <span class="recommendline"></span>
	</div>
	<!-- <h3 style="padding-bottom: 20px; font-family: 'Great Vibes', cursive; font-size: 3rem;">Similar Products</h3>
	   	<div class="sectionlineouter"><div class="sectionline"></div></div> -->
	<div class="">
		<div id="carouselExampleControls" class="carousel slide" data-ride="false">
	      <div class="carousel-inner">
	       <c:set var="size" value="${fn:length(recommend)}" />
	       <c:if test="${size == 0 }">
	       <p>비슷한 상품이 없습니다.</p>
	       </c:if>
	        <c:forEach var="i" begin="0" end="${(size-1) / 3}" step="1" varStatus="onerow"> 
	        <c:if test="${not empty requestScope.recommend[onrow.index+3]}">
	        <div class="carousel-item <c:if test='${onerow.index eq 0}'> active </c:if>" >
		        <div class="row row-cols-xs-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
			        <c:forEach var="similar" items="${requestScope.recommend }" begin="${onerow.index *3 }" end="${onerow.index *3 +2}" varStatus="status">
			          <div class="col mb-3 ">
				          <a href="${detail}?id=${similar.getId()}">
				          <img class="recommend-image" src="${pageContext.request.contextPath}${similar.getUrl()}"  alt="similar-img"><br>
				          <h5 style="padding-bottom: 5px; padding-top: 5;">${similar.getTitle()}</h5>
				          <em>₩ ${similar.getPrice()}</em>
				          </a>
			          </div>
			         </c:forEach>
		         </div> 
	        </div>
	        </c:if>
			</c:forEach>
	      </div>
	      <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
	       <!--  <span class="carousel-control-prev-icon"></span> -->
	       <i class="fas fa-chevron-left" aria-hidden="true"></i>
	      </a>
	      <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
	        <!-- <span class="carousel-control-next-icon"></span> -->
	        <i class="fas fa-chevron-right carousel-control-next-icon"></i>
	        
	      </a>
	    </div>
	</div>
</div>