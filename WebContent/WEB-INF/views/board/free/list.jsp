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
    	.freeList {
    		background-color: #F5F6F7;
    		min-height: 830px;
    	}
    	
    	.freeList .freeContainer{
    		width:1000px;
  			padding-top:30px;
  			margin : 0 auto;
  			min-height: 830px;
    	}
    	
    	.freeList .freeContainer .board {
    		width:100%;
    		min-height: 700px;
    		margin : 0 auto;
    		margin-top: 30px;
    	}
  		.freeList .freeContainer .board  table{
  			height: 100%; 
  			text-align: center; 
  			border: 1px solid #e4e4e4; 
  			background-color: #fff; 
  			clear: both; 
  			font-size: 17px;
  			text-overflow: ellipsis;
  		}
    </style>
    <script type="text/javascript">
    	function search(){
    		var f = document.searchForm;
    		var key = f.searchKey.value;
    		var value = f.searchValue.value;
    		if(!f.searchValue.value){
    			alert("검색어를 입력하세요!");
    			return;
    		}
    		f.action = "<%=cp%>/board/free/list.do?searchKey="+key+"&searchValue="+value;
    		f.submit();
    	}
    </script>
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
                <div class="freeList">
                    <div class="freeContainer">
                    	<h1>자유게시판</h1>
                    	<div class="board">
	                    	<form action="<%=cp%>/board/free/created.do">
	                    		<button type="submit" class="btn btn-black" style="float: right; margin-right:10px; margin-bottom: 10px;">글쓰기</button>
	                    		<table>
	                    		 	<tr style="border-bottom: 1px solid #e4e4e4;font-size: 20px;" height="40px" >
	                    		 		<th width="100px">글번호</th>
	                    		 		<th>제목</th>
	                    		 		<th width="250px">글쓴이</th>
	                    		 		<th width="100px">조회수</th>
	                    		 	</tr>
	                    		 	<c:if test="${dataCount!=0}">
	                    		 	<c:forEach var="n" items="${list}">
	                    		 	<tr height="30px" style="border-bottom: 1px solid #e4e4e4;">
	                    		 		<td>${n.listNum}</td>
	                    		 		<td><a href="${article_url}&boardNum=${n.boardNum}">${n.subject}</a></td>
	                    		 		<td>${n.name}</td>
	                    		 		<td>${n.hitCount}</td>
	                    		 	</tr>
	                    		 	</c:forEach>
	                    		 	</c:if>
	                    		 	<c:if test="${dataCount==0}">
	                    		 	<tr height="30px" style="border-bottom: 1px solid #e4e4e4;">
	                    		 		<td colspan="4"><b>등록된 게시물이 없습니다.</b></td>
	                    		 	</tr>
	                    		 	</c:if>
	                    		</table>
	                    		
	                    		
	                    	</form>
	                    	<div class="t_center mt20 mb20">${paging}</div>
	                    	<form name="searchForm" method="post" onsubmit="return search();" style="text-align: center; margin-top: 10px;">
	                    		<select name="searchKey">
	                    			<option value="subject">제목</option>
	                    			<option value="content">내용</option>
	                    			<option value="all">제목+내용</option>
	                    			<option value="name">작성자</option>
	                    		</select>
	                    		<input type="text" name="searchValue">
	                    		<button type="submit" class="btn btn-black" style="height: 26px;">검 색</button>
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