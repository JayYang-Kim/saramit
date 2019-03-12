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
<style type="text/css">
.star {
	font-size: 0;
	letter-spacing: -4px;
}

.star a {
	font-size: 50px;
	letter-spacing: 0;
	display: inline-block;
	margin-left: 3px;
	color: #cccccc;
	text-decoration: none;
}

.star a:first-child {
	margin-left: 0;
}

.star a.on {
	color: #F2CB61;
}
</style>

<c:if test="${sessionScope.member.email == dto.userEmail || sessionScope.member.email == 'admin'}">
<script type="text/javascript">
function deleteReview() {
	if(confirm("평가 게시물을 삭제 하시겠습니까 ?")) {
		var url="<%=cp%>/companies/reviewDelete.do?boardNum=${dto.boardNum}&page=${page}";
		location.href=url;
	}
}
</script>
</c:if>

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
	                	<h3>${dto.cop_name}</h3>
	            	</div>
					<div class="mt15 mb15">
						<table class="tb_kakao_row big">
							<colgroup>
								<col style="width:30%">
								<col style="width:70%">
							</colgroup>
							<tr>
								<th>기업 총 평점</th>
								<td style="height:100px;vertical-align:top;">
								<p class="star">
									<c:forEach var="dto" begin="1" end="${dto.star}">
										<a class="on" href="#">★</a> 
									</c:forEach>
									<c:forEach var="dto" begin="1" end="${5-dto.star}">
										<a href="#">★</a> 
									</c:forEach>
								</p>
								</td>
							</tr>
							<tr>
								<th>기업한줄평</th>
								<td style="height:200px;vertical-align:top;">${dto.content1}</td>
							</tr>
							<tr>
								<th>기업의 장점</th>
								<td style="height:200px;vertical-align:top;">${dto.content2}</td>
							</tr>
							<tr>
								<th>기업의 단점</th>
								<td style="height:200px;vertical-align:top;">${dto.content3}</td>
							</tr>
							<tr>
								<th>경영진에 바라는 점</th>
								<td style="height:230px;vertical-align:top;">${dto.content4}</td>
							</tr>
						
						</table>
						
						<div class="f_right mt20 mb20">
						<form action="<%=cp%>/companies/reviewUp.do?boardNum=${dto.boardNum}&page=${page}" method="post">
							<button type="button" class="btn_classic btn-black" onclick="javascript:location.href='<%=cp%>/companies/listReview.do?${query}';">목록보기</button>
			       			&nbsp;
			       			<c:if test="${sessionScope.member.email == dto.userEmail}">	
                   				<input type="hidden" name="email" value="${dto.companyEmail}">
	                   			<button class="btn_classic btn-white mr5">수정하기</button>
			       			</c:if>
			       			<c:if test="${sessionScope.member.email == dto.userEmail || sessionScope.member.email == 'admin'}">	
	                   			<button type="button" class="btn_classic btn-red" onclick="deleteReview();">삭제하기</button>
			       			</c:if>
			       			
								
						</form>
						</div>
							

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