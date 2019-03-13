<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <jsp:include page="/WEB-INF/views/layout/import.jsp"></jsp:include>
    <script type="text/javascript">
    
    function memberDelete(){
    	var url="<%=cp%>/member/delete.do";
		location.href=url;
    }
    
    $(function(){
    	$(".pop_content").append("<p>탈퇴하시겠습니까?</p>");
    });
   
    </script>
</head>

<body>
    <!-- Wrap -->
    <div id="wrap" class="tb_wrap">
        <!-- Header -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
        <!-- //Header -->
        <!-- container -->
        <div id="container" class="tb_container">
            <!-- contents -->
            <div class="contents">
            	<div class="contents_header_bg myPage center">
            		<div class="bg_black"></div>
            	</div>
            	<div class="inner">
                  	<div class="pageTitle mt30 pb10">
                		<h3>마이페이지</h3>
                	</div>
             		<c:if test="${level == 2}">      
	                   	<div style="width:40%; margin:50px; float:left;">
		                   	<div class="mb10">
			                   	<h3 style="display:inline-block; font-size: 20px; margin-bottom: 10px;">| 이력서 관리</h3>
			                   	<a href="<%=cp%>/resume/list.do" style="float:right; margin-top: 5px;">더보기</a>
		                   	</div>
		                   	<ul>
			                   	<c:forEach var="dto" items="${dto}" varStatus="status">
			                   		<li style="margin-left: 20px; margin-bottom: 10px; font-size: 15px;"><a href="#">${dto.title}</a></li>
			                   	</c:forEach>
		                   	</ul>
	                	</div>
	                   	
	                   	<div style="width:40%; margin:50px; float:left;">
		                   	<div class="mb10">
			                   	<h3 style="display:inline-block; font-size: 20px; margin-bottom: 10px;">| 지원사항</h3>
			                   	<a href="#" style="float:right; margin-top: 5px;">더보기</a>
		                   	</div>
		                	<ul>
		                   	<%for(int i=0; i<5; i++) {%>
		                   		<li style="margin-left: 20px; margin-bottom: 10px; font-size: 15px;"><a href="#">지원사항입니다</a></li>
		                   	<%}%>
		                   	</ul>
	                   </div>
                   </c:if>   
                   <div class="clear t_center mt20 mb20">
	                   <a href="<%=cp%>/member/update.do" class="btn_classic btn-black">정보수정</a>
	                   <!-- <a href="#" class="btn_classic btn-red ml20" onclick="memberDelete()">회원탈퇴</a> -->
	                   <button class="btn_classic btn-red ml20" onclick="layerShow('#popup')">회원탈퇴</button> 
                   </div>
            	</div>      
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
        
        <!-- Footer -->
       	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <!-- //Footer -->
    </div>
    <!-- //Wrap -->
    
    <!-- pop_layer -->
    <div id="popup" class="pop_bg">
        <article class="pop_wrap">
            <h1>메시지</h1>
            <div class="pop_cont">
                <div class="pop_content t_center f15"></div>
                <p class="t_center mt20">
                	<button type="button" class="button w72 btn-white pop_close">취소</button>
                    <button type="button" class="button w72 btn-black" onclick="memberDelete()">확인</button>
                </p>
            </div>
            <!-- 팝업을 닫을때는 .pop_close 클래스를 활용 하거나, popupHide 함수 활용 -->
            <a href="#" class="btn_close pop_close">닫기</a>
        </article>
    </div>
</body>
</html>