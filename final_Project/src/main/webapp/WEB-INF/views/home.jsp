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

	<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
	<c:url var="main" value="/" />
	<c:url var="join" value="/account/join" />
	<c:url var="login" value="/account/login" />
	<c:url var="logout" value="/account/logout" />
	<c:url var="update" value="/account/update" />
	<c:url var="updateView" value="/account/update_view" />
	<c:url var="product" value="/product" />
	<c:url var="cart" value="/cart" />
	<c:url var="email_write" value="/email/write" />
	<c:url var="admin_product" value="/admin/product" />
	<c:url var="admin_order" value="/admin/order/list" />
	<c:url var="admin_delivery" value="/admin/order/calendar" />
	<c:url var="admin_statistics" value="/admin/order/summary" />
	
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
.card {
	border-style: none;
}
</style>
</head>
<body>
<header class="cd-auto-hide-header">
	<div class="logo"><a href="${main }"><img src="./resources/img/log.png" alt="Logo" height="80px"></a></div>

	<nav class="cd-primary-nav">
		<a href="#cd-navigation" class="nav-trigger">
			<span>
				<em aria-hidden="true"></em>
				Menu
			</span>
		</a> <!-- .nav-trigger -->
		<ul id="cd-navigation">
		<c:choose>
			<c:when test="${sessionScope.atype == 'a' }">
				<li><a href="${admin_product }">상품 관리</a></li>
				<li><a href="${admin_order }">주문 관리</a></li>
				<li><a href="${admin_delivery }">배송 관리</a></li>
				<li><a href="${admin_statistics }">통계</a></li>
				<li><a href="${logout }">Logout</a></li>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${sessionScope.logined }">
						<li><a data-toggle="modal" href="#ModalConfirm">MyPage</a></li>
						<li><a href="${cart }">Cart</a></li>
						<li><a href="${logout }">Logout</a></li>
						<li><a href="${email_write }">Contact Us</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${login }">Login</a></li>
						<li><a href="${join }">Join</a></li>
						<li><a href="${email_write }">Contact Us</a></li>
					</c:otherwise>
				</c:choose>
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
		<li><a href="#0">Notice</a></li>
		<li><a href="${product }">Menu</a></li>
		<li><a href="#0">Buy</a></li>
		<li><a href="#0">Review</a></li>
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
					<h5 class="card-title" style="text-align: center;"><a href="#">시저 샐러드</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Cajun.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">케이준 샐러드</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Chicken.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">닭가슴살 샐러드</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Ricotta.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">리코타치즈 샐러드</a></h5>
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
					<h5 class="card-title" style="text-align: center;"><a href="#">연어 샐러드</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Shrimp.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">새우 샐러드</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Tuna.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><a href="#">참치 샐러드</a></h5>
				</div>
			</div>
		</div>
		<div class="col-2">
			<div class="card" style="border-style: none;">
				<img src="./resources/img/menu/Poke.png">
					<div class="card-body">
					<h5 class="card-title" style="text-align: center;"><span style="color: #df576e;">new </span><a href="#">하와이안 포케</a></h5>
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
</script>
<script src="./resources/js/main.js"></script> <!-- Resource jQuery -->

<!-- Modal -->
<div class="modal fade" id="ModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-40size" role="document">
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
		<h2 style="margin-bottom: 10px; color: #475c01;">회원 비밀번호 확인</h2>
		<h5>외부로부터 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</h5>
		<h5>항상 비밀번호는 타인에게 노출되지 않도록 주의해 주세요.</h5>
		<br>
		<form action="${updateView}" method="POST">
			<div class="form-group">
				<input style="margin-bottom: 20px;" id="id_password_confirm" type="password" name="password" placeholder="password" required>
				<div>
					<button type="submit" class="btn_confirm">확인</button>
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