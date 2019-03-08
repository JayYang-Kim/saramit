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
            <div style="height:230px; background-color: #2b2d2e;">
            	<div style="text-align: center; padding-top: 100px; color: white">
            		<h1>${dto.cop_name}</h1>
            	</div>
            </div>
            <div class="contents" style="background-color: #F5F6F7;">
            
                <div class="reviewForm" style="width:900px; margin: 0 auto; padding:30px;">
				
				
				<div style="background-color: white;">
					
						<div class="t_center mt30">
							<label>별점</label>
							<div class="p10">
								${dto.star}&nbsp;점
							</div>
						</div>
						<div class="t_center mt30" style="padding-top: 30px;">
							<h2 class="m20" style="text-align: left;">&nbsp;&nbsp;content1</h2>
							<div class="p10 m20" style="border:1px solid gray; box-shadow: 1px 1px 3px rgba(0,0,0,0.13); height:130px;">${dto.content1}</div>
						</div>
						<br>
						<div class="t_center mt30">
							<h2 class="m20" style="text-align: left;">&nbsp;&nbsp;content2</h2>
							<div class="p10 m20" style="border:1px solid gray; box-shadow: 1px 1px 3px rgba(0,0,0,0.13); height:130px;">${dto.content2}</div>
						</div>
						<br>
						<div class="t_center mt30">
							<h2 class="m20" style="text-align: left;">&nbsp;&nbsp;content3</h2>
							<div class="p10 m20" style="border:1px solid gray; box-shadow: 1px 1px 3px rgba(0,0,0,0.13); height:130px;">${dto.content3}</div>
						</div>
						<br>
						<div class="t_center mt30">
							<h2 class="m20" style="text-align: left;">&nbsp;&nbsp;content4</h2>
							<div class="p10 m20" style="border:1px solid gray; box-shadow: 1px 1px 3px rgba(0,0,0,0.13); height:130px;">${dto.content4}</div>
						</div>
						<br>
						
					
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