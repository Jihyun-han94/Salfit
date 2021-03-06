<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit Admin | 상품 등록</title>

<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<style>
.cm-stl {
	border: 1px solid #e7e7e7;
	margin: 30px;
}
i:hover {
	color: green;
}
.btn_confirm {
	margin: 15px;
}
.btn_confirm {
 padding: 5px 25px;
 border: 1px solid #bac600;
 color: #263238;
 background: transparent;
 -moz-border-radius: 2px;
 -webkit-border-radius: 2px;
 border-radius: 2px;
}
.btn_confirm:hover {
  background-color: #bac600;
  color: #ffffff;
}
</style>
<body>
<header>
	<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
</header>
	<c:url var="add" value="/admin/product/add" />
	<main class="cd-main-content sub-nav" style="margin-top: 100px;">
	<div style="margin: 0 auto; width:60%;">
	<h1 style="text-align:center; margin-bottom: 30px;">상품 등록</h1>
	<form action="${add}" method="POST" enctype="multipart/form-data">
		<input class="cm-stl" type="hidden" name="aid" value="1">
		<div class="col-8" style="text-align:left; margin:0 auto;">
			<label for="id_title">제목<span style="padding: 30px; color: #e7e7e7;">|</span></label>
			<input class="cm-stl" id="id_title" type="text" name="title" style="width: 350px;" required>
		</div>
		<div style="text-align:center; margin-bottom: 30px;">
			<!-- <label for="id_file">썸네일 이미지</label><br> -->
			<img id="imgPreview" style="width: 200px; height: 200px; border:none;">
			<label class="file_label" for="id_file" style="font-size: 13px; color: gray; margin-left:30px;">
			<i class="bi bi-file-earmark-medical"><span>썸네일 이미지 파일 업로드</span></i><br>
				<input class="cm-stl" type="file" style="display: none;" id="id_file" name="file" accept=“image/*” onchange="PreviewImage();">
			</label>
		</div>
		<div class="col-8" style="text-align:left; margin:0 auto;">
			<label for="id_ptype">상품 종류<span style="padding: 30px; color: #e7e7e7;">|</span></label>
			<select class="cm-stl" id="id_ptype" name="ptype" style="width: 150px;">
				<c:forEach var="data" items="${requestScope.producttypes}">
					<option value="${data.id}">${data.name}</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-8" style="text-align:left; margin:0 auto;">
			<label for="id_price">가격<span style="padding-left: 60px; padding-right: 30px; color: #e7e7e7;">|</span></label>
			<input class="cm-stl" id="id_price" type="number" name="price">
		</div>
		<div class="col-8" style="text-align:left; margin:0 auto;">
			<label for="id_contents">내용<span style="padding: 60px; color: #e7e7e7;">|</span></label>
			<textarea class="cm-stl" id="id_contents" name="contents" cols="75" rows="10" style="text-align: left;" required></textarea>
		</div>
		<div class="col-8" style="text-align:left; margin:0 auto;">
			<label for="id_active">공개 여부<span style="padding: 30px; color: #e7e7e7;">|</span></label>
			<input class="cm-stl" id="id_active" type="checkbox" name="active" checked>
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