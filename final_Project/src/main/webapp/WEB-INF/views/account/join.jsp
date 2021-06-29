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
</style>
<script>
function emailCheck() {
	/* var email = document.getElementById("id_email").value;
	if(email == "" || email == undefined){
		alert("이메일 주소를 입력하세요.");
		document.getElementById("id_email").focus();
		return;
	} */
	$.ajax({
		url: "${email_check }",
		type: "get",
		datatype: "json",
		data: {
			email: document.getElementById("id_email").value
		},
		success: function(data){
			if(data.result == false){
				document.getElementById("email_check_res").innerText = "사용 가능한 이메일 주소입니다."
				document.getElementById("email_check_res").style.color = "blue";
			} else {
				document.getElementById("email_check_res").innerText = "이미 사용중인 이메일 주소 입니다."
					document.getElementById("email_check_res").style.color = "red";
			}
		}
	});
}
</script>
</head>
<body>
<c:url var="login" value="/account/login" />
<c:url var="join" value="/account/join" />
<nav>
	<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
</nav>
<p style="color:red;">${param.error}</p>
<section class="signcontainer">
	<article class="signhalf">
	     <h1>Join us!</h1>
	     <div class="signtabs">
	          <span class="tab signup active"><a href="#signup">Sign up</a></span>
	          <span class="tab signin"><a href="#signin">Sign in</a></span>
	     </div>
	     <div class="signcontent">
	     	<div class="signup-cont cont">
	          		<form action="${login}" method="post">
	                    <input type="email" name="email" id="id_email" class="inpt" required="required" placeholder="Your email">
	                    <label for="id_email">email</label>
	                    <input type="password" name="password" id="id_password" class="inpt" required="required" placeholder="Your password">
	          			<label for="id_password">password</label>
	                    <!-- <input type="checkbox" id="remember" class="checkbox" checked>
	                    <label for="remember">Remember me</label> -->
	                    <div class="submit-wrap">
	                        <input type="submit" value="Sign in" class="submit">
	                       	<div class="g-signin2" data-onsuccess="onSignIn"><a href="${google_url}"></a></div>
	                        <a href="#" class="more">Forgot your password?</a>
	                    </div>
	  				</form>
	      		</div>
	          <div class="signin-cont cont">
	  				<form action="${join }" method="post">
	                    <input id="id_email" type="email" name="email" class="inpt" placeholder="Your email" oninput="emailCheck('${email_check}', this.value);" required>
						<br>
						<label id="email_check_res"></label>
	                    <input type="text" name="name" id="id_username" class="inpt" required="required" placeholder="Your name">
	                    <label for="id_username">name</label>
	                    <input type="password" name="password" id="password" class="inpt" required="required" placeholder="Your password">
	          			<label for="password">password</label>
	          			<input type="number" name="phone" id="id_phnumber" class="inpt" required="required" placeholder="Your phone">
	                    <label for="id_phnumber">Phone</label>
	                    <div class="submit-wrap">
	                        <input type="submit" value="Sign up" class="submit">
	                        <a></a>
	                    </div>
	  				</form>
			  	</div>
	     </div>
	</article>
	<div class="signhalf bg"></div>
</section>

<br><br>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>  -->
<script type="text/javascript">
$('.signtabs .tab').click(function(){
    if ($(this).hasClass('signup')) {
        $('.signtabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signin-cont').show();
    }
    if ($(this).hasClass('signin')) {
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