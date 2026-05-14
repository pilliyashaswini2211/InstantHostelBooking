<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Details - Book Now</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .logo { height: 40px; margin-right: 10px; }
        .hostel-card { transition: transform 0.2s; }
        .hostel-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .carousel-inner img {
            object-fit: cover;
            height: 400px;
        }
    </style>
</head>
<body>

<%@ include file="menu.jsp" %>

<!-- Main Content -->
<div class="container mt-4">
    <h2>Hostel Details</h2>
    <div class="alert alert-info">
        <p>Below are the full details of the hostel. You can proceed with the booking if interested.</p>
    </div>

    <%
        // Fetching the hostel details from the database
        String hostelIdParam = request.getParameter("hostel_id");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

            String sql = "SELECT * FROM hostel WHERE hostel_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(hostelIdParam));
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Hostel details from the database
                String hostelName = rs.getString("hostel_name");
                String hostelType = rs.getString("hostel_type");
                String description = rs.getString("description");
                String location = rs.getString("location");
                String city = rs.getString("city");
                String state = rs.getString("state");
                String mobile = rs.getString("mobile");
                String facilities = rs.getString("facilities");
                String cost = rs.getString("cost");
                String roomDetails = rs.getString("room_details");
                String foodDetails = rs.getString("food_details");
                String availabilityStatus = rs.getString("availability_status");
                String pic1 = rs.getString("pic1");
                String pic2 = rs.getString("pic2");
                String pic3 = rs.getString("pic3");
                String pic4 = rs.getString("pic4");
        %>

            <!-- Hostel Details Display -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><%= hostelName %></h5>
                    <p class="card-text"><strong>Type:</strong> <%= hostelType %></p>
                    <p class="card-text"><strong>Location:</strong> <%= location %>, <%= city %>, <%= state %></p>
                    <p class="card-text"><strong>Contact:</strong> <%= mobile %></p>
                    <p class="card-text"><strong>Cost per Month:</strong> ₹<%= cost %></p>
                    <p class="card-text"><strong>Availability Status:</strong> <%= availabilityStatus %></p>

                    <!-- Image Gallery with Carousel -->
                    <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <% if (pic1 != null) { %>
                                <div class="carousel-item active">
                                    <img src="../uploads/<%= pic1 %>" class="d-block w-100" alt="Hostel Image 1">
                                </div>
                            <% } if (pic2 != null) { %>
                                <div class="carousel-item">
                                    <img src="../uploads/<%= pic2 %>" class="d-block w-100" alt="Hostel Image 2">
                                </div>
                            <% } if (pic3 != null) { %>
                                <div class="carousel-item">
                                    <img src="../uploads/<%= pic3 %>" class="d-block w-100" alt="Hostel Image 3">
                                </div>
                            <% } if (pic4 != null) { %>
                                <div class="carousel-item">
                                    <img src="../uploads/<%= pic4 %>" class="d-block w-100" alt="Hostel Image 4">
                                </div>
                            <% } %>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>

                    <!-- Hostel Description -->
                    <div class="mt-4">
                        <h6>Description:</h6>
                        <p><%= description %></p>
                    </div>

                    <!-- Hostel Facilities -->
                    <div class="mt-4">
                        <h6>Facilities:</h6>
                        <p><%= facilities %></p>
                    </div>

                    <!-- Room Details -->
                    <div class="mt-4">
                        <h6>Room Details:</h6>
                        <p><%= roomDetails %></p>
                    </div>

                    <!-- Food Details -->
                    <div class="mt-4">
                        <h6>Food Details:</h6>
                        <p><%= foodDetails %></p>
                    </div>

                    <!-- Booking Form -->
                    <div class="mt-4">
                        <h5>Book Hostel</h5>
                        <form method="post" action="confirm-booking.jsp">
                            <div class="mb-3">
                                <label for="booking_duration_days" class="form-label">Booking Duration (in days)</label>
                                <input type="number" class="form-control" name="booking_duration_days" value="30" min="1" required>
                            </div>
                            <input type="hidden" name="student_id" value="<%= session.getAttribute("student_id") %>">
                            <input type="hidden" name="hostel_id" value="<%= hostelIdParam %>">
                            <button type="submit" class="btn btn-primary">Confirm Booking</button>
                        </form>
                    </div>
                </div>
            </div>

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
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
