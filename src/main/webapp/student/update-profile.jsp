<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.*, jakarta.servlet.http.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - InstantHostelBooking</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
</head>
<body>

<div class="container mt-4">
    <h2>Profile Updated Successfully</h2>
    <p>Your profile has been updated successfully.</p>
    <a href="student-profile.jsp" class="btn btn-success">Go Back to Profile</a>
</div>

<%
    // Get the student_id from the session
    int studentId = (int) session.getAttribute("student_id");

    // Retrieve the updated values from the request
    String fullName = request.getParameter("full_name");
    String mobile = request.getParameter("mobile");
    String password = request.getParameter("password");

    // Database connection variables
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load the database driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Create the database connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

        // Prepare the SQL query to update the student profile
        String sql = "UPDATE student SET full_name = ?, mobile = ?, password = ? WHERE student_id = ?";
        stmt = conn.prepareStatement(sql);

        // Set the parameters for the SQL query
        stmt.setString(1, fullName);
        stmt.setString(2, mobile);
        stmt.setString(3, password);
        stmt.setInt(4, studentId);

        // Execute the update query
        int rowsUpdated = stmt.executeUpdate();

        // Check if the update was successful
        if (rowsUpdated > 0) {
            // Optionally, update the session with the new full_name
            session.setAttribute("full_name", fullName);
        }
    } catch (Exception e) {
        // Print stack trace in case of any error
        e.printStackTrace();
    } finally {
        // Close database resources
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
