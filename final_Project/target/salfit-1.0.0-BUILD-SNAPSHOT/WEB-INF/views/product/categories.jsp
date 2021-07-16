<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:url var="deleteC" value="/admin/product/ptype/delete" />
<c:url var="addC" value="/admin/product/ptype/add" />
<form action="${addC}" method="post" enctype="multipart/form-data">
<c:url var="all" value="/product" />

<div class="productContainer" style="margin-top: -200px;">
	<c:if test="${sessionScope.account.getAtype() == 'a' }" >
		<div class="text-right" style="margin-bottom: 20px;">
			<button type="button" style="font-size:13px;" class="btn btncustom productAddBtn rounded-pill" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
			카테고리 등록
			 <i class="bi bi-file-earmark-plus"></i></button>
		</div>
	</c:if>
	<div class="">
		<c:if test="${empty requestScope.productlist}" >
			<div class="productIndiv">
			<div class="row">
					<div class="col-4 mb-4 "></div>
				<div class="col-4 mb-4 ">
					<div class="card border-0 text-center">
						<a href="${all}">
							<img class="rounded card-img-top productImg"
								src="${pageContext.request.contextPath}/resources/upload/product/no-category.png">
						</a>
						<div class="card-body bg-transparent border-0">
							<h5 class="card-title card-text">
								<a href="${all}">모든 상품 조회</a>
							</h5>
						</div>
					</div>
				</div>
					<div class="col-4 mb-4 "></div>
					</div>
			</div>
		</c:if>
		<c:if test="${not empty requestScope.productlist}">
		<div id="carouselExampleControls" class="carousel slide" data-ride="false">
	      <div class="carousel-inner">
	        <c:set var="size" value="${fn:length(producttypes)}" />
	        <c:forEach var="i" begin="0" end="${(size-1) / 3}" step="1" varStatus="onerow"> 
	        <c:if test="${not empty requestScope.producttypes[onrow.index+1]}">
		        <div class="carousel-item <c:if test='${onerow.index eq 0}'> active </c:if>" >
		        <div class="row row-cols-xs-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
			        <c:forEach var="ptype" items="${requestScope.producttypes }" begin="${onerow.index *3 }" end="${onerow.index *3 +2}" varStatus="status">
			          <div class="col mb-3 text-center">
				          <a href="?ptype=${ptype.id }">
								<img class="rounded card-img-top productImg"
									src="${pageContext.request.contextPath}${ptype.getImgurl()}">
							</a>
							<div class="card-body bg-transparent border-1">
								<h5 class="card-title card-text text-center">
									<a style="font-weight: bold; color:#77A612;" href="?ptype=${ptype.id }">${ptype.name }</a>
								</h5>
								<c:if test="${sessionScope.account.getAtype() == 'a' }" >
									<div class="text-center">
									<a style="font-size:12px; color: gray;" type="button" href="${deleteC}?id=${ptype.id}">삭제</a>
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
  <div class="modal-dialog modal-dialog-centered modal-30size"  role="document">
    <div class="modal-content row d-flex justify-content-center">
      <div class="modal-header border-bottom-0">
        <!-- <h5 class="modal-title" id="exampleModalLabel">상품 카테고리 추가</h5> -->
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="d-flex flex-column text-center justify-content-center">
      <h2 style="margin-bottom: 10px; color: #475c01;">카테고리 추가</h2>
      <div class="modal-body">
          <div class="form-group row d-flex justify-content-center">
            <input type="text" style="width: 200px; margin-bottom: 10px;" class="form-control" id="category-name" name="name" placeholder="카테고리 명을 입력해 주세요." required>
            </div>
          <div class="form-group row d-flex justify-content-center">
            <input type="file" class="form-control" style="width: 200px; margin-bottom: 15px; border:none;" id="file" name="file" accept=“image/*” onchange="PreviewImage();">
          </div>
      </div>
      <div class="modal-footer d-flex flex-column text-center justify-content-center">
        <button type="submit"  class="btn_confirm">등록</button>
      </div>
    </div>
  </div>
</div>
</div>

</form>