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
							<div class="email mb10">${dto.name} (${dto.email})</div>
							<div class="content mb10">${dto.content}</div>
							<div class="etc mb10"><span>${dto.created}</span> 
								<c:if test="${sessionScope.member.email == dto.email}">| <a onclick='deleteReply(${dto.boardNum}, ${dto.replyNum});' style="cursor:pointer;">삭제</a></c:if>
							</div>
							<div class="btn_reply">
								<button type='button' class='btn btn-white btnReplyAnswerLayout' data-replyNum='${dto.replyNum}'>답글 <span id="answerCount${dto.replyNum}">${dto.answerCount}</span></button>
		            			<button type='button' class='btnSendReplyLike btn btn-white f_right' data-replyNum="${dto.replyNum}" data-replyLike="0">싫어요<span>${dto.disLikeCount}</span> </button>
		            			<button type='button' class='btnSendReplyLike btn btn-white f_right mr5' data-replyNum="${dto.replyNum}" data-replyLike="1">좋아요 <span>${dto.likeCount}</span></button>
							</div>
						</div>
						<div class="replyAnswer hide">
							<div id="listReplyAnswer${dto.replyNum}" class="answerList"></div>
							<div class="box_answerWrite">
								<span class="answer_icon">└</span>
								<div class="box_answer">
									<form name="answerForm" method="post">
										<div class="wrtieAnswer">
				           					<%-- <input type="hidden" name="boardNum" value="${dto.boardNum}"/>
				           					<input type="hidden" name="answer" value="0"/> --%>
				           					<textarea placeholder="내용을 입력해주세요." id="reply_content" name="reply_content" title="내용" style="min-height:120px;"></textarea>
				           					<div class="txt mt10 mb10">* 타인을 비방하거나 개인정보를 유출하는 글의 댓글은 삭제 처리가 될 수 있습니다.</div>
				           					<div class="t_right">
				           						<button type="reset" class="btn_classic btn-white mr5">다시입력</button>
				            					<button type="button" class="btn_classic btn-black btnSendReplyAnswer" data-replyNum="${dto.replyNum}">답글 등록</button>
				           					</div>
				           				</div>
									</form>
								</div>
							</div>
							<div>
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