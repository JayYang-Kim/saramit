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
				<div class="contents_header_bg resume_list center">
            		<div class="bg_black"></div>
            	</div>
				<div class="inner">
					<div class="pageTitle mt30 pb10">
                		<h3>피드백 게시판</h3>
                	</div>
					<div class="mt20">
						<form name="resumeForm" method="post">
							<div class="p10">
								<input type="text" name="title" style="width:100%;" placeholder="이력서 제목 작성">
							</div>
							
							<h3 style="background-color:#4c4c4c;color:#ffffff;padding:10px;">| 개인 정보</h3>
							<div id="personalInfo">
								<table class="tb_basic_row">
									<colgroup>
										<col style="width:20%;">
										<col style="width:30%;">
										<col style="width:20%;">
										<col style="width:30%;">
									</colgroup>
									<tr>
										<th>이름</th>
										<td>
											<input type="text" name="name" size="10" autofocus value="${dto.userName}">
										</td>
										<th>생년월일</th>
										<td>
											<input type="text" name="birth" size="10" maxlength="10" value="${dto.birth}">
										</td>
									</tr>
									<tr>
										<th>성별</th>
										<td>
											<input type="text" name="gender" value="${dto.gender}">
										</td>
										<th>이메일</th>
										<td>
											<input type="text" name="userEmail" value="${dto.userEmail}">
										</td>
									</tr>
									<tr>
										<th>주소</th>
										<td colspan="3">
											<input type="text" name="addr" style="width: 80%;" value="${dto.address}">
										</td>
									</tr>
								</table>
							</div>
							<h3 style="background-color:#4c4c4c;color:#ffffff;padding:10px;">| 자격 사항</h3>
							<div class="inputBox">
								<div id="licenseInfo">
									<div>
										<table class="tb_basic_row" style="border-bottom:none;">
											<colgroup>
												<col style="width:20%;">
												<col style="width:30%;">
												<col style="width:20%;">
												<col style="width:30%;">
											</colgroup>
											<tr>
												<th>자격증명</th>
												<td>
													<input type="text" size="10" name="licenseName" placeholder="자격증명">
												</td>
												<th>발급처</th>
												<td>
													<input type="text" size="10" name="licensePublisher" placeholder="발급처">			
												</td>
											</tr>
											<tr>
												<th>취득날짜</th>
												<td colspan="3">
													<input type="text" title="calendar" name="licenseDate" placeholder="취득 날짜">			
												</td>												
											</tr>
											<tr>
												<td colspan="4" style="text-align:right;">
													<button class="btn btn-black removeLicense" type="button">삭제</button>
												</td>
											</tr>
										</table>
									</div>
								</div>
								<p class="t_center mt20 mb20">
									<button type="button" class="btn btn-black" id="addLicense"
										style="height: 26px; line-height: 10px;">추가</button>
								</p>
							</div>
							<h3 style="background-color:#4c4c4c;color:#ffffff;padding:10px;">| 수상 경력</h3>
							<div class="inputBox">
								<div id="awardsInfo">
									<div>
										<table class="tb_basic_row" style="border-bottom:none;">
											<colgroup>
												<col style="width:20%;">
												<col style="width:30%;">
												<col style="width:20%;">
												<col style="width:30%;">
											</colgroup>
											<tr>
												<th>수상명</th>
												<td>
													<input type="text" size="10" name="awardsName"
											placeholder="수상명">
												</td>
												<th>발급처</th>
												<td>
													<input type="text"
											size="10" name="awardspublisher" placeholder="발급처">
												</td>
											</tr>
											<tr>
												<th>수상날짜</th>
												<td colspan="3">
													<input
											type="text" title="calendar"
											name="awardsDate" placeholder="수상 날짜">
												</td>
											</tr>
											<tr>
												<td colspan="4" style="text-align:right;">
													<button class="btn btn-black removeAwards">삭제</button>
												</td>
											</tr>
										</table>		
									</div>
								</div>
								<p class="t_center mt20 mb20">
									<button type="button" class="btn btn-black" id="addAwards"
										style="height: 26px; line-height: 10px;">추가</button>
								</p>
							</div>
							<h3 style="background-color:#4c4c4c;color:#ffffff;padding:10px;">| 학력</h3>
							<div class="inputBox">
								<div id="educationInfo">
									<table class="tb_basic_row" style="border-bottom:none;">
										<colgroup>
											<col style="width:20%;">
											<col style="width:30%;">
											<col style="width:20%;">
											<col style="width:30%;">
										</colgroup>
										<tr>
											<th>최종학력</th>
											<td>
												<select size="1" name="educationCode">
										<option value="1">중졸</option>
										<option value="2">고졸</option>
										<option value="3">초대졸</option>
										<option value="4">대졸</option>
										<option value="5">대학원졸</option>
									</select>
											</td>
											<th>학교명</th>
											<td>
												<input type="text" size="10" id="schoolName" name="schoolName" placeholder="학교명">
											</td>
										</tr>
										<tr>
											<th>지역명</th>
											<td>
												<select size="1" name="region">
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
											</td>
											<th>전공/학과명</th>
											<td><input type="text" size="10" name="major" placeholder="전공/학과명"></td>
										</tr>
										<tr>
											<th>재학중</th>
											<td>
												<input type="checkbox" name="graduate_status" value="재학중">재학중
											</td>
											<th>기간</th>
											<td>
												<input type="text" title="calendar" name="entrance" placeholder="입학일자"> 
												<input type="text" title="calendar" name="graduate" placeholder="졸업일자">		
											</td>
										</tr>
									</table>	
								</div>
							</div>
							<h3 style="background-color:#4c4c4c;color:#ffffff;padding:10px;">| 경력 사항</h3>
							<div class="inputBox">
								<div id="careerInfo">
									<div>
										<table class="tb_basic_row" style="border-bottom:none;">
											<colgroup>
												<col style="width:20%;">
												<col style="width:30%;">
												<col style="width:20%;">
												<col style="width:30%;">
											</colgroup>
											<tr>
												<th>경력구분</th>
												<td>
													<input type="text" size="10" name="copName"
											placeholder="회사명">
												</td>
												<th>구분</th>
												<td>
													<select size="1" name="gubun">
											<option value="intern">인턴</option>
											<option value="contract">계약직</option>
											<option value="regular">정규직</option>
											<option value="dispatch">파견직</option>
											</select>
												</td>
											</tr>
											<tr>
												<th>직위</th>
												<td>
													<input type="text" size="10" name="position"
											placeholder="직위">
												</td>
												<th>업무내용</th>
												<td>
													<input type="text" size="10"
											name="task" placeholder="업무내용">
												</td>
											</tr>
											<tr>
												<th>입사일자</th>
												<td>
													<input type="text"
											title="calendar" name="carrerjoinDate"
											placeholder="입사일자">
												</td>
												<th>퇴사일자</th>
												<td>
													<input type="text"
											title="calendar" name="carrerresignDate"
											placeholder="퇴사일자">
												</td>
											</tr>
											<tr>
												<td colspan="4" style="text-align:right;">
													<button class="btn btn-black removeCareer">삭제</button>
												</td>
											</tr>
										</table>
										
										
									</div>
								</div>
								<p class="t_center mt20 mb20">
									<button type="button" class="btn btn-black" id="addCareer" style="height: 26px; line-height: 5px;">추가</button>
								</p>
							</div>
							<div class="t_center p20" style="border-top:1px solid #c4c4c4;">
								<a href="javascript:sendok()" class="btn_classic btn-yellow" style="width:100%;">작성완료</a>
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