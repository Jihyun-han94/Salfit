<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:url var="all" value="/product" />
<div class="productContainer">
	<div class="productIndividual">
		<c:if test="${empty requestScope.productlist}" >
			<div class="productIndiv">
					<div class="col mb-3 ">
						<div class="card border-0 text-center">
							<a href="${all}">
								<img class="rounded card-img-top productImg"
									src="${pageContext.request.contextPath}/resources/upload/product/all.png"
									>
							</a>
							<div class="card-body bg-transparent border-0">
								<h5 class="card-title card-text">
									<a href="${all}">모든 상품 조회</a>
								</h5>
							</div>
						</div>
					</div>
				</div>
		</c:if>
		<c:if test="${not empty requestScope.productlist}">
			<div class="row row-cols-xs-1 row-cols-sm-1 row-cols-md-2 row-cols-lg-3">
				<%-- <div class="productIndiv">
					<div class="col mb-3 ">
						<div class="card border-0 text-center">
							<a href="${all}">
								<img class="rounded card-img-top productImg"
									src="${pageContext.request.contextPath}${item.getFileUrl}"
									>
							</a>
							<div class="card-body bg-transparent border-0">
								<h5 class="card-title card-text">
									<a href="${all}">모든 상품 조회</a>
								</h5>
							</div>
						</div>
					</div>
				</div> --%>
				<c:forEach var="ptype" items="${producttypes}" varStatus="status">
				<div class="productIndiv">
					<div class="col mb-3 ">
						<div class="card border-0 text-center">
							<a href="?ptype=${ptype.id }">
								<img class="rounded card-img-top productImg"
									src="${pageContext.request.contextPath}/resources/upload/product/${status.index}.png"
									>
							</a>
							<div class="card-body bg-transparent border-0">
								<h5 class="card-title card-text">
									<a href="?ptype=${ptype.id }">${ptype.name }</a>
								</h5>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
</div>