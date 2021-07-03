<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:url var="deleteC" value="/admin/product/ptype/delete" />
<c:url var="addC" value="/admin/product/ptype/add" />
<form action="${addC}" method="post" enctype="multipart/form-data">
<c:url var="all" value="/product" />
<div class="productContainer">
	<c:if test="${sessionScope.account.getAtype() == 'a' }" >
		<div class="text-right">
			<button type="button" class="btn btncustom productAddBtn rounded-pill" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
			카테고리 수정
			 <i class="bi bi-file-earmark-plus"></i></button>
		</div>
	</c:if>
	<div class="">
		<c:if test="${empty requestScope.productlist}" >
			<div class="productIndiv">
				<div class="col mb-3 ">
					<div class="card border-0 text-center">
						<a href="${all}">
							<img class="rounded card-img-top productImg"
								src="${pageContext.request.contextPath}/resources/upload/product/all.png">
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
		<div id="carouselExampleControls" class="carousel slide" data-ride="false">
	      <div class="carousel-inner">
	        <c:set var="size" value="${fn:length(producttypes)}" />
	        <c:forEach var="i" begin="0" end="${(size-1) / 3}" step="1" varStatus="onerow"> 
	        <c:if test="${not empty requestScope.producttypes[onrow.index+3]}">
		        <div class="carousel-item <c:if test='${onerow.index eq 0}'> active </c:if>" >
		        <div class="row row-cols-xs-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
			        <c:forEach var="ptype" items="${requestScope.producttypes }" begin="${onerow.index *3 }" end="${onerow.index *3 +2}" varStatus="status">
			          <div class="col mb-3 ">
				          <a href="?ptype=${ptype.id }">
								<img class="rounded card-img-top productImg"
									src="${pageContext.request.contextPath}${ptype.getImgurl()}">
							</a>
							<div class="card-body bg-transparent border-0">
								<h5 class="card-title card-text">
									<a href="?ptype=${ptype.id }">${ptype.name }</a>
								</h5>
								<c:if test="${sessionScope.account.getAtype() == 'a' }" >
									<div class="text-center">
									<a type="button" href="${deleteC}?id=${ptype.id}">삭제</a>
									</div>
								</c:if>
							</div>
			          </div>
			         </c:forEach>
		         </div>
	        </div>
			</c:if>
			</c:forEach>
	      </div>
	      <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
	        <span class="carousel-control-prev-icon"></span>
	      </a>
	      <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
	        <span class="carousel-control-next-icon"></span>
	      </a>
	    </div>
	</c:if>
	</div>
</div>





<!-- add category modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">상품 카테고리 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <label for="category-name" class="col-form-label">카테고리 명 :</label>
            <input type="text" class="form-control" id="category-name" name="name">
          </div>
          <div class="form-group">
            <label for="file" class="col-form-label">대표 이미지 :</label>
            <input type="file" class="form-control" id="file" name="file" accept=“image/*” onchange="PreviewImage();">
          </div>
      </div>
      <div class="modal-footer">
      	<input type="submit" value="SUBMIT" class="btn"/>
        <button type="submit"  class="btn btn-primary">등록</button>
      </div>
    </div>
  </div>
</div>

</form>