<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 컨텍스트패스(진입점 폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<link rel="stylesheet" href="${contextPath}/css/writeForm.css">
</head>
<body>
	<div class="title-wrap">
		<h2 id="title">글 작성하기</h2>
	</div>
	<form action="${contextPath}/write" id="writeForm" method="post">
		<div class="input-wrap">
			<label for="title">제목</label>
			<input type="text" name="title" id="titleInput">
		</div>
		<div class="input-wrap">
			<label for="content">내용</label>
			<textarea name="content" id="contentInput"></textarea>
		</div>
		<div class="button-wrap">
			<button type="submit" id="submitBtn">등록</button>
		</div>
	</form>
</body>
</html>