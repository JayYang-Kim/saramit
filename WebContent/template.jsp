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
    <style type="text/css">
    	.resumeContainer {
    		background-color: #F5F6F7;
    		min-height: 750px;
    	}
    	.resumeContainer .resume{
    		margin:0 auto;
    		width:50%;
    		padding-top:30px;
    	}
    	.resumeContainer .resume .personalInfo {
    	
    	}
    </style>
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
                <div class="resumeContainer">
                	<div class="resume">
                		<form>
	                		<h1 style="">인적사항</h1>
	                		<div class="personalInfo" style="background-color: #fff; border: 1px solid #e4e4e4; min-height:200px; margin-top: 30px;">
	                			<div style="border: 1px solid #e4e4e4; width:250px; min-height: 80px; margin:20px; float: left;">
	                				<label style="position: relative; left:5px; top:5px; font-size:14px; color:#e4e4e4;display: block;">이름</label>
	                				<input type="text" style="position: relative; left:5px; top:15px; font-size:20px; outline: none; border: none; width:200px;" maxlength="5" placeholder="임상근">
	                			</div>
	                			<div style="border: 1px solid #e4e4e4; width:250px; min-height: 80px; margin:20px; float:left;">
	                				<label style="position: relative; left:5px; top:5px; font-size:14px; color:#e4e4e4;display: block;">이름</label>
	                				<input type="text" style="position: relative; left:5px; top:15px; font-size:20px; outline: none; border: none; width:200px;" maxlength="5" placeholder="임상근">
	                			</div>
	                		</div>
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