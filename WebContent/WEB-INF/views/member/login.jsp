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
    <meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
    
    <title>SARAMIT - 너도 취업할 수 있어</title>
    
    <!-- Favicon - 파비콘 (주소창 영역 아이콘) -->
    <link rel="Shortcut Icon" href="<%=cp%>/resources/images/common/saramit.ico"/>
    
    <!-- Css -->
    <link rel="stylesheet" href="<%=cp%>/resources/css/common.css" media="all" />
	<link rel="stylesheet" href="<%=cp%>/resources/css/style.css" media="all" />

    <!-- Javascript -->
    <script src="<%=cp%>/resources/js/lib/jquery-1.12.4.min.js"></script>
	<script src="<%=cp%>/resources/js/lib/jquery-migrate-1.4.1.min.js"></script>
    <script src="<%=cp%>/resources/js/lib/jquery-ui-1.12.1.min.js"></script>
    
    <script src="<%=cp%>/resources/js/plugins.js"></script>
    <script src="<%=cp%>/resources/js/basic.js"></script>
   
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="resources/js/lib/html5shiv.js"></script>
    <![endif]-->
    <script type="text/javascript">
    	function sendOk(){
    		var f = login_form;
    		if(!f.radioLevel.value){
    			alert("로그인 종류를 선택하세요!");
    			return;
    		}
    		f.submit();
    	}
    </script>
</head>

<body>
    <!-- Wrap -->
    <div id="wrap" class="login_wrap">
        <!-- Header -->
        <header>
            <div class="login_header">
                <h1 class="title">
                    <a href="<%=cp%>">SARAMIT | 로그인</a>
                </h1>
            </div>
        </header>
        <!-- //Header -->
        
        <!-- container -->
        <div id="container" class="login_container">
            <!-- contents -->
            <div class="register">
                <form name="login_form" action="<%=cp%>/member/login_ok.do" method="post">
                    <fieldset>
                        <div class="box_login">
                            <h3 class="title">로그인</h3>
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
                                <label class="radio">
                                    <input name="radioLevel" type="radio" value="user"/>
                                    <span class="lbl">개인</span>
                                </label>
                                <label class="radio ml20">
                                    <input name="radioLevel" type="radio" value="company"/>
                                    <span class="lbl">회사</span>
                                </label>
                            </div>
                            <div class="mt30">
                                <button type="button" class="btn_login" onclick="sendOk()">로그인</button>
                            </div>
                        </div>
                    </fieldset>
                </form>
                <div class="login_info">
                    <a href="#">아이디 찾기</a><span class="bar">|</span> 
                    <a href="#">비밀번호 찾기</a><span class="bar">|</span> 
                    <a href="#">회원가입</a>
                </div>
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
        
        <!-- Footer -->
        <footer>
            <div class="box_footer">
                <div class="links">
                    <ul>
                        <li><a href="#" target="_blank" title="회사소개 새창열기">회사소개</a></li>
                        <li><a href="#" target="_blank" title="찾아오시는길 새창열기">찾아오시는길</a></li>
                        <li><a href="#" title="회원약관 바로가기">회원약관</a></li>
                        <li><a href="#" title="개인정보처리방침 바로가기">개인정보처리방침</a></li>
                        <li><a href="#" title="이메일무단수집거부 바로가기">이메일무단수집거부</a></li>
                        <li><a href="#" title="고객센터 바로가기">고객센터</a></li>
                    </ul>
                </div>
                <div class="copyright">
                    <p>(주)SARAMIT | 주소 : 서울특별시 마포구 월드컵북로 21 풍성빌딩 2-4층 쌍용강북교육센터<br/>
                    대표 : 이민영, 김진양, 임상근, 홍재승, 김소민 | 사업자등록 : 123-45-67890<br/>
                    Copyright (c) (주)SARAMIT. All rights reserved.</p>
                </div>
            </div>
        </footer>
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