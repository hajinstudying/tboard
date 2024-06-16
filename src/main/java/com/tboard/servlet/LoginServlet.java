package com.tboard.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tboard.vo.Member;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 로그인 폼 JSP로 요청을 전달
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        
        // 진입점 경로
        String contextPath = request.getContextPath();
        
        // 회원 정보를 저장할 리스트
        List<Member> memberList = new ArrayList<>();

        // 데이터베이스 접속 및 쿼리 실행 객체
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        // JDBC 설정 정보
        String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
        String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
        String DB_USER = "tboard";
        String DB_PASSWORD = "1234";

        try {
            // JDBC 드라이버 로드
            Class.forName(JDBC_DRIVER);

            // 데이터베이스 연결
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            stmt = conn.createStatement();

            // 회원 정보를 가져오는 쿼리문
            String sql = "SELECT member_id, password FROM member";

            // 쿼리문 실행 및 결과 저장
            rs = stmt.executeQuery(sql);

            // 결과 처리
            while (rs.next()) {
                String memberId = rs.getString("member_id");
                String password = rs.getString("password");

                // Member 객체 생성 및 리스트에 추가
                Member member = new Member(memberId, password);
                memberList.add(member);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 로그인 확인
        boolean loginSuccess = false;

        // 입력받은 로그인 정보
        String loginId = request.getParameter("id");
        String loginPwd = request.getParameter("password");

        // 입력받은 정보와 데이터베이스 정보를 비교
        for (Member member : memberList) {
            if (loginId.equals(member.getMemberId()) && loginPwd.equals(member.getPassword())) {
                loginSuccess = true;
                break;
            }
        }

        // 세션 생성하여 로그인 아이디 저장
        HttpSession session = request.getSession();

        if (loginSuccess) {
            // 로그인 성공 처리
            session.setAttribute("loginId", loginId);
            response.sendRedirect(contextPath + "/index.jsp");
        } else {
            // 로그인 실패 처리
            response.sendRedirect(contextPath + "/loginForm.jsp");
        }
    }
}