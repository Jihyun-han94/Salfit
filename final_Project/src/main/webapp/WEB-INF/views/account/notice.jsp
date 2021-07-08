<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
<style>
.tab_body, html {width:100%;  }
.tab_body , div .tab .tabcontent, ul .tabnav ,li .tab_li {margin:0; padding:0;}
ul .tabnav, li .tab_li {list-style:none;}
/*tab css*/
.tab{width:100%; text-align:center;}
.tabnav{font-size:0; width:100%; padding-bottom: 30px;}
.tabnav li{display: inline-block; border-right:1px solid #ddd;}
.tabnav li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:3px; }
.tabnav li a.active:before{background:#7ea21e;}
.tabnav li a.active{border-bottom:1px solid #fff;}
.tabnav li a{ position:relative; display:block; background: #f8f8f8; color: #000; padding:0 30px; line-height:46px; text-decoration:none; font-size:16px;}
.tabnav li a:hover,
.tabnav li a.active{background:#fff; color:#7ea21e; }
.tabcontent{padding: 20px; border-top:none;}
</style>
<script>
$(function(){
	  $('.tabcontent > div').hide();
	  $('.tabnav a').click(function () {
	    $('.tabcontent > div').hide().filter(this.hash).fadeIn();
	    $('.tabnav a').removeClass('active');
	    $(this).addClass('active');
	    return false;
	  }).filter(':eq(0)').click();
	  });
</script>
</head>
<body class="tab_body">
<header style="padding-bottom:100px;">
	<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
</header>
<main class="cd-main-content sub-nav">
<div style="margin: 0 auto;">
  <div class="tab">
    <ul class="tabnav">
      <li class="tab_li"><a href="#tab01">그린 박스</a></li>
      <li class="tab_li"><a href="#tab02">문고리 배송</a></li>
      <li class="tab_li"><a href="#tab03">대량 주문 문의</a></li>
    </ul>
    <div class="tabcontent">
      <div id="tab01">
      	<img src="${pageContext.request.contextPath}/resources/img/board/notice_1.png">
      </div>
      <div id="tab02">
      	<img src="${pageContext.request.contextPath}/resources/img/board/notice_2.png">
      </div>
      <div id="tab03">
      	<img src="${pageContext.request.contextPath}/resources/img/board/notice_3.png">
      </div>
    </div>
  </div>
</div>
</main>
<footer>
	<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</footer>
</body>
</html>