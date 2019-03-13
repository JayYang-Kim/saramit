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
	<style>
		.freeBody {
    		background-color: #F5F6F7;
    		min-height: 830px;
    	}
    	
    	.freeBody .freeContainer{
    		width:700px;
  			padding-top:30px;
  			margin : 0 auto;
  			min-height: 830px;
    	}
    	
    	.freeBody .freeContainer .board{
    		min-height: 600px;
    		background-color: #fff;
    		border: 1px solid #e4e4e4;
    		margin-top : 20px;
    	}
    	
    	.freeBody .freeContainer .board .innerDiv{
    		border-bottom: 1px solid #e4e4e4;
    		width: 100%;
    		padding: 5px 0 5px;
    	}
		.ui-widget-header {
  			background: #4c4c4c;
  			color: #fff;
  		}
  		.freeBody .freeContainer .board .replyForm{
  			width:600px;
    		margin : 15px auto 15px;
    		border :1px solid #e4e4e4;
    	}
    	
    </style>
    <script type="text/javascript">
    var current_page;
    $(function(){
    	$("#btn_update").click(function(){
    		$("#dlg_update").dialog({
    			title:"확인메세지",
    			width:350,
    			height:140,
    			modal:true,
    			hide:"explode"
    		});
    		$("#update_ok").click(function(){
				location.href="<%=cp%>/board/free/update.do?page=${page}&num=${dto.boardNum}";
			});
			$("#update_cancel").click(function(){
				$("#dlg_update").dialog("close");
			});
    	});
    	$("#btn_delete").click(function(){
    		$("#dlg_delete").dialog({
    			title:"확인메세지",
    			width:350,
    			height:140,
    			modal:true,
    			hide:"explode"
    		});
    		$("#delete_ok").click(function(){
				location.href="<%=cp%>/board/free/delete.do?page=${page}&num=${dto.boardNum}";
			});
			$("#delete_cancel").click(function(){
				$("#dlg_delete").dialog("close");
			});
    	});    	
    });
    
    $(function(){
    	listPage(1);
    });
    function listPage(page) {
    	var url = "<%=cp%>/board/free/reply.do";
    	var query = "pageNo="+page+"&boardNum=${dto.boardNum}";
    	
    	$.ajax({
    		type:"get",
    		url:url,
    		data:query,
    		dataType:"json",
    		success:function(data){
    			current_page = data.current_page;
    			drawReply(data);
    		},
    		error:function(e){
    			console.log(e.responseText);
    		}
    	});
    }
    function drawReply(data){
    	if(data.list.length != 0){
    		out+= "<div align='left' style='margin-bottom:5px; padding-left:10px;'><h3>총 "+data.dataCount+"개의 댓글</h3></div>"
    		for(var i=0; i<data.list.length; i++){
    			out += '<div style="border-top: 1px solid #e4e4e4; height:150px; padding: 3px 15px; font-size: 13px; line-height: 18px;" align="left">';
    			out += "	<input type='hidden' id='replyNum' value='"+data.list[i].replyNum+"'>";
        		out += '	<div style="color: black; font-weight: bold;"><span>'+data.list[i].email+'</span></div>';
        		out += '	<div><textarea readonly="readonly" style="border:0;" maxlength="300" >'+data.list[i].content+'</textarea></div>';
        		out += '	<div style="color:#ADADAD; height:26px;" align="right">';
        		out += '		<button class="btn btn-white" id="btn_updateReply" type="button" style="height:26px; display:none; float:left;">수정</button>';
        		out += '		<button class="btn btn-white" id="btn_cancle" type="button" style="height:26px; display:none;float:left;">취소</button>';
        		out += '		<p style="width:220px; float:right;">'+data.list[i].created+' |';
        		if(data.list[i].email == '${sessionScope.member.email}' || data.list[i].email == 'admin'){
        			out += ' 		<a id="updateReply" style="cursor:pointer;">수정</a> | <a id="deleteReply" style="cursor:pointer;">삭제</a></span></div>';
        		}else{
        			out += ' 신고</p></div>';	
        		}
        		out += '</div>';
    		}
    		out+= "<div align='center'>"+data.paging+"</div>"
    	}else{
    		var out ="";
    		out += "<div style='border-top: 1px solid #e4e4e4; padding: 15px; font-size: 13px; line-height: 18px;' align='left'>";
			out += "<div style='color: black; font-weight: bold;' align='center'><h3>등록된 댓글이 없습니다.</h3></div>";
			out += "</div>";
    	}
    	
    	$("#replyBody").html(out);
    }
    
    $(function(){
    	var current_value;
    	$("body").on("click","#updateReply",function(){
    		current_value = $(this).parent().parent().parent().find("textarea").val();
    		$(this).parent().parent().parent().find("textarea").removeAttr("readonly");
    		$(this).parent().parent().parent().find("textarea").css("border","1px solid #e4e4e4");
    		$(this).parent().parent().parent().find("#btn_updateReply").css("display","block");
    		$(this).parent().parent().parent().find("#btn_cancle").css("display","block");
	 	});
    	$("body").on("click","#btn_cancle",function(){
    		$(this).parent().parent().find("textarea").attr("readonly","readonly");
    		$(this).parent().parent().find("textarea").css("border","none");
    		$(this).parent().parent().find("#btn_updateReply").css("display","none");
    		$(this).parent().parent().find("#btn_cancle").css("display","none");
    		$(this).parent().parent().find("textarea").val(current_value);
    	});
    	$("body").on("click","#btn_updateReply",function(){
    		if(!$(this).parent().parent().find("textarea").val().trim()){
    			$(this).parent().parent().find("textarea").focus();
    			return;
    		}
    		var content = $(this).parent().parent().find("textarea").val().trim();
    		var replyNum = $(this).parent().parent().find("input[type=hidden]").val();
    		var query = "content="+encodeURIComponent(content)+"&replyNum="+replyNum+"&boardNum=${dto.boardNum}";
    		var url = "<%=cp%>/board/free/replyUpdate.do";
    		if(confirm("수정하시겠습니까?")){
    			$.ajax({
    				type:"post",
    				data:query,
    				url:url,
    				beforeSend:function(jqXHR){
    					jqXHR.setRequestHeader("AJAX",true); //서버에서  AJAX라는 사실을 알 수 있도록 헤더에 정보를 보낸다. 내가 그냥 추가 시키는 거
    				},
    				success:function(data){
    					listPage(current_page);
    				},
    				error:function(e){
    					console.log(e.responseText);
    				}
    			});
    		}
    	});
    	$("body").on("click","#deleteReply",function(){
    		var replyNum = $(this).parent().parent().parent().find("input[type=hidden]").val();
    		console.log(replyNum);
    		var query = "replyNum="+replyNum+"&boardNum=${dto.boardNum}";
    		var url = "<%=cp%>/board/free/replyDelete.do";
    		if(confirm("삭제하시겠습니까?")){
	    		$.ajax({
    				type:"post",
    				data:query,
    				url:url,
    				beforeSend:function(jqXHR){
    					jqXHR.setRequestHeader("AJAX",true); //서버에서  AJAX라는 사실을 알 수 있도록 헤더에 정보를 보낸다. 내가 그냥 추가 시키는 거
    				},
    				success:function(data){
    					listPage(current_page);
    				},
    				error:function(e){
    					console.log(e.responseText);
    				}
    			});
	    	}
	 	});
    	
    	
    });
   
    
    $(function(){
    	$("#btn_reply").click(function(){ //리플 삽입
    		if(!$("#replyContent").val().trim()){
    			$("#replyContent").focus();
    			return;
    		}
    		var url = "<%=cp%>/board/free/replyInsert.do";
    		var content = encodeURIComponent($("#replyContent").val().trim());
    		var query="content="+content+"&boardNum=${dto.boardNum}";
    		$.ajax({
    			type:"post",
    			url:url,
    			data:query,
    			dataType:"json",
    			beforeSend:function(jqXHR){
    				jqXHR.setRequestHeader("AJAX",true); //서버에서  AJAX라는 사실을 알 수 있도록 헤더에 정보를 보낸다. 내가 그냥 추가 시키는 거
    			},
    			success:function(data){
    				$("#replyContent").val("");
    				listPage(1);
    			},
    			error:function(e){
    				console.log(e.responseText);
    			}
    		});
    	});
    })
    </script>
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
            	<div style="position: absolute; right: 0;top: 500px;"><img alt="사진없지롱" src="<%=cp%>/resources/movingKAKAO.gif"></div>
				<div class="freeBody">
					<div class="freeContainer">
						<h1 style="text-align: left; padding: 5px 8px">자유게시판</h1>
						<div class="board" align="center" style="text-align: center">
							<h2 style="text-align: center; padding: 5px 8px; background-color: #4c4c4c; color: #fff">글보기</h2> 
								<div class="innerDiv" style="padding-top: 15px; text-align: left;">
									<b style="margin-left: 60px;">제 &nbsp;목 : </b><input type="text" name="subject" value="${dto.subject}"style="margin-left:5px; width: 55%; font-weight:bold; height: 30px; border: none; outline: none;" readonly="readonly">
									<b>조회수 :&nbsp;</b>${dto.hitCount}
								</div>
								<div class="innerDiv" style=" text-align: left;">
									<b style="margin-left: 60px;">작성자 : </b><input type="text" name="writer" value="${dto.name}" readonly="readonly" style="border: none; outline: none; width:55%; font-weight: bold;">
									<b>작성일 :&nbsp;${dto.created}</b>
									
								</div>
								<div class="innerDiv">
									<textarea style="width:80%; height: 350px; outline: none; border: none;" maxlength="1000" name="content" readonly="readonly">${dto.content}</textarea>
								</div>
									<div align="left" style="border-bottom:1px solid #e4e4e4; height:30px; padding-top:10px; line-height: 20px;"><p style="padding-left:60px;">
									<b>이전 글 : </b><a style="cursor: pointer" onclick="javascript:location.href='${prev_url}'">${prevDto.subject}</a></p></div>
									<div align="left" style="border-bottom:1px solid #e4e4e4; height:30px; padding-top:10px; line-height: 20px;"><p style="padding-left:60px;">
									<b>다음 글 : </b><a style="cursor: pointer" onclick="javascript:location.href='${next_url}'">${nextDto.subject}</a></p></div>
								<div style="margin-top: 10px; height: 45px; border-bottom: 1px solid #e4e4e4">
									<c:if test="${dto.userEmail == sessionScope.member.email}">
									<button type="button" class="btn btn-black" id="btn_update">수정하기</button>&nbsp;
									</c:if>
									<c:if test="${dto.userEmail == sessionScope.member.email or sessionScope.member.email=='admin'}">
									<button type="button" class="btn btn-black" id="btn_delete">삭제하기</button>&nbsp;
									</c:if>
									<button type="button" class="btn btn-black" onclick="javascript:location.href='${list_url}';">목록으로</button>
								</div>
								<div style="margin: 0 auto;text-align: left; width: 600px; margin-top: 10px;">
									<h3>댓글</h3>
								</div>
								<div class="replyForm">
									<div style="width: 100%;border-bottom: 1px solid #e4e4e4">
										<p style="text-align:left;width: 100%; padding:8px 10px; color: black;">${sessionScope.member.email}</p>
										<textarea id="replyContent" style="width: 550px; margin-top: 3px; border: none;" placeholder="200자 까지만 입력가능합니다." maxlength="300"></textarea>
									</div>
									<div align="right" style="height: 26px; border-bottom: 1px solid #e4e4e4">
										<button type="button" id="btn_reply" class="btn btn-black" style="height:26px; line-height: 10px; margin-right:3px;">올리기</button>
									</div>
								</div>
								<div id="replyBody" style="width: 600px; margin: 0 auto"></div>
						</div>
					</div>
					<!-- freeContainer -->
				</div>
				<!-- free body -->
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
        <!-- Footer -->
       	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <!-- //Footer -->
    </div>
    <!-- //Wrap -->
    <div id="dlg_update" style="display:none;" align="center">
    	<h3>해당 게시물을 수정하시겠습니까?</h3>
	    <div style="margin-top:30px;">
	    <button class="btn btn-black" id="update_ok">확인</button>
	    <button class="btn btn-black" id="update_cancel">취소</button>
	    </div>
    </div>
    <div id="dlg_delete" style="display:none;" align="center">
    	<h3>해당 게시물을 삭제하시겠습니까?</h3>
    	<div style="margin-top:30px;">
    	<button class="btn btn-black" id="delete_ok">확인</button>
    	<button class="btn btn-black" id="delete_cancel">취소</button>
    	</div>
    </div>
</body>
</html>