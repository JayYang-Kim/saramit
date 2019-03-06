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
                <div class="inner">
                	<!-- pageTitle -->
                	<div class="pageTitle mt20 mb20">
                		<h3>자소서 피드백 게시판</h3>
                	</div>
                	<!-- //pageTitle -->
                	<div>
                		<table class="tb_basic big">
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
                					<tr>
	                					<td>${dto.listNum}</td>
	                					<td>${dto.subject}</td>
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