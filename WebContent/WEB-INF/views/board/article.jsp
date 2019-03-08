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
                <div class="inner">
                	<!-- pageTitle -->
                	<div class="pageTitle mt20 mb20">
                		<h3>자소서 피드백 게시판 - 상세</h3>
                	</div>
                	<!-- //pageTitle -->
                	<form name="feedback_form" method="post">
                		<div>
	                		<table class="tb_basic_row big">
	                			<colgroup>
	                				<col style="width:20%">
	                				<col style="width:30%">
	                				<col style="width:20%">
	                				<col style="width:30%">
	                			</colgroup>
	                			<tr>
	                				<th>제목</th>
	                				<td colspan="3">${dto.subject}</td>
	                			</tr>
	                			<tr>
	                				<th>작성자</th>
	                				<td>${dto.userName}</td>
	                				<th>이메일</th>
	                				<td>${dto.userEmail}</td>
	                			</tr>
	                			<tr>
	                				<th>작성일</th>
	                				<td>${dto.created}</td>
	                				<th>조회수</th>
	                				<td>${dto.hitCount}</td>
	                			</tr>
	                			<tr>
	                				<th>내용</th>
	                				<td colspan="3" style="height:480px;vertical-align:top;">
	                					${dto.content}
	                				</td>
	                			</tr>
	                		</table>
	                	</div>
	                	<div class="mt20 mb20"> 
	                		<button type="button" class="btn_classic btn-white">이전</button>
	                		<button type="button" class="btn_classic btn-white">다음</button>
	                		<button type="button" class="btn_classic btn-black" style="float:right;" onclick="location.href='<%=cp%>/board/list.do?page=${page}'">목록보기</button>
	                	</div>
                	</form>
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