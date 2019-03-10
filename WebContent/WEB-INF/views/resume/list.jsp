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
                <div align="left" style="width:30%; margin:0 auto;">
          <div>
          <form> 
           <h2>&nbsp; 이력서 관리</h2>   
           <br><br>  
           <table border="1">
           <tr>
           	<td>
         		<div>이력서 번호</div>
         	</td>
			<td>
         		<div>이력서 제목</div>
         	</td>
           	<td>
         		<div>작성일자</div>
         	</td>         	      
         </tr>
         <tr>
         	<td>
         		<div>1</div>
         	</td>
         	<td>
         		<div>2</div>
         	</td>
         	<td>
         		<div>3</div>
         	</td>         	         	
         </tr>
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