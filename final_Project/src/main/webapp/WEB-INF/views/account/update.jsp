<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
</head>
<c:url var="expire" value="/ajax/account/expire"	/>
<c:url var="view_address" value="/ajax/account/address/view"	/>
<c:url var="add_address" value="/ajax/account/address/add"	/>
<c:url var="delete_address" value="/ajax/account/address/delete"	/>

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
function addressSend() {
	$.ajax({
		url: "${add_address }",
		type: "post",
		datatype: "json",
		data: {
			address: document.getElementById("id_address").value
		},
		success: function(data){
			if(data.res == "success") {
				alert("주소 등록이 완료되었습니다.")
				getAddressList(data.address) // 주소 목록 출력
			} else {
				alert("주소 등록에 실패했습니다.")
			}
		}
	});
}
function getAddressList(address) {
	var item = document.createElement("div");
	var no = document.createElement("span");
	var lbl = document.createElement("span")
	var content = document.createElement("span");
	var delete_btn = document.createElement("button");
	
	lbl.innerText = "[방금 추가 된 주소입니다.]";
	//no.innerText = " " + (document.getElementById("address_list").getElementsByTagName("span").length/3+1);
	
	content.innerText = address;
	delete_btn.innerText = "삭제";
	delete_btn.type = "button";
	delete_btn.style = "color:red;"
	delete_btn.className = "input-file-button"
	delete_btn.onclick = function() {deleteAddress()};
	
	item.append(lbl);
	item.append(no);
	item.append(content);
	item.append(delete_btn);
	
	document.getElementById("address_list").append(item);
}
function deleteAddress() {
	
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
	}/*  else if (${account.getPhone() } == password) {
		alert("새로운 패스워드로 변경하세요.")
		return;
	} */
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
input {
	width: 450px;
	border: 1px solid #e7e7e7;
}
.inputstyle .addressstyle {
	font-size: 18px;
}
.btn_submit {
	text-align: center;
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

	<form class="inputstyle" action="${update }" name="update_form" method="POST">
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
		<form id="address_form" class="addressstyle" style="margin-bottom: 20px;">
			<label for="address">주소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e0e0e0; font-size: 28px;">|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input id="id_address" type="text" name="address">  <button class="input-file-button" type="button" onclick="addressSend();">추가</button>
		</form>
		<div id="address_list" style="margin-bottom: 50px; margin-left: 150px;">
			<c:forEach var="addressList" items="${addressList }">
			<div>
				<span>주소 목록&nbsp;&nbsp;</span>
				<span>${addressList.getAno() }&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<span>${addressList.getAddress() }&nbsp;&nbsp;</span>
				<button type="button" class="input-file-button" onclick="delAddress(this, ${addressList.getAno() })">삭제</button>
			</div>
			</c:forEach>
		</div>
	
		
		<div class="btn_submit" style="margin-bottom: 100px;">
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