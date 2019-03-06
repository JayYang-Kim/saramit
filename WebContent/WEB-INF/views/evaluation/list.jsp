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
.container {
    clear:both;
    width:100%;
    text-align:left;
}

.body-container {
    clear:both;
    margin: 0px auto 15px;
    min-height: 450px;
}
</style>
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
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
            <div class="contents" style="width:700px; height:700px; margin: 30px auto 30px;">
                <div>
                	<div>
                  		<h3>이거 회사평가 게시글이다</h3>
                  	</div>
                  	<div style="height:50px; margin: 30px auto;">
                  		<form name="searchForm" action="<%=cp%>/evaluation/listReview.do" method="post">
                  			<select name="searchKey" class="selectField" style="width:120px; height:45px;">
                  				<option value="cop" selected="selected">기업명</option>
                  				<option value="content">내용</option>
                  				<option value="created">등록일</option>
                  			</select>
                  			<input type="text" name="searchValue" style="width:474px; height:45px;">
			            	<button type="button" class=" btn btn-black" style="width:100px; height:45px;" onclick="searchList()">검색</button>
                  		</form>
                  	</div>
            		<div>
                  	<table style="width:100%; margin: 20px auto 0px; border-spacing: 0px;">
                  		<tr height="10">
                  			<td align="left" width="50%">${dataCount}개(${page}/${total_page} 페이지)</td>
                  			<td align="right">&nbsp;</td>
                  		</tr>		
                  	</table>
                  	<table style="width:100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
                  		<tr align="center" height="35" style="border-top: 1px solid; #cccccc; border-bottom: 1px solid #cccccc;">
                  			<th width="40">번호</th>
                  			<th width="120">기업명</th>
                  			<th width="80">작성일</th>
                  		<!-- 	<th width="60">조회수</th> -->
                  		</tr>
                  		
                  <c:forEach var="dto" items="${list}"> 
                  		<tr align="center" height="35" style="border-bottom: 1px solid #cccccc;">
                  			<td>${dto.boardNum}</td>
                  			<%-- <td><a href="${articleUrl}&num=${dto.boardNum}">${dto.cop_name}</a></td> --%>
                  			<td><a href="<%=cp%>/companies/articleReview.do?page=1&num=${dto.boardNum}">${dto.cop_name}</a></td>
                  			<td>${dto.created}</td>
                  		<!-- 	<td>조회수</td> -->
                  		</tr>
                  </c:forEach> 
                  	</table>
                  	
                  	<table style="width:100%; margin:0px auto; border-spacing: 0px;'">
                  		<tr height="35">
                  			<td align="center">
                  				<c:if test="${dataCount==0}">
                  					등록된 게시물이 없습니다.
                  				</c:if>
                  				<c:if test="${dataCount!=0}">
                  					${paging}
                  				</c:if>
                  			</td>
                  		</tr>
                  	</table>
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