<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!-- 컨텍스트패스(진입점 폴더) 변수 설정 -->
	<c:set var="contextPath" value="${pageContext.request.contextPath }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm.jsp</title>
</head>
<body>
	<h3>로그인(정규식 추가)</h3>
	<form action="${contextPath }/login" method="post" id="loginForm">
		<p>아이디 : <input type="text" id="id" name="id" size="10"/></p>	
		<p>비밀번호 : <input type="password" id="password" name="password" size="10"></p>
		<input type="submit" value="로그인">
		<input type="reset" value="다시입력">
	</form>
	<a href="${contextPath}/register.jsp">회원등록</a>
	
	<script>
	 	const form = document.querySelector("#loginForm"); 
     	form.addEventListener("submit", function(event){
				// submit 방지
				event.preventDefault();
				// id 속성이 "id"인 요소의 참조 주소를 가져옴
				let idInput = document.getElementById("id");
				// id 속성이 "password"인 요소의 참조 주소를 가져옴
				let pwdInput = document.getElementById("password");
				
				// idInput 요소의 입력값 가져옴. 양쪽의 빈칸을 제거하고 가져옴
				let id = idInput.value.trim();
				let password = pwdInput.value.trim();
			
				// 입력값 검증 플래그 변수 선언
				let isValid = true; // 모든 값의 유효성 검사 플래그
				
				// id 검증
				if(id === "") {
					alert("아이디를 입력하세요.")
					isValid = false;
					idInput.focus(); // 커서를 idInput(아이디 입력칸)으로 이동해줌
					return false; //자바스크립트를 끝내라는 의미
				}
				
				// id 길이 검증
				if(id.length < 5){
					alert("아이디는 5자 이상어야합니다.")
					isValid = false;
					idInput.focus();
					return false;
				}
				
				// id 정규식 검증
				// regs : regularExpression의 약자
				const idRegex = /^[A-Za-z0-9]+$/;
				if(!idRegex.test(id)){
					alert("아이디는 영문과 숫자만 가능합니다.")
					isValid = false;
					idInput.focus();
					return false;
				}
						
				// password 검증
				if(password === "") {
					alert("비밀번호를 입력하세요.")
					isValid = false;
					pwdInput.focus();
					return false;		
				}
				// password 정규식 검증
				const pwdRegex = /[ `!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
				if(!pwdRegex.test(password)){
					alert("비밀번호는 특수문자가 포함되어있어야 합니다.")
					isValid = false;
					pwdInput.focus();
					return false;
				}
				
				// 검증 결과 확인 (isValid가 true이면 문제가 없었다는 의미)
				if(isValid) {
					form.submit();
				}
			});
	</script>
</body>
</html>