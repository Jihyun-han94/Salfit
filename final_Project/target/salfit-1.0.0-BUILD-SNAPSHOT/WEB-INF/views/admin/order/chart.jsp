<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit Admin | 통계</title>
<!-- favicon -->
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/img/favicon.ico" />
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>

<body>
	<header>
 		<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include> 
	</header><br><br><br><br><br><br><br><br>
	<section class="mb-5 col-10 m-auto">
		<nav class="mb-5">
		  <div class="nav nav-tabs" id="nav-tab" role="tablist">
		    <a class="nav-link active" id="nav-monthly-tab" data-toggle="tab" href="#nav-monthly" role="tab" aria-controls="nav-monthly" aria-selected="true">월 매출액/ 판매수</a>
		    <a class="nav-link" id="nav-top5-tab" data-toggle="tab" href="#nav-top5" role="tab" aria-controls="nav-top5" aria-selected="false">인기 상품 top5 (실구매 기준)</a>
		    <a class="nav-link" id="nav-topRating-tab" data-toggle="tab" href="#nav-topRating" role="tab" aria-controls="nav-topRating" aria-selected="false">인기 상품 top5 (상품평 기준)</a>
		  </div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
		  	<div class="tab-pane fade show active" id="nav-monthly" role="tabpanel" aria-labelledby="nav-monthly-tab">
		  		<select id="selectedYear" name="selectedYear" class="mt-5" onchange="setYear(this.value);">
	                <option value="" disabled ${param.selectedYear == null ? 'selected' : '' } >년도 선택</option>
	            </select>
				<canvas id="myChart" width="400" height="170" class="mb-5 mt-5"></canvas>
		
			</div>
		  	<div class="tab-pane fade mt-5 pt-5 text-center" style="width:80%; margin:auto;" id="nav-top5" role="tabpanel" aria-labelledby="nav-top5-tab">
		  		<canvas id="myChart2" width="80" height="100" class="w-50 mb-5 mt-5 pt-5 m-auto"></canvas>
			</div>
			<div class="tab-pane fade mt-5 pt-5 text-center" style="width:80%; margin:auto;" id="nav-topRating" role="tabpanel" aria-labelledby="nav-topRating-tab">
		  		<canvas id="myChart3" width="80" height="100" class="w-50 mb-5 mt-5 pt-5 m-auto"></canvas>
			</div>
		</div>
	</section>
<script>
$(document).ready(function() {
	let selectbox = document.getElementById("selectedYear");
	generateYear(selectbox);
		
	<c:if test="${!empty param.selectedYear}">
		selectbox.setAttribute("value", ${param.selectedYear});
		let option = document.getElementById(${param.selectedYear});
		option.setAttribute('selected', 'selected');
	</c:if>
});
// years
function generateYear(element) {
    let date = new Date();
    if (element.children.length <= 1) {
        for(let year = date.getFullYear(); year >= 2020; year--) {
            let option = document.createElement("option");
            option.setAttribute("value", year);
            option.setAttribute("id", year);
            option.innerText = year;
            element.appendChild(option);
        }
    }
}

function setYear(value) {
    window.location.href = "summary?selectedYear=" + value;
}


/* 매출액,판매수 */

var ctx = document.getElementById('myChart').getContext('2d');
const labels = ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'];
var revenue = new Array(12).fill(0);	var numOfOrders = new Array(12).fill(0); var numOfProducts = new Array(12).fill(0);
	<c:forEach items="${revenue}" var="rev" varStatus="loop">
	    revenue.fill("${rev}", "${loop.index}", "${loop.count}");
	</c:forEach>
    <c:forEach items="${numOforders}" var="noo" varStatus="loop">
    	numOfOrders.fill("${noo}", "${loop.index}", "${loop.count}");
	</c:forEach>
	    <c:forEach items="${numOfProducts}" var="nop" varStatus="loop">
	    numOfProducts.fill("${nop}", "${loop.index}", "${loop.count}");
	</c:forEach>
	
var myChart = new Chart(ctx, {
    data: {
        labels: labels,
        datasets: [{
		    type: 'bar',
            label: '# 총 매출액',
            data: revenue,
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
                 'rgb(54, 162, 235, 0.2)'
            ],
            borderWidth: 1,
            yAxisID: 'left-y-axis'
        }, {
        	type: 'line',
            label: '# 총 주문 건수',
            data: numOfOrders,
            backgroundColor: [
                'rgba(54, 162, 265, 1)'
            ],
            borderColor: [
                 'rgb(54, 162, 235, 1)'
            ],
            borderWidth: 1,
            yAxisID: 'right-y-axis'
        }, {
        	type: 'line',
            label: '# 총 배송 상품 개수',
            data: numOfProducts,
            backgroundColor: [
                '#E98580'
            ],
            borderColor: [
                 '#E98580'
            ],
            borderWidth: 1,
            yAxisID: 'right-y-axis'
        } ]
    },
    options: {
        scales: {
        	x: {
                grid: {
					color: 'white'                  
                },
                ticks: {
                  color: 'blue',
                }
              },
            'left-y-axis': {
                type: 'linear',
                position: 'left',
                beginAtZero: true,
                grid: {
					color: 'white'                  
                },
                ticks: {
                    callback: function(value, index, values) {
                        return '₩ ' + value;
                    }
                }
            },
            'right-y-axis': {
                type: 'linear',
                position: 'right',
                beginAtZero: true,
                grid: {
					color: '#EFEFEF'                  
                }
            }
        },
        plugins: {
            legend: {
                labels: {
                    font: {
                        size: 16
                    }
                }
            }
        }
    }
});


/* 구매수 top5 */

var top5 = [
<c:forEach items="${top5}" var="title" varStatus="loop">
    "${title}"
	    ${!loop.last ? ',' : ''}
</c:forEach>
]; 
var top5bcnt = [
<c:forEach items="${top5bcnt}" var="bcnt" varStatus="loop">
    "${bcnt}"
     ${!loop.last ? ',' : ''}
</c:forEach>
];
var ctx2 = document.getElementById('myChart2').getContext('2d');
const products = [];
	for(var i = 1; i <= 12 ; i++){
		products.push(i);
	};

var myChart2 = new Chart(ctx2, {
	type: 'doughnut',
    data: {
    	  labels: top5,
    		  datasets: [{
    		    label: '인기상품 상위 5위',
    		    data: top5bcnt,
    		    backgroundColor: [
    		      'rgb(255, 99, 132)',
    		      'rgb(54, 162, 235)',
    		      'rgb(255, 205, 86)',
    		      'rgb(153, 102, 255)',
    		      'rgb(201, 203, 207)'
    		    ],
    		    hoverOffset: 4
    		  }]
    		},
	options: {
		plugins: {
            legend: {
                labels: {
                    font: {
                        size: 16
                    }
                }
            }
        }
	}
});


/* 별점 top5 */

var rating5 = [
<c:forEach items="${rating5}" var="pname" varStatus="loop">
    "${pname}"
	    ${!loop.last ? ',' : ''}
</c:forEach>
]; 
var rating = [
<c:forEach items="${rating}" var="r" varStatus="loop">
    "${r}"
     ${!loop.last ? ',' : ''}
</c:forEach>
];
var ctx3 = document.getElementById('myChart3').getContext('2d');

var myChart3 = new Chart(ctx3, {
	type: 'doughnut',
    data: {
    	  labels: rating5,
    		  datasets: [{
    		    label: '평가 상위 5위',
    		    data: rating,
    		    backgroundColor: [
    		      'rgb(255, 99, 132)',
    		      'rgb(54, 162, 235)',
    		      'rgb(255, 205, 86)',
    		      'rgb(153, 102, 255)',
    		      'rgb(201, 203, 207)'
    		    ],
    		    hoverOffset: 4
    		  }]
    		},
	options: {
		plugins: {
            legend: {
                labels: {
                    font: {
                        size: 16
                    }
                }
            }
        }
	}
});
</script>

<jsp:include page="/WEB-INF/views/module/footer.jsp"></jsp:include>
</body>

</html>