<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<%@ include file="/WEB-INF/views/module/css_js.jsp" %>
</head>
<body>
	<header>
		<%@ include file="/WEB-INF/views/module/top_nav.jsp" %>
	</header>
 	<div class="">
      <div class="row my-5"> <!-- row(하나의 행)의 my(margin을 y축방향으로) 5만큼 준것 -->
         <div class="col-4">
        	 <h1 style="padding-bottom: 50px;">
	            ${fn:replace(item.getTitle(), newline, "<br>") }
            </h1>
            <div>
               <h3 style="font-weight: bolder; padding-bottom: 15px;">내용</h3>
               <p class="font-weight-light" style="padding-bottom: 15px;">
               ${fn:replace(item.getContents(), newline, "<br>") }
               </p>
            </div>
         </div>
         <div class="col-4">
 			<img class="w-100 rounded card-img-top productImg" width="500px" height="400px"
					src="${pageContext.request.contextPath}${item.getUrl()}" 
			>       
         </div>
         <div class="col-4">
            <div>
               <div class="view_like" style="margin-top: 238px; padding-left: 179px; font-size: 22px;">
                  <i class="fa fa-hand-o-up" style="color: navy;" aria-hidden="true"></i>  ${item.getVcnt()}
                  <i class="fa fa-heart-o  jobdetail-like" style="color: red;" aria-hidden="true"></i>  ${item.getGcnt()}
               </div>       
                         <!-- <button type="button" class="btn btn-primary jobdetail-btnsizeL" data-toggle="modal" data-target="#staticBackdrop">지원하기</button> -->
                   <button type="button" class="btn btn-light btn-block badge-pill" 
                   data-toggle="modal" data-target="#staticBackdrop" style="margin-top:30px;"><b>장바구니에 담기</b></button><br>  
               <div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                     <div class="modal-content">
                        <div class="modal-header">
                           <h5 class="modal-title" id="staticBackdropLabel">상품 담기 성공!</h5>
                           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">&times;</span>

                           </button>
                        </div>
                     <div class="modal-body">
                     	${item.getTitle()} 상품을 장바구니에 추가했습니다. 
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-outline-dark" data-dismiss="modal">계속 쇼핑하기</button>
                        <form action="${pageContext.request.contextPath}/cart" method="POST">
                           <%-- <input type="hidden" name="" value="${pageContext.request.session }"> --%>
                           <button type="submit" class="btn btn-outline-dark">내 장바구니로 가기</button>
                        </form>
                     </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!--  <button type="button" class="btn btn-primary jobdetail-btnsizeL" data-toggle="modal" data-target="#bookmark">북마크</button> -->
             <%--  <button type="button" class="btn btn-light btn-block badge-pill" data-toggle="modal"
                     data-target="#bookmark"><b>북마크</b></button>
                  <% if(session.getAttribute("userno") != null) { %>
                  <div class="modal fade" id="bookmark" data-backdrop="static" data-keyboard="false" tabindex="-1"
                     aria-labelledby="bookmarkLabel" aria-hidden="true">
                     <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                        <div class="modal-content">
                           <div class="modal-header">
                              <h5 class="modal-title" id="bookmarkLabel">북마크</h5>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">&times;</span>
                              </button>
                           </div>
                           <% if(likechk.equals("false")) { %>
                           <div class="modal-body">
                              북마크 하시겠습니까?
                           </div>
                           <div class="modal-footer">
                              <button type="button" class="btn btn-outline-dark"
                                 data-dismiss="modal">닫기</button>
                              <form action="<%=request.getContextPath()%>/indiv/board/detail" method="post">
                                 <input type="hidden" name="user_id"
                                    value="<%=session.getAttribute("userid")%>">
                                 <input type="hidden" name="board_id" value="<%=jobData.getId()%>">
                                 <input type="hidden" name="cancle" value="false">
                                 <button type="submit" class="btn btn-outline-dark">북마크 하기</button>
                              </form>
                           </div>
                           <% } else { %>
                           <div class="modal-body">
                              북마크를 취소 하시겠습니까?
                           </div>
                           <div class="modal-footer">
                              <button type="button" class="btn btn-outline-dark"
                                 data-dismiss="modal">닫기</button>
                              <form action="<%=request.getContextPath()%>/indiv/board/detail" method="post">
                                 <input type="hidden" name="user_id"
                                    value="<%=session.getAttribute("userid")%>">
                                 <input type="hidden" name="board_id" value="<%=jobData.getId()%>">
                                 <input type="hidden" name="cancle" value="true">
                                 <button type="submit" class="btn btn-outline-dark">확인</button>
                              </form>
                           </div>
                           <% } %>
                        </div>
                     </div>
                  </div>
                  <% } else { %>
                  <div class="modal fade" id="bookmark" data-backdrop="static" data-keyboard="false" tabindex="-1"
                     aria-labelledby="bookmarkLabel" aria-hidden="true">
                     <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                        <div class="modal-content">
                           <div class="modal-header">
                              <h5 class="modal-title" id="bookmarkLabel">북마크</h5>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">&times;</span>
                              </button>
                           </div>
                           <div class="modal-body">
                              북마크를 위해서는 로그인이 필요합니다. <br>
                              로그인페이지로 이동하시겠습니까?
                           </div>
                           <div class="modal-footer">
                              <button type="button"
                                 class="btn btn-outline-dark data-dismiss=modal">닫기</button>
                              <a href="<%=request.getContextPath()%>/user/login"
                                 class="btn btn-outline-dark">이동</a>
                           </div>
                        </div>
                     </div>
                  </div>
                  <% } %>
               </div>
            </div>
         </div> --%>
		<div class="container">
	      <div class="row my-5">
	         <div class="col-12">
	            
	         </div>
	      </div>
		</div>
		<div class="container">
		<!-- 임시주석
			<jsp:include page="/WEB-INF/views/product/reviews.jsp" flush="false" > -->
				<jsp:param name="item" value="${item}" />
			</jsp:include>
		</div>
      </div>   
   </div>
	<%@ include file="/WEB-INF/views/module/footer.jsp" %>
</body>
</html>