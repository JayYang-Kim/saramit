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
                <div align="center" style="width:30%; margin:0 auto;">
          <div>
          <form> 
           <h2>&nbsp; 이력서 관리</h2>   
           <br><br>  
           <table  style="width: 700px; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
           	<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc">
      		<th width="60" style="color: #787878;">글 번호</th>
      		<th style="color: #787878;">제목</th>
		      <th width="80" style="color: #787878;">작성일자</th>
		  	</tr>           		
           	<c:forEach var="dto" items="${list}">
           	<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #ffffff;">
          		<td>${dto.userEmail}</td>        	
 				<td align="left" style="padding-left: 10px;">         	        
            </td>
            <tr>             
	 			<td>글번호</td>
	 			<td>제목</td>
	 			<td>작성일자</td>
 			</tr>
  			<tr>
         		<td>${dto.resumeCode}</td>
         		<td>${dto.title}</td>
         		<td>${dto.created}</td>
         	</tr>
        	
 	
         </c:forEach>	
       </table>
         <br><br>
             
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