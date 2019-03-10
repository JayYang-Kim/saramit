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
    	function sendBoard() {
    		var f = document.boardForm;
    		
    		var str = f.title.value;
    		if(!str) {
    			alert("제목을 입력하세요.");
    			f.title.focus();
    			return;
    		}
    		
    		var str = f.companyName.value;
    		if(!str) {
    			alert("회사명을 입력하세요.");
    			f.companyName.focus();
    			return;
    		}
    		
    		var str = f.field.value;
    		if(!str) {
    			alert("지원분야를 입력하세요.");
    			f.field.focus();
    			return;
    		}
    		
    		var str = f.content.value;
    		if(!str) {
    			alert("내용을 입력하세요.");
    			f.content.focus();
    			return;
    		}
    		
    		var mode="${mode}";
    		if(mode=="created")
    			f.action="<%=cp%>/pass_board/created_ok.do";
    		else if(mode=="update")
    			f.action="<%=cp%>/pass_board/update_ok.do";
    			
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
            <div style="height:61px"></div>
            <!-- contents -->
            <div class="contents">
                <div class="inner">
                   <div class="body_title" style="width: 100%; margin: 20px auto; font-size: 20px;">
					<h3>합격자소서 등록</h3>
					</div>
					
				<div>
					<form name="boardForm" method="post">
		  			<table class="tb_basic" style="margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  			<tr align="left" height="60" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      			<td width="100" bgcolor="#eeeeee" style="text-align: center;">제목</td>
			      			<td style="padding-left:10px;"> 
			        		<input type="text" name="title" maxlength="100" class="boxTF" style="width: 90%; height: 30px;" value="${dto.title}">
			      			</td>
			 		 	</tr>
			
			  			<tr align="left" height="60" style="border-bottom: 1px solid #cccccc;"> 
			      			<td bgcolor="#eeeeee" style="width:150px; text-align: center;">입력사항</td>
			      			<td style="padding-left:10px;">
			      			<div style="text-align: left; margin-left: 50px">
			            	<p>회사명 : <input type="text" name="companyName" class="boxTF mt5 mb5" style="margin-left:20px; width:300px; height: 30px;" placeholder="ex) (주)사람잇"></p>
			            	<span>지원분야 : <input type="text" name="field" class="boxTF mt5 mb5 ml10" style="width:250px; height: 30px;" placeholder="ex) 웹개발, MD, 영업 등"></span>
			            	<span style="margin-left: 160px">구분 : <select name="selectGubun" style="width:100px; height: 30px; margin-left:10px">
			            			<option value="new">신입</option>
			            			<option value="career">경력</option>
			            			</select>
			            	</span>
			            	</div>
			      			</td>
			  			</tr>
			
			  			<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      			<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:20px;" valign="top">내용</td>
			      			<td valign="top" style="padding:5px 0px 5px 10px;"> 
			        		<textarea name="content" rows="30" class="boxTA mt10 mb10" style="width: 90%; height:500px;  padding-top:10px; ">${dto.content}</textarea>
			      			</td>
			  			</tr>
			  		</table>
			
			  <table style="width: 100%; margin: 20px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center">
			        <button type="button" class="btn_classic btn-black mr5" onclick="sendBoard();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn_classic btn-white mr5">다시입력</button>
			        <button type="button" class="btn_classic btn-white mb20" onclick="javascript:location.href='<%=cp%>/pass_board/list.do';">${mode=='update'?'수정취소':'등록취소'}</button>
			         <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="num" value="${dto.num}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
			</form>
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