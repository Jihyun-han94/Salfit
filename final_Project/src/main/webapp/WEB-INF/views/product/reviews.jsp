<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container text-center">
	<h3>구매자 리뷰</h3>
	<div class="row my-5">
	   <div class="col-12">
	      
	   </div>
	</div>
	<div class="">
		<div id="carouselExampleControls" class="carousel slide" data-ride="false">
	      <div class="carousel-inner">
	        <div class="carousel-item active">
		        <div class="row row-cols-xs-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-1">
			        <c:forEach var="review" items="${requestScope.reviews }" begin="0" end="2" varStatus="status">
			          <div class="col mb-3 ">
				          <%-- <img class="recommend-image" src="${pageContext.request.contextPath}${review.getUrl()}"  alt="similar-img"><br> --%>
				          <h5 class="">${review.getAname()}</h5>
				          <em>${review.getContents()}</em>
			          </div>
			         </c:forEach>
		         </div>
	        </div>
	        <c:if test="${not empty requestScope.reviews[3]}">
		        <div class="carousel-item">
		        <div class="row row-cols-xs-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-1">
			        <c:forEach var="review" items="${requestScope.reviews }" begin="3" end="5" varStatus="status">
			          <div class="col mb-3 ">
				          <%-- <img class="recommend-image" src="${pageContext.request.contextPath}${review.getUrl()}"  alt="similar-img"><br> --%>
				          <h5 class="">${review.getAname()}</h5>
				          <em>${review.getContents()}</em>
			          </div>
			         </c:forEach>
		         </div>
	        </div>
			</c:if>
	      </div>
	      <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
	        <i class="bi bi-chevron-double-down" style="font-size: 2rem;"></i>
	      </a>
	    </div>
	</div>
</div>