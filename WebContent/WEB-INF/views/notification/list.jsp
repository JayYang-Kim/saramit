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
    		margin-top: 20px;
    	}
  		.freeList .freeContainer .board  table{
  			height: 100%; 
  			text-align: center; 
  			border: 1px solid #e4e4e4; 
  			background-color: #fff; 
  			clear: both; 
  			font-size: 15px;
  			text-overflow: ellipsis;
  			border-collapse: collapse;
  			border-spacing: 0;
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
    		f.action = "<%=cp%>/notification/list.do?searchKey="+key+"&searchValue="+value;
    		f.submit();
    	}
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
            	<div class="contents_header_bg freeBoard_list bottom">
            		<div class="bg_black"></div>
            	</div>
            	<div class="inner">
            		<div class="pageTitle mt30 pb10">
                		<h3>공지사항</h3>
                	</div>
                	<div class="searchBox">
               			<form name="searchForm" method="post" onsubmit="return search();">
                    		<select name="searchKey">
                    			<option value="subject">제목</option>
                    			<option value="content">내용</option>
                    			<option value="all">제목+내용</option>
                    			<option value="email">작성자</option>
                    		</select>
                    		<input type="text" name="searchValue">
                    		<button type="submit" class="btn btn-black">검 색</button>
                    	</form>	 
                	</div>
                	<div>
						<table class="tb_kakao tb_hover big">
							<colgroup>
								<col style="width:70px;">
								<col>
								<col style="width:160px;">
								<col style="width:80px;">
								<col style="width:140px;">
								<col style="width:80px;">
							</colgroup>
							<thead>
								<tr>
									<th>글번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>조회수</th>
									<th>작성일</th>
									<th>첨부</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${dataCount!=0}">
									<c:forEach var="n" items="${list}">
										<tr>
											<td>${n.listNum}</td>
											<td style="cursor: pointer;"
												onclick="javascript:location.href='${article_url}&boardNum=${n.boardNum}'">${n.subject}
												&nbsp;<c:if test="${n.gap<=1}"><img src="<%=cp%>/resources/images/common/new.gif"></c:if>
											</td>
											<td>${n.name}</td>
											<td>${n.hitCount}</td>
											<td>${n.created}</td>
											<td>
											<c:if test="${not empty n.saveFileName}">
						      					<a href="<%=cp%>/notification/download.do?boardNum=${n.boardNum}"><img src="<%=cp%>/resources/images/common/disk.gif" border="0" style="margin-top: 1px;"></a>
											</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${dataCount==0}">
									<tr>
										<td colspan="4"><b>등록된 게시물이 없습니다.</b></td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<div class="t_center mt20 mb20">${paging}</div>
						<div class="t_right mb20">
						<button type="button" class="btn_classic btn-black" onclick="javacript:location.href='<%=cp%>/notification/created.do';">글쓰기</button>
							<!--<c:if test="${sessionScope.member.email=='admin'}">
		                		<button type="button" class="btn_classic btn-black" onclick="javacript:location.href='<%=cp%>/notification/created.do';">글쓰기</button>
		                	</c:if> -->
		                </div>
					</div>
            	</div>
                <%-- <div class="freeList">
                    <div class="freeContainer">
                    	<h1>자유게시판</h1>
                    	<div class="board">
	                    		<button type="button" class="btn btn-black" style="float: right; margin-right:10px; margin-bottom: 10px; color: #fff; font-size: 14px;" onclick="javacript:location.href='<%=cp%>/board/free/created.do';">글쓰기</button>
	                    		<table class="tb_hover">
	                    		<thead>
	                    		 	<tr style="border-bottom: 1px solid #e4e4e4;font-size: 20px;color: #fff" height="50px;" bgcolor="#4c4c4c" >
	                    		 		<th width="80px" style="padding-left: 3px;">글번호</th>
	                    		 		<th>제목</th>
	                    		 		<th width="170px">글쓴이</th>
	                    		 		<th width="70px">조회수</th>
	                    		 		<th width="150px">작성일</th>
	                    		 	</tr>
	                    		</thead>
	                    		 	<c:if test="${dataCount!=0}">
	                    		 	<c:forEach var="n" items="${list}">
	                    		 	<tr height="30px" style="border-bottom: 1px solid #e4e4e4;">
	                    		 		<td>${n.listNum}</td>
	                    		 		<td style="cursor: pointer;" onclick="javascript:location.href='${article_url}&boardNum=${n.boardNum}'">${n.subject}</td>
	                    		 		<td>${n.name}</td>
	                    		 		<td>${n.hitCount}</td>
	                    		 		<td>${n.created}</td>
	                    		 	</tr>
	                    		 	</c:forEach>
	                    		 	</c:if>
	                    		 	<c:if test="${dataCount==0}">
	                    		 	<tr height="30px" style="border-bottom: 1px solid #e4e4e4;">
	                    		 		<td colspan="4"><b>등록된 게시물이 없습니다.</b></td>
	                    		 	</tr>
	                    		 	</c:if>
	                    		</table>
	                    	<div class="t_center mt20 mb20">${paging}</div>
	                    	<form name="searchForm" method="post" onsubmit="return search();" style="text-align: center; margin-top: 10px;">
	                    		<select name="searchKey">
	                    			<option value="subject">제목</option>
	                    			<option value="content">내용</option>
	                    			<option value="all">제목+내용</option>
	                    			<option value="name">작성자</option>
	                    		</select>
	                    		<input type="text" name="searchValue">
	                    		<button type="submit" class="btn btn-black" style="height: 26px; line-height: 10px;">검 색</button>
	                    	</form>	 
                    	</div>
                    	<!-- board -->
                    </div>
                    <!--freeContainer-->
                </div> --%>
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