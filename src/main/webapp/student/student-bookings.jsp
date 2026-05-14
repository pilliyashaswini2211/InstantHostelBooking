<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - InstantHostelBooking</title>
   <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
</head>
<body>

<%@ include file="menu.jsp" %>

<!-- Main Content -->
<div class="container mt-4">
    <h2>My Bookings</h2>

    <%
        int studentId = (int) session.getAttribute("student_id");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

            // SQL to fetch all bookings of the student
            String sql = "SELECT b.booking_id, h.hostel_name, b.booking_duration_days, b.status, b.booking_date " +
                         "FROM booking b " +
                         "JOIN hostel h ON b.hostel_id = h.hostel_id " +
                         "WHERE b.student_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            rs = stmt.executeQuery();

            if (!rs.next()) {
    %>
                <div class="alert alert-warning">
                    You have no active bookings.
                </div>
    <%
            } else {
    %>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Hostel Name</th>
                            <th scope="col">Booking Duration (Days)</th>
                            <th scope="col">Booking Date</th>
                            <th scope="col">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        do {
                    %>
                        <tr>
                            <td><%= rs.getString("hostel_name") %></td>
                            <td><%= rs.getInt("booking_duration_days") %> days</td>
                            <td><%= rs.getDate("booking_date") %></td>
                            <td><%= rs.getString("status") %></td>
                        </tr>
                    <%
                        } while (rs.next());
                    %>
                    </tbody>
                </table>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <div class="alert alert-danger">
                <h4>Error!</h4>
                <p>There was an issue retrieving your booking details. Please try again later.</p>
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
