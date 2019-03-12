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
	<style>
	body{
		background-color: #f5f5f5;
	}
	form{
		background-color: #FFFFFF;
		min-height: 700px;
		margin-top: 40px;
	}
	
	</style>
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
	          <div align="center" style="min-height:750px; width:40%; margin:0 auto;">
	          <div>
	          <form> 
	          <br><br>
	           <h2 style="margin-top: 40px">&nbsp; 이력서 관리</h2>   
	           <br><br>  
	           <table  style="width: 750px; margin: 0px auto; border-spacing: 0px; border-collapse: collapse; text-align: center;">
	           	<tr align="center" bgcolor="#eeeeee" height="35px" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc">
	      		<th width="100px" style="color: #787878;">글 번호</th>
	      		<th style="color: #787878;">제목</th>
			      <th width="150px" style="color: #787878;">작성일자</th>
			      <th width="200px" style="color: #787878;">기능</th>
			  	</tr>        		  		
	  		<c:forEach var="dto" items="${list}">
	  			<tr height="35px" style="border-bottom: 1px solid #e4e4e4;">
	       		<td >${dto.listNum}</td>
	         		<td><a href="<%=cp%>/resume/view.do?resumeCode=${dto.resumeCode}">${dto.title}</a></td>
	         		<td>${dto.created}</td>
	         		<td>
	         			<button class="btn btn-white" type="button" style="width: 95px; height: 35px;" onclick="location.href=delete.jsp">삭제</button>
	         		</td>
	         	</tr>
	         </c:forEach>
	         	
	       </table>
	         <div align="center" style="margin-top: 15px;"><p>${paging}</p></div>
	         <br>
	             <a href="<%=cp%>/resume/created.do" class="btn_classic btn-black mt20">이력서 작성</a>
	          </form>  
	          </div>
	         <br><br> 
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