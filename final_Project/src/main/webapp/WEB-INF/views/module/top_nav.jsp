<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">

	<link rel="stylesheet" href="/webapp/resources/static/css/main.css"> <!-- Resource style -->
	<c:url var="main" value="/" />
	<c:url var="join" value="/account/join" />
	<c:url var="login" value="/account/login" />
</head>
<body>
	<header class="cd-auto-hide-header">
		<div class="logo"><a href="${main }"><img src="/webapp/resources/img/log.png" alt="Logo" height="80px"></a></div>
	
		<nav class="cd-primary-nav">
			<a href="#cd-navigation" class="nav-trigger">
				<span>
					<em aria-hidden="true"></em>
					Menu
				</span>
			</a> <!-- .nav-trigger -->

			<ul id="cd-navigation">
				<li><a href="${login }">Login</a></li>
				<li><a href="${join }">Join</a></li>
				<li><a href="#0">Cart</a></li>
				<li><a href="#0">Contact Us</a></li>
			</ul>
		</nav> <!-- .cd-primary-nav -->

	<nav class="cd-secondary-nav">
		<ul>
			<li><a href="#0">Notice</a></li>
			<li><a href="#0">Menu</a></li>
			<li><a href="#0">Buy</a></li>
			<li><a href="#0">Review</a></li>
		</ul>
	</nav> <!-- .cd-secondary-nav -->
</header> <!-- .cd-auto-hide-header -->
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	if( !window.jQuery ) document.write('<script src="js/jquery-3.0.0.min.js"><\/script>');
</script>
<script src="/webapp/resources/js/main.js"></script> <!-- Resource jQuery -->>
</body>
</html>