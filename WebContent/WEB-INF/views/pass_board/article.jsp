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
	<%-- function deleteBoard(num) {
		var page = "${page}";
		var query = "num="+num+"&page="+page;
		var url = "<%=cp%>/pass_board/delete.do?" + query;
		
		
	} --%>
	
	function updateBoard(num) {
<c:if test="${sessionScope.member.userEmail==dto.userEmail}">
	var page="${page}";
	var query="num="+num+"&page="+page;
	var url="<%=cp%>/pass_board/update.do?" + query;
	
	location.href=url;
</c:if>

<c:if test="${sessionScope.member.userEmail!=dto.userEmail}">
	alert("게시물 수정 권한이 없습니다.");
</c:if>
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
            	<div class="inner">
                  <div>
                   <div class="body_title" style="margin: 20px auto; font-size: 20px;">
					<h3>합격자소서</h3>
					</div>
					
			<div>
			<table style="width: 800px; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="4" align="center">
				   ${dto.title}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="100px" bgcolor="#eeeeee" style="text-align: center;">회사명</td>
			    <td width="200px" align="left" style="padding-left: 5px;">
			      	${dto.companyName}
			    </td>
			    <td width="50px" bgcolor="#eeeeee" style="text-align: center;">작성일</td>
			    <td width="100px" align="left" style="padding-left: 5px;">
			        ${dto.created}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="20px" bgcolor="#eeeeee" style="text-align: center;">지원분야</td>
			    <td width="100px" align="left" style="padding-left: 5px;">
			      	${dto.field}
			    </td>
			    <td width="50px" bgcolor="#eeeeee" style="text-align: center;">구분</td>
			    <td width="100px" align="left" style="padding-left: 5px;">
			        ${dto.gubun}
			    </td>
			</tr>
			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="4" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
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
			        <button type="button" class="btn_classic btn-black" onclick="javascript:location.href='<%=cp%>/pass_board/list.do?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
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