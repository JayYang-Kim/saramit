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
	<title>이력서 작성</title>
    <jsp:include page="/WEB-INF/views/layout/import.jsp"></jsp:include>
	<style>
	body{
		background-color: #f5f5f5;
	}
	
	form{
		background-color: #FFFFFF;
	}
	</style>
	
	<script type="text/javascript">
	function sendok(){
		var f=document.resumeForm;
		
		if(! f.name.value) {
			alert("이름을 입력하세요.");
			f.name.focus();
			return;
		}
		
		f.action="<%=cp%>/resume/${mode}_ok.do";
		f.submit();
	}
	</script>
	
	<script type="text/javascript">
		$(function(){
			$("#addLicense").click(function(){
				var div = $(this).closest(".inputBox").find("#licenseInfo div:first").clone(true).wrapAll("<div>").parent().html();
				$(this).closest(".inputBox").find("#licenseInfo").append(div);
				
			});
			$("body").on("click", ".removeLicense", function(){
				if($("#licenseInfo").find("div").length <= 1){
					return;
				}
				$(this).parent().remove();
			});
		});
		

		$(function(){
			$("#addAwards").click(function(){
				var div = $(this).closest(".inputBox").find("#awardsInfo div:first").clone(true).wrapAll("<div>").parent().html();
				$(this).closest(".inputBox").find("#awardsInfo").append(div);
			});
			$("body").on("click", ".removeAwards", function(){
				if($("#awardsInfo").find("div").length <= 1){
					return;
				}
				$(this).parent().remove();
			});
		});
		$(function(){
			$("#addCareer").click(function(){
				var div = $(this).closest(".inputBox").find("#careerInfo div:first").clone(true).wrapAll("<div>").parent().html();
				$(this).closest(".inputBox").find("#careerInfo").append(div);
			});
			$("body").on("click", ".removeCareer", function(){
				if($("#careerInfo").find("div").length <= 1){
					return;
				}
				$(this).parent().remove();
			});
		});
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
          <div align="left" style="width:30%; margin:0 auto;">
          <div>      
          <form name="resumeForm" method="post">
          <br><br>
           <h2>&nbsp;이력서 작성</h2>  
           
           <input type="text" name="title" style="width: 80%; margin:10px 5px 10px; " placeholder="이력서 제목 작성">
           <br> 
           <h3>&nbsp;| 개인 정보</h3>
           <br>
        <div id="personalInfo">	
        		&nbsp;
                <input type="text" name="name" size="10" autofocus value="${dto.userName}">
                &nbsp;
                <input type="text" name="birth" size="10" maxlength="10" value="${dto.birth}">
                &nbsp;
                <label for="gender">성별</label>
                <input type="text" name="gender" size="10" value="${dto.gender}">            
                </div>
                <div>     
                <br>
                &nbsp;
                <input type="text" name="userEmail" size="30" value="${dto.userEmail}">
                <br><br>
                &nbsp;
                <input type="text" name="addr" style="width:80%;" value="${dto.address}">
                <br><br><hr>
		</div>
			
			<h3>&nbsp;| 자격 사항</h3>
			
			<br> 
		
		<div class="inputBox">
			<div id="licenseInfo">
				<div>
					&nbsp;
	                <input type="text" size="10" name="licenseName" placeholder="자격증명">
	                &nbsp;
	                <input type="text" size="10" name="licensePublisher" placeholder="발급처">
	                &nbsp;
	                <span class="datepicker_wrap">
	                <input type="text" class="datepicker"  title="calendar" name="licenseDate" placeholder="취득 날짜">       
	            	</span>
	            	<button class="btn btn-black removeLicense" type="button"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
	                <br><br>
                </div>
           </div>   
            <p align="center">
	         	<button type="button" class="btn btn-black" id="addLicense" style="height: 26px;line-height: 10px;">추가</button>
	        </p>             
           <hr>
        </div>
        	<h3>&nbsp;| 수상 경력</h3>
        	<br> 
	
		<div class="inputBox">
			<div id="awardsInfo">
				<div>
				&nbsp;
                <input type="text" size="10" name="awardsName" placeholder="수상명">
                &nbsp;
                <input type="text" size="10" name="awardspublisher" placeholder="발급처">
                &nbsp;
                <span class="datepicker_wrap">
                <input type="text" class="datepicker"  title="calendar" name="awardsDate" placeholder="수상 날짜">       
            	</span>
            	<button class="btn btn-black removeAwards"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
                <br><br>
                </div>
            </div>              
            <p align="center">
	         	<button type="button" class="btn btn-black" id="addAwards" style="height: 26px;line-height: 10px;">추가</button>
	         </p>
	         <hr>  
		</div>
			<h3>&nbsp;| 학력</h3>
			<br> 
		<div class="inputBox">  
			<div id="educationInfo">           
				&nbsp;
                <label for="educationCode">&nbsp; 최종학력</label>    
                <br>
                &nbsp;
                <select size="1" name="educationCode">         
                    <option value="1">중졸</option>
                    <option value="2">고졸</option>
                    <option value="3">초대졸</option>
                    <option value="4">대졸</option>
                    <option value="5">대학원졸</option>
                </select>
                &nbsp;     		                      
                <input type="text" size="10" id="schoolName" name="schoolName" placeholder="학교명">
                &nbsp;
                <label for="region">지역</label>                
                <select size="1" name="region">
                    <option value="seoul">서울특별시</option>
                    <option value="busan">부산광역시</option>
                    <option value="daegu">대구광역시</option>
                    <option value="incheon">인천광역시</option>
                    <option value="daejeon">대전광역시</option>
                    <option value="gwangju">광주광역시</option>
                    <option value="ulsan">울산광역시</option>
                    <option value="sejong">세종특별자치시</option>
                    <option value="gwangwon">강원도</option>
                    <option value="gyeonggi">경기도</option>
                    <option value="chungcheongbukdo">충청북도</option>
                    <option value="chungcheongnamdo">충청남도</option>
                    <option value="jeonrabukdo">전라북도</option>
                    <option value="jeonranamdo">전라남도</option>
                    <option value="gyeongsangbukdo">경상북도</option>
                    <option value="gyeongsangnamdo">경상남도</option>
                    <option value="jejudo">제주특별자치도</option>
                </select>
                &nbsp;
                <input type="text" size="10" name="major" placeholder="전공/학과명">
                <br><br>
                &emsp;
                <label><input type="checkbox" name="graduate_status" value="재학중">재학중</label>
                &emsp;
                <span class="datepicker_wrap"> 
                <input type="text" class="datepicker"  title="calendar" name="entrance" placeholder="입학일자">
                <input type="text" class="datepicker"  title="calendar" name="graduate" placeholder="졸업일자">
                </span>
                <br><br> 
            </div>
	         <hr>               
		</div>
			<h3>&nbsp;| 경력 사항</h3>
			<br> 
		<div class="inputBox">  
			<div id="careerInfo">
				<div>
					&nbsp;                       
		            <input type="text" size="10" name="copName" placeholder="회사명">
		            &nbsp;
		            <label for="gubun">경력구분</label>
		            <select size="1" name="gubun">
		                <option value="intern">인턴</option>
		                <option value="contract">계약직</option>
		                <option value="regular">정규직</option>
		                <option value="dispatch">파견직</option>
		            </select>
		            <br> 
		         	&nbsp;
		            <input type="text" size="10" name="position" placeholder="직위">
		            &nbsp;
		            <input type="text" size="10" name="task" placeholder="업무내용">
		            <span class="datepicker_wrap">
		                <input type="text" class="datepicker"  title="calendar" name="carrerjoinDate" placeholder="입사일자">
		                <input type="text" class="datepicker"  title="calendar" name="carrerresignDate" placeholder="퇴사일자">
		            </span>
		            <button class="btn btn-black removeCareer"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
		            <br>
		            <br>
	            </div>
	          </div>
	            <p align="center">
	         	<button type="button" class="btn btn-black" id="addCareer" style="height: 26px;line-height: 5px;">추가</button>
	         	</p>
	         </div>
	         <hr>
         <div>
         &nbsp;
           <a href="javascript:sendok()" class="btn_classic btn-black mt20">작성완료</a>
            <br><br>
         </div>
         </form>        
            </div>             
            </div>           
                </div>
            </div>
            <!-- //contents -->        
        <!-- //container -->
        <!-- Footer -->
       	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <!-- //Footer -->
    <!-- //Wrap -->
    </div>
</body>
</html>