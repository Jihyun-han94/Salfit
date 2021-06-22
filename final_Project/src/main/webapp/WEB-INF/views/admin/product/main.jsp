<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 상품 메인</title>
<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
</head>
<style type="text/css" rel="stylesheet">
.productContainer {
	 width: 75%;
     margin: 0 auto;
}


.productIndividual {
	margin-top : 70px;
}
.productIndiv {
	padding : 0px 5px 80px;
}

.productBtnContainer {
     margin: 0 auto;
}

.productBtnIndividual {
	display : inline-block;
	
}

.productImg {
 	width: 100%; 
	height: 150px; 
} 


.btncustom {
   background-color: white;
   border-color : #3235A5;
   color: #3235A5;
}
.btn:hover {
   background-color: navy;
   color: white;
}
</style>
<body>
	<header>
		<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
	</header>
	<div>
		<div>
			<c:url var="search" value="/admin/product" />
			<form id="search_form" action="${search }" method="get">
				<c:if test="${not empty param.ptype}" >
					<input type="hidden" name="ptype" value="${param.ptype }">
				</c:if>
			    <select name="searchtype">
			        <option value="t">제품 명</option>
			        <option value="c">제품 정보</option>
			    </select>
				<input type="text" name="search">
				<button type="submit">검색</button>
			</form>
		</div>
	</div>
	<div>
		<jsp:include page="/WEB-INF/views/product/categories.jsp" flush="false" >
			<jsp:param name="producttypes" value="${producttypes}" />
		</jsp:include>
	</div>
	<div>
		<div class="productContainer">
			<div class="text-right">
				<c:url var="add" value="/admin/product/add" />
				<form action="${add}" method="get">
					<button class="btn btncustom productAddBtn rounded-pill" type="submit">새 상품 등록
					 <i class="bi bi-file-earmark-plus"></i></button>
				</form>
			</div>
		
		<div class="productIndividual">
			<c:if test="${empty requestScope.productlist}" >
				<div>
					<p>제품이 존재하지 않습니다.</p>
				</div>
			</c:if>
			<c:if test="${not empty requestScope.productlist}">
				<div class="row row-cols-xs-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4">
					<c:url var="detail" value="/admin/product/detail" />
					<c:forEach var="item" items="${requestScope.productlist }" >
					<div class="productIndiv">
						<div class="col mb-3 ">
							<div class="card border-0 text-center">
								<input type="hidden" name="id" value="${item.getId()}" readonly>
								<input type="hidden" name="aid" value="${item.getAid()}" readonly>
								<a href="${detail}?id=${item.getId()}">
									<img class="rounded card-img-top productImg"
										src="${pageContext.request.contextPath}${item.getUrl()}"
										>
								</a>
								<div class="card-body bg-transparent border-0">
									<h5 class="card-title card-text">
										<a href="${detail}?id=${item.getId() }">${item.getPtype() }${item.getTitle() }</a>
									</h5>
									<c:if test="${item.getActive() == 'y'}" >
										<i class="bi bi-eye-fill" style="color:red;">공개된 상품</i>
									</c:if>
								</div>
								<div class="card-footer bg-transparent border-0"> 
									<p class="card-text">
										<small class="text-muted">
											<i class="bi bi-eye-fill" style="color:#6f9eaf;"></i> ${item.getVcnt()}
										</small><span class="text-light">--</span>
										<small class="text-muted">
										<a id="heart${item.getId()}" class="bi bi-heart" style="color:#ff75a0;">
												${item.getGcnt()}</a>
										</small>
									</p>
									<p class="card-text">
											₩ ${item.getPrice() }
									</p>
									<p class="card-text">
										<small class="text-muted">
											<fmt:formatDate var="cdate" value="${item.getCdate() }"
				                                pattern="yyyy/MM/dd" />${cdate}
										</small>
									</p>
									<div class="productBtnContainer">
										<div class="productBtnIndividual">
											<form
												action="${pageContext.request.contextPath}/admin/product/update?id=${item.getId()}"
												method="GET">
												<input type="hidden" name="id" value="${item.getId()}" readonly>
												<button class="btn btn-outline-dark text-muted border-0" type="submit">
													<i class="bi bi-pencil"></i> 수정</button>
											</form>
										</div>
										<div class="productBtnIndividual">
											<input type="hidden" name="id" value="${item.getId()}" readonly>
											<button class="btn btn-outline-danger border-0" type="button"
												data-toggle="modal" data-target="#staticBackdropc${item.getId()}">
												<i class="bi bi-trash"></i> 삭제</button>
											<div class="modal fade" id="staticBackdropc${item.getId()}" data-backdrop="static"
												data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
												aria-hidden="true">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title" id="staticBackdropLabelc${item.getId()}">상품 삭제</h5>
															<button type="button" class="close" data-dismiss="modal" aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
														</div>
														<div class="modal-body">
															삭제된 상품은 복구되지 않습니다. 정말 삭제하시겠습니까?
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-secondary"
																data-dismiss="modal">취소</button>
															<form action="${pageContext.request.contextPath}/admin/product/delete" method="POST">
																<input type="hidden" name="id" value="${item.getId()}" readonly>
																<button type="submit" class="btn btn-primary">상품 삭제</button>
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
					</c:forEach>
				</div>
			</c:if>
		</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
</html>