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
						<!-- <div class="body_title"
							style="margin: 20px auto; font-size: 20px;">
							<h3>합격자소서</h3>
						</div> -->
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
		                		<button type="button" class="btn_classic btn-black" onclick="javascript:location.href='<%=cp%>/pass_board/list.do?${query}';">리스트</button>
		                	</div>
		                	
							<%-- <table
								style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
								<tr height="45">
									<td width="300" align="left">
								       <c:if test="${sessionScope.member.userEmail==dto.userEmail}">				    
								          <button type="button" class="btn" onclick="updateBoard('${dto.num}');">수정</button>
								       </c:if>
								       <c:if test="${sessionScope.member.userEmail==dto.userEmail || sessionScope.member.userEmail=='admin'}">				    
								          <button type="button" class="btn" onclick="deleteBoard('${dto.num}');">삭제</button>
								       </c:if>
								    </td>

									<td align="right">
										<button type="button" class="btn"
											onclick="javascript:location.href='<%=cp%>/pass_board/list.do?${query}';">리스트</button>
									</td>
								</tr>
							</table> --%>
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