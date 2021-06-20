<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
</head>
<body>
	<header>
		<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
	</header>
	<div>
		<ul>
			<c:url var="all" value="/product" />
			<li><a href="${all}">전체</a></li>
			<c:forEach var="ptype" items="${requestScope.producttypes }" >
				<li><a href="?ptype=${ptype.id }">${ptype.name }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div>
		<div>
			<c:url var="add" value="/product/add" />
			<button type="button" onclick="location.href='${add }'">글쓰기</button>
		</div>
		<div>
			<c:url var="search" value="/product" />
			<form id="search_form" action="${search }" method="get">
				<c:if test="${not empty param.ptype}" >
					<input type="hidden" name="ptype" value="${param.ptype }">
				</c:if>
			    <select name="searchtype">
			        <option value="t">제목</option>
			        <option value="c">내용</option>
			    </select>
				<input type="text" name="search">
				<button type="submit">검색</button>
			</form>
		</div>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>구분</th>
					<th>제목</th>
					<th>가격</th>
					<th>작성자</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:url var="detail" value="/product/detail" />
				<c:forEach var="item" items="${requestScope.productlist }" >
					<tr>
						<td>${item.getId() }</td>
						<td>${item.getPtype() }</td>
						<td><a href="${detail }?id=${item.getId() }">${item.getTitle() }</a></td>
						<td>₩ ${item.getPrice() }</td>
						<fmt:formatDate var="cdate" value="${item.getCdate() }"
		                                pattern="yyyy/MM/dd" />
						<td>${cdate }</td>
						<td>${item.getVcnt() }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
</html>