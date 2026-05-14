<%@ page import="java.sql.*, java.io.*, jakarta.servlet.*, jakarta	.servlet.http.*" %>
<%@ page session="true" %>
<%
    // Get the form data
    String hostelId = request.getParameter("hostel_id");
    String hostelName = request.getParameter("hostel_name");
    String hostelType = request.getParameter("hostel_type");
    String description = request.getParameter("description");
    String location = request.getParameter("location");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String mobile = request.getParameter("mobile");
    String facilities = request.getParameter("facilities");
    String roomDetails = request.getParameter("room_details");
    String foodDetails = request.getParameter("food_details");
    String cost = request.getParameter("cost");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

        // Update query
        String sql = "UPDATE hostel SET hostel_name=?, hostel_type=?, description=?, location=?, city=?, state=?, mobile=?, facilities=?, room_details=?, food_details=?, cost=? WHERE hostel_id=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, hostelName);
        stmt.setString(2, hostelType);
        stmt.setString(3, description);
        stmt.setString(4, location);
        stmt.setString(5, city);
        stmt.setString(6, state);
        stmt.setString(7, mobile);
        stmt.setString(8, facilities);
        stmt.setString(9, roomDetails);
        stmt.setString(10, foodDetails);
        stmt.setString(11, cost);
        stmt.setInt(12, Integer.parseInt(hostelId));

        int rowsUpdated = stmt.executeUpdate();
        
        if (rowsUpdated > 0) {
            // Successfully updated
            out.println("<script>alert('Hostel updated successfully!'); window.location.href='my-hostels.jsp';</script>");
        } else {
            // Hostel ID not found or update failed
            out.println("<script>alert('Update failed! Try again.'); window.location.href='edit-hostel.jsp?id=" + hostelId + "';</script>");
        }

    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.location.href='edit-hostel.jsp?id=" + hostelId + "';</script>");
        e.printStackTrace();
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
