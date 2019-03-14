<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
%>

<ul>
	<c:forEach var="dto" items="${listReplyAnswer}">
		<li>
			<div class="box_listAnswer">
				<span class="answer_icon">└</span>
				<div class="answerContent">
					<div class="email mb10">${dto.email}</div>
					<div class="content mb10">${dto.content}</div>
					<div class="etc mb10"><span>${dto.created}</span> 
						<c:if test="${sessionScope.member.email == dto.email}">| <a class="deleteReplyAnswer" data-replyNum="${dto.replyNum}" data-answer="${dto.answer}" style="cursor:pointer;">삭제</a></c:if>
					</div>
				</div>
			</div>
		</li>
	</c:forEach>
</ul>