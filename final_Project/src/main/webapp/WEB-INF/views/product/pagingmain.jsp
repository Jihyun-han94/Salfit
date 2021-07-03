<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Infinite Scroll</title>
    <jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
    <c:url var="detail" value="/product/detail" />
	<c:url var="like" value="/ajax/product/like" />
	<c:url var="login" value="/account/login" />
	<c:url var="moreProducts" value="/ajax/product/moreProducts" />
</head>
<style>
@import url('https://fonts.googleapis.com/css?family=Open+Sans:300,600&display=swap');

* {
	box-sizing: border-box;
}

body {
	background-color: #fafafa;
	font-family: 'Open Sans', sans-serif;
	padding-bottom: 100px;
}

.container {
	margin: 0 auto;
	/* max-width: 1300px; */
}

.itemindiv {
	background-color: #fff;
    box-shadow: 0px 1px 2px rgba(50, 50, 50, .1), 
		0px 2px 4px rgba(60, 60, 60, 0.1);
	border-radius: 4px;
	padding: 40px;
	margin: 20px 0;
}

.title {
	margin: 0;
}

.text {
	color: #555;
	margin: 20px 0;
}

.user-info {
	display: flex;
	align-items: center;
}

.user-info img {
	border-radius: 50%;
	height: 30px;
	width: 30px;
}

.user-info span {
	font-size: 13px;
	margin-left: 10px;
}

.loading {
	opacity: 0;
	display: flex;
	position: fixed;
	bottom: 50px;
	left: 50%;
	transform: translateX(-50%);
	transition: opacity .3s ease-in;
}

.loading.show {
	opacity: 1;
}

.ball {
	background-color: #777;
	border-radius: 50%;
	margin: 5px;
	height: 10px;
	width: 10px;
	animation: jump .5s ease-in infinite;
}

.ball:nth-of-type(2) {
	animation-delay: 0.1s;
}

.ball:nth-of-type(3) {
	animation-delay: 0.2s;
}

@keyframes jump {
	0%, 100% {
		transform: translateY(0);
	}
	
	50% {
		transform: translateY(-10px);
	}
}
</style>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<br><br><br><br><br><br><br><br><br>
<div>
	<div>
		<c:url var="search" value="/product" />
		<form id="search_form" action="${search }" method="get">
			<c:if test="${not empty param.ptype}" >
				<input type="hidden" name="ptype" value="${param.ptype }">
			</c:if>
		    <select id="searchtype" name="searchtype">
		        <option value="t">제품 명</option>
		        <option value="c">제품 정보</option>
		    </select>
			<input type="text" name="search">
			<button type="submit">검색</button>
		</form>
	</div>
</div>
<br><br><br><br><br><br><br><br><br>
<div>
	<jsp:include page="/WEB-INF/views/product/categories.jsp" flush="false" >
		<jsp:param name="producttypes" value="${producttypes}" />
	</jsp:include>
</div>
<div class="productContainer" id="container"> 
	<div class="productIndividual">
	</div>
</div>

<div class="loading">
	<div class="ball"></div>
	<div class="ball"></div>
	<div class="ball"></div>
</div>

<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
const container = document.getElementById('container');
const loading = document.querySelector('.loading');
var oldListCnt = "${oldListCnt}";
/* alert("oldlistcnt: "+oldListCnt); */

var startIndex = 1;	// 인덱스 초기값
var searchStep = 4;	// 4개씩 로딩
getPost(startIndex);


window.addEventListener('scroll', infiniteScroll);
function infiniteScroll () {
	const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
	
		if(clientHeight + scrollTop >= scrollHeight - 5) {
			startIndex += searchStep;
			showLoading();
		}
}

function showLoading() {
	loading.classList.add('show');
	
	setTimeout(getPost(startIndex), 1000)
}

async function getPost(index) {
	let _endIndex = index+searchStep-1;
	var ptype = 0;
	var search = "";
	var searchtype = document.getElementById('searchtype').value; 
	if(${!empty param.ptype}) {
		ptype = "${param.ptype}";
	} 
	if(${!empty param.search}) {
		search = "${param.search}";
	}
	await
	$.ajax({
		url: "${moreProducts}",
		type: "get",
		async: "true",
		dataType: "json",
		data: {
			ptype: ptype,
			searchtype: searchtype,
			search: search,
			startIndex: index,
			endIndex: _endIndex,
			oldListCnt : oldListCnt
		},
		success: function (data) {
			if(${oldListCnt} == 0) {
				const postElement = document.createElement('div');
				postElement.classList.add('itemindiv');
				postElement.innerHTML = "<div class='text-center'><p>상품이 존재하지 않습니다.</p></div>";
				container.appendChild(postElement);
			} else {
				addDataToDOM(data);
			}
			if(_endIndex >= oldListCnt){
				window.removeEventListener('scroll', infiniteScroll);	
			}
		}, error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		   }
	});
}

function getRandomNr() {
	return Math.floor(Math.random() * 100) + 1;
}

function addDataToDOM(data) {
	const postrow = document.createElement('div');
	postrow.classList.add('row', 'row-cols-xs-1', 'row-cols-sm-2', 'row-cols-md-3', 'row-cols-lg-4');
	for(i = 0; i < data.length; i++) {
	const postElement = document.createElement('div');
	postElement.classList.add('productIndiv');
	var string ="";
	if(${liked}.includes(data[i].id)) {
		string = '				<a id="heart'+data[i].id+'" class="bi bi-heart-fill" onclick="liked('+data[i].gcnt+', '+data[i].id+', this, ${account.getId()});"'   
		+'					 style="color:#ff75a0;" data-value="true"}>'
		+'					'+data[i].gcnt+'</a>';
	} else {
		string = '				<a id="heart'+data[i].id+'" class="bi bi-heart" onclick="liked('+data[i].gcnt+', '+data[i].id+', this, ${account.getId()});"'   
		+'					 style="color:#ff75a0;" data-value="false">'
		+'					'+data[i].gcnt+'</a>';
	}
	
	postElement.innerHTML = '<div class="card border-0 text-center">'
							+'<input type="hidden" name="id" value="'+data[i].id+'" readonly>'
							+'<input type="hidden" name="aid" value="'+data[i].aid+'" readonly>'
							+'<a href="${detail}?id='+data[i].id+'">'
							+'	<img class="rounded card-img-top productImg"'
							+'		src="${pageContext.request.contextPath}'+data[i].url+'"></a>'
							+'<div class="card-body bg-transparent border-0">'
							+'	<h5 class="card-title card-text">'
							+'		<a href="${detail}?id='+data[i].id+'">'+data[i].title+'</a>'
							+'	</h5>'
							+'</div>'
							+'<div class="card-footer bg-transparent border-0">' 
							+'	<p class="card-text">'
							+'		<small class="text-muted">'
							+ string
							+'		</small>'
							+'	</p>'
							+'	<p class="card-text">'
							+'		₩ '+data[i].price
							+'	</p>'
							+'</div>'
							+'</div>';
	
	postrow.appendChild(postElement);
	}
	container.appendChild(postrow);
	loading.classList.remove('show');
}


function liked(gcnt, pid, e, aid) {
	let cancel = e.dataset.value;
	$.ajax({
		url: "${like}",
		type: "post",
		async: "false",
		dataType: "json",
		data: {
			aid: aid,		 
			pid: pid,
			cancel : e.dataset.value,
			gcnt: gcnt
		},
		success: function (data) {
			if(data.res == true) {
				e.innerText = " " +data.gcnt;
				e.dataset.value = data.cancel;
				if(data.cancel == "true") {
					e.setAttribute("class", "bi-heart-fill");
				} else {
					e.setAttribute("class", "bi-heart");
				} 
			} else if(data.res == "no_login") {
				$('#loginModal').modal('show');
				location.href = data.redirect; 
			}
		}		
	});
} 

function myFunction(e) {
	   var element = document.getElementById("myDIV");
	   e.classList.toggle("bi-heart-fill", "bi-heart");
	}
</script>
</html>
