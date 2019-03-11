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
    	function searchList() {
    		var f = document.searchForm;
    		
    		if(f.searchValue.value == "") {
    			alert("검색내용을 입력해주세요.");
    			f.searchValue.focus();
    			return;
    		}
    		
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
            	<div class="contents_header_bg board_list bottom">
            		<div class="bg_black"></div>
            	</div>
                <div class="inner">
                	<!-- pageTitle -->
                	<div class="pageTitle mt30 pb10">
                		<h3>자소서 피드백</h3>
                	</div>
                	<!-- //pageTitle -->
                	<div class="searchBox">
               			<form name="searchForm" action="<%=cp%>/board/list.do" method="post">
               				<select name="searchKey" title="검색">
               					<option value="subject">제목</option>
               					<option value="userName">작성자</option>
               					<option value="content">내용</option>
               					<option value="created">등록일</option>
               				</select>
               				<input type="text" name="searchValue" title="검색내용"/>
               				<button type="button" class="btn btn-black" onclick="searchList()">검색</button>
               			</form>
                	</div>
                	<div>
                		<table class="tb_kakao tb_hover big">
                			<colgroup>
                				<col style="width:70px">
                				<col>
                				<col style="width:100px">
                				<col style="width:80px">
                				<col style="width:110px">
                			</colgroup>
                			<thead>
                				<tr>
                					<th>No.</th>
                					<th>제목</th>
                					<th>작성자</th>
                					<th>조회수</th>
                					<th>작성일</th>
                				</tr>
                			</thead>
                			<tbody>
                				<c:forEach var="dto" items="${list}">
                					<tr onclick="location.href='<%=cp%>/board/article.do?boardNum=${dto.boardNum}&page=${page}'">
	                					<td>${dto.listNum}</td>
	                					<td class="left txt_overflow">${dto.subject}</td>
	                					<td>${dto.userName}</td>
	                					<td>${dto.hitCount}</td>
	                					<td>${dto.created}</td>
	                				</tr> 
                				</c:forEach>
                				<c:if test="${dataCount == 0}">
                					<tr>
                						<td colspan="5">등록된 게시물이 없습니다.</td>
                					</tr>
                				</c:if>
                			</tbody>
                		</table>
                	</div>
                	<!-- 페이징 -->
                	<div class="t_center m20 mb20">
	                    <c:if test="${dataCount != 0}">
	                    	${paging}
	                    </c:if>
	                </div>
	                <div class="t_right mb20">
	                	<button type="button" class="btn_classic btn-white" style="float:left;" onclick="location.href='<%=cp%>/board/list.do'">새로고침</button>
	                	<button type="button" class="btn_classic btn-black" onclick="location.href='<%=cp%>/board/created.do'">등록하기</button>
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