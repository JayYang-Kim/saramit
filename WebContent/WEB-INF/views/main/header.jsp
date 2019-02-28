<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%String cp = request.getContextPath(); %>
   <!-- Css -->
    <link rel="stylesheet" href="./resources/css/common.css" media="all" />
	<link rel="stylesheet" href="./resources/css/style.css" media="all" />

    <!-- Javascript -->
    <script src="./resources/js/lib/jquery-1.12.4.min.js"></script>
	<script src="./resources/js/lib/jquery-migrate-1.4.1.min.js"></script>
    <script src="./resources/js/lib/jquery-ui-1.12.1.min.js"></script>
    
    <script src="./resources/js/plugins.js"></script>
    <script src="./resources/js/basic.js"></script>

    <!-- Carousel -->
    <script type="text/javascript" src="./resources/js/carousel.js"></script>
   
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="resources/js/lib/html5shiv.js"></script>
    <![endif]-->

<header>
            <div class="header">
                <h1 class="title">
                    <a href="main.html">SARAMIT</a>
                </h1>
                <!-- gnb : 회사 -->
                <!-- <div class="gnb">
                    <ul>
                        <li><a href="#">회사검색</a></li>
                        <li><a href="#">지원확인</a></li>
                        <li><a href="#">피드백 게시판</a></li>
                        <li><a href="#">자유게시판</a></li>
                        <li><a href="#">사람잇과 소통</a></li>
                    </ul>
                </div> -->
                <!-- //gnb -->
                <!-- gnb : 유저 -->
                <div class="gnb">
                    <ul>
                        <li><a href="#">회사검색</a></li>
                        <li><a href="#">회사평가</a></li>
                        <li><a href="#">피드백 게시판</a></li>
                        <li><a href="#">자유게시판</a></li>
                        <li><a href="#">자소서 관리</a></li>
                    </ul>
                </div>
                <!-- //gnb -->
                <!-- 회원 : 비로그인 -->
                <c:if test="${sessionScope.member.email == null}">
                <div class="userInfo">
                    <ul>
                        <li><a href="<%=cp%>/member/login.do">로그인</a></li>
                        <li><span>|</span></li>
                        <li><a href="<%=cp%>/member/join.do">회원가입</a></li>
                    </ul>
                </div>
                </c:if>
                <!-- //회원 -->
                <!-- 회원 : 로그인 -->
                <c:if test="${sessionScope.member.email != null}">
	                <div class="userInfo_login">
	                    <ul>
	                        <li><span>${sessionScope.member.name}</span></li>
	                        <li><span>|</span></li>
	                        <li><a href="<%=cp%>/member/myPage.do">마이페이지</a></li>
	                        <li><span>|</span></li>
	                        <li><a href="<%=cp%>/member/logout.do">로그아웃</a></li>
	                    </ul>
	                </div> -->
                </c:if>
                <!-- 회원 : 로그인 -->
            </div>
        </header>