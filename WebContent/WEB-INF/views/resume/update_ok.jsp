<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% 
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
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
    <!-- Wrap -->
    <div id="wrap" class="tb_wrap">
        <!-- Header -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
        <!-- //Header -->
        <!-- container -->
        <div id="container" class="tb_container">
            <div style="height:61px"></div>
            <!-- contents -->
            <div class="contents">
                <div align="center" style="width:30%; margin:0 auto;">
          <div>      
          <form name="update_okForm" method="post">
          <br><br><br><br><br>
           <h1>&nbsp; 이력서 수정이 완료되었습니다.</h1> 
           <br><br><br><br><br><br>
           <h2>&nbsp; 수정한 이력서 제목<br>
           <input type="text" name="update_ok_title" style="width: 50%; margin:10px 5px 10px;" value="${dto_resume.title}" disabled="disabled">
           </h2>  
           <br><br><br><br><br><br>
           <a href="<%=cp%>/" class="btn_classic btn-black mt20">홈 메뉴 이동</a>
           &nbsp;
           <a href="<%=cp%>/resume/created.do" class="btn_classic btn-black mt20">다른 이력서 작성</a>
		   &nbsp;
           <a href="<%=cp%>/resume/list.do" class="btn_classic btn-black mt20">이력서 관리메뉴 이동</a>
           <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
            <!-- //contents -->        
        
        <!-- //container -->
        </form>
 				</div>  
       		</div>   
       			 </div>           
       			
        <!-- Footer -->
       	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <!-- //Footer -->
   		 </div>            
       			</div>
                     
            
            
            
    <!-- //Wrap -->

</body>
</html>