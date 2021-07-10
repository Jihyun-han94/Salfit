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
 		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include> 
	</header><br><br><br><br><br><br><br><br>
	<div class="bodyContainer">
	<a href="${orderurl}/calendar" class="pull-left mb-5 ml-5"><i class="bi bi-arrow-left-circle" style="font-size: 3rem; color: grey;"></i> 달력</a>
		<h1 class="text-center mb-3">배송 목록</h1>
		<p class="text-center mb-3">&lt${param.startdate} 배송 상품&gt</p>
		<a href="${orderurl}/list?ddate=${dto.getStartdate()}" class="pull-right mb-5">${dto.getStartdate()} 날짜 포함 주문 전체 보기</a>
		<section class="col-10 m-auto">
			<table class="table text-center table-hover border-success align-middle">
				<thead class="thead table-borderless">
					<tr class="" style="height: 50px">
						<th scope="col" class="align-middle">주문번호</th>
						<th scope="col" class="align-middle">상품 명</th>
						<th scope="col" class="align-middle">주문 개수</th>
						<th scope="col" class="align-middle">수령자 이름</th>
						<th scope="col" class="align-middle">주소</th>
						<th scope="col" class="align-middle">배송시작일</th>
						<th scope="col" class="align-middle">배송완료일</th>
						<th scope="col" class="align-middle">연락하기</th>
						<th scope="col" class="align-middle">상태 체크</th>
						<th scope="col" class="align-middle">
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
						<td>${order.getQty()}</td>
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
									<i class="bi bi-check text-primary" onclick="checked(this, ${order.getId()},  ${order.getOid()}, document.getElementById('status${order.getId()}'));"  style="font-size: 2rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('shipping')}" >
									<i class="bi bi-truck text-success" onclick="delivered(this, ${order.getId()},${order.getOid()}, document.getElementById('status${order.getId()}'));" style="font-size: 2rem; padding-left:4rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('delivered')}" >
									<i class="bi bi-person-check-fill text-dark" style="font-size: 2rem; padding-left:8rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('holding')}" >
										<i class="bi bi-dash-circle-fill text-warning" style="font-size: 2rem; padding-left:4rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('canceled')}" >
										<i class="bi bi-x-circle-fill text-danger" style="font-size: 2rem; padding-left:4rem;"></i>
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
				oid: oid,
				status: "shipping"
			},
			success: function (data) {
					if(data.res == "true") {
						e.setAttribute("class", "bi bi-truck text-success");
						e.setAttribute("style", "font-size: 2rem; padding-left:4rem;");
						e.setAttribute("onclick", "delivered(this, "+id+", "+status+");")
						e.onclick = function() {delivered(this, id, oid, status);};

						status.innerText = "shipping";
						
						// 알림창 
						
						let NodeList = "";
						let newNode = "<a id='qoo"+id+"' data-toggle='popover' data-trigger='hover' data-content='배송중~'></a>";
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
	
	function delivered(e, id, oid, status) {
		$.ajax({
			url: "${ajax_order}/delivered",
			type: "post",
			async: "false",
			dataType: "json",
			data: {
				id: id,
				oid: oid,
				status: "delivered"
			},
			success: function (data) {
					if(data.res == "true") {
						e.setAttribute("class", "bi bi-person-check-fill text-dark");
						e.setAttribute("style", "font-size: 2rem; padding-left:8rem;");
						status.innerText = "delivered";
						
						// 알림창 
						
						let NodeList = "";
						let newNode = "<a id='qoo"+id+"' data-toggle='popover' data-trigger='hover' data-content='배송완료!'></a>";
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