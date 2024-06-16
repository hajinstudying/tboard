<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.tboard.vo.*, java.util.*, java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 컨텍스트패스(진입점 폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardDetail</title>
</head>
<body>
	<%
	// 쿼리스트링에 딸려온 보드넘버 가져오기
	String bno = request.getParameter("bno");

	//객체들 선언
	Board board = null;
	Connection conn = null;
	PreparedStatement pstmt = null;
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

		// 쿼리문 생성
		String sql = "SELECT board_no, title, content, member_id, reg_date FROM board "
					 + " WHERE board_no = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(bno));
		
		// 쿼리문 실행 및 결과 받기
		rs = pstmt.executeQuery();

		// 결과 루프
		while (rs.next()) {
			int boardNo = rs.getInt("board_no");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String memberId = rs.getString("member_id");
			java.sql.Date regDate = rs.getDate("reg_date");

			// db에서 조회한 정보 객체로 저장
			board = new Board(boardNo, title, content, memberId, regDate);

		}
	} catch (Exception e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		try {
			if (rs != null)
		rs.close();
			if (pstmt != null)
		pstmt.close();
			if (conn != null)
		conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 목록을 page 영역에 저장
	pageContext.setAttribute("board", board);
	%>
	<c:choose>
		<c:when test="${empty board}">
			<p>해당 게시글을 찾을 수 없습니다.</p>
		</c:when>
		<c:otherwise>
			<h3>게시글 조회</h3>
			<table border="1">
				<tr>
					<th>번호</th>
					<td>${board.boardNo}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${board.title}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${board.content}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${board.memberId}</td>
				</tr>
				<tr>
					<th>작성일자</th>
					<td>${board.regDate}</td>
				</tr>
			</table>
		</c:otherwise>
	</c:choose>
</body>
</html>