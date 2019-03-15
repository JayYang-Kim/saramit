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
	<style type="text/css">
		.cp_info_bg {
			width: 100%;
			height: 200px;
			background-image: url("<%=cp%>/resources/images/common/bg-header9.png");
		}
		.cp_info_logoBox{
			width:1040px;
			padding-left:145px;
			height:100%;
			z-index: 10;
			margin : 0 auto;
			left:0;
			top:50%;
		}
		
		.cp_info_logo{
			position: relative;
			top:30%;
			width: 100px;
			height: 80px;
			background-color: #fff;
			box-sizing: border-box;
			float: left;
		}
		
		.cp_info_title{
			position:relative;
			top:30%;
			text-align: left;
			padding-left: 30px;
			color:#fff;
			font-size: 20px;
			float: left;
			height:80px;
			padding-top:25px;
		}
		.cp_info_logo img{
			position: relative;
			top:30%;
		}
		.cp_info_apply {
			position: relative;
			top:20%;
			float:right;
			width: 150px;
			margin-right: 200px;
		}
		.cp_info_apply button{
			color: #fff;
			width:100%;
		}
		
		.cp_info_body {
			width:100%;
			height : 1050px;
			background: #e4e4e4;
			
		}
		.body_info {
			
		}
		#map {
			
	        height: 400px;
	        width: 100%;
	        margin : 0 auto 0;
        }
		
	</style>
</head>

<body>
    <!-- Wrap -->
    <div id="wrap" class="tb_wrap">
        <!-- Header -->
        <!-- //Header -->
        <!-- container -->
        <div id="container" class="tb_container">
            <!-- contents -->
            <div class="contents">
                <div class="cp_info_bg">
                   	<div class="cp_info_logoBox">
                   		<div class="cp_info_logo">
                   			<img src="<%=cp%>/uploads/photo/${company.savefilename}" width="100%">
                   		</div>
                   		<div class="cp_info_title">
                   			${company.companyName}<br>
                   		</div>
                   		<div class="cp_info_apply">
                   			<button class="btn btn-black" onclick="window.open('http://${company.homepage}')">홈페이지</button>
							<p></p>
							<br>
                   			<button class="btn btn-black" onclick="javascript:alert('지원하였습니다.')">지원하기</button>
                   			<p></p>
                   			<br>
                   			<form action="<%=cp%>/companies/review.do" method="post">
                   				<input type="hidden" name="email" value="${company.companyEmail}">
	                   			<button class="btn btn-black">평가하기</button>
                   			</form>
                   			
                   		</div>
                    </div>
                    
                </div>
                <div class="cp_info_body inner">
           			<div style="background-color: #ffffff; height:1050px;">
           			<!-- <ul class="tabmenu2 tabMotion" style="padding-left: 100px;">
           				<li><a onclick="javascript:document.getElementById('info').style.display='';" style="cursor : pointer;">기업정보</a></li>
           				<li><a onclick="javascript:document.getElementById('info').style.display='none';" style="cursor : pointer;">기업리뷰</a></li>
           			</ul> -->
                	<!-- change를 위한  div -->
                	<div id="info" class="p20">
                		<div style="text-align: left; padding-top: 20px; padding-left:10px;padding-bottom:30px;">
                			<h3>| 기업 소개</h3>
                		</div>
                		<div class="body_info">
                		<table class="tb_basic_row" style="table-layout:fixed;">
                				<tr height="50px">
                					<th width="140px">
                						회사명 
                					</th>
                					<td align="left" width="260px">
                						${company.companyName}
                					</td>
                					<th width="140px">
                						대표자
                					</th>
                					<td align="left" width="260px">
                						${company.owner}
                					</td>
                				</tr>
                				<tr height="50px">
                					<th>
                						설립일 
                					</th>
                					<td align="left">
                						${company.establishmentDate}
                					</td>
                					<th>
                						사이트
                					</th>
                					<td align="left">
                						${company.homepage}
                					</td>
                				</tr>
                				<tr height="50px">
                					<th>
                						사원수 
                					</th>
                					<td align="left">
                						<fmt:formatNumber type="number" maxFractionDigits="3" value="${company.employees}"/>(명)
                					</td>
                					<th>
                						매출액 
                					</th>
                					<td align="left">
                						<fmt:formatNumber type="number" maxFractionDigits="3" value="${company.sale}"/>(만원)
                					</td>
                				</tr>
                				<tr height="50px">
                					<th>
                						평균연봉 
                					</th>
                					<td align="left">
                						<fmt:formatNumber type="number" maxFractionDigits="3" value="${company.salary}"/>(만원)
                					</td>
                					<th>
                						위치
                					</th>
                					<td align="left">
                						${company.location}
                					</td>
                				</tr>
                				<tr height="80px">
                					<th>
                						소 개
                					</th>
                					<td align="left" colspan="3">
                						${company.introduction}
                					</td>
                				</tr>
                		</table>
                		<div style="text-align: left; padding-top: 30px; padding-left:10px; margin-bottom:30px;">
                			<h3>| 기업 위치</h3>
                		</div>
                		 <div id="map">
                		 		
			                 <script type="text/javascript">
			                 
						      function initMap() {
						    	var address = "${company.location}";
					            var geocoder = new google.maps.Geocoder();
					            var xPosition;
					            var yPosition;
					            
					            geocoder.geocode({'address':address}, function(results,status){
					            		if(status == 'OK'){
					            			 var uluru = {lat: parseFloat(results[0].geometry.location.lat()), lng: parseFloat(results[0].geometry.location.lng())};
										        var map = new google.maps.Map(document.getElementById('map'), {
										          zoom: 18,
										          center: uluru
										        });
										        var marker = new google.maps.Marker({
										          position: uluru,
										          map: map
										        });
					            		}else{
					            			document.getElementById("map").innerHTML = "구글 맵을 불러오지 못하였습니다.";
					            		}
					            });
					           
						       
						      }
						    </script>
						    <script async defer
						   	 src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAbw2AXKEI1KEvuwEQVCf3JmudVJQyWJpU&callback=initMap&sensor=false">
						    </script>
		                </div>
		                <!-- //map -->
		                <div align="center" style="margin-top:15px;">
		                <button type="button" class="btn btn-black" style="width:100%;padding:15px 0;margin-top:20px" onclick="javascript:location.href='${url}'">돌아가기</button>
		                </div>
			    	</div>
			    	<!-- //body_info -->
			    	</div>
			    	<!-- change를 위한 div -->
			    </div>
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