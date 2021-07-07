<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제확인페이지</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<h1>${username }님 결제 완료 되었습니다!</h1>
<table border="1">
<th>날짜</th>
<th>결제 금액</th>
<th>결제 수단</th>
<th>결제 상태</th>
<tr>
<td>${orderDTO.pdate }</td>
<td>${orderDTO.total }</td>
<td>${paymethod }</td>
<td>${orderDTO.status }</td>
</tr>
</table>

<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
</html>