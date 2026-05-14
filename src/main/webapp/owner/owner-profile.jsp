<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    Integer ownerId = (Integer) session.getAttribute("ownerId");
    if (ownerId == null) {
        response.sendRedirect("owner-login.jsp");
        return;
    }

    String fullName = "";
    String mobile = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

        String sql = "SELECT * FROM hostel_owner WHERE owner_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, ownerId);
        rs = stmt.executeQuery();
        if (rs.next()) {
            fullName = rs.getString("full_name");
            mobile = rs.getString("mobile");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Owner Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="menu.jsp" %>
<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-success text-white text-center">
            <h2>Owner Profile</h2>
        </div>
        <div class="card-body">
            <form action="owner-profile-update.jsp" method="post">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name:</label>
                    <input type="text" class="form-control" id="fullName" name="full_name" value="<%= fullName %>" required>
                </div>
                <div class="mb-3">
                    <label for="mobile" class="form-label">Mobile:</label>
                    <input type="text" class="form-control" id="mobile" name="mobile" value="<%= mobile %>" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">New Password (leave blank to keep current password):</label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>
                <button type="submit" class="btn btn-primary w-100">Update Profile</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
