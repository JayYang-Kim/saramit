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
    		
    		if(f.userEmail.value == "") {
				$("#txt_userEmail").focus().css("outline-color","#df4442");
				$("#txt_userEmail").next(".message").html("* 이메일 주소를 입력해주세요.").show();
				return;
			} else {
				$("#txt_userEmail").next(".message").hide();
			}
    		
    		if(f.userPwd.value == "") {
				$("#txt_pwd").focus().css("outline-color","#df4442");
				$("#txt_pwd").next(".message").html("* 비밀번호를 입력해주세요.").show();
				return;
			} else {
				$("#txt_pwd").next(".message").hide();
			}
			
			if(f.userPwd_ok.value == "") {
				f.userPwd_ok.focus();
				$("#txt_pwd_ok").focus().css("outline-color","#df4442");
				$("#txt_pwd_ok").next(".message").html("* 비밀번호 확인을 입력해주세요.").show();
				return;
			} else {
				$("#txt_pwd_ok").next(".message").hide();
			}
			
			if(f.userPwd.value != f.userPwd_ok.value) {
				$("#txt_pwd_ok").focus().css("outline-color","#df4442");
				$("#txt_pwd_ok").next(".message").html("* 비밀번호가 일치하지 않습니다.").show();
				return;
			} else {
				$("#txt_pwd_ok").next(".message").hide();
			}
			
			if(f.userName.value == "") {
				$("#txt_name").focus().css("outline-color","#df4442");
				$("#txt_name").next(".message").html("* 이름을 입력해주세요.").show();
				return;
			} else {
				$("#txt_name").next(".message").hide();
			}
			
			if(f.birth.value == "") {
				$("#txt_birth").focus().css("outline-color","#df4442");
				$("#txt_birth").next(".message").html("* 생일을 입력해주세요.").show();
				return;
			} else {
				$("#txt_birth").next(".message").hide();
			}
			
			if(f.gender.value == "") {
				$(".radio").next(".message").html("* 성별을 선택해주세요.").show();
				return;
			} else {
				$(".radio").next(".message").hide();
			}
			
			if(f.postCode.value == "") {
				$("#postcode").focus().css("outline-color","#df4442");
				$("#postcode").parent(".address").find(".message").html("* 우편번호를 입력해주세요.").show();
				return;
			} else {
				$("#postcode").parent(".address").find(".message").hide();
			}
			
			if(f.address.value == "") {
				$("#address").focus().css("outline-color","#df4442");
				$("#address").parent(".address").find(".message").html("* 주소를 입력해주세요.").show();
				return;
			} else {
				$("#address").parent(".address").find(".message").hide();
			}
			
			if(f.detailAddress.value == "") {
				$("#detailAddress").focus().css("outline-color","#df4442");
				$("#detailAddress").parent(".address").find(".message").html("* 상세주소를 입력해주세요.").show();
				return;
			} else {
				$("#detailAddress").parent(".address").find(".message").show();
			}
    		
    		f.action = "<%=cp%>/member/join_ok.do";
    		f.submit();
    	}
    	
		function joinCompany() {
			var f = document.joinCompany_form;
			
			if(f.companyEmail.value == "") {
				$("#txt_companyEmail").focus().css("outline-color","#df4442");
				$("#txt_companyEmail").next(".message").html("* 이메일 주소를 입력해주세요.").show();
				return;
			} else {
				$("#txt_companyEmail").next(".message").hide();
			}
			
			if(f.companyPwd.value == "") {
				$("#txt_companyPwd").focus().css("outline-color","#df4442");
				$("#txt_companyPwd").next(".message").html("* 비밀번호를 입력해주세요.").show();
				return;
			} else {
				$("#txt_companyPwd").next(".message").hide();
			}
			
    		if(f.companyPwd_ok.value == "") {
				$("#txt_companyPwd_ok").focus().css("outline-color","#df4442");
				$("#txt_companyPwd_ok").next(".message").html("* 비밀번호 확인을 입력해주세요.").show();
				return;
			} else {
				$("#txt_companyPwd_ok").next(".message").hide();
			}
    		
    		if(f.companyPwd.value != f.companyPwd_ok.value) {
				$("#txt_companyPwd_ok").focus().css("outline-color","#df4442");
				$("#txt_companyPwd_ok").next(".message").html("* 비밀번호가 일치하지 않습니다.").show();
				return;
			} else {
				$("#txt_companyPwd_ok").next(".message").hide();
			}
    		
    		if(f.businessLicenseNum.value == "") {
				$("#txt_businessLicenseNum").focus().css("outline-color","#df4442");
				$("#txt_businessLicenseNum").next(".message").html("* 사업자등록 번호를 입력해주세요.").show();
				return;
			} else {
				$("#txt_businessLicenseNum").next(".message").hide();
			}
    		
    		if(f.companyName.value == "") {
				$("#txt_companyName").focus().css("outline-color","#df4442");
				$("#txt_companyName").next(".message").html("* 기업명을 입력해주세요.").show();
				return;
			} else {
				$("#txt_companyName").next(".message").hide();
			}
    		
    		if(f.owner.value == "") {
				$("#txt_owner").focus().css("outline-color","#df4442");
				$("#txt_owner").next(".message").html("* 대표자명을 입력해주세요.").show();
				return;
			} else {
				$("#txt_owner").next(".message").hide();
			}
    		
    		if(f.establishmentDate.value == "") {
				$("#txt_establishmentDate").focus().css("outline-color","#df4442");
				$("#txt_establishmentDate").next(".message").html("* 설립일을 입력해주세요.").show();
				return;
			} else {
				$("#txt_establishmentDate").next(".message").hide();
			}
    		
    		if(f.employees.value == "") {
				$("#txt_employees").focus().css("outline-color","#df4442");
				$("#txt_employees").next(".message").html("* 사원수를 입력해주세요.").show();
				return;
			} else {
				$("#txt_employees").next(".message").hide();
			}
    		
    		if(f.sale.value == "") {
				$("#txt_sale").focus().css("outline-color","#df4442");
				$("#txt_sale").next(".message").html("* 매출액(단위 : 만원)을 입력해주세요.").show();
				return;
			} else {
				$("#txt_sale").next(".message").hide();
			}
    		
    		if(f.postCode.value == "") {
				$("#company_postcode").focus().css("outline-color","#df4442");
				$("#company_postcode").parent(".location").find(".message").html("* 우편번호를 입력해주세요.").show();
				return;
			} else {
				$("#company_postcode").parent(".location").find(".message").hide();
			}
			
			if(f.location.value == "") {
				$("#company_address").focus().css("outline-color","#df4442");
				$("#company_address").parent(".location").find(".message").html("* 주소를 입력해주세요.").show();
				return;
			} else {
				$("#company_address").parent(".location").find(".message").hide();
			}
			
			if(f.detailLocation.value == "") {
				$("#company_detailAddress").focus().css("outline-color","#df4442");
				$("#company_detailAddress").parent(".location").find(".message").html("* 상세주소를 입력해주세요.").show();
				return;
			} else {
				$("#company_detailAddress").parent(".location").find(".message").show();
			}
			
			if(f.salary.value == "") {
				$("#txt_salary").focus().css("outline-color","#df4442");
				$("#txt_salary").next(".message").html("* 평균연봉(단위 : 만원)을 입력해주세요.").show();
				return;
			} else {
				$("#txt_salary").next(".message").hide();
			}
			
			if(f.homepage.value == "") {
				$("#txt_homepage").focus().css("outline-color","#df4442");
				$("#txt_homepage").next(".message").html("* 사이트 주소를 입력해주세요.").show();
				return;
			} else {
				$("#txt_homepage").next(".message").hide();
			}
    		
    		if(f.file.value != "") {
    			if(!/(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.file.value)) {
    				$("#txt_img_logo").focus().css("outline-color","#df4442");
    				$("#txt_img_logo").closest(".inp_file").next(".message").html("* 이미지 파일만 저장 가능합니다.").show();
        			return;
        		} else {
        			$("#txt_img_logo").closest(".inp_file").next(".message").hide();
        		}
    		} else if(f.file.value == "") {
    			$("#txt_img_logo").focus().css("outline-color","#df4442");
				$("#txt_img_logo").closest(".inp_file").next(".message").html("* 로고 이미지를 선택해주세요.").show();
				return;
    		} else {
    			$("#txt_img_logo").closest(".inp_file").next(".message").hide();
    		}
    		
    		if(f.introduction.value == "") {
				$("#txt_introduction").focus().css("outline-color","#df4442");
				$("#txt_introduction").next(".message").html("* 회사소개 내용을 입력해주세요.").show();
				return;
			} else {
				$("#txt_introduction").next(".message").hide();
			}
			
			f.action = "<%=cp%>/member/join_ok.do";
    		f.submit();
    	}
		
		function user_Postcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                var addr = '';
	                var extraAddr = '';

	                if (data.userSelectedType === 'R') {
	                    addr = data.roadAddress;
	                } else {
	                    addr = data.jibunAddress;
	                }

	                if(data.userSelectedType === 'R'){
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }

	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                document.getElementById("detailAddress").focus();
	            }
	        }).open();
	    }
		
		function company_Postcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                var addr = '';
	                var extraAddr = '';

	                if (data.userSelectedType === 'R') {
	                    addr = data.roadAddress;
	                } else { 
	                    addr = data.jibunAddress;
	                }

	                if(data.userSelectedType === 'R'){
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    document.getElementById("company_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("company_extraAddress").value = '';
	                }

	                document.getElementById('company_postcode').value = data.zonecode;
	                document.getElementById("company_address").value = addr;
	                document.getElementById("company_detailAddress").focus();
	            }
	        }).open();
	    }
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
            <div class="register">
            	<div class="contents_header_bg join top mb50">
            		<div class="bg_black"></div>
            	</div>
				<ul class="tabmenu2 tabMotion">
					<li class="on"><a href="#tabCon1">개인회원</a></li>
					<li><a href="#tabCon2">회사회원</a></li>
				</ul>
				<div id="tabCon1" class="tab_cont">
					<form name="joinUser_form" method="post">
						<fieldset>
							<div class="box_register">
								<h3 class="title">회원가입</h3>
								<div class="mt30">
									<label for="txt_userEmail">이메일</label>
									<div>
										<input type="text" name="userEmail" id="txt_userEmail" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_pwd">비밀번호</label>
									<div>
										<input type="password" name="userPwd" id="txt_pwd" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_pwd_ok">비밀번호 확인</label>
									<div>
										<input type="password" name="userPwd_ok" id="txt_pwd_ok" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_name">이름</label>
									<div>
										<input type="text" name="userName" id="txt_name" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_birth">생년월일</label>
									<div>
										<input type="text" name="birth" id="txt_birth" class="boxTf" placeholder="YYYY-MM-DD" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
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
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_address">주소</label>
									<div class="address mt15">
										<input type="text" id="postcode" name="postCode" class="boxTf" autocomplete="off" autofocus placeholder="우편번호" style="width:75%">
										<input type="button" onclick="user_Postcode()" value="우편번호 찾기" class="btn btn-black" style="height:45px;margin-top:10px;margin-left:3px;"><br>
										<input type="text" id="address" name="address" placeholder="주소" class="boxTf" autocomplete="off" autofocus/><br>
										<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" class="boxTf" autocomplete="off" autofocus/>
										<input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<input type="hidden" name="status" value="1"/>
									<input type="hidden" name="level" value="2"/>
									<button type="button" class="btn_register" onclick="joinUser()">회원가입</button>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
				<div id="tabCon2" class="tab_cont">
					<form name="joinCompany_form" method="post" enctype="multipart/form-data">
						<fieldset>
							<div class="box_register">
								<h3 class="title">회원가입</h3>
								<div class="mt30">
									<label for="txt_companyEmail">이메일</label>
									<div>
										<input type="text" name="companyEmail" id="txt_companyEmail" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_companyPwd">비밀번호</label>
									<div>
										<input type="password" name="companyPwd" id="txt_companyPwd" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_companyPwd_ok">비밀번호 확인</label>
									<div>
										<input type="password" name="companyPwd_ok" id="txt_companyPwd_ok" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_businessLicenseNum">사업자 등록번호</label>
									<div>
										<input type="text" name="businessLicenseNum" id=txt_businessLicenseNum class="boxTf" placeholder="000-00-00000" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_companyName">기업명</label>
									<div>
										<input type="text" name="companyName" id="txt_companyName" class="boxTf" placeholder="(주)SARAMIT" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_owner">대표자명</label>
									<div>
										<input type="text" name="owner" id="txt_owner" class="boxTf" placeholder="홍길동" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_establishmentDate">설립일</label>
									<div>
										<input type="text" name="establishmentDate" id="txt_establishmentDate" class="boxTf" placeholder="YYYY-MM-DD" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_employees">사원수</label>
									<div>
										<input type="text" name="employees" id="txt_employees" class="boxTf" placeholder="100" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_sale">매출액 (단위 : 만원)</label>
									<div>
										<input type="text" name="sale" id="txt_sale" class="boxTf" placeholder="10000000000" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_location">위치(주소)</label>
									<div class="location mt15">
										<input type="text" id="company_postcode" name="postCode" class="boxTf" autocomplete="off" autofocus placeholder="우편번호" style="width:75%">
										<input type="button" onclick="company_Postcode()" value="우편번호 찾기" class="btn btn-black" style="height:45px;margin-top:10px;margin-left:3px;"><br>
										<input type="text" id="company_address" name="location" placeholder="주소" class="boxTf" autocomplete="off" autofocus/><br>
										<input type="text" id="company_detailAddress" name="detailLocation" placeholder="상세주소" class="boxTf" autocomplete="off" autofocus/>
										<input type="text" id="company_extraAddress" name="extraLocation" placeholder="참고항목" class="boxTf" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_salary">평균연봉 (단위 : 만원)</label>
									<div>
										<input type="text" name="salary" id="txt_salary" class="boxTf" placeholder="10000000" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_homepage">사이트 주소</label>
									<div>
										<input type="text" name="homepage" id="txt_homepage" class="boxTf" placeholder="ex)http://www.naver.com" autocomplete="off" autofocus/>
										<div class="message t_red mt15"></div>
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
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_introduction">회사소개</label>
									<div class="mt10">
										<textarea name="introduction" id="txt_introduction" placeholder="내용" title="내용"></textarea>
										<div class="message t_red mt15"></div>
									</div>
								</div>
								<div class="mt30">
									<input type="hidden" name="status" value="1"/>
									<input type="hidden" name="level" value="1"/>
									<button type="button" class="btn_register" onclick="joinCompany()">회원가입</button>
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