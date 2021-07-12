<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 주문 관리</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
<c:url var="order" value="/admin/order" />
<c:url var="ajax_order" value="/ajax/admin/order" />

</head>
<body>

	<header>
 		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include> 
	</header><br><br><br><br><br><br><br><br>
	<div class="bodyContainer">
	<c:if test="${!empty param.ddate}">
		<a href="${order}/calendar" class="pull-left mb-5 ml-5"><i class="bi bi-arrow-left-circle align-middle" style="font-size: 3rem; color: #bac600;"></i> 달력</a>
	</c:if>
		<h1 class="text-center mb-3">주문 내역</h1>
		<p class="text-center mb-3"><c:if test="${!empty param.ddate}">&lt${param.ddate} 배송 상품 포함&gt</c:if> </p>
		<section class="mb-5 col-10 m-auto">
		<c:if test="${!empty param.ddate}">
		<a href="${order}/delivery?startdate=${param.ddate}" class="pull-right mb-5">${param.ddate} <span style="color:#bac600 ;">당일 배송 상품 목록</span> </a>
		</c:if>
		<c:if test="${cri.getId() != 0}">
		<a href="${order}/list" class="pull-right mb-5" style="color:#bac600 ;">전체 주문 보기</a>
		</c:if>
			
			<c:if test="${cri.getId() == 0 && empty param.ddate}">
			<div class="row">
				<div class="col-md-1 mb-5 ml-auto">	
					<select class="form-control align-middle" id="perPageSel">
				  		<option value="10">10개씩</option>
				  		<option value="15">15개씩</option>
				  		<option value="20">20개씩</option>
					</select>
				</div>
			</div>
			</c:if>
			
			<table class="table text-center table-hover border-success align-middle">
				<thead class="thead table-borderless">
					<tr class="" style="height: 50px">
						<th scope="col" class="align-middle">주문번호</th>
						<th scope="col" class="align-middle">회원번호</th>
						<th scope="col" class="align-middle">수령자 이름</th>
						<th scope="col" class="align-middle">주소</th>
						<th scope="col" class="align-middle">결제수단 / 총금액</th>
						<th scope="col" class="align-middle">결제일자</th>
						<th scope="col" class="align-middle">배송시작일</th>
						<th scope="col" class="align-middle">배송완료일</th>
						<th scope="col" class="align-middle">연락하기</th>
						<th scope="col" class="align-middle">상태 체크</th>
						<th scope="col" class="align-middle">
						<c:if test="${cri.getId() == 0 && empty param.ddate}">
						<form id="select_status_form" action="${order}/list" method="get">
							<select id="selectOrderStatus" onchange="searchStatus(this)" name="status" >
						        <option value="" ${dto.getStatus() == null ? "selected" : "" }>전체</option>
						        <option value="paid" ${dto.getStatus() == "paid" ? "selected" : "" }>미확인</option>
						        <option value="checked" ${dto.getStatus() == "checked" ? "selected" : "" }>배송전</option>
						        <option value="shipping" ${dto.getStatus() == "shipping" ? "selected" : "" }>배송중</option>
						        <option value="delivered" ${dto.getStatus() == "delivered" ? "selected" : "" }>배송완료</option>
						        <option value="holding" ${dto.getStatus() == "holding" ? "selected" : "" }>취소요청</option>
						        <option value="canceled" ${dto.getStatus() == "canceled" ? "selected" : "" }>취소완료</option>
						    </select>
						</form>
						</c:if>
						</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${empty orderlist}" >
						<tr>
						<td colspan="9">주문 결과가 없습니다.</td>
					</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="order" items="${orderlist}" varStatus="status">
						<tr scope="row">
						<th> ${order.getId()}
							<c:choose>
								<c:when test="${order.getStatus().equals('paid')}">
									<a id="${order.getId()} " type="button"  data-target="#staticBackdrop" class="ordermodal btn" onclick="zoomin(this, ${order.getId()},document.getElementById('statusicon${order.getId()}') , document.getElementById('status${order.getId()}'));" >
									<i class="bi bi-zoom-in" style="font-size: 1.5rem; color: cornflowerblue;" ></i>
									</a>
								</c:when>
								<c:otherwise>
									<a id="${order.getId()} " type="button" data-target="#staticBackdrop" class="ordermodal btn" >
										<i class="bi bi-zoom-in" style="font-size: 1.5rem; color: cornflowerblue;" ></i>
									</a>
								</c:otherwise>
							</c:choose>

							<!-- Modal -->
							<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="staticBackdropLabel">주문번호 :  <span id="oidinmodal">${oreder.getId()}</span></h5>
							        <c:set var="oid" value="" />
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <div id="modalbody" class="modal-body">
							      </div>
							      <div class="modal-footer">
						        <button type="button"  class="btn btn-secondary"  data-dismiss="modal">주문확인 완료</button>
						      </div>
						    </div>
						  </div>
						</div>
						</th>
						<td>${order.getAid()}</td>
						<td>${order.getReceiver()}</td>
						<td class="text-truncate" style="max-width: 100px;">
							<a tabindex="0" role="button" data-toggle="popover" data-trigger="hover" data-container="body" data-placement="top" title="상세 주소" data-content="${order.getAddress()}">${order.getAddress()}</a>
						</td>
						<td class="text-truncate" style="max-width: 150px;">
							${order.getPaytype()} / ${order.getTotal()}</td>
						<td>${order.getPdate() }</td>
						<td>${order.getDdate() }</td>
						<td>${order.getEdate() }</td>
						<td> 
							<a href="tel:${order.getPhone()}"> 
								<i class="bi bi-telephone-outbound" style="font-size: 1.5rem; color: cornflowerblue;"></i>
							</a>
						</td>
						<td id="statusicon${order.getId()}">
							<c:choose>
								<c:when test="${order.getStatus().equals('unpaid')}" >
									<i></i>
								</c:when>
								<c:when test="${order.getStatus().equals('paid')}" >
									<i></i>
								</c:when>
								<c:when test="${order.getStatus().equals('checked')}" >
										<i class="bi bi-check text-primary"  style="font-size: 2rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('shipping')}" >
										<i class="bi bi-truck text-success" style="font-size: 2rem; padding-left:4rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('holding')}" >
										<i class="bi bi-dash-circle-fill text-warning" onclick="cancel(this, ${order.getId()}, document.getElementById('status${order.getId()}'));" style="font-size: 2rem; padding-left:4rem;"></i>
								</c:when>
								<c:when test="${order.getStatus().equals('canceled')}" >
										<i class="bi bi-x-circle-fill text-danger" style="font-size: 2rem; padding-left:4rem;"></i>
								</c:when>
								<c:otherwise>
										<i class="bi bi-person-check-fill text-dark" style="font-size: 2rem; padding-left:8rem;"></i>
								</c:otherwise>
							</c:choose>
						</td>
						<td id="status${order.getId()}">
							<c:choose>
								<c:when test="${order.getStatus().equals('paid')}" >
									<p>paid</p>
								</c:when>
								<c:when test="${order.getStatus().equals('checked')}" >
									<p>checked</p>
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
									<p>cancelled</p>
								</c:when>
								<c:otherwise>
									<p>unpaid</p>
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
		
		<c:if test="${cri.getId() == 0 && empty param.ddate}">
		<section class="mt-5">
		<!-- 페이지 번호 -->
			<nav aria-label="Page navigation">
			  <ul class="pagination justify-content-center">
			    <li id="page-prev" class="page-item">
			      <a class="page-link" href="list${pageMaker.makeQuery(pageMaker.startPage)}" aria-label="Prev" tabindex="-1" aria-disabled="true">
			      <span aria-hidden="true">«</span>
			      </a>
			    </li>
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				    <li id="page${idx}" class="page-item">
					    <a class="page-link" href="list${pageMaker.makeQuery(idx)}">
					    	<!-- 시각 장애인을 위한 추가 -->
					      	<span>${idx}<span class="sr-only">(current)</span></span>
					    </a>
				    </li>
				</c:forEach>
			    <li id="page-next" class="page-item">
			      <a class="page-link" href="list${pageMaker.makeQuery(pageMaker.endPage)}" aria-label="Next">
			      <span aria-hidden="true">»</span>
			      </a>
			    </li>
			  </ul>
			</nav>
		</section>
		</c:if>

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
	
	/* 모달에 장바구니 아이디 넘겨주기 */
	$(".ordermodal").click(function(){
		var orderId = $(this).attr('id'); 
	  	var modaloid = $("#oidinmodal");
		modaloid.text(orderId);
		
		const container = document.getElementById('modalbody');
		container.innerHTML = '<div class="row">'
							+ '	  <div class="col-1 col-sm-1">번호</div>'
							+ '   <div class="col-3 col-sm-3">상품명</div>'
							+ '   <div class="col-2 col-sm-2">주문 수량 / 가격</div>'
							+ '   <div class="col-5 col-sm-4">구독 기간(일수)</div>'
							+ '   <div class="col-1 col-sm-2">상태</div>'
							+ '</div><hr>';
		var orderdetail = []; var i = 0;
   		    <c:forEach items="${orderdetaillist}" var="orderdetail" varStatus="loop">
	  			if (${orderdetail.getOid()} == orderId) { 
	  				i++;
    		     	orderdetail.push(
 		  				{	"title": "${orderdetail.getPname()}",
    		        	"oid" : "${orderdetail.getOid()}",
    		        	"start": "${orderdetail.getStartdate()}",
    		        	"end":"${orderdetail.getEnddate()}", 
  		        		"qty" : "${orderdetail.getQty()}",
  		        		"price" : "${orderdetail.getPrice()}",
      					"period" : "${orderdetail.getStartdate()} ~ ${orderdetail.getEnddate()} (${orderdetail.getDays()} 일)",
      					"receiver" : "${orderdetail.getReceiver()}",
      					"phone" : "${orderdetail.getPhone()}",
      					"address" : "${orderdetail.getAddress()}",
    		        	"id": "${orderdetail.getId()}",
    		        	"status": "${orderdetail.getStatus()}"
   		        		}
   		        	)
	  			}
   		    </c:forEach>

   		for(var j=0; j < i; j++) {
			let NodeList = "";
			let newNode = "<div class='row'>";
				newNode += "<div id='detailid' class='col-1 col-sm-1'>"+orderdetail[j].id+"</div>";	
				newNode += "<div class='col-3 col-sm-3'><a id='detailpname' href='/salfit/product/detail?id="+orderdetail[j].id+"' class='tooltip-test' title='Tooltip'>"+orderdetail[j].title+"</a></div>";
				newNode += "<div id='detailqtyprice' class='col-2 col-sm-2'>"+orderdetail[j].qty + " 개 / " + orderdetail[j].price+" 원</div>";
				newNode += "<div id='detailperiod' class='col-5 col-sm-4'>"+orderdetail[j].period+"</div>";
				newNode += "<div id='detailstatus' class='col-1 col-sm-2'>"+orderdetail[j].status+"</div>";
				newNode += "</div>";
			NodeList += newNode;
			$(NodeList).appendTo(container);
		}
		// modal show 
		$('#staticBackdrop').modal('show');
	});
	
	
	/* paging */
	//perPageNum select 박스 설정
	setPerPageNumSelect();
	
	var canPrev = '${pageMaker.prev}';
	var canNext = '${pageMaker.next}';
	
	//현재 페이지 파란색으로 활성화
	var thisPage = '${param.page}';
	$('#page'+thisPage).addClass('active');
	if(${empty param.page}) {
		$('#page1').addClass('active');
	}
		
});


	var perPageNum = "${pageMaker.cri.perPageNum}";
	var $perPageSel = $('#perPageSel');
	var thisPage = '${pageMaker.cri.page}';
	function setPerPageNumSelect(){
		$perPageSel.val(perPageNum).prop("selected",true);
		//PerPageNum가 바뀌면 링크 이동
		$perPageSel.on('change',function(){
			let status = document.getElementById('selectOrderStatus').value;
			if(status != null || status == "") {
				window.location.href = "list?status="+status+"&page=1&perPageNum="+$perPageSel.val();
			} else {
				window.location.href = "list?page=1&perPageNum="+$perPageSel.val();
			}
		})
	}

	function searchStatus(e) {
		const url = new URL(window.location.href);
		const urlParams = url.searchParams;
		if(urlParams.has('ddate')) {
			var ddateParam = urlParams.get('ddate'); // null or not 
		}
		if(urlParams.has('id')) {
			urlParams.delete('id');
		}
		if(urlParams.has('status')) {
			urlParams.set('status', e.value);
		} else {
			urlParams.append('status', e.value);
		}
		if(urlParams.has('page')) {
			urlParams.set('page', "1");
		} else {
			urlParams.append('page', "1");
		}
		if(urlParams.has('perPageNum')) {
			urlParams.set('perPageNum', perPageNum);
		} else {
			urlParams.append('perPageNum', "10");
		}
		window.location.href = "list?" + urlParams;
	}


	function orderid(id) {
	     document.getElementById("orderId").value = id;
	     alert(id);
	}
	
	function zoomin(e, id, icon, status) {
		
		if(status.innerText == "paid") {
		$.ajax({
			url: "${ajax_order}/checked",
			type: "post",
			async: "false",
			dataType: "json",
			data: {
				id: id,		 
				status: "checked"
			},
			success: function (data) {
					if(data.res == "true") {
						icon.setAttribute("class", "bi bi-check text-primary");
						icon.setAttribute("style", "font-size: 2rem;");
						status.innerText = "checked";
						
						
						// 알림창 
						
						let NodeList = "";
						let newNode = "<a id='qo"+id+"' data-toggle='popover' data-trigger='hover' data-content='주문확인'></a>";
						NodeList += newNode;
						$(NodeList).appendTo(icon);
						
						$('#qo'+id).popover('show');
						$('#qo'+id).on('shown.bs.popover', function() {
						    setTimeout(function() {
						        $('#qo'+id).popover('hide');
						    }, 3000);
						});
						
					} 
			}				
		});
		}
	}
	
	function checked(e, id, status) {
		if(status.innerText == "checked") {
		$.ajax({
			url: "${ajax_order}/checked",
			type: "post",
			async: "false",
			dataType: "json",
			data: {
				id: id,		 
				status: "shipping"
			},
			success: function (data) {
					if(data.res == "true") {
						e.setAttribute("class", "bi bi-truck text-success");
						e.setAttribute("style", "font-size: 2rem; padding-left:4rem;");
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
	}
	
	function cancel(e, id, status) {
		if(status.innerText == "holding") {
		$.ajax({
			url: "${ajax_order}/cancel",
			type: "post",
			async: "false",
			dataType: "json",
			data: {
				id: id,		 
				status: "canceled"
			},
			success: function (data) {
					if(data.res == "true") {
						e.setAttribute("class", "bi bi-x-circle-fill text-danger");
						e.setAttribute("style", "font-size: 2rem; padding-left:4rem;");
						status.innerText = "cancelled";
						
						// 알림창 
						
						let NodeList = "";
						let newNode = "<a id='qoo"+id+"' data-toggle='popover' data-trigger='hover' data-content='취소완료'></a>";
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
	}
	
	
	
</script>
</html>