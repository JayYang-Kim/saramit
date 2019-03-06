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
</head>

<body>
    <!-- Wrap -->
    <div id="wrap">
        <!-- Header -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
        <!-- //Header -->
        <!-- container -->
        <div id="container">
            <div style="height:61px"></div>
            <!-- contents -->
            <div class="contents">
                <div class="reviewForm" style="width:900px; height:1000px; background:lightgray; margin: 70px auto; padding:20px;">
				<ul>
					<li><h1>리뷰작성</h1></li>	
				</ul>
				<br>
				<br>
				<div>
					<form name="ReviewForm" action="#" method="post">
						<div class="t_center mt30">
							<label>content1</label>
							<div class="p10">
								<div style="border: 1px solid; width: 85%">${dto.content1}</div>
							</div>
						</div>
						<div class="t_center mt30">
							<label>content2</label>
							<div class="p10">
								<div style="border: 1px solid; width: 85%">${dto.content2}</div>
							</div>
						</div>
						<div class="t_center mt30">
							<label>content3</label>
							<div class="p10">
								<div style="border: 1px solid; width: 85%">${dto.content3}</div>
							</div>
						</div>
						<div class="t_center mt30">
							<label>content4</label>
							<div class="p10">
								<div style="border: 1px solid; width: 85%">${dto.content4}</div>
							</div>
						</div>
						<div class="t_center mt30">
							<label>별점</label>
							<div class="p10">
								${dto.star}"&nbsp;점
							</div>
						</div>
						<%-- 
						<div class="t_center mt20">
						    <input type="hidden" name="email" value="${email}">
							<button type="button" class="btn_classic btn-black">작성취소</button>
							<button type="button" class="btn_classic btn-black ml20" onclick="sendReview();">${mode=='update'?'수정완료':'등록완료'}</button>
						</div>
							 --%>
					</form>
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
</body>
</html>