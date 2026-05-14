<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String mobile = request.getParameter("mobile");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

        String sql = "SELECT * FROM student WHERE mobile = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, mobile);
        stmt.setString(2, password);

        rs = stmt.executeQuery();

        if (rs.next()) {
            // Login successful
            session.setAttribute("student_id", rs.getInt("student_id"));
            session.setAttribute("full_name", rs.getString("full_name"));
            response.sendRedirect("student/student-dashboard.jsp");
        } else {
            // Login failed
            session.setAttribute("error", "Invalid mobile number or password!");
            response.sendRedirect("student/student-login.jsp");
        }

    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("error", "Something went wrong. Please try again!");
        response.sendRedirect("student/student-login.jsp");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
