<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var num = 1;
	function add(){
		var div = document.createElement("div");
		div.innerHTML = document.getElementById('work-detail').innerHTML;
		div.id = 'div'+num;
		div.innerHTML += "<br>";
		document.getElementById('work').appendChild(div);
	}
	
	function remove(obj){
		document.getElementById('work').removeChild(obj.parentNode);
	}
</script>
</head>
<body>
	<input type="button" value="추가" onclick="add();"><br>
	<div id="work">
	<h1>| 경력 사항</h1><br>
		<div id="work-detail" style="margin-top:30px; display: none;">
			<input type="text" value="" placeholder="직장명"><br>
			<input type="date" value="" placeholder="입사일" required="required">
			<input type="date" value="" placeholder="퇴사일" required="required"><br>
			<input type="text" value="" placeholder="부서"><br>
			<input type="text" value="" placeholder="직위">
			<button type="button" onclick="remove(this);">삭제</button>
		</div>
	</div>
</body>
</html>