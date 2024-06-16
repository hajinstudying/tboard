<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.tboard.vo.*, java.util.*, java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 컨텍스트패스(진입점 폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerAction</title>
</head>
<body>
	<%
	// 캐릭터 인코딩(message body에 담겨오는 파라미터들은 인코딩이 필요하다)
	request.setCharacterEncoding("utf-8");
	
	String memberId = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	//스크립트릿에서 컨텍스트 경로 얻기
	String contextPath = request.getContextPath();
	
	//jdbc 로드
	String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	String DB_USER = "tboard";
	String DB_PASSWORD = "1234";
	
	try{
		
		Class.forName(JDBC_DRIVER);
		conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
		String sql = "insert into member(member_id, password, name, email) ";
		sql = sql + " values(?, ?, ?, ?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memberId);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, email);
		
		pstmt.executeUpdate();
		
		response.sendRedirect(contextPath + "/login.jsp");
		
	} catch (Exception e){
		e.printStackTrace();
		out.println("회원가입 중 오류가 발생했습니다." + e.getMessage());
	} finally {
		try{
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}catch(Exception e) {
			e.printStackTrace();			
		}
	}
	%>
</body>
</html>