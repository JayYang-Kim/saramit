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
    	function feedback_send() {
    		var f = document.feedback_form;
    		
    		var subject = f.subject.value;
    		if(!subject) {
    			alert("제목을 입력해주세요.");
    			f.subject.focus();
    			return;
    		}
    		
    		var contents = f.contents.value;
    		if(!contents) {
    			alert("내용을 입력해주세요.");
    			f.contents.focus();
    			return;
    		}
    		
    		f.action = "<%=cp%>/board/${mode}_ok.do";
    		f.submit();
    	}
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
                		<h3>자소서 피드백 게시판 - 등록</h3>
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
	                				<td colspan="3">
	                					<input class="w100p" type="text" name="subject" placeholder="제목을 입력해주세요."/>
	                				</td>
	                			</tr>
	                			<tr>
	                				<th>작성자</th>
	                				<td>${name}</td>
	                				<th>이메일</th>
	                				<td>${email}</td>
	                			</tr>
	                			<tr>
	                				<th>내용</th>
	                				<td colspan="3">
	                					<textarea placeholder="내용을 입력해주세요." name="contents" title="내용" style="min-height:450px;"></textarea>
	                				</td>
	                			</tr>
	                		</table>
	                	</div>
	                	<div class="mt20 mb20 t_right"> 
	                		<button type="button" class="btn_classic btn-white" style="float:left;" onclick="location.href='<%=cp%>/board/list.do'">목록보기</button>
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