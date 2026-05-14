<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    Integer ownerId = (Integer) session.getAttribute("ownerId");
    if (ownerId == null) {
        response.sendRedirect("owner-login.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    String fullName = request.getParameter("full_name");
    String mobile = request.getParameter("mobile");
    String password = request.getParameter("password"); // may be empty

    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

        String sql = "";
        if (password == null || password.trim().equals("")) {
            // Update without changing password
            sql = "UPDATE hostel_owner SET full_name=?, mobile=? WHERE owner_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, mobile);
            stmt.setInt(3, ownerId);
        } else {
            // Update with new password
            sql = "UPDATE hostel_owner SET full_name=?, mobile=?, password=? WHERE owner_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, mobile);
            stmt.setString(3, password);
            stmt.setInt(4, ownerId);
        }

        int rows = stmt.executeUpdate();
        if (rows > 0) {
%>
            <script>
                alert('Profile updated successfully!');
                window.location.href = 'owner-profile.jsp';
            </script>
<%
        } else {
%>
            <script>
                alert('Profile update failed!');
                window.location.href = 'owner-profile.jsp';
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert('Error occurred. Please try again.');
        window.location.href = 'owner-profile.jsp';
    </script>
<%
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
