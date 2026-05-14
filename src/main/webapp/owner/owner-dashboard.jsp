<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>InstantHostelBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .logo {
            height: 40px;
            margin-right: 10px;
        }
        .booking-card {
            transition: transform 0.2s;
        }
        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
   <%@ include file="menu.jsp"%>

    <div class="container mt-4">
        <!-- Welcome Message -->
        <div class="alert alert-info">
            <h4 class="alert-heading">Welcome, <%= session.getAttribute("ownerName") %>!</h4>
            <p>Here are your recent bookings and activities.</p>
        </div>

        <!-- Recent Bookings Section -->
        <div class="row mb-4">
            <div class="col-md-12">
                <h3><i class="fas fa-calendar-alt"></i> Recent Bookings</h3>
                <div class="row">
                    <%
                        int ownerId = (Integer) session.getAttribute("ownerId");
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");
                            
                            String sql = "SELECT b.booking_id, b.booking_date, b.booking_duration_days, b.status, " +
                                         "s.full_name as student_name, s.mobile as student_mobile, " +
                                         "h.hostel_name, h.cost " +
                                         "FROM booking b " +
                                         "JOIN student s ON b.student_id = s.student_id " +
                                         "JOIN hostel h ON b.hostel_id = h.hostel_id " +
                                         "WHERE h.owner_id = ? " +
                                         "ORDER BY b.booking_date DESC LIMIT 5";
                            
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, ownerId);
                            rs = pstmt.executeQuery();
                            
                            while (rs.next()) {
                                String statusClass = "";
                                switch(rs.getString("status")) {
                                    case "Booked": statusClass = "bg-success"; break;
                                    case "Cancelled": statusClass = "bg-danger"; break;
                                    case "Completed": statusClass = "bg-secondary"; break;
                                    default: statusClass = "bg-info";
                                }
                    %>
                    <div class="col-md-4 mb-3">
                        <div class="card booking-card h-100">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <span>Booking #<%= rs.getInt("booking_id") %></span>
                                <span class="badge <%= statusClass %>"><%= rs.getString("status") %></span>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><%= rs.getString("hostel_name") %></h5>
                                <p class="card-text">
                                    <strong>Student:</strong> <%= rs.getString("student_name") %><br>
                                    <strong>Contact:</strong> <%= rs.getString("student_mobile") %><br>
                                    <strong>Booked On:</strong> <%= rs.getDate("booking_date") %><br>
                                    <strong>Duration:</strong> <%= rs.getInt("booking_duration_days") %> days<br>
                                    <strong>Total Cost:</strong> ₹<%= rs.getDouble("cost") * rs.getInt("booking_duration_days") / 30 %>
                                </p>
                            </div>
                           <!--  <div class="card-footer bg-transparent">
                                <a href="booking-details.jsp?id=<%= rs.getInt("booking_id") %>" class="btn btn-sm btn-primary">View Details</a>
                            </div>  -->
                        </div>
                    </div>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                    <div class="col-12">
                        <div class="alert alert-danger">Error loading bookings: <%= e.getMessage() %></div>
                    </div>
                    <%
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (pstmt != null) pstmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </div>
                
                <% if (session.getAttribute("message") != null) { %>
                    <div class="alert alert-success mt-3">
                        <%= session.getAttribute("message") %>
                    </div>
                    <% session.removeAttribute("message"); %>
                <% } %>
                
                <div class="text-center mt-3">
                    <a href="show-bookings.jsp" class="btn btn-outline-primary">View All Bookings</a>
                </div>
            </div>
        </div>
        
       <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#bookingsTable').DataTable({
                responsive: true,
                ordering: false,
                info: false,
                paging: false,
                searching: false
            });
        });
    </script>
</body>
</html>