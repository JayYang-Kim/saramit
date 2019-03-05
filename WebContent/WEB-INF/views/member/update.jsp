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
	    function upd_myPage_user() {
			var f = document.updUser_form;
			
			if(f.userPwd.value == "") {
				alert("비밀번호를 입력해주세요.");
				f.userPwd.focus();
				return;
			}
			
			if(f.userPwd.value != f.userPwd_ok.value) {
				alert("비밀번호가 일치하지 않습니다.");
				f.userPwd_ok.focus();
				return;
			}
			
			f.action = "<%=cp%>/member/update_ok.do";
    		f.submit();
		}
	    
    	function upd_myPage_company() {
    		var f = document.updCompany_form;
    		
    		if(f.companyPwd.value == "") {
				alert("비밀번호를 입력해주세요.");
				f.companyPwd.focus();
				return;
			}
			
			if(f.companyPwd.value != f.companyPwd_ok.value) {
				alert("비밀번호가 일치하지 않습니다.");
				f.companyPwd_ok.focus();
				return;
			}
    		
    		// 이미지 파일 체크 (이미지 파일이 있을 경우)
    		if(f.file.value != "") {
    			if(!/(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.file.value)) {
        			alert('이미지 파일만 저장 가능합니다.');
        			f.file.focus();
        			return;
        		}
    		}
    		
    		f.action = "<%=cp%>/member/update_ok.do";
    		f.submit();
    	}
    </script>
</head>

<body>
    <!-- Wrap -->
    <div id="wrap" class="login_wrap">
        <!-- Header -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
        <!-- //Header -->
        
        <!-- container -->
        <div id="container" class="login_container">
            <!-- contents -->
            <div class="register" style="padding:141px 0 60px">
				<div>
					<fieldset>
						<div class="box_login">
							<h3 class="title">회원정보 수정</h3>
							<!-- 유저 -->
							<c:if test="${sessionScope.member.level eq 2}">
								<form name="updUser_form" method="post">
									<div class="mt30">
										<label for="txt_email">이메일</label>
										<div>
											<input type="text" name="userEmail" id="txt_userEmail" class="boxTf" value="${dto.userEmail}" disabled="disabled" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_pwd">비밀번호</label>
										<div>
											<input type="password" name="userPwd" id="txt_userPwd" class="boxTf" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_pwd_ok">비밀번호 확인</label>
										<div>
											<input type="password" name="userPwd_ok" id="txt_userPwd_ok" class="boxTf" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_name">이름</label>
										<div>
											<input type="text" name="userName" id="txt_userName" class="boxTf" value="${dto.userName}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_birth">생년월일</label>
										<div>
											<input type="text" name="birth" id="txt_birth" class="boxTf" placeholder="YYYY-MM-DD" value="${dto.birth}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_gender">성별</label>
										<div class="mt15">
											<label class="radio">
												<c:if test="${dto.gender eq '남자'}">
													<input name="gender" type="radio" checked="checked" disabled="disabled"/>
													<span class="lbl">남자</span>
												</c:if>
												<c:if test="${dto.gender ne '남자'}">
													<input name="gender" type="radio" disabled="disabled"/>
													<span class="lbl">남자</span>
												</c:if>
											</label>
											<label class="radio ml20">
												<c:if test="${dto.gender eq '여자'}">
													<input name="gender" type="radio" checked="checked" disabled="disabled"/>
													<span class="lbl">여자</span>
												</c:if>
												<c:if test="${dto.gender ne '여자'}">
													<input name="gender" type="radio" disabled="disabled"/>
													<span class="lbl">여자</span>
												</c:if>
											</label>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_address">주소</label>
										<div>
											<input type="text" name="address" id="txt_address" class="boxTf" value="${dto.address}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="box_joinBtn mt30">
										<input type="hidden" name="og_email" value="${dto.userEmail}"/>
										<input type="hidden" name="og_pwd" value="${dto.userPwd}"/>
										<button type="button" class="button btn_join" onclick="upd_myPage_user()">수정완료</button>
										<button type="button" class="button btn_join" onclick="location.href='<%=cp%>/member/myPage.do'">취소</button>
									</div>
								</form>
							</c:if>
							<!-- //유저 -->
							<!-- 회사 -->
							<c:if test="${sessionScope.member.level eq 1}">
								<form name="updCompany_form" method="post" enctype="multipart/form-data">
									<div class="mt30">
										<label for="txt_companyEmail">이메일</label>
										<div>
											<input type="text" name="companyEmail" id="txt_companyEmail" class="boxTf" value="${dto.companyEmail}" disabled="disabled" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_companyPwd">비밀번호</label>
										<div>
											<input type="password" name="companyPwd" id="txt_companyPwd" class="boxTf" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_companyPwd_ok">비밀번호 확인</label>
										<div>
											<input type="password" name="companyPwd_ok" id="txt_companyPwd_ok" class="boxTf" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_businessLicenseNum">사업자 등록번호</label>
										<div>
											<input type="text" name="businessLicenseNum" id="txt_businessLicenseNum" class="boxTf" placeholder="000-00-00000" value="${dto.businessLicenseNum}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_companyName">기업명</label>
										<div>
											<input type="text" name="companyName" id="txt_companyName" class="boxTf" placeholder="(주)SARAMIT" value="${dto.companyName}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_owner">대표자명</label>
										<div>
											<input type="text" name="owner" id="txt_owner" class="boxTf" placeholder="홍길동" value="${dto.owner}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_establishmentDate">설립일</label>
										<div>
											<input type="text" name="establishmentDate" id="txt_establishmentDate" class="boxTf" placeholder="YYYY-MM-DD" value="${dto.establishmentDate}" disabled="disabled" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_employees">사원수</label>
										<div>
											<input type="text" name="employees" id="txt_employees" class="boxTf" placeholder="100" value="${dto.employees}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_sale">매출액 (단위 : 만원)</label>
										<div>
											<input type="text" name="sale" id="txt_sale" class="boxTf" placeholder="10000000000" value="${dto.sale}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_location">위치(주소)</label>
										<div>
											<input type="text" name="location" id="txt_location" class="boxTf" value="${dto.location }" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_salary">평균연봉 (단위 : 만원)</label>
										<div>
											<input type="text" name="salary" id="txt_salary" class="boxTf" placeholder="10000000" value="${dto.salary}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_homepage">사이트 주소</label>
										<div>
											<input type="text" name="homepage" id="txt_homepage" class="boxTf" placeholder="ex)http://www.naver.com" value="${dto.homepage}" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_img_logo">로고</label>
										<div class="mt10">
											<!-- <p>  
												<input type="file">
											</p> -->
											<p class="inp_file">
												<input type="text" placeholder="첨부파일을 선택해주세요." title="첨부파일 선택" readonly="readonly">
												<span class="btn_file">
													<a href="#" class="button btn-white">파일찾기</a>
													<input type="file" id="txt_img_logo" name="file" placeholder="내용입력" title="파일첨부">
												</span>
											</p>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_introduction">회사소개</label>
										<div class="mt10">
											<textarea name="introduction" id="txt_introduction" placeholder="내용" title="내용">${dto.introduction}</textarea>
										</div>
									</div>
									<div class="box_joinBtn mt30">
										<input type="hidden" name="og_email" value="${dto.companyEmail}"/>
										<input type="hidden" name="og_pwd" value="${dto.companyPwd}"/>
										<input type="hidden" name="og_saveFilename" value="${dto.saveFilename}"/>			
										<button type="button" class="button btn_join" onclick="upd_myPage_company()">수정완료</button>
										<button type="button" class="button btn_join" onclick="javascript:location.href='<%=cp%>/member/myPage.do'">취소</button>
									</div>
								</form>
							</c:if>
							<!-- //회사 -->	
						</div>
					</fieldset>
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