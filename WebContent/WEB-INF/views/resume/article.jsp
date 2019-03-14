<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/views/layout/import.jsp"></jsp:include>
    <script type="text/javascript">


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
                		<h3>자소서 피드백 - 등록</h3>
                	</div>
                	<!-- //pageTitle -->
                	<form name="feedback_form" method="post">
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
	                				<td colspan="3">
	                					<input class="w100p" type="text" name="subject" value="${dto.subject}" placeholder="제목을 입력해주세요."/>
	                				</td>
	                			</tr>
	                			<tr>
	                				<th>작성자</th>
	                				<td>${dto.userName}</td>
	                				<th>이메일</th>
	                				<td>${dto.userEmail}</td>
	                			</tr>
	                			<tr>
	                				<th>내용</th>
	                				<td colspan="3">
	                					<textarea placeholder="내용을 입력해주세요." name="contents" title="내용" style="min-height:450px;">${dto.content}</textarea>
	                				</td>
	                			</tr>
	                		</table>
	                	</div>
	                	<div class="mt20 mb20 t_right">
	                		<c:if test="${mode == 'update'}">
	                			<input type="hidden" name="boardNum" value="${dto.boardNum}">
					        	<input type="hidden" name="page" value="${page}">
					        	<input type="hidden" name="searchKey" value="${searchKey}">
					        	<input type="hidden" name="searchValue" value="${searchValue}">
	                		</c:if>
	                		<c:if test="${mode=='reply'}">
					      	     <input type="hidden" name="groupNum" value="${dto.groupNum}">
					      	     <input type="hidden" name="orderNo" value="${dto.orderNum}">
					      	     <input type="hidden" name="depth" value="${dto.depth}">
					      	     <input type="hidden" name="parent" value="${dto.boardNum}">
					      	     <input type="hidden" name="page" value="${page}">
					      	</c:if>
	                		<button type="button" class="btn_classic btn-white" style="float:left;" onclick="location.href='<%=cp%>/board/list.do'">목록보기</button>
	                		<button type="reset" class="btn_classic btn-white">다시입력</button>
	                		<button type="button" class="btn_classic btn-black" onclick="feedback_send()">${mode=='update'?'수정하기':(mode=='reply'? '답변하기':'등록하기')}</button>
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