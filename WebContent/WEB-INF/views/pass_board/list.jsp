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
	/* border: 1 solid# */
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
                		<h3>합격자소서 보기</h3>
                	</div>
					
					<div>
						<div class="f_left mt20 mb20">
	                  		<span>검색결과: ${dataCount}개(${page} / ${total_page} 페이지)</span>
	                  	</div>
	                  	<div class="searchBox">
	               			<form name="searchForm" action="<%=cp%>/pass_board/list.do" method="post">
	               				<select name="searchKey">
	                  				<option value="companyName">회사명</option>
									<option value="field">지원분야</option>
	                  			</select>
	               				<input type="text" name="searchValue" title="검색내용"/>
	               				<button type="button" class="btn btn-black" onclick="searchList()">검색</button>
	               			</form>
	                	</div>
					
						<table class="tb_kakao big tb_hover">
							<colgroup>
								<col style="width:30px">
								<col style="width:150px">
								<col style="width:100px">
								<col style="width:80px">
								<col style="width:60px">
								<col style="width:80px">
								<col style="width:30px">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>회사이름</th>
									<th>지원분야</th>
									<th>구분</th>
									<th>등록일</th>
									<th>조회수</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="dto" items="${list}">
									<tr onclick="location.href='${articleUrl}&num=${dto.num}'">
										<td>${dto.listNum}</td>
										<td>${dto.title}</td>
										<td>${dto.companyName}</td>
										<td>${dto.field}</td>
										<td>${dto.gubun}</td>
										<td>${dto.created}</td>
										<td>${dto.hitCount}</td>
									</tr>
								</c:forEach>
								<c:if test="${dataCount==0 }">
									<td colspan="7">등록된 게시물이 없습니다.
						            </td>
					            </c:if>
							</tbody>		
						</table>
					</div>
	
				
					<div class="t_center m20 mb20">
	                    <c:if test="${dataCount != 0}">
	                    	${paging}
	                    </c:if>
	                </div>
	
					<div class="t_right mb20">
						<button type="button" class="btn_classic btn-black" onclick="javascript:location.href='<%=cp%>/pass_board/created.do';">자소서 등록</button>
					</div>
				</div> 
				<!-- //inner -->
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