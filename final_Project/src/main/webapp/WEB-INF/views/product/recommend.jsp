<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container text-center">
	<h3>비슷한 상품</h3>
	<div class="">
		<div id="carouselExampleControls" class="carousel slide" data-ride="false">
	      <div class="carousel-inner">
	        <div class="carousel-item active">
		        <div class="row row-cols-xs-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
			        <c:forEach var="similar" items="${requestScope.recommend }" begin="0" end="2" varStatus="status">
			          <div class="col mb-3 ">
				          <a href="${detail}?id=${similar.getId()}">
				          <img class="recommend-image" src="${pageContext.request.contextPath}${similar.getUrl()}"  alt="similar-img"><br>
				          <h5 class="">${similar.getTitle()}</h5>
				          <em>₩ ${similar.getPrice()}</em>
				          </a>
			          </div>
			         </c:forEach>
		         </div>
	        </div>
	        <c:if test="${not empty requestScope.recommend[3]}">
		        <div class="carousel-item">
		        <div class="row row-cols-xs-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
			        <c:forEach var="similar" items="${requestScope.recommend }" begin="3" end="5" varStatus="status">
			          <div class="col mb-3 ">
				          <a href="${detail}?id=${similar.getId()}">
				          <img class="recommend-image" src="${pageContext.request.contextPath}${similar.getUrl()}"  alt="similar-img"><br>
				          <h5 class="">${similar.getTitle()}</h5>
				          <em>₩ ${similar.getPrice()}</em>
				          </a>
			          </div>
			         </c:forEach>
		         </div>
	        </div>
			</c:if>
	      </div>
	      <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
	        <span class="carousel-control-prev-icon"></span>
	      </a>
	      <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
	        <span class="carousel-control-next-icon"></span>
	      </a>
	    </div>
	</div>
</div>