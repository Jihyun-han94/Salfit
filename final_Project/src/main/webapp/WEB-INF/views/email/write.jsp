<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 보내기</title>
</head>
<body>
<c:url var="email_send" value="/email/send" />
<h2>이메일 보내기</h2>
<form method="post" action="${email_send}"> 
<!-- post방식으로 자료를 컨트롤러로 보냄 -->
 
발신자 이름 : <input name="senderName"><br>
발신자 이메일 : <input name="senderMail"><br>
내용 : <textarea rows="5" cols="80" name="message"></textarea>
<br>
<input type="submit" value="전송">
</form>
<span style="color:red;">${message}</span>
</body>
</html>