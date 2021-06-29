<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
 <%@ include file="/WEB-INF/views/module/css_js.jsp" %>
 <link rel="stylesheet" href="/webapp/resources/static/css/total.css">
</head>
<c:url var="expire" value="/ajax/account/expire"	/>
<script type="text/javascript">
function updateInfo() {
	var name = document.getElementById("id_name").value;
	var password = document.getElementById("id_password").value;
	var phone = document.getElementById("id_phnumber").value;
	
	document.update_form.submit();
	
	if(name == "") {
		alert("이름을 입력하세요.");
		return;
	}
	if(password == "") {
		alert("패스워드를 입력하세요.")
	} else if (${account.getPhone() } == password) {
		alert("새로운 패스워드로 변경하세요.")
		return;
	}
	if(phone == "") {
		alert("전화번호를 입력하세요.");
		return;
	}
}
function expire() {
	$.ajax({
		url: "${expire }",
		type: "post",
		datatype: "json",
		data: {
			id: document.getElementById("id").value
		},
		success: function(data){
			if(data.res == "success") {
				alert("탈퇴 처리가 완료되었습니다.");
				location.href = "${pageContext.request.contextPath }/account/logout"
			} else {
				alert("탈퇴 처리에 실패하였습니다.");
			}
		}
	});
}

</script>
<c:url var="update" value="/account/update"	/>
<c:url var="add" value="/account/profile_update" />
<c:url var="delete" value="/account/signout" />
<body>
<nav>
	<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
</nav>
<section class="body_class">
	<form action="${add }" method="post" enctype="multipart/form-data">
		<h1 class="first_class">회원 정보 수정</h1>
		<c:url var="img" value="/resources/img/icon.png" />
		<c:url var="img_user" value="/resources" />
			<c:if test="${sessionScope.account.profile_img == null }">
				<img src="${img }">
			</c:if>
			<c:if test="${sessionScope.account.profile_img != null }">
				<img src="${img_user }/${sessionScope.account.profile_img }">
			</c:if>
		<div>
			<label for="id_file">파일업로드</label>
			<input type="file" id="id_file" name="file">
			<button type="submit">사진 저장</button>
		</div>
	</form>

	<form action="${update }" name="update_form" method="POST">
		<input type="hidden" name="id" id="id" value="${requestScope.account.getId() }">
		<div>
			<label for="email">이메일 : </label>
			<input id="id_email" name="email" type="text" value="${requestScope.account.getEmail() }" disabled>
		</div>
		<div>
			<label for="name">이름 : </label>
			<input id="id_name" name="name" type="text" value="${requestScope.account.getName() }" required>
		</div>
		<div>
			<label for="password">비밀번호 : </label>
			<input id="id_password" name="password" type="text" value="${requestScope.account.getPassword() }" required>
		</div>
		<div>
			<label for="phone">전화번호 : </label>
			<input id="id_phnumber" type="text" name="phone" value="${requestScope.account.getPhone() }" required>
		</div>
		<div>
			<button type="submit">수정</button>
	<button data-toggle="modal" id="btn_exp" data-target="#ModalExpire">탈퇴</button>
		</div>
	</form>
</section>

<div class="modal fade" id="ModalExpire" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="form-title text-center">
        </div>
		<%-- <p style="color:red;">${param.error}</p> --%>
		<div class="d-flex flex-column text-center">
		<form action="${delete}" method="POST">
			<div class="form-group">
			<input type="hidden" name="id" id="id" value="${requestScope.account.getId() }">
				<label for="id_email">이메일</label>
				<input id="id_email" type="email" name="email" value="${requestScope.account.getEmail() }" disabled>
			</div>
			<div class="form-group">
				<label for="id_password">비밀번호</label>
				<input id="id_password" type="password" name="password" placeholder="password" required>
				<button type="submit" class="btn btn-info btn-block btn-round">탈퇴</button>
			</div>
		</form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
</div>

<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
</html>