<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
%>

<c:if test="${replyCount != 0}">
	<div class="reply">
		<div class="replyCount" style="padding:10px;background-color:#4c4c4c;color:#ffffff;"> 
			<span class="bold">댓글 ${replyCount}개</span>
			<span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span>
		</div>
		<div class="boxReply">
			<ul>
				<c:forEach var="dto" items="${list}">
					<li>
						<div class="box">
							<div class="email mb10">${dto.email}</div>
							<div class="content mb10">${dto.content}</div>
							<div class="etc mb10"><span>${dto.created}</span> | <a onclick='deleteReply(${dto.boardNum}, ${dto.replyNum});'>삭제</a></div>
							<div class="btn_reply">
								<button type='button' class='btn btn-white btnReplyAnswerLayout' data-replyNum='1'>답글 <span id="answerCount1">1</span></button>
		            			<button type='button' class='btn btn-white f_right' onclick="">싫어요 </button>
		            			<button type='button' class='btn btn-white f_right mr5' onclick="">좋아요 </button>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="t_center m20 mb20 clear">
			<c:if test="${dataCount != 0}">
				${paging}
			</c:if>
		</div>
	</div>
</c:if>