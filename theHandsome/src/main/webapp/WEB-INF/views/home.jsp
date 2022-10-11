<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<script>
 
function loginClick(){
	$("#loginForm").attr("action", "/member/login");
    $("#loginForm").submit();
}
 
</script>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>    <button id='loginForm' type="button" onclick="loginClick()">
                  로그인
         </button> </P>
</body>
</html>


<script type="text/javascript">
	$(document)
	.ready(
		function() {
					
			//새글 등록 처리
			$("#JoinBtn").on("click", function () {
				self.location="/member/joininfoform";				
			});
</script>