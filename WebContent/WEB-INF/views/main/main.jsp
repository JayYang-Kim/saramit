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
    <div id="wrap" class="tb_wrap">
        <!-- Header -->
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
        <!-- //Header -->
        <!-- container -->
        <div id="container" class="tb_container">
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
                            <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="4"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="5"></li>
                        </ol>
                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">
                            <div class="item active">
                                <img src="resources/images/title/title01.png" alt="2019. 03.15 SARAMIT 오픈">
                            </div>
                            <div class="item">
                                <img src="resources/images/title/title02.png" alt="SARAMIT 추천 채용">
                            </div>
                            <div class="item">
                                <img src="resources/images/title/title03.png" alt="우아한 형제들 2019 신입 / 경력 사원 채용공고">
                            </div>
                            <div class="item">
                                <img src="resources/images/title/title04.png" alt="카카오(KAKAO) 2019 신입 / 경력 사원 채용공고">
                            </div>
                            <div class="item">
                                <img src="resources/images/title/title05.png" alt="네이버(NAVER) 2019 신입 / 경력 사원 채용공고">
                            </div>
                            <div class="item">
                                <img src="resources/images/title/title06.png" alt="CJ 올리브네트웍스 2019 신입 / 경력 사원 채용공고">
                            </div>
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
                                <a href="<%=cp%>/resume/created.do" class="btn_classic btn-black mt20">나만의 이력서 작성</a>
                            </div>
                        </div>
                    </div>
                    <div class="companyList list">
                        <div class="inner">
                            <div class="list">
                                <h3 class="mt20 mb20">최신 회사정보</h3>
                                <ul>
                                  <c:forEach var="n" items="${recentCompanies}">
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color">
                                                <img src="<%=cp%>/resources/images/common/${n.savefilename}" alt="로고"/>
                                            </div>
                                            <span>${n.companyName}</span>
                                        </div>
                                        <ul>
                                            <li><span>사원수 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${n.employees}"/>(명)</span></li>
                                            <li><span>매출액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${n.sale}"/>(만원)</span></li>
                                            <li><span>평균연봉 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${n.salary}"/>(만원)</span></li>
                                            <li><span>위치 : ${n.location}</span></li>
                                        </ul>
                                        <div class="extra">
                                            <div class="site">
                                                <span>${n.homepage}</span>
                                            </div>
                                            <span><a style="cursor: pointer;" onclick="info('${n.companyEmail}')">더보기</a></span>
                                        </div>
                                    </li>
                                    </c:forEach>
                                </ul>
                                <a href="<%=cp%>/companies/list.do" class="add">회사 더보기</a>
                            </div>
                        </div>
                    </div>
                    <div class="companyList new">
                        <div class="inner">
                            <div class="list">
                                <h3 class="mt20 mb20">최신 회사정보</h3>
                                <ul>
                                    <li class="item">
                                        <div class="bg">
                                            <div class="color">
                                                <img src="<%=cp%>/resources/images/common/smilegate.gif" alt="로고"/>
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
                                <h3 class="mt20 mb20">인기 회사정보</h3>
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
                                <h3>공지사항</h3><p style="position: relative; top: 0; right: 0; z-index: 20"><a href="<%=cp%>/notification/list.do" class="add">공지사항 더보기</a></p>
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
       	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <!-- //Footer -->
    </div>
    <!-- //Wrap -->
</body>
</html>