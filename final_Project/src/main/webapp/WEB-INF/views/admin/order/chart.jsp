<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
<canvas id="myChart" width="400" height="400"></canvas>
<script>
var ctx = document.getElementById('myChart').getContext('2d');
const labels = ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'];
var revenue = new Array(12).fill(0);	var numOfOrders = new Array(12).fill(0); var numOfProducts = new Array(12).fill(0);
alert(revenue);
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
            label: '# 상품 총 배송 개수',
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
        }
    }
});
</script>

<canvas id="myChart2" width="400" height="400"></canvas>
<script>
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
    		}
});
</script>
</body>

</html>