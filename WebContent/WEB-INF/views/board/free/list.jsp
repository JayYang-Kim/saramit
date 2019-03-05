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
    	.freeBody {
    		background-color: #F5F6F7;
    		min-height: 600px;
    	}
    	
    	.freeBody .freeContainer{
    		width:1000px;
  			padding-top:30px;
  			margin : 0 auto;
  			min-height: 600px;
    	}
    	
    	.board {
    		width:100%;
    		min-height: 700px;
    		margin : 0 auto;
    		margin-top: 30px;
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
                <div class="freeBody">
                    <div class="freeContainer">
                    	<h1>자유게시판</h1>
                    	<div class="board">
	                    	<form action="<%=cp%>/board/free/created.do">
	                    		<button type="submit" class="btn btn-black" style="float: right; margin-right:10px; margin-bottom: 10px;">글쓰기</button>
	                    		<table style="height: 100%; text-align: center; border: 1px solid #e4e4e4; background-color: #fff; clear: both; font-size: 17px;">
	                    		 	<tr style="border-bottom: 1px solid #e4e4e4; font-size: 20px;" height="40px">
	                    		 		<th width="100px">글번호</th>
	                    		 		<th>제목</th>
	                    		 		<th width="250px">글쓴이</th>
	                    		 		<th width="100px">조회수</th>
	                    		 	</tr>
	                    		 	<tr>
	                    		 		<td>오늘의</td>
	                    		 		<td>날씨는</td>
	                    		 		<td>맑음</td>
	                    		 		<td>10</td>
	                    		 	</tr>
	                    		 	<tr>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 	</tr>
	                    		 	<tr>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 	</tr>
	                    		 	<tr>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 		<td> </td>
	                    		 	</tr>
	                    		 	<tr>
	                    		 		<td></td>
	                    		 		<td></td>
	                    		 		<td></td>
	                    		 		<td></td>
	                    		 	</tr>
	                    		</table>
	                    		<span>이전 1 2 3 4 5 다음</span>
	                    	</form>	 
                    	</div>
                    	<!-- board -->
                    </div>
                    <!--freeContainer-->
                </div>
                <!--freeContainer-->
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