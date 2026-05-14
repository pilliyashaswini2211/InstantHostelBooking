<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
   <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
</head>
<body>

<%@ include file="menu.jsp" %>

<!-- Main Content -->
<div class="container mt-4">
    <h2>Booking Confirmation</h2>

    <%
        // Retrieving form data
        int studentId = Integer.parseInt(request.getParameter("student_id"));
        int hostelId = Integer.parseInt(request.getParameter("hostel_id"));
        int bookingDuration = Integer.parseInt(request.getParameter("booking_duration_days"));

        // Preparing to insert the booking into the database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

            // Insert the booking details into the database
            String sql = "INSERT INTO booking (student_id, hostel_id, booking_duration_days, status) VALUES (?, ?, ?, 'Booked')";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            stmt.setInt(2, hostelId);
            stmt.setInt(3, bookingDuration);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
    %>
                <div class="alert alert-success">
                    <h4>Booking Successful!</h4>
                    <p>Your booking for the hostel has been confirmed. Duration: <%= bookingDuration %> days.</p>
                </div>
                <a href="student-bookings.jsp" class="btn btn-primary">View My Bookings</a>
    <%
            } else {
    %>
                <div class="alert alert-danger">
                    <h4>Error!</h4>
                    <p>There was an issue with your booking. Please try again later.</p>
                </div>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Display error message
    %>
            <div class="alert alert-danger">
                <h4>Error!</h4>
                <p>There was an issue with the database. Please try again later.</p>
            </div>
    <%
        } finally {
            try {
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
