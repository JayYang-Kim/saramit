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
    	function sendBoard() {
    		var f = document.boardForm;
    		
    		var str = f.title.value;
    		if(!str) {
    			alert("제목을 입력하세요.");
    			f.title.focus();
    			return;
    		}
    		
    		var str = f.companyName.value;
    		if(!str) {
    			alert("회사명을 입력하세요.");
    			f.companyName.focus();
    			return;
    		}
    		
    		var str = f.field.value;
    		if(!str) {
    			alert("지원분야를 입력하세요.");
    			f.field.focus();
    			return;
    		}
    		
    		var str = f.content.value;
    		if(!str) {
    			alert("내용을 입력하세요.");
    			f.content.focus();
    			return;
    		}
    		
    		var mode="${mode}";
    		if(mode=="created")
    			f.action="<%=cp%>/pass_board/created_ok.do";
    		else if(mode=="update")
    			f.action="<%=cp%>/pass_board/update_ok.do";
    			
    		f.submit();	
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
				<div class="contents_header_bg passBoard_list center">
					<div class="bg_black"></div>
				</div>
				<div class="inner">
					<div class="pageTitle mt30 pb10">
						<h3>합격자소서 - 등록</h3>
					</div>

					<div class="mt15 mb15">
						<form name="boardForm" method="post">
							<table class="tb_kakao_row big">
								<colgroup>
									<col style="width:20%">
									<col style="width:30%">
									<col style="width:20%">
									<col style="width:30%">
								</colgroup>
								<tr>
									<th>제목</th>
									<td colspan="3"><input type="text" name="title" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.title}"></td>
								</tr>
									
								<tr>
									<th>회사명</th>
									<td colspan="3">
										<input type="text" name="companyName" class="boxTF" style="width: 200px" placeholder="ex) (주)사람잇">
									</td>
								</tr>
								
								<tr>
									<th>지원분야</th>
									<td>
										<input type="text" name="field" class="boxTF" style="width: 130px" placeholder="ex) 웹개발, MD, 영업 등">
									</td>
									<th>구분</th>
									<td>
										<select name="selectGubun">
											<option value="new">신입</option>
											<option value="career">경력</option>
										</select>
									</td>
								</tr>

								<tr>
									<th>내용</th>
									<td colspan="3">
										<textarea name="content" style="min-height:450px;">${dto.content}</textarea>
									</td>
								</tr>
							</table>
							
							<div class="t_center mt20 mb20">
								<button type="button" class="btn_classic btn-black"
									onclick="sendBoard();">${mode=='update'?'수정완료':'등록하기'}</button>
								<button type="reset" class="btn_classic btn-white">다시입력</button>
								<button type="button" class="btn_classic btn-red"
									onclick="javascript:location.href='<%=cp%>/pass_board/list.do';">${mode=='update'?'수정취소':'등록취소'}</button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="num" value="${dto.num}">
									<input type="hidden" name="page" value="${page}">
								</c:if>
							</div>
							
						</form>
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