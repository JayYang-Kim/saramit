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
    	function search(){
    		var form = document.searchForm;
    		if(!form.searchValue.value){
    			alert("검색어를 입력해주세요!");
    			return;
    		}
    		form.action ="<%=cp%>/companies/list.do";
    		form.submit();
    	}
    	
    	function openInfo(email){
    		var cEmail = email;
    		cEmail = encodeURIComponent(cEmail);
    		window.open("<%=cp%>/companies/info.do?email="+cEmail);
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
       			<div class="companyList list">
       				<div class="inner">
       					<div class="list">
       						<h3>| 기업 검색</h3>
       						<div align="center">
	       						<form name="searchForm">
		       						<select name="searchKey">
		       							<option value="companyname">기업명</option>
		       							<option value="owner">대표이름</option>
		       							<option value="location">지역</option>
		       						</select>
		       						<input type="text" name="searchValue"/>
		       						<button type="button" class="btn btn-darkGray" style="height: 26px" onclick="search();">검 색</button>
	       						</form>
       						</div>
       						<br>
       						<c:forEach var="n" items="${companies}" varStatus="status">
									${status.index==0?"<ul style='margin-top : 10px;'>":""}
										<c:if test="${status.index != 0 && status.index%4==0}">
											<c:out value="</ul><ul style='margin-top : 10px;'>" escapeXml="false"/>
										</c:if>
		       							<li class="item"> <!-- 하나 하나의 박스 -->
		       								<div class="bg">
		       									<div class="color">
		       										<img src="<%=cp%>/resources/images/common/${n.originalfilename}" width="100%" alt="로고"/>
		       									</div>
		       									<span style="display:inline-block; font-size: 20px; width:90%;">${n.companyName}</span>
		       								</div>
		       								<ul>
		       									<li><span>사원수 : ${n.employees}</span></li>
		       									<li><span>매출액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${n.sale}"/>(원)</span></li>
		       									<li><span>평균연봉 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${n.salary}"/>(원)</span></li>
		       									<li><span>위치 : ${n.location}</span></li>
		       								</ul>
		       								<div class="extra">
		       									<div class="site">
		       										<span>${n.homepage}</span>
		       									</div>
		       									<a style="cursor: pointer;" onclick="openInfo('${n.companyEmail}');">더보기</a>
		       								</div>
		       							</li> 					
       						</c:forEach>
       						<c:out value="</ul>" escapeXml="false"/>
       						<div style="padding-top:10px;text-align: center;">${paging}</div> 
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