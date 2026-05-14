<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>InstantHostelBooking - Student Dashboard</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .logo { height: 40px; margin-right: 10px; }
        .hostel-card { transition: transform 0.2s; }
        .hostel-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<%@ include file="menu.jsp" %>

<!-- Main Content -->
<div class="container mt-4">
    <div class="alert alert-success">
        <h4 class="alert-heading">Welcome, <%= session.getAttribute("full_name") %>!</h4>
        <p>Search for your hostel near your college and book it easily!</p>
    </div>

    <!-- Search Form with Dropdown -->
    <form method="get" action="student-dashboard.jsp" class="mb-4">
        <div class="input-group">
            <select name="college_id" class="form-select" required>
                <option value="">-- Select College --</option>
                <% 
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");
                        String sql = "SELECT college_id, college_name FROM college";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                            int id = rs.getInt("college_id");
                            String name = rs.getString("college_name");
                            String selected = (request.getParameter("college_id") != null && request.getParameter("college_id").equals(String.valueOf(id))) ? "selected" : "";
                %>
                            <option value="<%= id %>" <%= selected %>><%= name %></option>
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
            </select>
            <button type="submit" class="btn btn-success"><i class="fas fa-search"></i> Search</button>
        </div>
    </form>

    <!-- Hostel Details Display -->
    <div class="row">
        <%
            String collegeId = request.getParameter("college_id");
            if (collegeId != null && !collegeId.trim().equals("")) {
                conn = null;
                stmt = null;
                rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

                    String sql = "SELECT * FROM hostel WHERE near_college_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(collegeId));
                    rs = stmt.executeQuery();

                    boolean hostelFound = false;
                    while (rs.next()) {
                        hostelFound = true;
        %>
                        <div class="col-md-4 mb-4">
                            <div class="card hostel-card">
                                <!-- Carousel for images -->
                                <div id="carousel<%= rs.getInt("hostel_id") %>" class="carousel slide" data-bs-ride="carousel">
                                    <div class="carousel-inner">
                                        <div class="carousel-item active">
                                            <img src="../uploads/<%= rs.getString("pic1") %>" class="d-block w-100" alt="Hostel Image 1" style="height: 200px; object-fit: cover;">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="../uploads/<%= rs.getString("pic2") %>" class="d-block w-100" alt="Hostel Image 2" style="height: 200px; object-fit: cover;">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="../uploads/<%= rs.getString("pic3") %>" class="d-block w-100" alt="Hostel Image 3" style="height: 200px; object-fit: cover;">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="../uploads/<%= rs.getString("pic4") %>" class="d-block w-100" alt="Hostel Image 4" style="height: 200px; object-fit: cover;">
                                        </div>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#carousel<%= rs.getInt("hostel_id") %>" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#carousel<%= rs.getInt("hostel_id") %>" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>

                                <div class="card-body">
                                    <h5 class="card-title"><i class="fas fa-building me-2"></i><%= rs.getString("hostel_name") %></h5>
                                    <p class="card-text">
                                        <strong>Hostel Type:</strong> <%= rs.getString("hostel_type") %><br>
                                        <strong>Description:</strong> <%= rs.getString("description") %><br>
                                        <strong>Location:</strong> <%= rs.getString("location") %>, <%= rs.getString("city") %>, <%= rs.getString("state") %><br>
                                        <strong>Contact:</strong> <%= rs.getString("mobile") %><br>
                                        <strong>Facilities:</strong> <%= rs.getString("facilities") %><br>
                                        <strong>Rent per Month:</strong> ₹<%= rs.getString("cost") %><br>
                                        <strong>Room Details:</strong> <%= rs.getString("room_details") %><br>
                                        <strong>Food Details:</strong> <%= rs.getString("food_details") %><br>
                                        <strong>Status:</strong> <%= rs.getString("availability_status") %><br>
                                    </p>
                                    <form method="post" action="book-hostel.jsp">
                                        <input type="hidden" name="hostel_id" value="<%= rs.getInt("hostel_id") %>">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-bed me-2"></i>Book Hostel
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
        <%
                    }
                    if (!hostelFound) {
        %>
                        <div class="col-12">
                            <div class="alert alert-warning text-center">
                                No hostels found for selected college.
                            </div>
                        </div>
        <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
        %>
                    <div class="col-12">
                        <div class="alert alert-danger text-center">
                            Error fetching hostel details. Please try again later.
                        </div>
                    </div>
        <%
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            }
        %>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
