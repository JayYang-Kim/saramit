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

.star {
	font-size: 0;
	letter-spacing: -4px;
}

.star a {
	font-size: 14px;
	letter-spacing: 0;
	display: inline-block;
	margin-left: 3px;
	color: #cccccc;
	text-decoration: none;
}

.star a:first-child {
	margin-left: 0;
}

.star a.on {
	color: #F2CB61;
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
    <div id="wrap" class="tb_wrap">
        <!-- Header -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
        <!-- //Header -->
        <!-- container -->
        <div id="container" class="tb_container">
            <!-- contents -->
            <div class="contents">
            	<div class="contents_header_bg evaluation_list center">
            		<div class="bg_black"></div>
            	</div>
                <div class="inner">
                	<div class="pageTitle mt30 pb10">
                  		<h3>회사평가 </h3>
                  	</div>
                  	
                  	<div class="mt20 mb20">&nbsp;&nbsp;기업 평점 순위</div>
                  	<div>
                  	<table class="tb_kakao mb10" style="width: 500px; float: left;">
                  			
                		<c:forEach var="dtoS" items="${listS}" end="4">
                			<tr>
                	  			<td>${dtoS.rank}</td>
		                 		<td>${dtoS.cop_name}</td>
		                 		<td>
									<p class="star">
										<c:forEach var="dto" begin="1" end="${dtoS.star}">
											<a class="on" href="#">★</a> 
										</c:forEach>
										<c:forEach var="dto" begin="1" end="${5-dtoS.star}">
											<a href="#">★</a> 
										</c:forEach>
									</p>
						  		</td>
		              		<tr>
		              	</c:forEach>
		              	 </table>
		              	<table class="tb_kakao mb10" style="width: 500px; float: left;">
		              	<c:forEach var="dtoS" items="${listS}" begin="5" end="9">
                			<tr>
                	  			<td>${dtoS.rank}</td>
		                 		<td>${dtoS.cop_name}</td>
		                 		<td>
									<p class="star">
										<c:forEach var="dto" begin="1" end="${dtoS.star}">
											<a class="on" href="#">★</a> 
										</c:forEach>
										<c:forEach var="dto" begin="1" end="${5-dtoS.star}">
											<a href="#">★</a> 
										</c:forEach>
									</p>
						  		</td>
		              		<tr>
		              	</c:forEach>
		              
	                </table>
	                </div>
            		<div class="clear">
	                  	
	                  	<div class="f_left mt20 mb20">
	                  		<span>${dataCount}개 (${page}/${total_page} 페이지)</span>
	                  	</div>
	                  	<div class="searchBox">
	               			<form name="searchForm" action="<%=cp%>/companies/listReview.do" method="post">
	               				<select name="searchKey">
	                  				<option value="cop" selected="selected">기업명</option>
	                  				<option value="content1">내용</option>
	                  				<option value="created">등록일</option>
	                  			</select>
	               				<input type="text" name="searchValue" title="검색내용"/>
	               				<button type="button" class="btn btn-black" onclick="searchList()">검색</button>
	               			</form>
	                	</div>
	                	
	                  	<table class="tb_kakao tb_hover big">
	                  		<colgroup>
                				<col style="width:40px">
                				<col style="width:120px">
                				<col style="width:80px">
                			</colgroup>
	                  		<thead>
	                  			<tr>
		                  			<th>번호</th>
		                  			<th>기업명</th>
		                  			<th>작성일</th>
		                  			<!-- <th width="60">조회수</th> -->
		                  		</tr>
	                  		</thead>
	                  		<tbody>
	                  			<c:forEach var="dto" items="${list}">
		                  			<tr align="center" height="35" style="border-bottom: 1px solid #cccccc;" onclick="location.href='${articleUrl}&boardNum=${dto.boardNum}'">
			                  			<td>${dto.listNum}</td>
			                  			<td>${dto.cop_name}</td>
			                  			<td>${dto.created}</td>
			                  			<!-- <td>조회수</td> -->
			                  		</tr>
		                  		</c:forEach>
		                  		<c:if test="${dataCount==0}">
                  					<td colspan="3">등록된 게시물이 없습니다.</td>
                  				</c:if> 
							</tbody>
	                  	</table>
                  	
                  		<div class="t_center m20 mb20">
		                    <c:if test="${dataCount != 0}">
		                    	${paging}
		                    </c:if>
		                </div>
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