<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%String cp = request.getContextPath();%>
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
    <script src="<%=cp%>/resources/js/util.js"></script>

    <!-- Carousel -->
    <script type="text/javascript" src="<%=cp%>/resources/js/carousel.js"></script>
    
    <!-- 다음 주소검색 -->
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
   
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="<%=cp%>/resources/js/lib/html5shiv.js"></script>
    <![endif]-->