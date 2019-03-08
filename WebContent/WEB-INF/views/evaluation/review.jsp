<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/layout/import.jsp"></jsp:include>
<style type="text/css">
.cp_info_bg {
	width: 100%;
	height: 200px;
	background-image: url("<%=cp%>/resources/images/common/bg-header9.png");
}

.cp_info_logoBox {
	width: 1040px;
	padding-left: 145px;
	height: 100%;
	z-index: 10;
	margin: 0 auto;
	left: 0;
	top: 50%;
}

.cp_info_logo {
	position: relative;
	top: 30%;
	width: 100px;
	height: 80px;
	background-color: #fff;
	box-sizing: border-box;
	float: left;
}

.cp_info_title {
	position: relative;
	top: 30%;
	text-align: left;
	padding-left: 30px;
	color: #fff;
	font-size: 20px;
	float: left;
	height: 80px;
	padding-top: 25px;
}

.cp_info_logo img {
	position: relative;
	top: 30%;
}

.cp_info_apply {
	position: relative;
	top: 20%;
	float: right;
	width: 150px;
	margin-right: 200px;
}

.cp_info_apply button {
	color: #fff;
	width: 100%;
}

.cp_info_body {
	width: 100%;
	height: 1050px;
	background: #e4e4e4;
}

.body_info {
	
}

.body_info table {
	margin-top: 20px;
	background: #fff;
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
	height: 400px;
	width: 80%;
	margin: 0 auto;
}

#map {
	height: 400px;
	width: 80%;
	margin: 0 auto 0;
}

div {
	border: none;
}

.star {
	font-size: 0;
	letter-spacing: -4px;
}

.star a {
	font-size: 50px;
	letter-spacing: 0;
	display: inline-block;
	margin-left: 3px;
	color: #cccccc;
	text-decoration: none;
}

.star a:first-child {
	margin-left: 0;
}

.star a.on {
	color: #F2CB61;
}
</style>


<script type="text/javascript">
    function sendReview() {
        var f = document.ReviewForm;

    	var str = f.content1.value;
        if(!str) {
            alert("content1을 입력하세요. ");
            f.content1.focus();
            return;
        }
        
        var str = f.content2.value;
        if(!str) {
            alert("content2을 입력하세요. ");
            f.content2.focus();
            return;
        }
        
        var str = f.content3.value;
        if(!str) {
            alert("content3을 입력하세요. ");
            f.content3.focus();
            return;
        }
        
        var str = f.content4.value;
        if(!str) {
            alert("content4을 입력하세요. ");
            f.content4.focus();
            return;
        }
        
    	var mode="${mode}";
    	if(mode=="created")
    		f.action="<%=cp%>/companies/review_ok.do";
    	else if(mode=="update")
    		f.action="<%=cp%>/companies/reviewUp_ok.do";

		f.submit();
	}

	$(function() {
		$(".star a").click(function() {
			var b = $(this).hasClass("on");
			$(this).parent().children("a").removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
			if (b)
				$(this).removeClass("on");

			var s = $(".star .on").length;
			$("#score").val(s);

		});
	});
</script>
</head>
<body>
<div id="wrap">
	<div class="cp_info_bg">
		<div class="cp_info_logoBox">
			<div class="cp_info_logo">
				<img src="<%=cp%>/resources/images/common/${savefilename}" width="100%"> 
					
			</div>
			<div class="cp_info_title">
				${cop_name}<br>
				<p style="font-size: 14px; padding-left: 3px;">게임/서버 개발 전문 기업</p>
			</div>
		</div>

	</div>
	<div style="background-color: #F5F6F7;">
		<div class="reviewForm"
			style="width: 60%; background-color: white; margin: 0 auto;">
			<div style="text-align: left; padding-top: 30px; padding-left: 10px;">
				<h1>| 평가 작성</h1>
			</div>
			
			<div>

				<form name="ReviewForm" method="post">

					<div class="t_center mt30">
						<span style="display: inline-block; width: 20%;">기업 총 평점</span>
						<div class="p30" style="display: inline-block; width: 70%;">
							<p class="star">
								<a href="#">★</a> 
								<a href="#">★</a> 
								<a href="#">★</a> 
								<a href="#">★</a> 
								<a href="#">★</a>
							</p>
						</div>


						<input type="hidden" name="score" id="score" value="${dto.star}"
							readonly="readonly">


					</div>

					<div class="t_center mt30">
						<span style="display: inline-block; width: 20%;">기업한줄평</span>
						<div class="p30" style="display: inline-block; width: 70%;">
							<textarea name="content1" style="width: 85%;">${dto.content1}</textarea>
						</div>
					</div>
					<div class="t_center mt30">
						<span style="display: inline-block; width: 20%;">기업의 장점</span>
						<div class="p30" style="display: inline-block; width: 70%;">
							<textarea name="content2" style="width: 85%;">${dto.content2}</textarea>
						</div>
					</div>
					<div class="t_center mt30">
						<span style="display: inline-block; width: 20%;">기업의 단점</span>
						<div class="p30" style="display: inline-block; width: 70%;">
							<textarea name="content3" style="width: 85%;">${dto.content3}</textarea>
						</div>
					</div>
					<div class="t_center mt30">
						<span style="display: inline-block; width: 20%;">경영진에 바라는 점</span>
						<div class="p30" style="display: inline-block; width: 70%;">
							<textarea name="content4" style="width: 85%;">${dto.content4}</textarea>
						</div>
					</div>


					<div class="t_center mt20 pb20">
						<input type="hidden" name="email" value="${email}">
						<button type="button" class="btn_classic btn-black">작성취소</button>
						<button type="button" class="btn_classic btn-black ml20"
							onclick="sendReview();">${mode=='update'?'수정완료':'등록완료'}</button>
					</div>

				</form>
			</div>

		</div>
		
        </div>
        <!-- //container -->
        <!-- Footer -->
       	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <!-- //Footer -->
    </div>
    <!-- //Wrap -->
</body>
</html>