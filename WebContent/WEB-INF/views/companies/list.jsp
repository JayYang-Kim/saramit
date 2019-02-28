<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%String cp = request.getContextPath();%>
<!DOCTYPE html>
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

    <!-- Carousel -->
    <script type="text/javascript" src="<%=cp%>/resources/js/carousel.js"></script>
   
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="resources/js/lib/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	<div id="wrap">
	<jsp:include page="../main/header.jsp"></jsp:include>
		<div style="height: 61px;"></div>
			<div class="contents" align="center">
				<div style="margin:30px">
					<form>
						<ul>
							<li style>서울</li>
							<li>서울</li>
							<li>서울</li>
							<li>서울</li>
							<li>서울</li>
							<li>서울</li>
							<li>서울</li>
							<li>서울</li>
							<li>서울</li>
						</ul>
					</form>
					
					<form>
						<select name="searchKey" style="text-align: center;">
							<option value="name">기업명</option>
							<option value="owner">대표자명</option>
							<option value="location">위치</option>
						</select>
						<input type="text" name="searchValue" height="35px">
						<button type="button" class="btn btn-black btn-bg" style="height:26px">검색</button>
					</form>
				</div>
			</div>
	<jsp:include page="../main/footer.jsp"></jsp:include>
     </div>
</body>
</html>