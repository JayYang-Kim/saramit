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
    	function sendOk(){
    		var f = document.login_form;
    		
    		if(!$("input[type=radio][name=radioLevel]:checked").val()){
    			alert("로그인 종류를 선택하세요!");
    			return;
    		}
    		
    		f.submit();
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
            <div class="login">
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