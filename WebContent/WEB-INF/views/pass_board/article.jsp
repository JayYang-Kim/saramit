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
	
    $(function(){
    	$(".pop_content").append("<p>게시물을 삭제하시겠습니까?</p>");
    });
    
    $(function(){
    	$(".pop_content2").append("<p>게시물을 수정하시겠습니까?</p>");
    });
    
    
    
    function deleteBoard(num) {
	<c:if test="${sessionScope.member.email=='admin'|| sessionScope.member.email==dto.userEmail}">	
		var page = "${page}";
		var query = "num="+num+"&page="+page;
		var url = "<%=cp%>/pass_board/delete.do?" + query;
			location.href=url;
	</c:if>	
	}
	
	function updateBoard(num) {
<c:if test="${sessionScope.member.email==dto.userEmail}">
	var page="${page}";
	var query="num="+num+"&page="+page;
	var url="<%=cp%>/pass_board/update.do?" + query;
	
	location.href=url;
</c:if>

<c:if test="${sessionScope.member.email!=dto.userEmail}">
	alert("게시물 수정 권한이 없습니다.");
</c:if>
	}
	
$(function(){
	resumeList();
});

function resumeList(){
	var url="<%=cp%>/pass_board/resumeList.do";
	var query="companyName=${dto.companyName}&num=${dto.num}&page=${page}"
	
	$.ajax({
		type:"get"
		,url:url
		,data:query
		,success:function(data){
			$("#resumeList").html(data);
		}
		,beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		}
		,error:function(e){
		}
			console.log(e.responseText);
	})
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
					<div>
						<div class="pageTitle mt30 pb10">
	                		<h3>합격자소서</h3>
	                	</div>
						
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
									<td colspan="3" align="center">${dto.title}</td>
								</tr>
								<tr>
									<th>회사명</th>
									<td>${dto.companyName}</td>
									<th>작성일</th>
									<td>${dto.created}</td>
								</tr>
								<tr>
									<th>지원분야</th>
									<td>${dto.field}</td>
									<th>구분</th>
									<td>${dto.gubun}</td>
								</tr>

								<tr>
									<th>내용</th>
									<td style="height:480px;vertical-align:top;">${dto.content}</td>
								</tr>
							</table>
							
							<div class="f_right mt20 mb20">
							<c:if test="${sessionScope.member.email==dto.userEmail}">
								<%-- <button type="button" class="btn_classic btn-white" onclick="updateBoard('${dto.num}');">수정</button> --%>
		                		<button type="button" class="btn_classic btn-white" onclick="layerShow('#popup2')">수정</button>
		                	</c:if>
		                	
		                	<c:if test="${sessionScope.member.email==dto.userEmail}">
								<%-- <button type="button" class="btn_classic btn-white" onclick="deleteBoard('${dto.num}');">삭제</button> --%>
								<button type="button" class="btn_classic btn-white" onclick="layerShow('#popup')">삭제</button>
		                	</c:if>
		                		
		                		<button type="button" class="btn_classic btn-black" onclick="javascript:location.href='<%=cp%>/pass_board/list.do?${query}';">리스트</button>
		                	</div>
						</div>
						<div id="resumeList"></div>
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
    
    <!-- pop_layer -->
    <div id="popup" class="pop_bg">
        <article class="pop_wrap">
            <h1>메시지</h1>
            <div class="pop_cont">
                <div class="pop_content t_center f15"></div>
                <p class="t_center mt20">
              		<button type="button" class="button w72 btn-white pop_close">취소</button>
                    <button type="button" class="button w72 btn-black" onclick="deleteBoard('${dto.num}');">확인</button>
                </p>
            </div>
            <!-- 팝업을 닫을때는 .pop_close 클래스를 활용 하거나, popupHide 함수 활용 -->
            <a href="#" class="btn_close pop_close">닫기</a>
        </article>
    </div>
    
    <div id="popup2" class="pop_bg">
        <article class="pop_wrap">
            <h1>메시지</h1>
            <div class="pop_cont">
                <div class="pop_content2 t_center f15"></div>
                <p class="t_center mt20">
              		<button type="button" class="button w72 btn-white pop_close">취소</button>
                    <button type="button" class="button w72 btn-black" onclick="updateBoard('${dto.num}');">확인</button>
                </p>
            </div>
            <!-- 팝업을 닫을때는 .pop_close 클래스를 활용 하거나, popupHide 함수 활용 -->
            <a href="#" class="btn_close pop_close">닫기</a>
        </article>
    </div>
</body>
</html>