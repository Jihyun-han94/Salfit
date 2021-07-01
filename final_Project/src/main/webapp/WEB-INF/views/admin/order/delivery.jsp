<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 배송 관리</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
<c:url var="orderurl" value="/admin/order" />
<c:url var="ajax_order" value="/ajax/admin/order" />

</head>
<body>

	<header>
<%-- 		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include> --%>
	</header>
	<div class="bodyContainer">
		<h1 class="corpBoardTitle">배송 관리(당일)</h1>
		<a href="${orderurl}/list" class="btn btn-outline-secondary pull-right">주문 관리</a>
		<a href="${orderurl}/calendar" class="btn btn-outline-secondary pull-right">배송 관리(월별)</a>
		<section class="applicantTableSection">
			<h3>오늘 배송 상품</h3>
		<%-- 	<p><a href="${orderurl}/list?ddate=${dto.getStartdate()}" >${dto.getStartdate()} : 날짜가 포함된 전체 주문 보기 </a></p> --%>
			<table class="table text-center">
				<thead class="thead-dark">
					<tr>
						<th scope="col">주문번호</th>
						<th scope="col">상품 명</th>
						<th scope="col">수령자 이름</th>
						<th scope="col">주소</th>
						<th scope="col">배송시작일</th>
						<th scope="col">배송완료일</th>
						<th scope="col">연락하기</th>
						<th scope="col">상태 체크</th>
						<th scope="col">배송 상태
						<form id="select_status_form" action="${orderurl}/delivery" method="get">
							<select id="selectOrderStatus" onchange="searchStatus(this)" name="status" >
						        <option value="" ${dto.getStatus() == null ? "selected" : "" }>전체</option>
						        <option value="paid" ${dto.getStatus() == "paid" ? "selected" : "" }>배송전</option>
						        <option value="shipping" ${dto.getStatus() == "shipping" ? "selected" : "" }>배송중</option>
						        <option value="delivered" ${dto.getStatus() == "delivered" ? "selected" : "" }>배송완료</option>
						        <option value="holding" ${dto.getStatus() == "holding" ? "selected" : "" }>취소요청</option>
						        <option value="canceled" ${dto.getStatus() == "canceled" ? "selected" : "" }>취소완료</option>
						    </select>
						</form>
						</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${empty orderdetaillist}" >
						<tr>
						<td colspan="9">주문 결과가 없습니다.</td>
					</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="order" items="${orderdetaillist}" varStatus="status">
						<tr scope="row">
						<th><a href="${orderurl}/list?id=${order.getOid()}" >${order.getOid()}</a></th>
						<td>${order.getPname()}</td>
						<td>${order.getReceiver()}</td>
						<td class="text-truncate" style="max-width: 100px;">
							<a tabindex="0" role="button" data-toggle="popover" data-trigger="hover" data-container="body" data-placement="top" title="상세 주소" data-content="${order.getAddress()}">${order.getAddress()}</a>
						</td>
						<td>${order.getStartdate() }</td>
						<td>${order.getEnddate() }</td>
						<td> 
							<a href="tel:${order.getPhone()}"> 
								<i class="bi bi-telephone-outbound" style="font-size: 1.5rem; color: cornflowerblue;"></i>
							</a>
						</td>
						<td id="statusicon${order.getId()}">
							<c:choose>
								<c:when test="${order.getStatus().equals('paid')}" >
									<i class="bi bi-check text-danger" onclick="checked(this, ${order.getId()},  ${order.getOid()}, document.getElementById('status${order.getId()}'));"  style="font-size: 2rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('shipping')}" >
									<i class="bi bi-truck text-warning" style="font-size: 2rem; padding-left:4rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('delivered')}" >
									<i class="bi bi-person-check-fill text-success" style="font-size: 2rem; padding-left:8rem;"></i>
								</c:when>
								<c:otherwise>
									<i></i>
								</c:otherwise>
							</c:choose>
						</td>
						<td id="status${order.getId()}">
							<c:choose>
								<c:when test="${order.getStatus().equals('paid')}" >
									<p>배송 준비중</p>
								</c:when>
								<c:when test="${order.getStatus().equals('shipping')}" >
									<p>shipping</p>
								</c:when>
								<c:when test="${order.getStatus().equals('delivered')}" >
									<p>delivered</p>
								</c:when>
								<c:when test="${order.getStatus().equals('holding')}" >
									<p>holding</p>
								</c:when>
								<c:when test="${order.getStatus().equals('canceled')}" >
									<p>canceled</p>
								</c:when>
								<c:otherwise>
									<p></p>
								</c:otherwise>
							</c:choose>
						</td>
						</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>

		</section>

	</div>
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$(function() {
		  $('[data-toggle="popover"]').popover({
		    html: true,
		sanitize: false,
		  })
	})
	
		
});

	function searchStatus(e) {
		const url = new URL(window.location.href);
		const urlParams = url.searchParams;
		if(urlParams.has('startdate')) {
			var ddateParam = urlParams.get('startdate'); // null or not 
		}
		if(urlParams.has('status')) {
			urlParams.set('status', e.value);
		} else {
			urlParams.append('status', e.value);
		}
		window.location.href = "delivery?" + urlParams;
	}


	function checked(e, id, oid, status) {
		$.ajax({
			url: "${ajax_order}/delivery",
			type: "post",
			async: "false",
			dataType: "json",
			data: {
				id: id,
				oid: id,
				status: "shipping"
			},
			success: function (data) {
					if(data.res == "true") {
						e.setAttribute("class", "bi bi-truck text-warning");
						e.setAttribute("style", "font-size: 2rem; padding-left:4rem;");
						status.innerText = "shipping";
						
						// 알림창 
						
						let NodeList = "";
						let newNode = "<a id='qoo"+id+"' data-toggle='popover' data-trigger='hover' data-content='배송중~'></a>";
						/* let newNode = "<div class='alert alert-warning alert-dismissible fade show' role='alert'>";
						newNode += "<strong>배송중!</strong>";
						newNode += "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>";
						newNode += "<span aria-hidden='true'>&times;</span>";
						newNode += "</button></div>"; */
						NodeList += newNode;
						$(NodeList).appendTo(e);
						
						$('#qoo'+id).popover('show');
						$('#qoo'+id).on('shown.bs.popover', function() {
						    setTimeout(function() {
						        $('#qoo'+id).popover('hide');
						    }, 3000);
						});
					} 
			}				
		});
	}
	
	
	
</script>
</html>