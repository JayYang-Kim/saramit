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
    	jQuery(function(){
    		$(".message").hide();
    	});
    
	    function upd_myPage_user() {
			var f = document.updUser_form;
			
			if(f.userPwd.value == "") {
				$("#txt_userPwd").focus().css("outline-color","#df4442");
				$("#txt_userPwd").next(".message").html("* 비밀번호를 입력해주세요.").show();
				return;
			} else {
				$("#txt_userPwd").next(".message").hide();
			}
			
			if(f.userPwd_ok.value == "") {
				f.userPwd_ok.focus();
				$("#txt_userPwd_ok").focus().css("outline-color","#df4442");
				$("#txt_userPwd_ok").next(".message").html("* 비밀번호 확인을 입력해주세요.").show();
				return;
			} else {
				$("#txt_userPwd_ok").next(".message").hide();
			}
			
			if(f.userPwd.value != f.userPwd_ok.value) {
				$("#txt_userPwd_ok").focus().css("outline-color","#df4442");
				$("#txt_userPwd_ok").next(".message").html("* 비밀번호가 일치하지 않습니다.").show();
				return;
			} else {
				$("#txt_userPwd_ok").next(".message").hide();
			}
			
			if(f.userName.value == "") {
				$("#txt_userName").focus().css("outline-color","#df4442");
				$("#txt_userName").next(".message").html("* 이름을 입력해주세요.").show();
				return;
			} else {
				$("#txt_userName").next(".message").hide();
			}
			
			if(f.birth.value == "") {
				$("#txt_birth").focus().css("outline-color","#df4442");
				$("#txt_birth").next(".message").html("* 생일을 입력해주세요.").show();
				return;
			} else {
				$("#txt_birth").next(".message").hide();
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
			
			f.action = "<%=cp%>/member/update_ok.do";
    		f.submit();
		}
	    
    	function upd_myPage_company() {
    		var f = document.updCompany_form;
    		
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
    		
    		if(f.owner.value == "") {
				$("#txt_owner").focus().css("outline-color","#df4442");
				$("#txt_owner").next(".message").html("* 대표자명을 입력해주세요.").show();
				return;
			} else {
				$("#txt_owner").next(".message").hide();
			}
    		
    		if(f.companyName.value == "") {
				$("#txt_companyName").focus().css("outline-color","#df4442");
				$("#txt_companyName").next(".message").html("* 기업명을 입력해주세요.").show();
				return;
			} else {
				$("#txt_companyName").next(".message").hide();
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
    		}
    		
    		if(f.introduction.value == "") {
				$("#txt_introduction").focus().css("outline-color","#df4442");
				$("#txt_introduction").next(".message").html("* 회사소개 내용을 입력해주세요.").show();
				return;
			} else {
				$("#txt_introduction").next(".message").hide();
			}
    		
    		f.action = "<%=cp%>/member/update_ok.do";
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
            <div class="login" style="padding:0;">
            	<div class="contents_header_bg join top mb50">
            		<div class="bg_black"></div>
            	</div>
				<div>
					<fieldset>
						<div class="box_login">
							<h3 class="title">회원정보 수정</h3>
							<%-- 유저 --%>
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
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_pwd_ok">비밀번호 확인</label>
										<div>
											<input type="password" name="userPwd_ok" id="txt_userPwd_ok" class="boxTf" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_name">이름</label>
										<div>
											<input type="text" name="userName" id="txt_userName" class="boxTf" value="${dto.userName}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_birth">생년월일</label>
										<div>
											<input type="text" name="birth" id="txt_birth" class="boxTf" placeholder="YYYY-MM-DD" value="${dto.birth}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
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
										<div class="address">
											<input type="text" id="postcode" name="postCode" class="boxTf" value="${dto.postCode}" autocomplete="off" autofocus placeholder="우편번호" style="width:391px">
											<input type="button" onclick="user_Postcode()" value="우편번호 찾기" class="btn btn-black" style="height:45px;margin-top:10px;margin-left:3px;"><br>
											<input type="text" id="address" name="address" value="${dto.address}" placeholder="주소" class="boxTf" autocomplete="off" autofocus/><br>
											<input type="text" id="detailAddress" name="detailAddress" value="${dto.detailAddress}" placeholder="상세주소" class="boxTf" autocomplete="off" autofocus/>
											<input type="text" id="extraAddress" name="extraAddress" value="${dto.extraAddress}" placeholder="참고항목" class="boxTf" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
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
							<%-- //유저 --%>
							<%-- 회사 --%>
							<c:if test="${sessionScope.member.level eq 1}">
								<form name="updCompany_form" method="post" enctype="multipart/form-data">
									<div class="mt30">
										<label for="txt_companyEmail">이메일</label>
										<div>
											<input type="text" name="companyEmail" id="txt_companyEmail" class="boxTf" value="${dto.companyEmail}" disabled="disabled" autocomplete="off" autofocus/>
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
											<input type="text" name="businessLicenseNum" id="txt_businessLicenseNum" class="boxTf" placeholder="000-00-00000" value="${dto.businessLicenseNum}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_companyName">기업명</label>
										<div>
											<input type="text" name="companyName" id="txt_companyName" class="boxTf" placeholder="(주)SARAMIT" value="${dto.companyName}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_owner">대표자명</label>
										<div>
											<input type="text" name="owner" id="txt_owner" class="boxTf" placeholder="홍길동" value="${dto.owner}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
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
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_sale">매출액 (단위 : 만원)</label>
										<div>
											<input type="text" name="sale" id="txt_sale" class="boxTf" placeholder="10000000000" value="${dto.sale}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_location">위치(주소)</label>
										<div class="location">
											<input type="text" id="company_postcode" name="postCode" class="boxTf" value="${dto.postCode}" autocomplete="off" autofocus placeholder="우편번호" style="width:391px">
											<input type="button" onclick="company_Postcode()" value="우편번호 찾기" class="btn btn-black" style="height:45px;margin-top:10px;margin-left:3px;"><br>
											<input type="text" id="company_address" name="location" placeholder="주소" class="boxTf" value="${dto.location}" autocomplete="off" autofocus/><br>
											<input type="text" id="company_detailAddress" name="detailLocation" placeholder="상세주소" class="boxTf" value="${dto.detailLocation}" autocomplete="off" autofocus/>
											<input type="text" id="company_extraAddress" name="extraLocation" placeholder="참고항목" class="boxTf" value="${dto.extraLocation}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_salary">평균연봉 (단위 : 만원)</label>
										<div>
											<input type="text" name="salary" id="txt_salary" class="boxTf" placeholder="10000000" value="${dto.salary}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_homepage">사이트 주소</label>
										<div>
											<input type="text" name="homepage" id="txt_homepage" class="boxTf" placeholder="ex)http://www.naver.com" value="${dto.homepage}" autocomplete="off" autofocus/>
											<div class="message t_red mt15"></div>
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
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_introduction">회사소개</label>
										<div class="mt10">
											<textarea name="introduction" id="txt_introduction" placeholder="내용" title="내용">${dto.introduction}</textarea>
											<div class="message t_red mt15"></div>
										</div>
									</div>
									<div class="box_joinBtn mt30">
										<input type="hidden" name="og_email" value="${dto.companyEmail}"/>
										<input type="hidden" name="og_pwd" value="${dto.companyPwd}"/>
										<input type="hidden" name="og_saveFilename" value="${dto.savefilename}"/>			
										<button type="button" class="button btn_join" onclick="upd_myPage_company()">수정완료</button>
										<button type="button" class="button btn_join" onclick="javascript:location.href='<%=cp%>/member/myPage.do'">취소</button>
									</div>
								</form>
							</c:if>
							<%-- //회사 --%>	
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