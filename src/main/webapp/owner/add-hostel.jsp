<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <div class="container mt-5 card">
        <h2 class="mb-4">Add New Hostel</h2>
        
        <form action="/InstantHostelBooking/AddHostelServlet" method="post" enctype="multipart/form-data">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="hostelName" class="form-label">Hostel Name</label>
                    <input type="text" class="form-control" id="hostelName" name="hostelName" required>
                </div>
                <div class="col-md-6">
                    <label for="hostelType" class="form-label">Hostel Type</label>
                    <select class="form-select" id="hostelType" name="hostelType" required>
                        <option value="">Select Type</option>
                        <option value="Boys">Boys</option>
                        <option value="Girls">Girls</option>
                        <option value="Co-ed">Co-ed</option>
                    </select>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
            </div>
            
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="location" class="form-label">Location</label>
                    <input type="text" class="form-control" id="location" name="location" required>
                </div>
                <div class="col-md-3">
                    <label for="city" class="form-label">City</label>
                    <input type="text" class="form-control" id="city" name="city" required>
                </div>
                <div class="col-md-3">
                    <label for="state" class="form-label">State</label>
                    <input type="text" class="form-control" id="state" name="state" required>
                </div>
            </div>
            
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="mobile" class="form-label">Contact Number</label>
                    <input type="text" class="form-control" id="mobile" name="mobile" required>
                </div>
                <div class="col-md-6">
                    <label for="cost" class="form-label">Monthly Cost (₹)</label>
                    <input type="number" step="0.01" class="form-control" id="cost" name="cost" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="facilities" class="form-label">Facilities (comma separated)</label>
                <input type="text" class="form-control" id="facilities" name="facilities" placeholder="e.g., WiFi, Laundry, AC">
            </div>
            
            <div class="mb-3">
                <label for="roomDetails" class="form-label">Room Details</label>
                <textarea class="form-control" id="roomDetails" name="roomDetails" rows="2"></textarea>
            </div>
            
            <div class="mb-3">
                <label for="foodDetails" class="form-label">Food Details</label>
                <textarea class="form-control" id="foodDetails" name="foodDetails" rows="2"></textarea>
            </div>
            
            <div class="mb-3">
    <label for="nearCollege" class="form-label">Nearby College</label>
    <select class="form-select" id="nearCollege" name="nearCollege">
        <option value="">Select College</option>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");
                
                String sql = "SELECT college_id, college_name FROM college ORDER BY college_name";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                
                while (rs.next()) {
        %>
        <option value="<%= rs.getInt("college_id") %>">
            <%= rs.getString("college_name") %>-<%= rs.getInt("college_id") %>
        </option>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <option value="">Error loading colleges</option>
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
    </select>
</div>
            
            <div class="mb-3">
                <label for="pic1" class="form-label">Hostel Image 1</label>
                <input type="file" class="form-control" id="pic1" name="pic1" accept="image/*">
            </div>
            <div class="mb-3">
                <label for="pic2" class="form-label">Hostel Image 2</label>
                <input type="file" class="form-control" id="pic2" name="pic2" accept="image/*">
            </div>
            <div class="mb-3">
                <label for="pic3" class="form-label">Hostel Image 3</label>
                <input type="file" class="form-control" id="pic3" name="pic3" accept="image/*">
            </div>
            <div class="mb-3">
                <label for="pic4" class="form-label">Hostel Image 4</label>
                <input type="file" class="form-control" id="pic4" name="pic4" accept="image/*">
            </div>
            
            <input type="hidden" name="ownerId" value="<%= session.getAttribute("ownerId") %>">
            
            <button type="submit" class="btn btn-primary">Add Hostel</button>
            <a href="owner-dashboard.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>