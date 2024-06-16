package com.tboard.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/write")
public class WriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public WriteServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		// 진입점 경로
		String contextPath = request.getContextPath();

		// 파라미터 가져오기
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		// 세션에서 로그인 아이디 가져오기
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");

		// 세션의 로그인 아이디가 없으면 로그인 페이지로 이동
		if (loginId == null || loginId.isEmpty()) {
		    response.sendRedirect(contextPath + "/loginForm.jsp");
		    return; // 메서드 종료
		}
		
		// jdbc 설정 정보 세팅
		// jdbc 드라이버 로딩 문자열
		String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
		// 데이터베이스 접속 문자열
		String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
		// 접속 계정(아이디/비밀번호)
		String DB_USER = "tboard";
		String DB_PASSWORD = "1234";
		
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

			String sql = "insert into board(board_no, title, content, member_id) ";
			sql = sql + " values(seq_bno.nextval, ?, ?, ?)";
			
			// PreparedStatement 객체 얻기
			pstmt = conn.prepareStatement(sql);
			// 쿼리문의 ?에 파라미터 세팅
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, loginId);

			pstmt.executeUpdate(); // 쿼리 실행

			// 메인화면(게시글목록)으로 이동
			response.sendRedirect(contextPath + "/index.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			out.println("도서 등록 중 오류가 발생했습니다." + e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
