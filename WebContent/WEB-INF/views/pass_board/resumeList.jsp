<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<div class="inner">
<c:if test="${not empty list}">
<div class="pageTitle mt100 pb10 f18">
	<h3>관련자소서</h3>
</div>
<div class="mt15 mb15">
	<table class="tb_kakao big tb_hover">
		<colgroup>
			<col style="width:150px">
			<col style="width:100px">
			<col style="width:80px">
			<col style="width:60px">
			<col style="width:100px">
			<col style="width:30px">
		</colgroup>
		
		<thead>
			<tr>
				<th>제목</th>
				<th>회사이름</th>
				<th>지원분야</th>
				<th>구분</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>
		</thead>

		<tbody>
	<c:forEach var="dto" items="${list}">
		<tr onclick="location.href='<%=cp%>/pass_board/article.do?num=${dto.num}&page=${page}'">
			<td>${dto.title}</td>
			<td>${dto.companyName}</td>
			<td>${dto.field}</td>
			<td>${dto.gubun}</td>
			<td>${dto.created}</td>
			<td>${dto.hitCount}</td>
		</tr>
	</c:forEach>
		</tbody>	
       </table>
     </div>
   </c:if>
   </div>