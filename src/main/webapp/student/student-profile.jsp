<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - InstantHostelBooking</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
</head>
<body>

<%@ include file="menu.jsp" %>

<!-- Main Content -->
<div class="container mt-4 card">
    <h2>My Profile</h2>

    <%
        int studentId = (int) session.getAttribute("student_id");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

            // Fetch current student profile data
            String sql = "SELECT full_name, mobile, password FROM student WHERE student_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String fullName = rs.getString("full_name");
                String mobile = rs.getString("mobile");
                String password = rs.getString("password");
    %>

    <!-- Display Profile Information -->
    <form method="post" action="update-profile.jsp">
        <div class="mb-3">
            <label for="full_name" class="form-label">Full Name</label>
            <input type="text" class="form-control" name="full_name" value="<%= fullName %>" required>
        </div>
        <div class="mb-3">
            <label for="mobile" class="form-label">Mobile</label>
            <input type="text" class="form-control" name="mobile" value="<%= mobile %>" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" value="<%= password %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Update Profile</button>
    </form>

    <%
            } else {
    %>
        <div class="alert alert-danger">
            <h4>Error!</h4>
            <p>Unable to retrieve your profile details. Please try again later.</p>
        </div>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
        <div class="alert alert-danger">
            <h4>Error!</h4>
            <p>There was an issue retrieving your profile. Please try again later.</p>
        </div>
    <%
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
