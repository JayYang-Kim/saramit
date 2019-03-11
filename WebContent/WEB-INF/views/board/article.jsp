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
    	function deleteBoard(boardNum) {
    		if(confirm("게시물을 삭제 하시겠습니까?")) {
    			var url = "<%=cp%>/board/delete.do?boardNum=" + boardNum + "&${query}";
    			location.href = url;
    		}
    	}
    	
    	<%-- function guest_send() {
    		var f = document.guestForm;
    		
    		f.action = "<%=cp%>/board/reply_ok.do";
    		f.submit();
    	} --%>
    	
    	function guest_send() {
    		var uEmail = "${sessionmScope.member.userEmail}";
    		
    		if(!uEmail) {
    			location.href = "<%=cp%>/member/login.do";
    			return;
    		}
    		
    		if(!$("#content").val().trim()) {
    			$("#content").focus();
    			return;
    		}
    		
    		var query= $("form[name=guestForm]").serialize();
    		var url = "<%=cp%>/board/reply_ok.do";
    		
    		$.ajax({
    			type : "post",
    			url : url,
    			data : query,
    			dataType : "json",
    			success : function(data) {
    				var state = data.state;
    				
    				if(state == "loginFail") {
    					location.href = "<%=cp%>/member/login.do";
    					return;
    				}
    				
    				$("#content").val("");
    				
    				listPage(1);
    			},
    			error : function(e) {
    				console.log(e.responseText);
    			}
    		});
    		
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
                		<h3>자소서 피드백 - 상세</h3>
                	</div>
                	<!-- //pageTitle -->
                	<div class="mt15 mb15">
                		<table class="tb_kakao_row big">
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
                		<c:if test="${empty preReadDto}">
                			<button type="button" class="btn_classic btn-lightGray" style="color:#d6d6d6;" disabled="disabled">이전</button>
                		</c:if>
                		<c:if test="${not empty preReadDto}">
                			<button type="button" class="btn_classic btn-lightGray" onclick="location.href='<%=cp%>/board/article.do?boardNum=${preReadDto.boardNum}&${query}'">이전</button>
                		</c:if>
                		<c:if test="${empty nextReadDto}">
                			<button type="button" class="btn_classic btn-lightGray" style="color:#d6d6d6;" disabled="disabled">다음</button>
                		</c:if>
                		<c:if test="${not empty nextReadDto}">
                			<button type="button" class="btn_classic btn-lightGray" onclick="location.href='<%=cp%>/board/article.do?boardNum=${nextReadDto.boardNum}&${query}'">다음</button>
                		</c:if>
                		<c:if test="${sessionScope.member.email == dto.userEmail || sessionScope.member.email == 'admin'}">
							<button type="button" class="btn_classic btn-red" style="float:right;" onclick="deleteBoard('${dto.boardNum}');">삭제하기</button>
						</c:if>
                		<c:if test="${sessionScope.member.email == dto.userEmail}">
							<button type="button" class="btn_classic btn-white mr5" style="float:right;" onclick="javascript:location.href='<%=cp%>/board/update.do?boardNum=${dto.boardNum}&${query}';">수정하기</button>
						</c:if>
						<c:if test="${sessionScope.member.email != dto.userEmail}">
                		<button type="button" class="btn_classic btn-black" style="float:right;" onclick="location.href='<%=cp%>/board/list.do?${query}'">목록보기</button>
                		</c:if>
                	</div>
                	<!-- 답변 -->
                	<div class="box_guest">
                		<div class="title">
                			<h3>댓글</h3>
                		</div>
                		<div>
                			<form name="guestForm" method="post">
	               				<c:if test="${mode=='reply'}">
						      		<input type="hidden" name="groupNum" value="${dto.groupNum}">
						      	    <input type="hidden" name="orderNo" value="${dto.orderNum}">
						      	    <input type="hidden" name="depth" value="${dto.depth}">
						      	    <input type="hidden" name="parent" value="${dto.boardNum}">
						      		<input type="hidden" name="page" value="${page}">
						      	</c:if>
                				<div>
                					<textarea placeholder="내용을 입력해주세요." id="content" name="content" title="내용" style="min-height:120px;"></textarea>
                					<span class="txt">타인을 비방하거나 개인정보를 유출하는 글의 댓글은 삭제 처리가 될 수 있습니다.</span>
                					<div>
                						<button type="reset" class="btn_classic btn-white">다시입력</button>
	                					<button type="button" class="btn_classic btn-black" onclick="guest_send()">댓글 등록</button>
                					</div>
                				</div>
                			</form>
                			<div id="listGuest">
                			</div>
                		</div>
                	</div>
                	<%-- <form name="feedback_form" method="post">
                		<div class="mt15 mb15">
	                		<table class="tb_kakao_row big">
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
	                	<!-- 답변 -->
	                	<div class="">
	                		
	                	</div>
	                	<div class="mt20 mb20">
	                		<c:if test="${empty preReadDto}">
	                			<button type="button" class="btn_classic btn-lightGray" style="color:#d6d6d6;" disabled="disabled">이전</button>
	                		</c:if>
	                		<c:if test="${not empty preReadDto}">
	                			<button type="button" class="btn_classic btn-lightGray" onclick="location.href='<%=cp%>/board/article.do?boardNum=${preReadDto.boardNum}&${query}'">이전</button>
	                		</c:if>
	                		<c:if test="${empty nextReadDto}">
	                			<button type="button" class="btn_classic btn-lightGray" style="color:#d6d6d6;" disabled="disabled">다음</button>
	                		</c:if>
	                		<c:if test="${not empty nextReadDto}">
	                			<button type="button" class="btn_classic btn-lightGray" onclick="location.href='<%=cp%>/board/article.do?boardNum=${nextReadDto.boardNum}&${query}'">다음</button>
	                		</c:if>
	                		<c:if test="${sessionScope.member.email == dto.userEmail || sessionScope.member.email == 'admin'}">
								<button type="button" class="btn_classic btn-red" style="float:right;" onclick="deleteBoard('${dto.boardNum}');">삭제하기</button>
							</c:if>
	                		<c:if test="${sessionScope.member.email == dto.userEmail}">
								<button type="button" class="btn_classic btn-white mr5" style="float:right;" onclick="javascript:location.href='<%=cp%>/board/update.do?boardNum=${dto.boardNum}&${query}';">수정하기</button>
							</c:if>
							<c:if test="${sessionScope.member.email != dto.userEmail}">
	                		<button type="button" class="btn_classic btn-black" style="float:right;" onclick="location.href='<%=cp%>/board/list.do?${query}'">목록보기</button>
	                		</c:if>
	                	</div>
                	</form> --%>
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