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
        <!-- <header>
            <div class="login_header">
                <h1 class="title">
                    <a href="main.html">SARAMIT | 회원가입</a>
                </h1>
            </div>
        </header> -->
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
					<form name="joinUser_form" action="#" method="post">
						<fieldset>
							<div class="box_login">
								<h3 class="title">회원가입</h3>
								<div class="mt30">
									<label for="txt_email">이메일</label>
									<div>
										<input type="text" name="email" id="txt_email" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_pwd">비밀번호</label>
									<div>
										<input type="password" name="pwd" id="txt_pwd" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_pwd_ok">비밀번호 확인</label>
									<div>
										<input type="password" name="pwd_ok" id="txt_pwd_ok" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_phoneNum">핸드폰 번호</label>
									<div>
										<input type="text" name="phoneNum" id="txt_phoneNum" class="boxTf" placeholder="000-0000-0000" autocomplete="off" autofocus/>
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
											<input name="gender" type="radio"/>
											<span class="lbl">남자</span>
										</label>
										<label class="radio ml20">
											<input name="gender" type="radio"/>
											<span class="lbl">여자</span>
										</label>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_address">주소</label>
									<div>
										<input type="text" name="address" id="txt_address" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<button type="button" class="btn_login">회원가입</button>
								</div>
								<!-- <div class="box_joinBtn mt30">
									<button type="button" class="button btn_join">회원가입</button>
									<button type="button" class="button btn_join">취소</button>
								</div> -->
							</div>
						</fieldset>
					</form>
				</div>
				<div id="tabCon2" class="tab_cont">
					<form name="joinCompany_form" action="#" method="#">
						<fieldset>
							<div class="box_login">
								<h3 class="title">회원가입</h3>
								<div class="mt30">
									<label for="txt_email">이메일</label>
									<div>
										<input type="text" name="email" id="txt_email" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_pwd">비밀번호</label>
									<div>
										<input type="password" name="pwd" id="txt_pwd" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
								<div class="mt30">
									<label for="txt_pwd_ok">비밀번호 확인</label>
									<div>
										<input type="password" name="pwd_ok" id="txt_pwd_ok" class="boxTf" autocomplete="off" autofocus/>
									</div>
								</div>
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
								<div class="mt30">
									<button type="button" class="btn_login">회원가입</button>
								</div>
								<!-- <div class="box_joinBtn mt30">
									<button type="button" class="button btn_join">회원가입</button>
									<button type="button" class="button btn_join">취소</button>
								</div> -->
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

    <!-- pop_layer -->
    <div id="popup" class="pop_bg">
        <article class="pop_wrap">
            <h1>카테고리생성</h1>
            <div class="pop_cont">
                <p>내용<br/>내용</p>
                <p class="t_center mt20">
                    <a href="#" class="button w72 btn_gray pop_close">취소</a>
                    <a href="#" class="button w72 btn_red" onclick="layerHide('#popup')">등록</a>
                </p>
            </div>
            <!-- 팝업을 닫을때는 .pop_close 클래스를 활용 하거나, popupHide 함수 활용 -->
            <a href="#" class="btn_close pop_close">닫기</a>
        </article>
    </div>
</body>
</html>