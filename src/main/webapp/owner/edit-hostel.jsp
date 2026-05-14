<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Hostels | InstantHostelBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
</head>
<body>
 <%@ include file="menu.jsp" %>
    <div class="container mt-5 card">
        <h2 class="text-center mb-4 ">Edit Hostel Details</h2>
        
        <% 
            // Get the hostel ID from the URL parameter
            String hostelId = request.getParameter("id");

            if (hostelId != null) {
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    // Database connection setup
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

                    // Query to fetch hostel details based on hostel_id
                    String sql = "SELECT * FROM hostel WHERE hostel_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(hostelId));
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        // Fetch current details from the result set
                        String hostelName = rs.getString("hostel_name");
                        String hostelType = rs.getString("hostel_type");
                        String description = rs.getString("description");
                        String location = rs.getString("location");
                        String city = rs.getString("city");
                        String state = rs.getString("state");
                        String mobile = rs.getString("mobile");
                        String facilities = rs.getString("facilities");
                        String roomDetails = rs.getString("room_details");
                        String foodDetails = rs.getString("food_details");
                        String cost = rs.getString("cost");
                        String pic1 = rs.getString("pic1");
                        String pic2 = rs.getString("pic2");
                        String pic3 = rs.getString("pic3");
                        String pic4 = rs.getString("pic4");
        %>

        <!-- Form to edit hostel details -->
        <form action="edit-hostel-code.jsp" method="POST">
            <input type="hidden" name="hostel_id" value="<%= hostelId %>">
            <div class="mb-3">
                <label for="hostel_name" class="form-label">Hostel Name</label>
                <input type="text" class="form-control" id="hostel_name" name="hostel_name" value="<%= hostelName %>" required>
            </div>
            <div class="mb-3">
                <label for="hostel_type" class="form-label">Hostel Type</label>
                <select class="form-control" id="hostel_type" name="hostel_type">
                    <option value="boys" <%= "boys".equals(hostelType) ? "selected" : "" %>>Boys</option>
                    <option value="girls" <%= "girls".equals(hostelType) ? "selected" : "" %>>Girls</option>
                    <option value="co-ed" <%= "co-ed".equals(hostelType) ? "selected" : "" %>>Co-ed</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3"><%= description %></textarea>
            </div>
            <div class="mb-3">
                <label for="location" class="form-label">Location</label>
                <input type="text" class="form-control" id="location" name="location" value="<%= location %>" required>
            </div>
            <div class="mb-3">
                <label for="city" class="form-label">City</label>
                <input type="text" class="form-control" id="city" name="city" value="<%= city %>" required>
            </div>
            <div class="mb-3">
                <label for="state" class="form-label">State</label>
                <input type="text" class="form-control" id="state" name="state" value="<%= state %>" required>
            </div>
            <div class="mb-3">
                <label for="mobile" class="form-label">Mobile</label>
                <input type="text" class="form-control" id="mobile" name="mobile" value="<%= mobile %>">
            </div>
            <div class="mb-3">
                <label for="facilities" class="form-label">Facilities</label>
                <textarea class="form-control" id="facilities" name="facilities" rows="3"><%= facilities %></textarea>
            </div>
            <div class="mb-3">
                <label for="room_details" class="form-label">Room Details</label>
                <textarea class="form-control" id="room_details" name="room_details" rows="3"><%= roomDetails %></textarea>
            </div>
            <div class="mb-3">
                <label for="food_details" class="form-label">Food Details</label>
                <textarea class="form-control" id="food_details" name="food_details" rows="3"><%= foodDetails %></textarea>
            </div>
            <div class="mb-3">
                <label for="cost" class="form-label">Cost</label>
                <input type="text" class="form-control" id="cost" name="cost" value="<%= cost %>">
            </div>
            

            <button type="submit" class="btn btn-primary">Update Hostel</button>
        </form>
       

        <% } } catch (Exception e) {
            // Handle the exception and display an error message
            out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
            e.printStackTrace();
        }} else { %>
            <div class="alert alert-danger" role="alert">
                Hostel not found!
            </div>
        <% } %>

    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>
