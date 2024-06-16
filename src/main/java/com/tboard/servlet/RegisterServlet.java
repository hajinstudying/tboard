package com.tboard.servlet;

import java.io.IOException;
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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/loginForm.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");

        // 진입점 경로
        String contextPath = request.getContextPath();
        
        // 파라미터에서 값 가져오기
        String memberId = request.getParameter("id");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // jdbc 드라이버 연결
        Connection conn = null;
        PreparedStatement pstmt = null;


        String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
        String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
        String DB_USER = "tboard";
        String DB_PASSWORD = "1234";

        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO member(member_id, password, name, email) VALUES(?, ?, ?, ?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            pstmt.setString(2, password);
            pstmt.setString(3, name);
            pstmt.setString(4, email);

            int result = pstmt.executeUpdate();
            if (result > 0) {
                response.sendRedirect(contextPath + "/loginForm.jsp");
            } else {
                request.setAttribute("errorMessage", "회원 가입에 실패했습니다.");
                RequestDispatcher dispatcher = request.getRequestDispatcher(contextPath + "/registerForm.jsp");
                dispatcher.forward(request, response);
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "JDBC 드라이버를 찾을 수 없습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher(contextPath + "/registerForm.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "회원 가입 중 데이터베이스 오류가 발생했습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher(contextPath + "/registerForm.jsp");
            dispatcher.forward(request, response);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}