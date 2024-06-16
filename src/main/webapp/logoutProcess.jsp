<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String contextPath = request.getContextPath();

//세션 삭제
session.invalidate();

//로그아웃 후 게시판 인덱스 페이지로 이동
response.sendRedirect(contextPath + "/index.jsp");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>logoutProcess</title>
</head>
<body>

</body>
</html>