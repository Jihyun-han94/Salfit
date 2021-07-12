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
    <title>Salfit Products</title>
    <jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
    <c:url var="search" value="/admin/product" />
    <c:url var="detail" value="/product/detail" />
	<c:url var="like" value="/ajax/product/like" />
	<c:url var="login" value="/account/login" />
	<c:url var="moreProducts" value="/ajax/product/moreProducts" />
</head>
<style>
.like-heart {
	cursor: pointer;
}
.productImg {
 	height: 170px;
  	width: 220px;
  	object-fit: fill;
}
</style>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
	</header>
	<br><br><br><br><br><br><br><br><br>
<main style="font-family: 'Kakao', 'sans-serif', 'normal';">
<div style="margin: 0 auto;">

<br><br><br><br><br><br><br><br><br>
<div>
	<jsp:include page="/WEB-INF/views/product/categories.jsp" flush="false" >
		<jsp:param name="producttypes" value="${producttypes}" />
	</jsp:include>
</div>
<div class="productContainer" id="container"> 
	<div class="productIndividual">
		<div class="loading">
			<div class="ball"></div>
			<div class="ball"></div>
			<div class="ball"></div>
		</div>
	</div>
</div>

</div>
</main>
<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
const container = document.getElementById('container');
const loading = document.querySelector('.loading');
var oldListCnt = "${oldListCnt}";

var startIndex = 1;	// 인덱스 초기값
var searchStep = 4;	// 4개씩 로딩
getPost(startIndex);
window.addEventListener('scroll', infiniteScroll);
function infiniteScroll () {
	const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
	
		if(clientHeight + scrollTop >= scrollHeight - 70) {
			startIndex += searchStep;
			showLoading();
		}
}
function showLoading() {
	loading.classList.add('show');
	
	setTimeout(getPost(startIndex), 3000);
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
									+'<div class="embed-responsive ">'
							+'	<img class="rounded card-img-top productImg"'
							+'		src="${pageContext.request.contextPath}'+data[i].url+'"></div></a>'
							+'<div class="card-body bg-transparent border-0">'
							+'	<h5 class="card-title card-text" style="display: inline-block;">'
							+'		<a href="${detail}?id='+data[i].id+'">'+data[i].title+'</a>'
							+'	</h5>'
							+'	<p class="card-text" style="display: inline-block; padding-left: 10px;">'
							+'		<small class="text-muted like-heart">'
							+ string
							+'		</small>'
							+'	</p>'
							+'</div>'
							+'<div class="card-footer bg-transparent border-0">' 
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