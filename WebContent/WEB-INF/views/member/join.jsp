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
    	function joinUser() {
    		var f = document.joinUser_form;
    		
    		f.action = "<%=cp%>/member/join_ok.do";
    		f.submit();
    	}
    	
		function joinCompany() {
			var f = document.joinCompany_form;
			
			f.action = "<%=cp%>/member/join_ok.do";
    		f.submit();
    	}
		
		function user_Postcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	            }
	        }).open();
	    }
		
		function company_Postcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	            }
	        }).open();
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
            <div class="register">
				<ul class="tabmenu2 tabMotion">
					<li class="on"><a href="#tabCon1">개인회원</a></li>
					<li><a href="#tabCon2">회사회원</a></li>
				</ul>
				<div id="tabCon1" class="tab_cont">
					<form name="joinUser_form" method="post">
						<fieldset>
							<div class="box_login">
								<h3 class="title">회원가입</h3>
								<div class="mt30">
									<label for="txt_userEmail">이메일</label>
									<div>
										<input type="text" name="userEmail" id="txt_userEmail" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_pwd">비밀번호</label>
									<div>
										<input type="password" name="userPwd" id="txt_pwd" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_pwd_ok">비밀번호 확인</label>
									<div>
										<input type="password" name="userPwd_ok" id="txt_pwd_ok" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_name">이름</label>
									<div>
										<input type="text" name="userName" id="txt_name" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_birth">생년월일</label>
									<div>
										<input type="text" name="birth" id="txt_birth" class="boxTf" placeholder="YYYY-MM-DD" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_gender">성별</label>
									<div class="mt15">
										<label class="radio">
											<input name="gender" type="radio" value="m"/>
											<span class="lbl">남자</span>
										</label>
										<label class="radio ml20">
											<input name="gender" type="radio" value="w"/>
											<span class="lbl">여자</span>
										</label>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_address">주소</label>
									<div class="mt15">
										<input type="text" id="postcode" name="postCode" class="boxTf" autocomplete="off" autofocus placeholder="우편번호" style="width:75%">
										<input type="button" onclick="user_Postcode()" value="우편번호 찾기" class="btn btn-black" style="height:45px;margin-top:10px;margin-left:3px;"><br>
										<input type="text" id="address" name="address" placeholder="주소" class="boxTf" autocomplete="off" autofocus/><br>
										<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" class="boxTf" autocomplete="off" autofocus/>
										<input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<input type="hidden" name="status" value="1"/>
									<input type="hidden" name="level" value="2"/>
									<button type="button" class="btn_login" onclick="joinUser()">회원가입</button>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
				<div id="tabCon2" class="tab_cont">
					<form name="joinCompany_form" method="post" enctype="multipart/form-data">
						<fieldset>
							<div class="box_login">
								<h3 class="title">회원가입</h3>
								<div class="mt30">
									<label for="txt_companyEmail">이메일</label>
									<div>
										<input type="text" name="companyEmail" id="txt_companyEmail" class="boxTf" autocomplete="off" autofocus/>
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
										<input type="text" name="businessLicenseNum" id=txt_businessLicenseNum class="boxTf" placeholder="000-00-00000" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_companyName">기업명</label>
									<div>
										<input type="text" name="companyName" id="txt_companyName" class="boxTf" placeholder="(주)SARAMIT" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_owner">대표자명</label>
									<div>
										<input type="text" name="owner" id="txt_owner" class="boxTf" placeholder="홍길동" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_establishmentDate">설립일</label>
									<div>
										<input type="text" name="establishmentDate" id="txt_establishmentDate" class="boxTf" placeholder="YYYY-MM-DD" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_employees">사원수</label>
									<div>
										<input type="text" name="employees" id="txt_employees" class="boxTf" placeholder="100" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_sale">매출액</label>
									<div>
										<input type="text" name="sale" id="txt_sale" class="boxTf" placeholder="10000000000" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_location">위치(주소)</label>
									<div>
										<input type="text" name="location" id="txt_location" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_salary">평균연봉</label>
									<div>
										<input type="text" name="salary" id="txt_salary" class="boxTf" placeholder="10000000" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_homepage">사이트 주소</label>
									<div>
										<input type="text" name="homepage" id="txt_homepage" class="boxTf" placeholder="ex)http://www.naver.com" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_img_logo">로고</label>
									<div class="mt10">
										<p class="inp_file">
											<input type="text" placeholder="첨부파일을 선택해주세요." title="첨부파일 선택" readonly="readonly">
											<span class="btn_file">
												<a href="#" class="button btn-white">파일찾기</a>
												<input type="file" name="file" id="txt_img_logo" placeholder="내용입력" title="파일첨부">
											</span>
										</p>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_introduction">회사소개</label>
									<div class="mt10">
										<textarea name="introduction" id="txt_introduction" placeholder="내용" title="내용"></textarea>
									</div>
								</div>
								<div class="mt30">
									<input type="hidden" name="status" value="1"/>
									<input type="hidden" name="level" value="1"/>
									<button type="button" class="btn_login" onclick="joinCompany()">회원가입</button>
								</div>
							</div>
						</fieldset>
					</form>
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