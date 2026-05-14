<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
    Integer ownerId = (Integer) session.getAttribute("ownerId");
    if (ownerId == null) {
        response.sendRedirect("owner-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="menu.jsp" %>
<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h2>Hostel Bookings</h2>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Booking ID</th>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Student Mobile</th>
                        <th>Hostel Name</th>
                        <th>Booking Date</th>
                        <th>Duration (days)</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

                        String sql = "SELECT b.booking_id, s.student_id, s.full_name, s.mobile, h.hostel_name, " +
                                     "b.booking_date, b.booking_duration_days, b.status " +
                                     "FROM booking b " +
                                     "INNER JOIN hostel h ON b.hostel_id = h.hostel_id " +
                                     "INNER JOIN student s ON b.student_id = s.student_id " +
                                     "WHERE h.owner_id = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, ownerId);
                        rs = stmt.executeQuery();

                        boolean found = false;
                        while (rs.next()) {
                            found = true;
                %>
                    <tr>
                        <td><%= rs.getInt("booking_id") %></td>
                        <td><%= rs.getInt("student_id") %></td>
                        <td><%= rs.getString("full_name") %></td>
                        <td><%= rs.getString("mobile") %></td>
                        <td><%= rs.getString("hostel_name") %></td>
                        <td><%= rs.getDate("booking_date") %></td>
                        <td><%= rs.getInt("booking_duration_days") %></td>
                        <td><%= rs.getString("status") %></td>
                    </tr>
                <%
                        }
                        if (!found) {
                %>
                    <tr>
                        <td colspan="8" class="text-center">No Bookings Found</td>
                    </tr>
                <%
                        }
                    } catch(Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
