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
    <link rel="Shortcut Icon" href="./resources/images/common/saramit.ico"/>
    
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
</head>

<body>
    <!-- Wrap -->
    <div id="wrap">
        <!-- Header -->
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
        <!-- //Header -->
        
        <!-- container -->
        <div id="container">
            <div style="height:61px"></div>
            <!-- contents -->
            <div class="contents">
                <div>
                    <!-- carousel -->
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>
                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">
                            <div class="item active">
                                <img src="resources/images/common/web_title_img_1551145711.jpg" alt="img">
                            </div>
                            <div class="item">
                                <img src="resources/images/common/web_title_img_1551145711.jpg" alt="img">
                            </div>
                            <div class="item">
                                <img src="resources/images/common/web_title_img_1551145711.jpg" alt="img">
                            </div>
                            <!-- <div class="item active">
                                <img src="resources/images/main_img/main_slide01.jpg" alt="...">
                                <div class="main_slide_btn">
                                    <img src="resources/images/main_img/main_slide_txt01.png" alt="">
                                </div>
                            </div>
                            <div class="item">
                                <img src="resources/images/main_img/main_slide02.jpg" alt="...">
                                <div class="main_slide_btn">
                                    <img src="resources/images/main_img/main_slide_txt02.png" alt="">
                                    <p class="mt25">
                                        <a href="#" class="button main">자세히 보기</a>
                                    </p>
                                </div>
                            </div>
                            <div class="item">
                                <img src="resources/images/main_img/main_slide03.jpg" alt="...">
                                <div class="main_slide_btn">
                                    <img src="resources/images/main_img/main_slide_txt03.png" alt="">
                                    <p class="mt25">
                                        <a href="#" class="button main">자세히 보기</a>
                                    </p>
                                </div>
                            </div> -->
                        </div>
                    
                        <!-- Controls -->
                        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                    <!-- //carousel -->
                    <div class="newUser_info">
                        <div class="inner">
                            <div class="t_center">
                                <h3>"야 너도 취업할 수 있어!! 취준생 당신을 응원합니다."</h3>
                                <p>취준생 모두가 취업하는 그날까지</p>
                                <a href="#" class="btn_classic btn-black mt20">나만의 이력서 작성</a>
                            </div>
                        </div>
                    </div>
                    <div class="companyList list">
                        <div class="inner">
                            <div class="list">
                                <h3>최신 회사정보</h3>
                                <ul>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color">
                                                <img src="./resources/images/common/smilegate.gif" alt="로고"/>
                                            </div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                </ul>
                                <a href="#" class="add">회사 더보기</a>
                            </div>
                        </div>
                    </div>
                    <div class="companyList new">
                        <div class="inner">
                            <div class="list">
                                <h3>최신 회사정보</h3>
                                <ul>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color">
                                                <img src="./resources/images/common/smilegate.gif" alt="로고"/>
                                            </div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                </ul>
                                <a href="#" class="add">회사 더보기</a>
                            </div>
                        </div>
                    </div>
                    <!-- //companyList -->
                    <div class="companyList top">
                        <div class="inner">
                            <div class="list">
                                <h3>인기 회사정보</h3>
                                <ul>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color"></div>
                                            <span>회사명</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : </span></li>
                                            <li><span>매출액 : </span></li>
                                            <li><span>평균연봉 : </span></li>
                                            <li><span>위치 : </span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>http://naver.com</span>
                                            </div>
                                            <a href="#">더보기</a>
                                        </div>
                                    </li>
                                </ul>
                                <a href="#" class="add">회사 더보기</a>
                            </div>
                        </div>
                    </div>
                    <div class="notice_event">
                        <div class="inner">
                            <div class="first">
                                <h3>인기 피드백</h3>
                                <ul>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                </ul>
                            </div>
                            <div>
                                <h3>공지사항</h3>
                                <ul>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">SARAMIT 사이트 오픈</a>
                                        <span>2019.02.27</span>
                                    </li>
                                </ul>
                            </div>
                            <div>
                                <h3>이벤트</h3>
                                <ul>
                                    <li>
                                        <a href="#">야 너도 취업할 수 있어!!</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">야 너도 취업할 수 있어!!</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">야 너도 취업할 수 있어!!</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">야 너도 취업할 수 있어!!</a>
                                        <span>2019.02.27</span>
                                    </li>
                                    <li>
                                        <a href="#">야 너도 취업할 수 있어!!</a>
                                        <span>2019.02.27</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <!-- //inner -->
                    </div>
                    <!-- //noticeEvent -->
                </div>
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
        
        <!-- Footer -->
        <footer class="clear">
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
                    <span class="b_logo">SARAMIT</span>
                </div>
            </div>
        </footer>
        <!-- //Footer -->
    </div>
    <!-- //Wrap -->
</body>
</html>