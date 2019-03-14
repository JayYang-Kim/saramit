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
	<style>
		.freeBody {
    		background-color: #F5F6F7;
    		min-height: 828px;
    	}
    	
    	.freeBody .freeContainer{
    		width:650px;
  			padding-top:30px;
  			margin : 0 auto;
  			min-height: 828px;
    	}
    	
    	.freeBody .freeContainer .board{
    		min-height: 550px;
    		background-color: #fff;
    		border: 1px solid #e4e4e4;
    		margin-top : 20px;
    	}
    	
    	.freeBody .freeContainer .board .innerDiv{
    		border-bottom: 1px solid #e4e4e4;
    		width: 100%;
    		padding: 5px 0 5px;
    	}
    </style>
    <script type="text/javascript">
    	function sendOk(){
    		var f = document.sendForm;
    		
    		if(!f.subject.value){
    			alert('제목을 입력하세요');
    			return;
    		}
    		if(!f.content.value){
    			alert('내용을 입력하세요');
    			return;
    		}
    		if(${mode != null && mode=='update'}){
    			f.action="<%=cp%>/board/free/update_ok.do?boardNum=${num}&page=${page}";
    		}
    		f.submit();
    	}
    </script>
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
				<div class="freeBody">
					<div class="freeContainer">
						<h1 style="text-align: left; padding: 5px 8px">자유게시판</h1>
						<div class="board" align="center" style="text-align: center">
							<h2 style="text-align: center; padding: 5px 8px;background-color: #4c4c4c; color: #fff">글쓰기</h2>
							<form name="sendForm" action="<%=cp%>/board/free/created_ok.do" method="post">
								<div class="innerDiv" style="padding-top: 15px;">
									<b>제 목 :&nbsp;</b> &nbsp;&nbsp;<input maxlength="25" type="text" name="subject" style="width: 73%; font-size: 16px; height: 30px;" value="${mode=='update'?dto.subject:''}">
								</div>
								<div class="innerDiv">
									<b style="padding-left: 45px;">작성자 : </b><input type="text" name="writer" value="${sessionScope.member.name}" readonly="readonly" style="border: none; outline: none; width: 80%; font-weight: bold;">
								</div>
								<div class="innerDiv">
									<textarea style="width:80%; height: 350px;" placeholder="내 용" maxlength="1000" name="content">${mode=='update'?dto.content:''}</textarea>
								</div>
								<div style="margin-top: 10px;">
									<button type="button" class="btn btn-black" onclick="sendOk();">${mode=='update'?'수정하기':'작성하기'}</button>&nbsp;
									<button type="reset" class="btn btn-black">초기화</button>&nbsp;
									<c:if test="${mode=='update'}">
									<button type="button" class="btn btn-black" onclick="javascript:location.href='<%=cp%>/board/free/article.do?page=${page}&boardNum=${dto.boardNum}';">취소하기</button>
									</c:if>
									<c:if test="${mode=='created'}">
									<button type="button" class="btn btn-black" onclick="javascript:location.href='<%=cp%>/board/free/list.do';">취소하기</button>
									</c:if>
								</div>
							</form>
						</div>
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