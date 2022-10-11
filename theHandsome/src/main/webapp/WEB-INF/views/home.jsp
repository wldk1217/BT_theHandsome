<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>
 
function joinClick(){
	location.href="member/joininfoform";
}
 
</script>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>메인 페이지 입니다!</h1>
	<button id='Join' type="button" onclick="joinClick()">회원가입</button>

</body>
</html>


<script type="text/javascript">
	
</script>

<%@ include file="./includes/footer.jsp" %>