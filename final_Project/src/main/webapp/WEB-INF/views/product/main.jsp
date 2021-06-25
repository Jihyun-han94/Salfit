<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 메인</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
<c:url var="like" value="/ajax/product/like" />
<script type="text/javascript">
	function liked(gcnt, pid, e) {
		let userid = 1;	// 추후에 유저 세션아이디로 변경 
		$.ajax({
			url: "${like}",
			type: "post",
			async: "true",
			dataType: "json",
			data: {
				aid: userid,		// 추후에 유저 아이디 uid 로 변경! LIKEDTO 도 같이 
				pid: pid,
				cancel : e.dataset.value,
				gcnt: gcnt
			},
			success: function (data) {
					e.innerText = " " +data.gcnt;
					e.dataset.value = data.cancel;
					if(data.cancel == "true") {
						e.setAttribute("class", "bi-heart-fill");
					} else {
						e.setAttribute("class", "bi-heart");
					}
					
				
				
			}				
		});
	}
	function myFunction(e) {
		   var element = document.getElementById("myDIV");
		   e.classList.toggle("bi-heart-fill", "bi-heart");
		}
	
</script>
</head>
<body>
	<header>
	
<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<div>
		<div>
			<c:url var="search" value="/product" />
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
			<div class="productIndividual">
				<c:if test="${empty requestScope.productlist}" >
					<div>
						<p>제품이 존재하지 않습니다.</p>
					</div>
				</c:if>
				<c:if test="${not empty requestScope.productlist}">
					<div class="row row-cols-xs-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4">
						<c:url var="detail" value="/product/detail" />
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
											<a href="${detail}?id=${item.getId()}">${item.getTitle()}</a>
										</h5>
									</div>
									<div class="card-footer bg-transparent border-0"> 
										<p class="card-text">
											<small class="text-muted">
											<c:choose>
												<c:when test="${fn:contains(liked,item.getId())}">
													<a id="heart${item.getId()}" class="bi bi-heart-fill" onclick="liked(${item.getGcnt()}, ${item.getId()}, this);"  
														 style="color:#ff75a0;" data-value="${fn:contains(liked,item.getId())}">
														${item.getGcnt()}</a>
												</c:when>
												<c:otherwise>
													<a id="heart${item.getId()}" class="bi bi-heart" onclick="liked(${item.getGcnt()}, ${item.getId()}, this);"  
														 style="color:#ff75a0;" data-value="${fn:contains(liked,item.getId())}">
														${item.getGcnt()}</a>
												</c:otherwise>
											</c:choose>
											</small>
										</p>
										<p class="card-text">
											₩ ${item.getPrice() }
										</p>
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
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
</html>