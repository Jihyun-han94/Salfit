<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- CSS -->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/bootstrap-4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="icon" href="${pageContext.request.contextPath}/resources/static/css/favicon.ico">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="preconnect" href="https://fonts.gstatic.com">
<!-- <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet"> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/main.css"> <!-- Resource style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/total.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/account.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/top_nav.css">
<!-- favicon -->
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/img/newicon.ico" />

<!-- JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/jquery/js/jquery-3.6.0.min.js"></script>
<!-- dropdown 작동이 안되어 bootstrap.bundle.min.js 추가 (기존 부트스트랩과 이중으로 들어가면 작동 안되어 주석 처리) -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.bundle.min.js" integrity="sha384-3ziFidFTgxJXHMDttyPJKDuTlmxJlwbSkojudK/CkRqKDOmeSbN6KLrGdrBQnT2n" crossorigin="anonymous"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/bootstrap-4.6.0/js/bootstrap.min.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js" ></script>

<!-- popper -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->

<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- chart -->

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- google login -->
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="160834933439-tao649nb9m6941v7r4a52t5q6a3g92uq.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>