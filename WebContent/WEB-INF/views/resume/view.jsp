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
	<title>이력서 상세보기</title>
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
		$(".basicChange").click(function(){
			$(this).attr("disabled","disabled");
			$(".updateBasic").css("display","block");
			$("#title").attr("disabled",false);
			$("#addr").attr("disabled",false);
		});
		$(".updateBasic").click(function(){
			             
			var sort = "basic";
			var addr = $("#addr").val();
			var title = $("#title").val();

			var query = "sort="+sort+"&resumeCode=${resumeCode}&addr="+encodeURIComponent(addr)+"&title="+encodeURIComponent(title);
			var url = "<%=cp%>/resume/addInfo.do";
			var button = $(this);
			if(!title || !addr){
				alert("인적사항을 모두 입력하세요!");
				return;
			}
			$.ajax({
				type:"post",
				data:query,
				url:url,
				dataType:"json",
				success:function(data){
					if(data.basic_dto == null){
						alert("삽입 실패하였습니다.");
						return;
					}
					$("#addr").val(data.basic_dto.addr);
					$("#title").val(data.basic_dto.title);
					alert("저장되었습니다.");
					$("#addr").attr("disabled","disabled");
					$("#title").attr("disabled","disabled");
					$(".basicChange").attr("disabled",false);
					button.css("display","none");
				},
				error:function(e){
					console.log(e.responseText)
				}
			});
		});
	});
	
	
		$(function(){
			$(".educationChange").click(function(){
				$(this).attr("disabled","disabled");
				$(".updateEducation").css("display","block");
				$("#schoolName").attr("disabled",false);
				$("#graduate_status").attr("disabled",false);
				$("#entrance").attr("disabled",false);
				$("#graduate").attr("disabled",false);
				$("#major").attr("disabled",false);
				$("#educationCode").attr("disabled",false);
				$("#region").attr("disabled",false);
			});
			$(".updateEducation").click(function(){
				             
				var sort = "education";
				var gubun = $(this).parent().find("#educationCode").val();
				var schoolName = $(this).parent().find("#schoolName").val();
				var region = $(this).parent().find("#region").val();
				var major = $(this).parent().find("#major").val();
				var graduate_status = null;
				if($(this).parent().find("#graduate_status").prop("checked")){
					graduate_status = "재학중";
				}
				var entrance = $(this).parent().find("#entrance").val();
				var graduate = $(this).parent().find("#graduate").val();
				
				//alert(gubun+","+schoolName+","+region+","+major+","+graduate_status+","+entrance+","+graduate);
				var query = "resumeCode=${resumeCode}&sort="+sort+"&gubun="+encodeURIComponent(gubun)+"&schoolName="+encodeURIComponent(schoolName)+"&region="+encodeURIComponent(region);
				query += "&major="+encodeURIComponent(major)+"&graduate_status="+encodeURIComponent(graduate_status)+"&entrance="+encodeURIComponent(entrance)+"&graduate="+encodeURIComponent(graduate);
				var url = "<%=cp%>/resume/addInfo.do";
				var button = $(this);
				if(!schoolName || !major || !graduate || !entrance){
					alert("정보를 모두 입력하세요!");
					return;
				}
				$.ajax({
					type:"post",
					data:query,
					url:url,
					dataType:"json",
					success:function(data){
						if(data.education_dto == null){
							alert("삽입 실패하였습니다.");
							return;
						}
						console.log(data.education_dto);
						$("#schoolName").val(data.education_dto.schoolName);
						$("#graduate_status").prop("checked",false);
						if(data.education_dto.graduate_status!= null){
							$("#graduate_status").prop("checked","checked");
						}
						alert(data.education_dto.entrance);
						$("#entrance").val(data.education_dto.entrance);
						$("#graduate").val(data.education_dto.graduate);
						$("#major").val(data.education_dto.major);
						$("#educationCode").val(data.education_dto.gubun).attr("selected","selected");
						$("#region").val(data.education_dto.region).attr("selected","selected");
						alert("저장되었습니다.");
						$("#schoolName").attr("disabled","disabled");
						$("#graduate_status").attr("disabled","disabled");
						$("#entrance").attr("disabled","disabled");
						$("#graduate").attr("disabled","disabled");
						$("#major").attr("disabled","disabled");
						$("#educationCode").attr("disabled","disabled");
						$(".educationChange").attr("disabled",false);
						$("#region").attr("disabled","disabled");
						button.css("display","none");
					},
					error:function(e){
						console.log(e.responseText)
					}
				});
			});
		});
	
		$(function(){
			$("#addLicense").click(function(){
				var div = $(this).closest(".inputBox").find("#licenseInfo div:first").clone(true).css("display","block");
				div = div.wrapAll("<div>").parent().html();
				$(this).closest(".inputBox").find("#licenseInfo").append(div);
				
			});
			$("body").on("click", ".removeLicense", function(){
				
				if($("#licenseInfo").find("div").length <= 1){
					return;
				}
				if(!$(this).parent().find("input[type=hidden]:first").val()){
					button.parent().remove();
				}
				var sort = "license";
				var licenseCode = $(this).parent().find("input[type=hidden]").val();
				var query = "licenseCode="+licenseCode+"&sort="+sort;
				var url = "<%=cp%>/resume/removeInfo.do";
				var button = $(this);
				$.ajax({
					type:"post",
					data:query,
					url:url,
					dataType:"json",
					success:function(data){
						if(!data.flag){
							alert("삭제에 실패하였습니다.");
							return;
						}
						alert("삭제 완료되었습니다.");
						button.parent().remove();
					},
					error:function(e){
						console.log(e.responseText)
					}
				});
				
				
				
			});
			$("body").on("click",".addLicense", function(){
				var sort = "license";
				var licenseName = $(this).parent().find("input[name=licenseName]").val();
				var licensePublisher = $(this).parent().find("input[name=licensePublisher]").val();
				var licenseDate = $(this).parent().find("input[name=licenseDate]").val();
				var query = "resumeCode=${resumeCode}&sort="+sort+"&licenseName="+encodeURIComponent(licenseName)+"&licensePublisher="+encodeURIComponent(licensePublisher)+"&licenseDate="+encodeURIComponent(licenseDate);
				var url = "<%=cp%>/resume/addInfo.do";
				var button = $(this);
				if(!licenseName || !licensePublisher || !licenseDate){
					alert("정보를 모두 입력하세요!");
					return;
				}
				$.ajax({
					type:"post",
					data:query,
					url:url,
					dataType:"json",
					success:function(data){
						if(data.dto == null){
							alert("삽입 실패하였습니다.");
							return;
						}
						button.parent().find("input[type=hidden]").val(data.dto.licenseCode);
						button.parent().find("input[name=licenseName]").prop("disabled","disabled");
						button.parent().find("input[name=licenseName]").val(data.dto.license_name);
						button.parent().find("input[name=licensePublisher]").prop("disabled","disabled");
						button.parent().find("input[name=licensePublisher]").val(data.dto.license_publisher);
						button.parent().find("input[name=licenseDate]").prop("disabled","disabled");
						button.parent().find("input[name=licenseDate]").val(data.dto.license_date);
						button.parent().find("input[name=licenseDate]").css("width","100px");
						button.remove();
					},
					error:function(e){
						console.log(e.responseText)
					}
				});
				
			});
		});
		

		$(function(){
			$("#addAwards").click(function(){
				var div = $(this).closest(".inputBox").find("#awardsInfo div:first").clone(true).css("display","block").wrapAll("<div>").parent().html();
				$(this).closest(".inputBox").find("#awardsInfo").append(div);
			});
			$("body").on("click", ".removeAwards", function(){
				if($("#awardsInfo").find("div").length <= 1){
					return;
				}
				if(!$(this).parent().find("input[type=hidden]:first").val()){
					button.parent().remove();
				}
				var sort = "awards";
				var awardsCode = $(this).parent().find("input[type=hidden]").val();
				var query = "awardsCode="+awardsCode+"&sort="+sort;
				var url = "<%=cp%>/resume/removeInfo.do";
				var button = $(this);
				$.ajax({
					type:"post",
					data:query,
					url:url,
					dataType:"json",
					success:function(data){
						if(!data.flag){
							alert("삭제에 실패하였습니다.");
							return;
						}
						alert("삭제 완료되었습니다.");
						button.parent().remove();
					},
					error:function(e){
						console.log(e.responseText)
					}
				});
			});
			$("body").on("click",".addAwards", function(){
				var sort = "awards";
				var awardsName = $(this).parent().find("input[name=awardsName]").val();
				var awardsPublisher = $(this).parent().find("input[name=awardsPublisher]").val();
				var awardsDate = $(this).parent().find("input[name=awardsDate]").val();
				var query = "resumeCode=${resumeCode}&sort="+sort+"&awardsName="+encodeURIComponent(awardsName)+"&awardsPublisher="+encodeURIComponent(awardsPublisher)+"&awardsDate="+encodeURIComponent(awardsDate);
				var url = "<%=cp%>/resume/addInfo.do";
				var button = $(this);
				if(!awardsName || !awardsPublisher || !awardsDate){
					alert("정보를 모두 입력하세요!");
					return;
				}
				
				$.ajax({
					type:"post",
					data:query,
					url:url,
					dataType:"json",
					success:function(data){
						if(data.awards_dto == null){
							alert("삽입 실패하였습니다.");
							return;
						}
						button.parent().find("input[type=hidden]").val(data.awards_dto.awardsCode);
						button.parent().find("input[name=awardsName]").prop("disabled","disabled");
						button.parent().find("input[name=awardsName]").val(data.awards_dto.awardsName);
						button.parent().find("input[name=awardsPublisher]").prop("disabled","disabled");
						button.parent().find("input[name=awardsPublisher]").val(data.awards_dto.awards_publisher);
						button.parent().find("input[name=awardsDate]").prop("disabled","disabled");
						button.parent().find("input[name=awardsDate]").val(data.awards_dto.awards_date);
						button.parent().find("input[name=awardsDate]").css("width","100px");
						button.remove();
					},
					error:function(e){
						console.log(e.responseText)
					}
				});
				
			});
		});
		$(function(){
			$("#addCareer").click(function(){
				var div = $(this).closest(".inputBox").find("#careerInfo div:first").clone(true).css("display","block").wrapAll("<div>").parent().html();
				$(this).closest(".inputBox").find("#careerInfo").append(div);
			});
			$("body").on("click", ".removeCareer", function(){
				if($("#careerInfo").find("div").length <= 1){
					return;
				}
				if(!$(this).parent().find("input[type=hidden]:first").val()){
					button.parent().remove();
				}
				var sort = "career";
				var careerCode = $(this).parent().find("input[type=hidden]").val();
				var query = "careerCode="+careerCode+"&sort="+sort;
				var url = "<%=cp%>/resume/removeInfo.do";
				var button = $(this);
				$.ajax({
					type:"post",
					data:query,
					url:url,
					dataType:"json",
					success:function(data){
						if(!data.flag){
							alert("삭제에 실패하였습니다.");
							return;
						}
						alert("삭제 완료되었습니다.");
						button.parent().remove();
					},
					error:function(e){
						console.log(e.responseText)
					}
				});	
			});
			$("body").on("click",".addCareer", function(){
				     
				var sort = "career";
				var copName = $(this).parent().find("input[name=copName]").val();
				var gubun = $(this).parent().find("select:first").val();
				var position = $(this).parent().find("input[name=position]").val();
				var task = $(this).parent().find("input[name=task]").val();
				var carrerjoinDate = $(this).parent().find("input[name=carrerjoinDate]").val();
				var carrerresignDate = $(this).parent().find("input[name=carrerresignDate]").val();
				
			 	var query = "resumeCode=${resumeCode}&sort="+sort+"&copName="+encodeURIComponent(copName)+"&gubun="+encodeURIComponent(gubun)+"&position="+encodeURIComponent(position);
			 	query += "&task="+encodeURIComponent(task)+"&carrerjoinDate="+encodeURIComponent(carrerjoinDate)+"&carrerresignDate="+encodeURIComponent(carrerresignDate);
				var url = "<%=cp%>/resume/addInfo.do";
				var button = $(this);
				if(!copName || !position || !task || !carrerjoinDate ||!carrerresignDate){
					alert("정보를 모두 입력하세요!");
					return;
				}
				$.ajax({
					type:"post",
					data:query,
					url:url,
					dataType:"json",
					success:function(data){
						if(data.career_dto == null){
							alert("삽입 실패하였습니다.");
							return;
						}
						button.parent().find("input[type=hidden]").val(data.career_dto.careerCode);
						button.parent().find("input[name=copName]").prop("disabled","disabled");
						button.parent().find("select:first").val(data.career_dto.gubun).prop("selected","selected");
						button.parent().find("select:first").attr("disabled","disabled");
						button.parent().find("input[name=position]").prop("disabled","disabled");
						button.parent().find("input[name=position]").val(data.career_dto.position);
						button.parent().find("input[name=task]").prop("disabled","disabled");
						button.parent().find("input[name=task]").val(data.career_dto.task);
						button.parent().find("input[name=carrerjoinDate]").prop("disabled","disabled");
						button.parent().find("input[name=carrerjoinDate]").val(data.career_dto.joinDate);
						button.parent().find("input[name=carrerresignDate]").prop("disabled","disabled");
						button.parent().find("input[name=carrerresignDate]").val(data.career_dto.resignDate);
						button.remove();
					},
					error:function(e){
						console.log(e.responseText)
					}
				});
				
			});
		});
		
		$(function(){
			$("#educationCode").val("${dto_edu.gubun}").attr("selected","selected");
			$("#region").val("${dto_edu.region}").attr("selected","selected");
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
          <div align="left" style="width:65%; margin:0 auto;">
          <div>      
          <form name="resumeForm" method="post">
          <br><br>
           <h2>&nbsp;이력서 작성</h2>  
           
           <input type="text" id="title" name="title" style="width: 50%; margin:10px 5px 10px;" value="${dto_resume.title}" disabled="disabled" >
           <br> 
           <h3>&nbsp;| 개인 정보</h3>
           <br>
        <div id="personalInfo">	
        		&nbsp;
                <input type="text" name="name" style="width:30%;" autofocus value="${dto_resume.name}" disabled="disabled">
                &nbsp;
                <input type="text" name="birth" style="width:30%;" maxlength="10" value="${dto_resume.birth}" disabled="disabled">
                &nbsp;
                <label for="gender">성별</label>
                <input type="text" name="gender" size="10" value="${dto_resume.gender}" disabled="disabled">            
                </div>
                <div>     
                <br>
                &nbsp;
                <input type="text" name="userEmail" size="30" value="${sessionScope.member.email}" disabled="disabled">
                <br><br>
                &nbsp;
                <input type="text" id="addr" name="addr" style="width:80%;" value="${dto_resume.addr}" disabled="disabled">               
                <br><br>
                <button class="btn btn-black basicChange" type="button" style="float:right; margin-right:10px; height: 26px; line-height: 10px;">변경</button>
                <button class="btn btn-black updateBasic" type="button"  style="float:right; margin-right:10px; height: 26px; line-height: 10px; display: none">저장</button>
                <br><br>
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
                <select size="1" name="educationCode" id="educationCode" disabled="disabled">         
                    <option value="1">중졸</option>
                    <option value="2">고졸</option>
                    <option value="3">초대졸</option>
                    <option value="4">대졸</option>
                    <option value="5">대학원졸</option>
                </select>
                &nbsp;     		
                <input type="text" size="10" id="schoolName" name="schoolName" placeholder="학교명" value="${dto_edu.schoolName}" disabled="disabled">
                &nbsp;
                <label for="region">지역</label>                
                <select size="1" name="region" id="region" disabled="disabled">
                    <option value="1">서울특별시</option>
                    <option value="2">부산광역시</option>
                    <option value="3">대구광역시</option>
                    <option value="4">인천광역시</option>
                    <option value="5">대전광역시</option>
                    <option value="6">광주광역시</option>
                    <option value="7">울산광역시</option>
                    <option value="8">세종특별자치시</option>
                    <option value="9">강원도</option>
                    <option value="10">경기도</option>
                    <option value="11">충청북도</option>
                    <option value="12">충청남도</option>
                    <option value="13">전라북도</option>
                    <option value="14">전라남도</option>
                    <option value="15">경상북도</option>
                    <option value="16">경상남도</option>
                    <option value="17">제주특별자치도</option>
                </select>
                &nbsp;
                <input type="text" size="10" id="major" name="major" placeholder="전공/학과명" value="${dto_edu.major}" disabled="disabled">
                <br><br>
                &emsp;
                <label><input type="checkbox" id="graduate_status" name="graduate_status" placeholder="재학중" value=${dto_edu.graduate_status!=null?"checked='checked'":""} disabled="disabled">재학중</label>
                &emsp;
                <input type="text" title="calendar" id="entrance" name="entrance" placeholder="입학일자" value="${dto_edu.entrance}" style="width:100px;" disabled="disabled">
                <input type="text" title="calendar" id="graduate" name="graduate" placeholder="졸업일자" value="${dto_edu.graduate}" style="width:100px;" disabled="disabled">
                <button class="btn btn-black educationChange" type="button" style="float:right; margin-right:10px; height: 26px; line-height: 10px;">변경</button>
                <button class="btn btn-black updateEducation" type="button"  style="float:right; margin-right:10px; height: 26px; line-height: 10px; display: none">저장</button>
                <br><br> 
            </div>
	         <hr>               	
			<h3>&nbsp;| 자격 사항</h3>
			
			<br> 
		
		<div class="inputBox">
			<div id="licenseInfo">
				<div style="display:none;">
					<input type="hidden" name="licenseCode">
					&nbsp;
	                <input type="text" size="10" name="licenseName" placeholder="자격증명">
	                &nbsp;
	                <input type="text" size="10" name="licensePublisher" placeholder="발급처">
	                &nbsp;
	                <input type="text" name="licenseDate" placeholder="취득 날짜"  style="width:100px;">    
	            	<button class="btn btn-black removeLicense" type="button"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
	            	<button class="btn btn-black addLicense" type="button"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">추가완료</button>
	                <br><br>
                </div>
				<c:forEach var="dto" items="${licenseList}">
				<div>
					<input type="hidden" name="licenseCode" value="${dto.licenseCode}">
					&nbsp;
	                <input type="text" size="10" name="licenseName" placeholder="자격증명" value="${dto.license_name}" disabled="disabled">
	                &nbsp;
	                <input type="text" size="10" name="licensePublisher" placeholder="발급처" value="${dto.license_publisher}" disabled="disabled">
	                &nbsp;
	                <span class="datepicker_wrap">
	                <input type="text" title="calendar" name="licenseDate" placeholder="취득 날짜" value="${dto.license_date}"  style="width:100px;" disabled="disabled">
	            	</span>
	            	<button class="btn btn-black removeLicense" type="button"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
	                <br><br>
                </div>
                </c:forEach>
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
				<div style="display:none;">
					<input type="hidden" name="awardsCode">
						&nbsp;
		                <input type="text" size="10" name="awardsName" placeholder="수상명">
		                &nbsp;
		                <input type="text" size="10" name="awardsPublisher" placeholder="발급처">
		                &nbsp;
		                <input type="text" name="awardsDate" placeholder="수상 날짜" style="width:100px;">       
		            	<button class="btn btn-black removeAwards"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
		            	<button class="btn btn-black addAwards" type="button"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">추가완료</button>
		                <br><br>
	            </div>
				<c:forEach var="dto" items="${awardList}">
					<div>
						<input type="hidden" name="awardsCode" value="${dto.awardsCode}">
						&nbsp;
		                <input type="text" size="10" name="awardsName" placeholder="수상명" value="${dto.awardsName}" disabled="disabled">
		                &nbsp;
		                <input type="text" size="10" name="awardsPublisher" placeholder="발급처" value="${dto.awards_publisher}" disabled="disabled">
		                &nbsp;
		                <input type="text" name="awardsDate" placeholder="수상 날짜" value="${dto.awards_date}" style="width:100px;" disabled="disabled">       
		            	<button class="btn btn-black removeAwards"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
		                <br><br>
	                </div>
                </c:forEach>
            </div>              
            <p align="center">
	         	<button type="button" class="btn btn-black" id="addAwards" style="height: 26px;line-height: 10px;">추가</button>
	         </p>
	         <hr>  
		</div>
		
		</div>
			<h3>&nbsp;| 경력 사항</h3>
			<br> 
		<div class="inputBox">  
			<div id="careerInfo">
			<div style="display:none;">
				<input type="hidden" name="careerCode">
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
		         	&nbsp;
		            <input type="text" size="10" name="position" placeholder="직위">
		            <br> 
		            &nbsp;
		            <input type="text" size="10" name="task" placeholder="업무내용">
		            <span class="datepicker_wrap">
		                <input type="text" class="datepicker"  title="calendar" name="carrerjoinDate" placeholder="입사일자" style="width:80px;">
		                <input type="text" class="datepicker"  title="calendar" name="carrerresignDate" placeholder="퇴사일자" style="width:80px;">
		            </span>
		            <button class="btn btn-black removeCareer"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
		            <button class="btn btn-black addCareer" type="button"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">추가완료</button>
		            <br>
		            <br>
	            </div>
			<c:forEach var="dto" items="${CareerList}">
				<div>
					<input type="hidden" name="careerCode" value="${dto.careerCode}">
					&nbsp;                       
		            <input type="text" size="10" name="copName" placeholder="회사명" value="${dto.copName}" disabled="disabled">
		            &nbsp;
		            <label for="gubun">경력구분</label>
		            <select size="1" name="gubun" disabled="disabled">
		                <option value="intern">인턴</option>
		                <option value="contract">계약직</option>
		                <option value="regular">정규직</option>
		                <option value="dispatch">파견직</option>
		            </select>
		         	&nbsp;
		            <input type="text" size="10" name="position" placeholder="직위" value="${dto.position}" disabled="disabled">
		            <br> 
		            &nbsp;
		            <input type="text" size="10" name="task" placeholder="업무내용" value="${dto.task}" disabled="disabled">
		                <input type="text" title="calendar" name="carrerjoinDate" placeholder="입사일자" value="${dto.joinDate}" style="width:100px;" disabled="disabled">
		                <input type="text" title="calendar" name="carrerresignDate" placeholder="퇴사일자" value="${dto.resignDate}" style="width:100px;" disabled="disabled">
		            <button class="btn btn-black removeCareer"  style="float:right; margin-right:10px; height: 26px; line-height: 10px;">삭제</button>
		            <br>
		            <br>
	            </div>
	            </c:forEach>
	          </div>
	            <p align="center">
	         	<button type="button" class="btn btn-black" id="addCareer" style="height: 26px;line-height: 5px;">추가</button>
	         	</p>
	         </div>
	         <hr>
         <div>
         &nbsp;
           <a href="<%=cp%>/resume/update_ok.do" class="btn_classic btn-black mt20">수정완료</a>
           &nbsp;
           <a href="<%=cp%>/resume/list.do" class="btn_classic btn-black mt20">취소</a>
            <br><br>
         </div>
         </form>        
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
   </div>  
</body>
</html>