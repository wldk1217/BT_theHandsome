<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>
 
function loginClick(){
   location.href="member/login";
}
 
</script>

<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<html>
<head>
<title>Home</title>
</head>
<body>
   <h1>메인 페이지 입니다!</h1>
   <hr>
   <hr>
  
   <button id='Login' type="button" onclick="loginClick()">로그인</button>

</body>
</html>


<script type="text/javascript">
   
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>