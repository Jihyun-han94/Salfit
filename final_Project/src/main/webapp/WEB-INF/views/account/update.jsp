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
var checkRePass = function(){
    let oPwd = document.getElementById("id_password").value;
    let cPwd = document.getElementById("id_password_check").value;
    if (cPwd != oPwd){
        document.getElementById("pass_check_res").innerHTML = "비밀번호가 일치하지 않습니다.";
        document.getElementById("pass_check_res").style.display = "inline-block";
      	return false;
    } else {
        document.getElementById("pass_check_res").style.display = "none";
        return true;
    }
}

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
<style>
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
.first_class {
	font-size: 40px;
	font-weight: bold;
}

.body_class {
	font-size: 15px;
}

.body_class_item {
	margin: 0 auto;
	width:50%;
/* 	text-align: center; */
}
.input-file-button{
  padding: 3px 15px;
  color: #bac600;
  background-color: transparent;
  border-radius: 4px;
  cursor: pointer;
  border: none;
}
.input-file-button:hover {
  color: white;
  font-weight: bold;
  background-color: #bac600;
}
</style>
<c:url var="update" value="/account/update"	/>
<c:url var="add" value="/account/profile_update" />
<c:url var="delete" value="/account/signout" />
<c:url var="add_address" value="/account/address" />
<c:url var="img" value="/resources/img/icon.png" />
<c:url var="img_user" value="/resources" />
<body>
<nav>
	<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
</nav>
<div class="body_class">
	<div class="body_class_item">
	<form action="${add }" method="post" enctype="multipart/form-data">
		<h1 class="first_class" style="margin-bottom: 20px;">나의 정보</h1>
		<p>고객님께서 가입하신 <span style="color: green;">Salfit</span> 회원 정보입니다.</p>
		<p style="margin-bottom: 50px;">안전한 배송 안내를 위하여 핸드폰 번호와 주소를 필히 확인 부탁드립니다.</p>
		
		<h1>필수 회원 정보</h1><hr><br>
			<c:if test="${sessionScope.account.profile_img == null }">
				<img src="${img }">
			</c:if>
			<c:if test="${sessionScope.account.profile_img != null }">
				<img src="${img_user }/${sessionScope.account.profile_img }">
			</c:if>
			<div style="margin-bottom: 50px; margin-top: 20px;">
				<label class="input-file-button" for="id_file">업로드</label>  
				<input type="file" id="id_file" name="file" style="display: none;">  
				<button type="submit" class="input-file-button">저장</button>	
			</div>
		</form>

	<form action="${update }" name="update_form" method="POST">
		<input type="hidden" name="id" id="id" value="${requestScope.account.getId() }">
		<div style="margin-bottom: 20px;">
			<label for="email">이메일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 28px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input id="id_email" name="email" type="text" value="${requestScope.account.getEmail() }" disabled>
		</div>
		<div style="margin-bottom: 20px;">
			<label for="name">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 28px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input id="id_name" name="name" type="text" value="${requestScope.account.getName() }" required>
		</div>
		<div style="margin-bottom: 20px;">
			<label for="password">비밀번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 28px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input id="id_password" name="password" type="password" required>
		</div>
		<div style="margin-bottom: 20px;">
			<label for="password">비밀번호 확인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 28px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input oninput="checkRePass()" id="id_password_check" name="repassword" type="password" required>&nbsp;&nbsp;&nbsp;&nbsp;
			<span id="pass_check_res" style="display : none; color : red;" aria-live="assertive"></span>
		</div>
		<div style="margin-bottom: 20px;">
			<label for="phone">휴대전화&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 28px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input id="id_phnumber" type="text" name="phone" value="${requestScope.account.getPhone() }" required>
		</div>
	</form>
		<form id="address_form" style="margin-bottom: 50px;">
			<label for="address">주소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 28px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<textarea style="resize: none;" id="id_address" rows="2" cols="30"></textarea>  <button class="input-file-button" type="button" onclick="addressSend();">추가</button>
		</form>
		<div id="address">
			<ol class="address_list">
				<c:forEach var="addressList" items="${addressList }">
					<li>
						<p>${addressList.getAddress() }</p>
						<c:if test="${addressList.getAid() == account.getId() }">
							<button type="button" onclick="delComment(this, ${addressList.getId() })">삭제</button>
						</c:if>
					</li>
				</c:forEach>
			</ol>
		</div>
	
		
		<div style="margin-bottom: 100px;">
			<button type="button" onclick="updateInfo();" class="btn_confirm">수정</button>&nbsp;&nbsp;&nbsp;&nbsp;
			<button class="btn_confirm" data-toggle="modal" id="btn_exp" data-target="#ModalExpire">탈퇴</button>
		</div>
	</div>
</div>

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
        <div class="d-flex flex-column text-center">
		<h2 style="margin-bottom: 10px; color: #475c01;">정말로 계정을 삭제하시겠습니까?</h2><br>
		<h5>비밀번호를 입력하시면 탈퇴가 완료됩니다.</h5><br>
		<form action="${delete}" method="POST">
			<div class="form-group">
			<input type="hidden" name="id" id="id" value="${requestScope.account.getId() }">
				<input id="id_email" type="email" name="email" value="${requestScope.account.getEmail() }" disabled>
			</div>
			<div class="form-group">
				<input style="margin-bottom: 20px;" id="id_password_delete" type="password" name="password" placeholder="password" required>
				<div>
					<button type="submit" class="btn_confirm">계정 삭제</button>
				</div>
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