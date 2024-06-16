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
<title>게시판</title>
</head>
<body>
	<h3>게시판 글 목록</h3>
	<c:choose>
	<c:when test="${not empty loginId}">
		<c:out value="${loginId}님 환영합니다." /> <br>
		<a href="${contextPath}/writeForm.jsp">글 작성하기</a>
		<a href="${contextPath}/logoutProcess.jsp">로그아웃</a>
	</c:when>
	<c:otherwise>
		<a href="${contextPath}/loginForm.jsp">로그인</a>
		<a href="${contextPath}/registerForm.jsp">회원가입</a>
	</c:otherwise>
	</c:choose>
	
	<%
	// 게시글 목록을 저장할 ArrayList
	List<Board> boardList = new ArrayList<>();

	// db 접속 및 쿼리 실행 객체 선언
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	// jdbc 설정 정보 세팅
	// jdbc 드라이버 로딩 문자열
	String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	// db 접속 문자열
	String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	// 접속 계정
	String DB_USER = "tboard";
	String DB_PASSWORD = "1234";

	try {
		// jdbc 드라이버 로드
		Class.forName(JDBC_DRIVER);
		
		// db 커넥션 객체
		conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		stmt = conn.createStatement();

		// 쿼리문 생성
		String sql = "SELECT board_no, title, content, member_id, reg_date FROM board";

		// 쿼리문 실행 및 결과 받기
		rs = stmt.executeQuery(sql);

		// 결과 루프
		while (rs.next()) {
			int boardNo = rs.getInt("board_no");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String memberId = rs.getString("member_id");
			java.sql.Date regDate = rs.getDate("reg_date");

			
			// db에서 조회한 정보 객체로 저장
			Board board = new Board(boardNo, title, content, memberId, regDate);

			// 객체를 배열에 넣기
			boardList.add(board);
		}
	} catch (Exception e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		try {
			if (rs != null)
		rs.close();
			if (stmt != null)
		stmt.close();
			if (conn != null)
		conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 목록을 page 영역에 저장
	pageContext.setAttribute("boardList", boardList);
	%>

	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="board" items="${boardList }">
			<tr>
				<td>${board.getBoardNo()}</td>
				<td><a href="${contextPath}/boardDetail.jsp?bno=${board.getBoardNo()}">${board.getTitle() }</a></td>
				<td>${board.getMemberId()}</td>
				<td>${board.getRegDate()}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>