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
<%-- 		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include> --%>
	</header>
	<div class="bodyContainer">
		<h1 class="corpBoardTitle">주문 관리</h1>
		<c:if test="${cri.getId() != 0}">
		<a href="${order}/list" class="btn btn-outline-secondary pull-right">전체 주문 보기</a>
		</c:if>
		<a href="${order}/calendar" class="btn btn-outline-secondary pull-right">배송 관리</a>
		<section class="applicantTableSection">
			<h3>전체 주문</h3>
			
			<c:if test="${cri.getId() == 0}">
			<div class="row">
				<div class="col-md-10"></div>
				<div class="col-md-1"><sapn>페이지 당 주문건수: </sapn></div>	
				<div class="col-md-1 text-right">
					<select class="form-control" id="perPageSel">
				  		<option value="10">10</option>
				  		<option value="15">15</option>
				  		<option value="20">20</option>
					</select>
				</div>
			</div>
			</c:if>
			
			<table class="table text-center">
				<thead class="thead-dark">
					<tr>
						<th scope="col">주문번호</th>
						<th scope="col">회원번호</th>
						<th scope="col">수령자 이름</th>
						<th scope="col">주소</th>
						<th scope="col">결제수단 / 총금액</th>
						<th scope="col">결제일자</th>
						<th scope="col">배송시작일</th>
						<th scope="col">배송완료일</th>
						<th scope="col">연락하기</th>
						<th scope="col">상태 체크</th>
						<th scope="col">주문 처리 상태
						<c:if test="${cri.getId() == 0}">
						<form id="select_status_form" action="${order}/list" method="get">
							<select id="selectOrderStatus" onchange="searchStatus(this)" name="status" >
						        <option value="" ${dto.getStatus() == null ? "selected" : "" }>전체</option>
						        <option value="paid" ${dto.getStatus() == "paid" ? "selected" : "" }>미확인</option>
						        <option value="checked" ${dto.getStatus() == "checked" ? "selected" : "" }>배송전</option>
						        <option value="shipping" ${dto.getStatus() == "shipping" ? "selected" : "" }>배송중</option>
						        <option value="delivered" ${dto.getStatus() == "delivered" ? "selected" : "" }>배송완료</option>
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
									<a id="${order.getId()} " type="button" data-toggle="modal" data-target="#staticBackdrop" class="ordermodal btn" onclick="zoomin(this, ${order.getId()},document.getElementById('statusicon${order.getId()}') , document.getElementById('status${order.getId()}'));" >
									<i class="bi bi-zoom-in" style="font-size: 1.5rem; color: cornflowerblue;" ></i>
									</a>
								</c:when>
								<c:otherwise>
									<a id="${order.getId()} " type="button" data-toggle="modal" data-target="#staticBackdrop" class="ordermodal btn" >
										<i class="bi bi-zoom-in" style="font-size: 1.5rem; color: cornflowerblue;" ></i>
									</a>
								</c:otherwise>
							</c:choose>

							<!-- Modal -->
							<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="staticBackdropLabel">주문번호 :  <span id="oidinmodal">${oreder.getId()}</span></h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <div class="modal-body">
							      	 <div class="row">
							      	 	  <div class="col-1 col-sm-1">
									        상품 번호
									      </div>
									      <div class="col-4 col-sm-5">
									        상품명
									      </div>
									      <div class="col-3 col-sm-3">
									      	주문 수량 / 가격 
									      </div>
									      <div class="col-4 col-sm-3">
									      	구독 기간(일수)
									      </div>
									 </div><hr>
								    <c:forEach var="orderdetail" items="${orderdetaillist}" varStatus="loop">
								      <%-- 	<c:if test="${orderdetail.getOid() == order.getId()}"> --%>
							      	 <div class="row">
								      	  <div class="col-1 col-sm-1">
								        	${orderdetail.getOid()}
								          </div>
								          <div class="col-4 col-sm-5">
								            <a href="#" class="tooltip-test" title="Tooltip">${orderdetail.getPname()}</a>
								          </div>
								          <div class="col-3 col-sm-3">
								             ${orderdetail.getQty()} 개 / ${orderdetail.getPrice()} 원 
								          </div>
								          <div class="col-4 col-sm-3">
								          	${orderdetail.getStartdate()} ~ ${orderdetail.getEnddate()} (${orderdetail.getDays()} 일간)
								          </div>
								    </div>
								      	<%-- </c:if> --%>
									  	${!loop.last ? '<hr>' : ''}	
									  </c:forEach>
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
						<%-- <fmt:formatDate var="pdate" value="${order.getPdate() }"
	                		pattern="yyyy년 MM월 dd일 a hh시 mm분 ss초" />
						<fmt:formatDate var="ddate" value="${order.getDdate() }"
	                		pattern="yyyy년 MM월 dd일 a hh시 mm분 ss초" /> --%>
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
								<c:when test="${order.getStatus().equals('paid')}" >
									<i></i>
								</c:when>
								<c:when test="${order.getStatus().equals('checked')}" >
									<%-- <a onclick="checked(this, ${order.getId()});">  --%>
										<i class="bi bi-check text-danger" onclick="checked(this, ${order.getId()}, document.getElementById('status${order.getId()}'));"  style="font-size: 2rem;"></i>
									<!-- </a> -->
								</c:when>
								<c:when test="${order.getStatus().equals('shipping')}" >
										<i class="bi bi-truck text-warning" style="font-size: 2rem; padding-left:4rem;"></i>
								</c:when>
								<c:otherwise>
										<i class="bi bi-person-check-fill text-success" style="font-size: 2rem; padding-left:8rem;"></i>
								</c:otherwise>
							</c:choose>
						</td>
						<td id="status${order.getId()}">
							<c:choose>
								<c:when test="${order.getStatus().equals('checked')}" >
									<p>checked</p>
								</c:when>
								<c:when test="${order.getStatus().equals('shipping')}" >
									<p>shipping</p>
								</c:when>
								<c:when test="${order.getStatus().equals('delivered')}" >
									<p>delivered</p>
								</c:when>
								<c:otherwise>
									<p>paid</p>
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
		
		<c:if test="${cri.getId() == 0}">
		<section>
			<!-- 페이지 번호 -->	
			<div class="text-center">
				<nav aria-label="pagination">
					<ul class="pagination">
					
						<!-- prev 버튼 -->
						<li id="page-prev">
							<a href="list${pageMaker.makeQuery(pageMaker.startPage-1)}" aria-label="Prev">
								<span aria-hidden="true">«</span>
							</a>
						</li>
						
						<!-- 페이지 번호 (시작 페이지 번호부터 끝 페이지 번호까지) -->
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						    <li id="page${idx}">
							    <a href="list${pageMaker.makeQuery(idx)}">
							    	<!-- 시각 장애인을 위한 추가 -->
							      	<span>${idx}<span class="sr-only">(current)</span></span>
							    </a>
						    </li>
						</c:forEach>
						
						<!-- next 버튼 -->
						<li id="page-next">
						    <a href="list${pageMaker.makeQuery(pageMaker.endPage)}" aria-label="Next">
						    	<span aria-hidden="true">»</span>
						    </a>
						</li>
						
					</ul>
				</nav>
			</div>
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
	  	var modalheader = $(".modal-header");
	  	var modaloid = $("#oidinmodal");
		let node = "<input type='hidden' data-id='"+orderId+"' value='"+orderId+"'>";
		$(node).appendTo(modalheader);
		modaloid.text(orderId);
	});
	
	
	/* paging */
	//perPageNum select 박스 설정
	setPerPageNumSelect();
	
	//prev 버튼 활성화, 비활성화 처리
	var canPrev = '${pageMaker.prev}';
	if(canPrev !== 'true'){
		$('#page-prev').addClass('disabled');
	}
	
	//next 버튼 활성화, 비활성화 처리
	var canNext = '${pageMaker.next}';
	if(canNext !== 'true'){
		$('#page-next').addClass('disabled');
	}
	
	//현재 페이지 파란색으로 활성화
	var thisPage = '${pageMaker.cri.page}';
	//매번 refresh 되므로 다른 페이지 removeClass 할 필요는 없음->Ajax 이용시엔 해야함
	$('#page'+thisPage).addClass('active');
		
});


	var perPageNum = "${pageMaker.cri.perPageNum}";
	var $perPageSel = $('#perPageSel');
	var thisPage = '${pageMaker.cri.page}';
	function setPerPageNumSelect(){
		$perPageSel.val(perPageNum).prop("selected",true);
		//PerPageNum가 바뀌면 링크 이동
		$perPageSel.on('change',function(){
			let status = document.getElementById('selectOrderStatus').value;
			//searchStatus($('#selectOrderStatus'));
			//pageMarker.makeQuery 사용 못하는 이유: makeQuery는 page만을 매개변수로 받기에 변경된 perPageNum을 반영못함
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
		/* var key = id;
		alert(key);
		eval("var orderId" + key + "=" + key); */
		
	     /* var orderId = $(this).data('id'); */
	     /* $(".modal-header #orderId").val( id ); */
	     document.getElementById("orderId").value = id;
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
						alert(id);
						icon.setAttribute("class", "bi bi-check text-danger");
						icon.setAttribute("style", "font-size: 2rem;");
						icon.setAttribute("onclick", "checked(this, "+id+", "+status+");")
						icon.onclick = function() {checked(this, id, status);};
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
	}
	
	
	
</script>
</html>