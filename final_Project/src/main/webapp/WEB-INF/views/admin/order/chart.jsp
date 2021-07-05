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
const labels = [];
	for(var i = 1; i <= 12 ; i++){
		labels.push(i);
	};

var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: '# 매출액',
            data: [12, 19, 3, 5, 2, 3,12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
                 'rgb(54, 162, 235)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
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