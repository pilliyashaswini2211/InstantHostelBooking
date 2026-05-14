<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    request.setCharacterEncoding("UTF-8");
    String fullName = request.getParameter("fullName");
    String mobile = request.getParameter("mobile");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

        String sql = "INSERT INTO student (full_name, mobile, password) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, fullName);
        stmt.setString(2, mobile);
        stmt.setString(3, password);

        int rows = stmt.executeUpdate();
        if (rows > 0) {
%>
            <script>
                alert('Registration successful! Please login.');
                window.location.href = 'student-login.jsp';
            </script>
<%
        } else {
%>
            <script>
                alert('Registration failed. Please try again.');
                window.location.href = 'student-register.jsp';
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert('Something went wrong. Please try again.');
        window.location.href = 'student-register.jsp';
    </script>
<%
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
