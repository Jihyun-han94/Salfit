<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
 <%@ include file="/WEB-INF/views/module/css_js.jsp" %>
 <c:url var="email_check" value="/ajax/account/email" />
 <c:url var="login" value="/account/login" />
 <c:url var="join" value="/account/join" />
 <style>
 * {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}
body {
  font-family: 'Lato', sans-serif;
  background-color: #f8f8f8;
  }
h1 {
  font-family: 'Arita-dotum-Medium';
}
p {
	font-size: x-small;
	text-align: center;
}
.btn_ck {
	font-size: x-small;
	border: none;
	background-color: green;
	color: white;
	height: 20px;
}
</style>
<script>
function emailCheck() {
	var email = document.getElementById("id_email").value;
	if(email == "" || email == undefined){
		document.getElementById("check_res").innerText = "이메일 주소를 입력하세요."
		document.getElementById("check_res").style.color = "black";
		document.getElementById("id_email").focus();
		return;
	}
	$.ajax({
		url: "${email_check }",
		type: "get",
		datatype: "json",
		data: {
			email: document.getElementById("id_email").value
		},
		success: function(data){
			if(data.result == false){
				document.getElementById("check_res").innerText = "사용 가능한 이메일 주소입니다."
				document.getElementById("email_check_res").innerText = "사용 가능한 이메일 주소입니다."
				document.getElementById("check_res").style.color = "blue";
			} else {
				document.getElementById("check_res").innerText = "이미 사용중인 이메일 주소 입니다."
				document.getElementById("email_check_res").innerText = "이미 사용중인 이메일 주소 입니다."
				document.getElementById("check_res").style.color = "red";
			}
		}
	});
}
function send() {
	var username = document.getElementById("id_username");
	if(username.value == "" || username.value == undefined){
		document.getElementById("check_res").innerText = "이름을 입력하세요."
		document.getElementById("check_res").style.color = "red";
		username.focus();
		return;
	}
	
	var email_check = document.getElementById("check_res").innerText;
	var email_check_res = document.getElementById("email_check_res").innerText;
	if(email_check == "" || email_check == undefined) {
		document.getElementById("check_res").innerText = "이메일 중복 확인을 먼저 진행하세요.";
		document.getElementById("check_res").style.color = "red";
		document.getElementById("id_email").focus();
		return;
	} else if(email_check_res != "사용 가능한 이메일 주소입니다.") {
		document.getElementById("check_res").innerText =  "해당 이메일 주소로는 가입을 할 수 없습니다.";
		document.getElementById("check_res").style.color = "red";
		document.getElementById("id_email").focus();
		return;
	}
	
	var password = document.getElementById("id_password");
	if(password.value == "" || password.value == undefined){
		console.log(password.value);
		document.getElementById("check_res").innerText = "패스워드를 입력하세요."
		document.getElementById("check_res").style.color = "red";
		password.focus();
		return;
	}
	
	var phone = document.getElementById("id_phnumber");
	if(phone.value == "" || phone.value == undefined){
		document.getElementById("check_res").innerText = "번호를 입력하세요."
		document.getElementById("check_res").style.color = "red";
		phone.focus();
		return;
	}
	
	document.account_form.submit();
	alert("회원가입이 완료되었습니다.");
}
</script>
</head>
<body>
<nav>
	<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
</nav>
<div class="cd-main-content sub-nav">
<section class="signcontainer">
	<article class="signhalf">
	     <h1>Please Login<br>to Continue</h1>
	     <div class="signtabs">
	          <span class="tab signin active"><a href="#signin">Sign in</a></span>
	          <span class="tab signup"><a href="#signup">Sign up</a></span>
	     </div>
	     <div class="signcontent">
	          <div class="signin-cont cont">
	               <form action="${login}" method="post">
	                    <input type="email" name="email" id="id_email_lg" class="inpt" required="required" placeholder="Your email">
	                    <label for="id_email_lg">email</label>
	                    <input type="password" name="password" id="id_password_lg" class="inpt" required="required" placeholder="Your password">
	          			<label for="id_password_lg">password</label>
	                    <div class="submit-wrap">
	                        <input type="submit" value="Sign in" class="submit">
	                       	<%-- <div class="g-signin2" data-onsuccess="onSignIn"><a href="${google_url}"></a></div> --%>
	                        <a href="#" class="more">Forgot your password?</a>
	                    </div>
	  				</form>
			  	</div>
			  	<div class="signup-cont cont">
	          		<form name="account_form" action="${join }" method="post">
	  					<p id="email_check_res" style="display: none;"></p>
						<p id="check_res">Hello Welcome to Salfit !</p>
	                    <input style="display: inline-block;" id="id_email" type="email" name="email" class="inpt" placeholder="Your email" required>
						<button class="btn_ck" type="button" onclick="emailCheck();">check</button>
	                    <input type="text" name="name" id="id_username" class="inpt" required="required" placeholder="Your name">
	                    <label for="id_username">name</label>
	                    <input type="password" name="password" id="id_password" class="inpt" required="required" placeholder="Your password">
	          			<label for="id_password">password</label>
	          			<input type="number" name="phone" id="id_phnumber" class="inpt" required="required" placeholder="Your phone">
	                    <label for="id_phnumber">phone</label>
	                    <div class="submit-wrap">
	                        <input type="button" onclick="send();" value="Sign up" class="submit">
	                        <a></a>
	                    </div>
	  				</form>
	      		</div>
	     </div>
	</article>
	<div class="signhalf bg"></div>
</section>
</div>
<br><br><br><br>

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>  -->
<script type="text/javascript">
$('.signtabs .tab').click(function(){
    if ($(this).hasClass('signin')) {
        $('.signtabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signin-cont').show();
    } 
    if ($(this).hasClass('signup')) {
        $('.signtabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signup-cont').show();
    }
});
</script>
<!-- 구글 api 사용을 위한 스크립트 -->
<script src="https://apis.google.com/js/platform.js" async defer></script>

<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
</html>