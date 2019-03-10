<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<!doctype html>
<html>
<head>
<style>
.list {
	width: 80%;
	border: 1 solid#
}
</style>
<jsp:include page="/WEB-INF/views/layout/import.jsp"></jsp:include>

<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
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
			<div style="height: 61px"></div>
			<!-- contents -->
			<div class="contents" style="margin:20px;">
				<div class="inner">
					<div class="body_title" style="margin: 20px auto; font-size: 20px;">
						<h3>합격자소서 보기</h3>
					</div>
					<hr>
					<div class="t_center mt20 mb20">
						<form name="searchForm" action="<%=cp%>/pass_board/list.do"
							method="post">
							<select name="searchKey" class="searchField"
								style="width: 120px; height: 40px">
								<option value="companyName">회사명</option>
								<option value="field">지원분야</option>
							</select> <input type="text" name="searchValue" class="box_TF"
								style="width: 300px; height: 40px">
							<button type="button" class="btn btn-white" onclick="searchList()"
								style="height: 40px">검색</button>
						</form>
					</div>
	
					<div style="font-size: 13px;">
						<ul>
							<li style="text-align:left;width:50%">검색결과: ${dataCount}개 (${page} / ${total_page} 페이지)</li>
							<li style="">&nbsp;</li>
						</ul>
					</div>
					
					<table class="tb_basic tb_hover">
						<tr align="center" height="35"
							style="border-bottom: 1px solid #cccccc; background-color: #efefef;">
							<th width="30">번호</th>
							<th width="200">제목</th>
							<th width="120">회사명</th>
							<th width="60">지원분야</th>
							<th width="30">구분</th>
							<th width="50">등록일</th>
							<th width="30">조회수</th>
						</tr>
	
	<c:forEach var="dto" items="${list}">
						<tr align="center" height="35" style="border-bottom: 1px solid #cccccc;"
							onclick="location.href='${articleUrl}&num=${dto.num}'">
							<td>${dto.listNum}</td>
							<td>${dto.title}</td>
							<td>${dto.companyName}</td>
							<td>${dto.field}</td>
							<td>${dto.gubun}</td>
							<td>${dto.created}</td>
							<td>${dto.hitCount}</td>
						</tr>
	</c:forEach>					
					</table>
	
					<table class="tb_basic">
						<tr height="35">
							<c:if test="${dataCount==0 }">
								<td align="center">
					               	등록된 게시물이 없습니다.
					            </td>
				            </c:if>
						</tr>
					</table>
					<c:if test="${dataCount!=0 }">
						<div class="t_center">${paging}</div>
					</c:if>
					<div class="t_right">
						<button type="button" class="btn_classic btn-black"
							onclick="javascript:location.href='<%=cp%>/pass_board/created.do';">자소서 등록</button>
					</div>
				</div> 
				<!-- //contents -->
			</div>
			<!-- //container -->

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include> 
			<!-- //Footer -->
		</div>
	</div>
	<!-- //Wrap -->
</body>
</html>