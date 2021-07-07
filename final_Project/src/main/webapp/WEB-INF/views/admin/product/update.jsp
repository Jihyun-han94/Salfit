<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 수정</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<style>
input, textarea, select {
	border: 1px solid #e7e7e7;
	margin: 30px;
}
i:hover {
	color: green;
}
.btn_confirm {
	margin: 15px;
}
</style>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<main class="cd-main-content sub-nav" style="margin-top: 100px;">
	<div style="margin: 0 auto; width:60%;">
	<h1 style="text-align:center; padding-bottom: 38px;">상품 정보 수정</h1>
	<c:url var="add" value="/admin/product/update" />
	<form action="${add}" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
	<input type="hidden" name="id" value="${item.getId()}" readonly>
		<input type="hidden" name="aid" value="1">
		<div style="text-align:center; margin-top: 38px;">
			<!-- <label for="id_title">상품 이름<span style="padding: 30px; color: #e7e7e7;">|</span></label> -->
			<input id="id_title" type="text" name="title" style="width: 400px; text-align:center; border:none;" placeholder="상품 이름을 입력해 주세요" value="${item.getTitle()}" required>
		</div>
		<div style="text-align:center; margin-bottom: 38px;">
			
			<img id="imgPreview" src="${pageContext.request.contextPath}${item.getUrl()}" style="width: 200px; height: 200px; border:none;">
			<label class="file_label" for="id_file" style="font-size: 13px; color: gray; margin-left:30px;">
			<i class="bi bi-file-earmark-medical"><span>썸네일 이미지 파일 업로드</span></i><br>
				<input type="file" style="display: none;" id="id_file" name="file" accept=“image/*” onchange="PreviewImage();">
			</label>
		</div>
		<div style="margin-left:45px;">
			<label for="id_ptype">상품 종류<span style="padding: 30px; color: #e7e7e7;">|</span></label>
			<select id="id_ptype" name="ptype" style="width: 180px;">
				<c:forEach var="data" items="${requestScope.ptypes}">
					<option value="${data.id}" ${data.id == item.getPtype() ? "selected" : ""}>${data.name}</option>
				</c:forEach>
			</select>
		</div>
		<div style="margin-left:45px;">
			<label for="id_price">가격<span style="padding-left: 60px; padding-right: 30px; color: #e7e7e7;">|</span></label>
			<input id="id_price" type="number" name="price" value="${item.getPrice()}">
		</div>
		<div style="margin-left:45px;">
			<label for="id_contents">내용<span style="padding: 60px; color: #e7e7e7;">|</span></label>
			<textarea id="id_contents" name="contents" cols="75" rows="10">${item.getContents()}</textarea>
		</div>
		<div style="margin-left:45px;">
			<label for="id_active">공개 여부<span style="padding: 30px; color: #e7e7e7;">|</span></label>
			<input id="id_active" type="checkbox" name="active" ${item.getActive() == "y" ? "checked" : ""}>
		</div>
		<div style="text-align: center; padding: 50px;">
			<button type="submit" class="btn_confirm">저장</button>
			<button type="button" class="btn_confirm" onclick="history.back();">취소</button>
		</div>
	</form>
	</div>
	</main>
	<footer>	
		<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
	</footer>
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
