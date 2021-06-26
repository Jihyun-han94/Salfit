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

		<section class="applicantTableSection">
			<h3>전체 주문</h3>
			<table class="table text-center">
				<thead class="thead-dark">
					<tr>
						<th scope="col">주문번호</th>
						<th scope="col">회원번호</th>
						<th scope="col">수령자 이름</th>
						<th scope="col">주소</th>
						<th scope="col">결제수단 / 총금액</th>
						<th scope="col">결제일자</th>
						<th scope="col">배송일자</th>
						<th scope="col">연락하기</th>
						<th scope="col">상태 체크</th>
						<th scope="col">확인 상태</th>
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
						<c:forEach var="order" items="${orderlist}" >
						<tr scope="row">
						<th>
							<a href="${order}/detail?id=${order.getId()}">
								${order.getId()}
								<i class="bi bi-zoom-in" style="font-size: 1.5rem; color: cornflowerblue;"></i>
							</a>
						</th>
						<td>${order.getAid()}</td>
						<td>${order.getReciever()}</td>
						<td class="text-truncate" style="max-width: 150px;">${order.getAddress()}</td>
						<td class="text-truncate" style="max-width: 150px;">
							${order.getPaytype()} / ${order.getTotal()}</td>
						<fmt:formatDate var="pdate" value="${order.getPdate() }"
	                		pattern="yyyy년 MM월 dd일 a hh시 mm분 ss초" />
						<fmt:formatDate var="ddate" value="${order.getDdate() }"
	                		pattern="yyyy년 MM월 dd일 a hh시 mm분 ss초" />
						<td>${pdate}</td>
						<td>${ddate}</td>
						<td> <i class="bi bi-telephone-outbound" style="font-size: 1.5rem; color: cornflowerblue;"></i>
							<%-- <a href="tel:${order.getPhone()}>${order.getPhone()}
								<i class="bi bi-telephone-outbound" style="font-size: 1.5rem; color: cornflowerblue;"></i>
							</a> --%>
						</td>
						<td>
							<c:choose>
								<c:when test="${order.getStatus().equals('paid')}" >
									<%-- <a onclick="checked(this, ${order.getId()});">  --%>
										<i class="bi bi-check text-danger" onclick="checked(this, ${order.getId()});"  style="font-size: 2rem;"></i>
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
						<td>
							<c:choose>
								<c:when test="${order.getStatus().equals('paid')}" >
									<p>paid</p>
								</c:when>
								<c:when test="${order.getStatus().equals('shipping')}" >
									<p>shipping</p>
								</c:when>
								<c:when test="${order.getStatus().equals('delivered')}" >
									<p>delivered</p>
								</c:when>
								<c:otherwise>
									<p>delivered</p>
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

	<%-- 	<section class="applicantTableSection">

			<h4>채용 완료</h4>
			<table class="table">
				<thead class="thead-light">
					<tr>
						<th scope="col">#</th>
						<th scope="col">지원공고</th>
						<th scope="col">지원자 이름</th>
						<th scope="col">경력 사항</th>
						<th scope="col">채용 일자</th>
					</tr>
				</thead>
				<tbody>
					<%
						int numOfHired = 0;
						for(ApplicantVO applicant : applicants) {
							if(applicant.getStatus().equals("hired")) {
								numOfHired++;
							}
						}
						if(numOfHired == 0) {
					%>
					<tr>
						<td colspan="9">조회 결과가 없습니다.</td>
					</tr>
					<% 
						} else {
					
			    		int j = 1;
						for(ApplicantVO applicant : applicants) {
						if(applicant.getStatus().equals("hired")) {
					%>
					<tr scope="row">
						<th><%=j++ %></th>
						<td class="text-truncate" style="max-width: 150px;"><%=applicant.getJobTitle() %></td>
						<td><%=applicant.getUserName()%></td>
						<td class="text-truncate" style="max-width: 150px;"><%=applicant.getUserCareer()%></td>
						<td><%=applicant.getHireDate()%></td>

						<% 	
						}}}
					%>
				</tbody>
			</table>

		</section>

		<section class="applicantTableSection">

			<h4>보류</h4>
			<table class="table">
				<thead class="thead-light">
					<tr>
						<th scope="col">#</th>
						<th scope="col">지원공고</th>
						<th scope="col">지원자 이름</th>
						<th scope="col">경력 사항</th>
						<th scope="col">지원 일자</th>
						<th scope="col">이력서</th>
						<th scope="col">연락하기</th>
						<th scope="col">채용</th>
						<th scope="col">삭제</th>

					</tr>
				</thead>
				<tbody>
					<%
						int numOfRefused = 0;
						for(ApplicantVO applicant : applicants) {
							if(applicant.getStatus().equals("refused")) {
								numOfRefused++;
							}
						}
						if(numOfRefused == 0) {
					%>
					<tr>
						<td colspan="9">조회 결과가 없습니다.</td>
					</tr>
					<% 
						} else {
					
						int l = 1;
						for(ApplicantVO applicant : applicants) {
							if(applicant.getStatus().equals("refused")) {
					%>
					<tr scope="row">

						<th scope="row"><%= l++ %></th>
						<td class="text-truncate" style="max-width: 150px;"><%=applicant.getJobTitle() %></td>
						<td><%=applicant.getUserName()%></td>
						<td class="text-truncate" style="max-width: 150px;"><%=applicant.getUserCareer()%></td>
						<td><%=applicant.getApplyDate()%></td>
						<td><a href="<%=request.getContextPath()%>/corp/applicant/view?id=<%=applicant.getId()%>">
								<i class="bi bi-zoom-in" style="font-size: 1.5rem; color: cornflowerblue;"></i>
							</a>
						</td>
						<td><a href="mailto:<%=applicant.getUserEmail()%>?Subject=지원해주셔서 감사합니다.&body=채용 프로세스 안내문 첨부">
								<i class="bi bi-envelope-fill" style="font-size: 1.5rem; color: cornflowerblue;"></i>
							</a>
						</td>
						<td>
							<a href="../corp/applicant/hire?id=<%=applicant.getId()%>">
								<i class="bi bi-person-check text-secondary" style="font-size: 1.5rem;"></i>
							</a>
						</td>
						<td>
							<button type="button" class="btn btn-link btn-outline" data-toggle="modal"
								data-target="#exampleModalca<%=applicant.getId()%>">
								<i class="bi bi-trash text-danger"></i>
							</button>

							<div class="modal fade" id="exampleModalca<%=applicant.getId()%>" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabelca<%=applicant.getId()%>">정말
												지원자 정보를 삭제하시겠습니까?</h5>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											삭제된 지원자는 다시 찾기가 불가능 합니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">취소</button>

											<form action="<%=request.getContextPath() %>/corp/applicant/refuse"
												method="POST">
												<input type="hidden" name="id" value="<%= applicant.getId()%>" readonly>
												<button type="submit" class="btn btn-danger">삭제</button>
											</form>
										</div>
									</div>
								</div>
							</div>


						</td>
					</tr>
					<%	
							}
						}
						}
					%>

				</tbody>
			</table>
		</section> --%>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function checked(e, id) {
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
					} 
			}				
		});
	}
</script>
</html>