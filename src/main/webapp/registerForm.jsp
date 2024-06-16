<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!-- 컨텍스트패스(진입점 폴더) 변수 설정 -->
		<c:set var="contextPath" value="${pageContext.request.contextPath }" />

		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>registerForm</title>
		</head>

		<body>
			<h3>회원가입 페이지</h3>
			<form action="${contextPath}/register" method="post" id="regForm">
				<div>
					아이디: <input type="text" name="id" id="id">
				</div>
				<div>
					비밀번호: <input type="text" name="password" id="password">
				</div>
				<div>
					비밀번호 확인: <input type="text" name="pwdConfirm" id="pwdConfirm">
				</div>
				<div>
					이름: <input type="text" name="name" id="name">
				</div>
				<div>
					이메일 : <input type="text" name="email" id="email">
				</div>
				<div>
					<input type="submit" id="btnSubmit" value="전송">
				</div>
			</form>

			<script>
				// form 태그 submit 이벤트 핸들러 설정
				const form = document.getElementById("regForm");
				form.addEventListener("submit", (event) => { // 이벤트의 종류는 "submit"
					// submit 막아두기
					event.preventDefault();
					// 각 입력 요소들의 참조 주소값을 변수에 할당
					// getElementById("id") : 메소드 자체가 id 속성으로 찾기 때문에 ("#id")와 같이 사용 안함.
					let idInput = document.getElementById("id");
					let pwdInput = document.getElementById("password");
					let pwdConInput = document.getElementById("pwdConfirm");
					let nameInput = document.getElementById("name");
					let emailInput = document.getElementById("email");

					// 입력 요소들의 값을 추출(trim 함수로 값 좌우측 공백 제거)
					let id = idInput.value.trim();
					let pwd = pwdInput.value.trim();
					let pwdCon = pwdConInput.value.trim();
					let name = nameInput.value.trim();
					let email = emailInput.value.trim();

		            //// 정규표현식
		            // 아이디는 첫 글자는 영문자, 나머지는 영문자 또는 숫자로 5자리에서 8자리까지
		            const regExpId = /^[a-zA-Z][a-zA-Z0-9]{4,7}$/;
		            // 이름이 반드시 한글로 시작하고, 2자 이상 5자 이하의 길이
		            const regExpName = /^[가-힣]{2,5}$/;
		            // 비밀번호는 특수문자와 영어 대문자, 소문자, 숫자를 모두 포함해야 하면 전체 자릿수는 5자리에서 8자리까지
		            const regExppwd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{5,8}$/;
		            // 이메일 정규식
		            const regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

					// 아이디 검증
					if (id === "") {
						alert("아이디를 입력하세요.")
						idInput.focus();
						return;
					}
					if (!regExpId.test(id)) {
						alert("아이디는 영문자로 시작하고 5자리에서 8자리로 입력하세요.")
						idInput.focus();
						return;					
					}

					// 비밀번호 검증 ()
					if (pwd === "") {
						alert("비밀번호를 입력하세요."); 
						pwdInput.focus();
						return;
					}
					if (!regExppwd.test(pwd)) {
						alert("비밀번호는 영문 대소문자와 숫자, 특수문자를 포함하여 5자리에서 8자리로 입력하세요.."); 
						pwdInput.focus();
						return;
					}
					if ((pwd !== pwdCon)) {
						alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.")
						pwdConInput.focus();
						return;
					}

					// 이름 검증
					if (name === "") {
						alert("이름을 입력해주세요.");
						nameInput.focus();
						return;
					}
					if (!regExpName.test(name)) {
						alert("이름은 한글 2-8글자로 입력해주세요.");
						nameInput.focus();
						return;
					}

					// 이메일 검증
					if (email === "") {
						alert("이메일을 입력해주세요.")
						emailInput.focus();
						return;
					}
					if (!regExpEmail.test(email)) {
						alert("이메일을 확인해주세요.")
						emailInput.focus();
						return;
					}

					// 모든 검증이 끝난 후 submit
					form.submit();
				});
			</script>
		</body>

		</html>