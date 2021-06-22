<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 수정</title>
<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
</head>

<body>
	<header>
		<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
	</header>
	<c:url var="add" value="/admin/product/update" />
	<form action="${add}" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
	<input type="hidden" name="id" value="${item.getId()}" readonly>
		<input type="hidden" name="aid" value="1">
		<div>
			<label for="id_title">제목</label>
			<input id="id_title" type="text" name="title" value="${item.getTitle()}" required>
		</div>
		<div>
			<label for="id_file">썸네일 이미지</label><br>
			<img id="imgPreview" src="${pageContext.request.contextPath}${item.getUrl()}" style="width: 200px; height: 200px;">
			<label for="id_file" style="font-size: 13px; color: gray;">
			<i class="bi bi-file-earmark-medical"></i>썸네일 이미지 파일 업로드<br>
				<input type="file" id="id_file" name="file" accept=“image/*” onchange="PreviewImage();">
			</label>
		</div>
		<div>
			<label for="id_ptype">상품 종류</label>
			<select id="id_ptype" name="ptype">
				<c:forEach var="data" items="${requestScope.ptypes}">
					<option value="${data.id}" ${data.id == item.getPtype() ? "selected" : ""}>${data.name}</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<label for="id_price">가격</label>
			<input id="id_price" type="number" name="price" value="${item.getPrice()}">
		</div>
		<div>
			<label for="id_contents">내용</label>
			<textarea id="id_contents" name="contents" cols="80" rows="20">${item.getContents()}</textarea>
		</div>
		<div>
			<label for="id_active">공개</label>
			<input id="id_active" type="checkbox" name="active" ${item.getActive() == "y" ? "checked" : ""}>
		</div>
		<div>
			<button type="submit">저장</button>
			<button type="button" onclick="history.back();">취소</button>
		</div>
	</form>
	<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
<script type="text/javascript">
	function PreviewImage() {
		var oFReader = new FileReader();
		oFReader.readAsDataURL(document.getElementById("id_file").files[0]);

		oFReader.onload = function (oFREvent) {
			document.getElementById("imgPreview").src = oFREvent.target.result;
		};
	};
</script>
</html>