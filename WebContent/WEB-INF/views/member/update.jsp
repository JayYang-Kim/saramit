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
				<div>
					<form name="joinUser_form" action="#" method="#">
						<fieldset>
							<div class="box_login">
								<h3 class="title">회원정보 수정</h3>
								<!-- 공통 -->
								<div class="mt30">
									<label for="txt_email">이메일</label>
									<div>
										<input type="text" name="userEmail" id="txt_email" class="boxTf" value="${dto.userEmail}" autocomplete="off" autofocus/>
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
								<!-- //공통 -->
								<!-- 유저 -->
								<c:if test="${sessionScope.member.level == 2}">
									<div class="mt30">
										<label for="txt_name">이름</label>
										<div>
											<input type="text" name="userName" id="txt_name" class="boxTf" value="${dto.userName}" disabled="disabled" autocomplete="off" autofocus/>
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
								</c:if>
								<!-- //유저 -->
								<!-- 회사 -->
								<c:if test="${sessionScope.member.level == 1}">
									<div class="mt30">
										<label for="txt_businessNum">사업자 등록번호</label>
										<div>
											<input type="text" name="businessNum" id="txt_businessNum" class="boxTf" placeholder="000-00-00000" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_companyName">기업명</label>
										<div>
											<input type="text" name="companyName" id="txt_companyName" class="boxTf" placeholder="(주)SARAMIT" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_ceoName">대표자명</label>
										<div>
											<input type="text" name="ceoName" id="txt_ceoName" class="boxTf" placeholder="홍길동" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_fountDate">설립일</label>
										<div>
											<input type="text" name="fountDate" id="txt_fountDate" class="boxTf" placeholder="YYYY-MM-DD" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_employeesNum">사원수</label>
										<div>
											<input type="text" name="employeesNum" id="txt_employeesNum" class="boxTf" placeholder="100" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_salesNum">매출액</label>
										<div>
											<input type="text" name="salesNum" id="txt_salesNum" class="boxTf" placeholder="10000000000" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_address">위치(주소)</label>
										<div>
											<input type="text" name="address" id="txt_address" class="boxTf" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_averageSalary">평균연봉</label>
										<div>
											<input type="text" name="averageSalary" id="txt_averageSalary" class="boxTf" placeholder="10000000" autocomplete="off" autofocus/>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_siteUrl">사이트 주소</label>
										<div>
											<input type="text" name="siteUrl" id="txt_siteUrl" class="boxTf" placeholder="ex)http://www.naver.com" autocomplete="off" autofocus/>
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
													<input type="file" placeholder="내용입력" title="파일첨부">
												</span>
											</p>
										</div>
									</div>
									<div class="mt30">
										<label for="txt_companyIntro">회사소개</label>
										<div class="mt10">
											<textarea name="companyIntro" id="txt_companyIntro" placeholder="내용" title="내용"></textarea>
										</div>
									</div>
								</c:if>
								<!-- //회사 -->	
								<div class="box_joinBtn mt30">
									<button type="button" class="button btn_join">수정완료</button>
									<button type="button" class="button btn_join">취소</button>
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