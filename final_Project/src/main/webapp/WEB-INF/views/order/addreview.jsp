<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salfit | Review</title>
<jsp:include page="/WEB-INF/views/module/css_js.jsp"></jsp:include>
</head>

<script>
//별점 마킹 모듈 프로토타입으로 생성
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
       
        }else{
            item.checked = false;
        }
    });
        
}
let rating = new Rating();//별점 인스턴스 생성
document.addEventListener('DOMContentLoaded', function(){
    //별점선택 이벤트 리스너
    document.querySelector('.rating').addEventListener('click',function(e){
        let elem = e.target;
        if(elem.classList.contains('rate_radio')){
            rating.setRate(parseInt(elem.value));
        } else {
        	rating.setRate(0);
        }
    })
});
</script>

<body>
<header style="padding-bottom: 180px;">
	<jsp:include page="/WEB-INF/views/module/top_nav.jsp"></jsp:include>
</header>

<div class="wrap" style="text-align: center; font-family: 'Kakao', 'sans-serif', 'normal';">
	<c:url var="review" value="/order/review/add" />
    <form name="reviewform" class="reviewform" method="post" action="${review }">
        <input type="hidden" name="rate" id="rate" value="0"/>
        <h1 class="title_star" style="margin-bottom: 25px; font-size: 40px;">상품은 만족하셨나요?</h1>
        <h3 style="color: gray;">상품에 대해 솔직한 후기를 남겨주세요.</h3>
        <h3 style="color: gray;">샐핏의 발전에 큰 도움이 됩니다!</h3>
 
        <div class="review_rating" style="margin-bottom: 20px;">
            <div class="warning_msg">별점을 선택해 주세요.</div>
            <div class="rating">
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점" required>
                <label for="rating1"></label>
                <input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점">
                <label for="rating2"></label>
                <input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점" >
                <label for="rating3"></label>
                <input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점">
                <label for="rating4"></label>
                <input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점">
                <label for="rating5" ></label>
            </div>
        </div>
        <div class="review_contents">
            <div class="warning_msg">5자 이상으로 작성해 주세요.</div>
            <textarea rows="5" cols="1" class="review_textarea" name="contents" style="border: solid 1px #e1e1e1;" required></textarea>
        </div>
        	<input value=${orderdetail.getPid() } name="pid" hidden>   
        <div class="cmd" style="padding-top: 30px;">
            <button class="submit_btn" type="submit" name="save" id="save" >등록</button>
        </div>
    </form>
</div>
</body>
</html>
