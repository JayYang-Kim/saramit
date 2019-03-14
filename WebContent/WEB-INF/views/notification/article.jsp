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
    		min-height: 830px;
    	}
    	
    	.freeBody .freeContainer{
    		width:700px;
  			padding-top:30px;
  			margin : 0 auto;
  			min-height: 830px;
    	}
    	
    	.freeBody .freeContainer .board{
    		min-height: 600px;
    		background-color: #fff;
    		border: 1px solid #e4e4e4;
    		margin-top : 20px;
    	}
    	
    	.freeBody .freeContainer .board .innerDiv{
    		border-bottom: 1px solid #e4e4e4;
    		width: 100%;
    		padding: 5px 0 5px;
    	}
		.ui-widget-header {
  			background: #4c4c4c;
  			color: #fff;
  		}
  		.freeBody .freeContainer .board .replyForm{
  			width:600px;
    		margin : 15px auto 15px;
    		border :1px solid #e4e4e4;
    	}
    	a:hover {
    		color:tomato;
    	}
    </style>
    <script type="text/javascript">
    var current_page;
    $(function(){
    	$("#btn_update").click(function(){
    		$("#dlg_update").dialog({
    			title:"확인메세지",
    			width:350,
    			height:140,
    			modal:true,
    			hide:"explode"
    		});
    		$("#update_ok").click(function(){
				location.href="<%=cp%>/board/free/update.do?page=${page}&num=${dto.boardNum}";
			});
			$("#update_cancel").click(function(){
				$("#dlg_update").dialog("close");
			});
    	});
    	$("#btn_delete").click(function(){
    		$("#dlg_delete").dialog({
    			title:"확인메세지",
    			width:350,
    			height:140,
    			modal:true,
    			hide:"explode"
    		});
    		$("#delete_ok").click(function(){
				location.href="<%=cp%>/board/free/delete.do?page=${page}&num=${dto.boardNum}";
			});
			$("#delete_cancel").click(function(){
				$("#dlg_delete").dialog("close");
			});
    	});    	
    });
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
            	<div style="position: absolute; right: 0;top: 500px;"><img alt="사진없지롱" src="<%=cp%>/resources/movingKAKAO.gif"></div>
				<div class="freeBody">
					<div class="freeContainer">
						<h1 style="text-align: left; padding: 5px 8px">공지사항</h1>
						<div class="board" align="center" style="text-align: center">
							<h2 style="text-align: center; padding: 5px 8px; background-color: #4c4c4c; color: #fff">글보기</h2> 
								<div class="innerDiv" style="padding-top: 15px; text-align: left;">
									<b style="margin-left: 63px;">제 &nbsp;목 : </b><input type="text" name="subject" value="${dto.subject}"style="margin-left:2px; width: 55%; font-weight:bold; height: 30px; border: none; outline: none;" readonly="readonly">
									<b>조회수 :&nbsp;</b>${dto.hitCount}
								</div>
								<div class="innerDiv" style=" text-align: left;">
									<b style="margin-left: 60px;">작성자 : </b><input type="text" name="writer" value="${dto.name}" readonly="readonly" style="border: none; outline: none; width:55%; font-weight: bold;">
									<b>작성일 :&nbsp;${dto.created}</b>
									
								</div>
								<div class="innerDiv">
									<textarea style="width:80%; height: 350px; outline: none; border: none;" maxlength="1000" name="content" readonly="readonly">${dto.content}</textarea>
								</div>
								<div class="innerDiv" style=" text-align: left; height: 30px; line-height: 30px;">
									 <b style="margin-left: 45px;">첨 부 파 일 : </b>
									 <c:if test="${not empty dto.saveFileName}">
					                    &nbsp;<a id="file" href="<%=cp%>/notification/download.do?num=${dto.boardNum}" style="padding-left:10px;">${dto.originalFileName}</a>
					                    (<fmt:formatNumber value="${dto.fileSize/1024}" pattern="0.00"/> Kbyte)
					          		 </c:if>
								</div>
									<div align="left" style="border-bottom:1px solid #e4e4e4; height:30px; padding-top:10px; line-height: 20px;"><p style="padding-left:60px;">
									<b>이전 글 : </b><a style="cursor: pointer" onclick="javascript:location.href='<%=cp%>/notification/article.do?${query}&boardNum=${preReadDto.boardNum}';">${preReadDto.subject}</a></p></div>
									<div align="left" style="border-bottom:1px solid #e4e4e4; height:30px; padding-top:10px; line-height: 20px;"><p style="padding-left:60px;">
									<b>다음 글 : </b><a style="cursor: pointer" onclick="javascript:location.href='<%=cp%>/notification/article.do?${query}&boardNum=${nextReadDto.boardNum}';">${nextReadDto.subject}</a></p></div>
								<div style="margin-top: 10px; height: 45px; border-bottom: 1px solid #e4e4e4">
									<c:if test="${dto.email == sessionScope.member.email}">
									<button type="button" class="btn btn-black" id="btn_update">수정하기</button>&nbsp;
									</c:if>
									<c:if test="${dto.email == sessionScope.member.email or sessionScope.member.email=='admin'}">
									<button type="button" class="btn btn-black" id="btn_delete">삭제하기</button>&nbsp;
									</c:if>
									<button type="button" class="btn btn-black" onclick="javascript:location.href='<%=cp%>/notification/list.do?${query}';">목록으로</button>
								</div>
						</div>
					</div>
					<!-- freeContainer -->
				</div>
				<!-- free body -->
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
        <!-- Footer -->
       	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <!-- //Footer -->
    </div>
    <!-- //Wrap -->
    <div id="dlg_update" style="display:none;" align="center">
    	<h3>해당 게시물을 수정하시겠습니까?</h3>
	    <div style="margin-top:30px;">
	    <button class="btn btn-black" id="update_ok">확인</button>
	    <button class="btn btn-black" id="update_cancel">취소</button>
	    </div>
    </div>
    <div id="dlg_delete" style="display:none;" align="center">
    	<h3>해당 게시물을 삭제하시겠습니까?</h3>
    	<div style="margin-top:30px;">
    	<button class="btn btn-black" id="delete_ok">확인</button>
    	<button class="btn btn-black" id="delete_cancel">취소</button>
    	</div>
    </div>
</body>
</html>