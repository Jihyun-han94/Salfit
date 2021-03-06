<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit Admin | 상품 메인</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<style>
.productImg {
  height: 150px;
  width: 200px;
  object-fit: fill;
}
</style>
<body>
<nav>
	<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
</nav>
<br><br><br><br><br><br><br>
<main style="font-family: 'Kakao', 'sans-serif', 'normal';">
	<div id="addOK" class="alert alert-info collapse text-center" role="alert">새 카테고리가 등록되었습니다.</div>	
	<div id="addFail" class="alert alert-danger collapse text-center" role="alert">카테고리 등록 실패</div>
	<div id="deleteOK" class="alert alert-danger collapse text-center" role="alert">해당 카테고리가 삭제되었습니다.</div>
<div style="margin: 250px auto;">
	
	<div>
		<jsp:include page="/WEB-INF/views/product/categories.jsp" flush="false" >
			<jsp:param name="producttypes" value="${producttypes}" />
		</jsp:include>
	</div>
	
	
	<div id="registerOK" class="alert alert-info collapse text-center" role="alert">새 상품이 등록되었습니다.</div>	
	<div id="removeOK" class="alert alert-danger collapse text-center" role="alert">상품 게시글이 삭제되었습니다.</div>
	<div id="removeFail" class="alert alert-danger collapse text-center" role="alert">해당 상품에 미완료 주문건이 존재합니다.</div>

	
	<div>
		<div class="productContainer">
		<div class="text-right">
				<c:url var="add" value="/admin/product/add" />
				<form action="${add}" method="get">
					<button class="btn btncustom productAddBtn rounded-pill" type="submit" style="font-size:13px;">새 상품 등록
					 <i class="bi bi-file-earmark-plus"></i></button>
				</form>
			</div>
		<div class="productIndividual">
			<c:if test="${empty requestScope.productlist}" >
				<div>
					<p style="text-align:center;">제품이 존재하지 않습니다.</p>
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
										src="${pageContext.request.contextPath}${item.getUrl()}">
								</a>
								<div class="card-body bg-transparent border-0">
									<p class="card-text">
									<c:if test="${item.getActive() == 'y'}" >
										<i class="bi bi-check-circle-fill" style="color:#E25; font-size: 13px;">공개 상품</i>
									</c:if>
									<c:if test="${item.getActive() == 'n'}" >
										<i class="bi bi-check-circle-fill" style="color:#AAE; font-size: 13px;">비공개 상품</i>
									</c:if>
										<small class="text-muted">
											<i class="bi bi-eye-fill" style="color:#6f9eaf; padding-left: 10px;"></i> ${item.getVcnt()}
										</small>
										<small class="text-muted">
										<a id="heart${item.getId()}" class="bi bi-heart" style="color:#ff75a0; padding-left: 10px;">
												${item.getGcnt()}</a>
										</small>
									</p>
								</div>
								<div class="card-footer bg-transparent border-1"> 
									<h5 class="card-title card-text">
										<a href="${detail}?id=${item.getId() }">${item.getTitle() }</a>
									</h5>
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
											<c:url var="update" value="/admin/product/update" />
								            <form
												action="${update}?id=${item.getId()}" method="GET">
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
															<c:url var="delete" value="/admin/product/delete" />
															<form action="${delete}?id=${item.getId()}" method="POST">
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
	</div>
</main>
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
<script>
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
			if(result === 'registerOK'){
				$('#registerOK').show();
				setTimeout(function() { 
				       $('#registerOK').fadeOut(1000); 
				   }, 5000);
			}
			if(result === 'removeOK'){
				$('#removeOK').show();
				setTimeout(function() { 
				       $('#removeOK').fadeOut(1000); 
				   }, 5000);
			}
			if(result === 'removeFail'){
				$('#removeFail').show();
				setTimeout(function() { 
				       $('#removeFail').fadeOut(1000); 
				   }, 5000);
			}
			if(result === 'addOK'){
				$('#addOK').show();
				setTimeout(function() { 
				       $('#addOK').fadeOut(1000); 
				   }, 5000);
			}
			if(result === 'addFail'){
				$('#addFail').show();
				setTimeout(function() { 
				       $('#addFail').fadeOut(1000); 
				   }, 5000);
			}
			if(result === 'deleteOK'){
				$('#deleteOK').show();
				setTimeout(function() { 
				       $('#deleteOK').fadeOut(1000); 
				   }, 5000);
			}
		})
	}
	
    /* $('#subscribe-email-form').on('submit', function(e){
        e.preventDefault();
        $.ajax({
            url: url, //this is the submit URL
            type: 'GET', //or POST
            data: $('#subscribe-email-form').serialize(),
            success: function(data){
                 alert('successfully submitted')
            }
        });
    }); */
    
	function form_submit() {
        document.getElementById("paymentitrform").submit();
   }  
})
</script>
</html>