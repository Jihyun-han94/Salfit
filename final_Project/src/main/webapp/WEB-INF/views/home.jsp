<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en" class="no-js">
<head>
	<title>Salfit | main</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link href="https://fonts.googleapis.com/css?family=David+Libre|Hind:400,700" rel="stylesheet">

	<jsp:include page="/WEB-INF/views/module/main.jsp"></jsp:include>
	<c:url var="main" value="/" />
	<c:url var="join" value="/account/join" />
	<c:url var="login" value="/account/login" />
	<c:url var="logout" value="/account/logout" />
	<c:url var="update" value="/account/update" />
	<c:url var="updateView" value="/account/update_view" />
	<c:url var="product" value="/product" />
	<c:url var="cart" value="/cart" />
	<c:url var="order" value="/order" />
	<c:url var="wishlist" value="/account/liked" />
	<c:url var="about" value="/about_us" />
	<c:url var="notice" value="/notice" />
	<c:url var="email_write" value="/email/write" />
	<c:url var="admin_product" value="/admin/product" />
	<c:url var="admin_order" value="/admin/order/list" />
	<c:url var="admin_delivery" value="/admin/order/calendar" />
	<c:url var="admin_statistics" value="/admin/order/summary" />
	<c:url var="searcha" value="/admin/product" />
	<c:url var="searchi" value="/product" />

<style>
*:focus  {
    outline: none!important; 
    outline-width: 0;
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
.card {
	border-style: none;
}
</style>
</head>
<body>
<header class="cd-auto-hide-header">
	<div class="logo"><a href="${main }"><img src="./resources/img/newlogo.png" alt="Logo" height="80px"></a>
	<form id="search_form" action="${sessionScope.atype == 'a' ? searcha : searchi  }" method="get" style="padding-left: 50px; padding-top: 23px; float:right;">
		<c:if test="${not empty param.ptype}" >
			<input type="hidden" name="ptype" value="${param.ptype }">
		</c:if>
	    <select id="searchtype" name="searchtype" style="width:80px; color: #D3D3D3; font-size:13px; border-radius: 10px; height:30px; border-color: #ffff; text-align: center;">
			<option value="a" ${empty param.searchtype || param.searchtype == 'a' ? 'selected' : ''}>??????</option>
	        <option value="t" ${param.searchtype == 't' ? 'selected' : ''}>?????? ???</option>
	        <option value="c" ${param.searchtype == 'c' ? 'selected' : ''}>?????? ??????</option>
	    </select>
		<input type="text" name="search" class="text-center text-muted" value="${!empty param.search ? param.search : ''}" style="width: 230px; height:23px; border-radius: 20px; border:1px solid #D3D3D3;">
		<button type="submit" class="btn_search" style="margin-left:-12px;"><i class="bi bi-search" style="color: #D3D3D3; font-size:7px; margin-left:-12px;"></i></button>
	</form>
	</div>

	<nav class="cd-primary-nav">
		<a href="#cd-navigation" class="nav-trigger">
			<span>
				<em aria-hidden="true"></em>
				Menu
			</span>
		</a> <!-- .nav-trigger -->
		<ul id="cd-navigation">
			<c:choose>
				<c:when test="${sessionScope.logined && sessionScope.atype == 'a' }">
				<li class="dropdown"><a href="#" id="dropdownMenuLink_a" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Admin Page</a>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink_a">
					    <li class="dropdown-item"><a href="${admin_product }">?????? ??????</a></li>
					    <li class="dropdown-item"><a href="${admin_order }">?????? ??????</a></li>
					    <li class="dropdown-item"><a href="${admin_delivery }">?????? ??????</a></li>
					    <li class="dropdown-item"><a href="${admin_statistics }">??????</a></li>
				  	</ul>
				 </li>
					<li><a type="button" onclick="signOut();">Logout</a></li>
				</c:when>
				<c:when test="${sessionScope.logined && (sessionScope.atype == 'i' || sessionScope.atype == 'g')}">
					<li class="dropdown"><a href="#" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">MyPage</a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						    <li class="dropdown-item"><a href="${cart }">Cart</a></li>
						    <li class="dropdown-item"><a href="${order }">Order</a></li>
						    <li class="dropdown-item"><a href="${wishlist }">WishList</a></li>
						    <c:if test="${sessionScope.atype != 'g'}">
						    	<li class="dropdown-item"><a data-toggle="modal" href="#ModalConfirm">Profile</a></li>
						    </c:if>
					  	</ul>
					 </li>
					<li><a type="button" onclick="signOut();">Logout</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${login }">Login</a></li>
					<li><a href="${join }">Join</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav> <!-- .cd-primary-nav -->
</header> <!-- .cd-auto-hide-header -->

<section class="cd-hero">
	<div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="./resources/img/real_main.png" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="./resources/img/poke_main.png" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="./resources/img/clean_main.png" class="d-block w-100" alt="...">
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
</section> <!-- .cd-hero -->

<nav class="cd-secondary-nav">
	<ul>
		<li><a href="${notice }">Notice</a></li>
		<li><a href="${product }">Menu</a></li>
		<li><a href="${about }">About</a></li>
		<li><a href="mailto:salfit.contact@gmail.com?Subject=[?????? ??????]%20&body=??????%20?????????%20?????????%20???????????????%20?????????%20????????????.
		%0D%0A%0D%0A????????????%20???%20??????:%0D%0A????????????%20???%20?????????:%0D%0A????????????:%0D%0A
		(?????????%20?????????%20??????%20?????????,%20??????,%20????????????%20??????%20???????????????.)" target="_top">Contact Us</a></li>
	</ul>
</nav> <!-- .cd-secondary-nav -->
<br><br><br>
<h1 style="text-align: center; font-size: 45px; color: #5f7115; font-weight: bold;">Best Menu</h1>
<br><br>
<main class="cd-main-content sub-nav-hero">
<div class="container-menu">
	<div class="row d-flex justify-content-center align-items-center h-100 m-4">
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Caesar.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">?????? ?????????</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Cajun.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">????????? ?????????</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Chicken.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">???????????? ?????????</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Ricotta.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">??????????????? ?????????</a></h5>
				</div>
			</div>
		</div>
	</div>
	<br>
	<div class="row d-flex justify-content-center align-items-center h-100 m-4">
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Salmon.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">?????? ?????????</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Shrimp.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">?????? ?????????</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Tuna.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">?????? ?????????</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Poke.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><span style="color: #df576e;">new </span><a href="#">???????????? ??????</a></h5>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row d-flex justify-content-center align-items-center h-50 w-20 m-4">
<img src="./resources/img/healthy.png">
</div>

</main> <!-- .cd-main-content -->
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	if( !window.jQuery ) document.write('<script src="js/jquery-3.0.0.min.js"><\/script>');
	
	var websocket;	
   	var neworder_alert = document.getElementById("neworder_alert");	
   	var neworder_nav = document.getElementById("neworder_nav");	
	var prev_val = neworder_alert.innerText; 	
   	neworder_nav.addEventListener("click", function(){	
	    	neworder_alert.classList.remove('new-order-counter');	
   	});	
    websocket = new WebSocket("ws://salfit.shop${pageContext.request.contextPath}/alert");	
    	
    websocket.onmessage = function(message) {	
    	//alert(message.data);	
    	onMessage(message); 	
    }	
    	
    function onMessage(evt) {	
    	if(!neworder_alert.classList.contains('new-order-counter')) {	
    		neworder_alert.classList.add('new-order-counter');	
	    }	
    	//var val = prev_val + 1;	
   		neworder_alert.innerText = "new";  	
}	
	    		
	// google_logout
	function signOut() {
		if(gapi.auth2 != null) {
		  	gapi.auth2.getAuthInstance().disconnect();
		}
	  	window.location.href = "${logout }";
	}
	
</script>
<script src="./resources/js/main.js"></script> <!-- Resource jQuery -->

<!-- Modal -->
<div class="modal fade" id="ModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-40size" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">??</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="form-title text-center">
        </div>
		<div class="d-flex flex-column text-center">
		<h2 style="margin-bottom: 10px; color: #475c01;">?????? ???????????? ??????</h2>
		<h5>??????????????? ????????? ???????????? ???????????? ?????? ??????????????? ?????? ??? ??? ???????????????.</h5>
		<h5>?????? ??????????????? ???????????? ???????????? ????????? ????????? ?????????.</h5>
		<br>
		<form action="${updateView}" method="POST">
			<div class="form-group">
				<input style="margin-bottom: 20px;" id="id_password_confirm" type="password" name="password" placeholder="password" required>
				<div>
					<button type="submit" class="btn_confirm">??????</button>
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