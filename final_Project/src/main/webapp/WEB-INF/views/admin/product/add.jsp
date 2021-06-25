<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 상품 등록</title>

<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<c:url var="add" value="/admin/product/add" />
	<form action="${add}" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="aid" value="1">
		<div>
			<label for="id_title">제목</label>
			<input id="id_title" type="text" name="title" required>
		</div>
		<div>
			<label for="id_file">썸네일 이미지</label><br>
			<img id="imgPreview" style="width: 200px; height: 200px;">
			<label for="id_file" style="font-size: 13px; color: gray;">
			<i class="bi bi-file-earmark-medical"></i>썸네일 이미지 파일 업로드<br>
				<input type="file" id="id_file" name="file" accept=“image/*” onchange="PreviewImage();">
			</label>
		</div>
		<div>
			<label for="id_ptype">상품 종류</label>
			<select id="id_ptype" name="ptype">
				<c:forEach var="data" items="${requestScope.producttypes}">
					<option value="${data.id}">${data.name}</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<label for="id_price">가격</label>
			<input id="id_price" type="number" name="price">
		</div>
		<div>
			<label for="id_contents">내용</label>
			<textarea id="id_contents" name="contents" cols="80" rows="20"></textarea>
		</div>
		<div>
			<label for="id_active">공개</label>
			<input id="id_active" type="checkbox" name="active" checked>
		</div>
		<div>
			<button type="submit">저장</button>
			<button type="button" onclick="history.back();">취소</button>
		</div>
	</form>
	<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
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