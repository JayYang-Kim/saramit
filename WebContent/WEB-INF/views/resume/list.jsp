<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% 
	String cp=request.getContextPath();
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
				<div class="contents_header_bg resume_list center">
            		<div class="bg_black"></div>
            	</div>
				<div class="inner">
					<div class="pageTitle mt30 pb10">
                		<h3>이력서 관리</h3>
                	</div>
					<div class="mt20">
						<form>
							<table class="tb_kakao tb_hover big">
								<colgroup>
									<col style="width:120px;">
									<col>
									<col style="width:160px;">
									<col style="width:140px;">
								</colgroup>
								<thead>
									<tr>
										<th width="100px">글 번호</th>
										<th>제목</th>
										<th width="150px">작성일자</th>
										<th width="200px">기능</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="dto" items="${list}">
									<tr height="35px" style="border-bottom: 1px solid #e4e4e4;">
										<td>${dto.listNum}</td>
										<td><a
											href="<%=cp%>/resume/view.do?resumeCode=${dto.resumeCode}">${dto.title}</a></td>
										<td>${dto.created}</td>
										<td>
											<button class="btn btn-white" type="button" style="width: 95px; height: 35px;" onclick="location.href=delete.jsp">삭제</button>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<div align="center" style="margin-top: 15px;">
								<p>${paging}</p>
							</div>
							<div class="t_right">
								<a href="<%=cp%>/resume/created.do" class="btn_classic btn-black mt20">이력서 작성</a>
							</div>
						</form>
					</div>
					<br>
					<br>
				</div>
			</div>
			<!-- //contents -->        
        
        <!-- //container -->
        
        <!-- Footer -->
       	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <!-- //Footer -->
   </div>
          </div>  
    <!-- //Wrap -->

</body>
</html>