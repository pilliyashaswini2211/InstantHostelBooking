<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>


<%
// Database configuration
String dbUrl = "jdbc:mysql://localhost:3306/hosteldb";
String dbUser = "root";
String dbPassword = "";

// Get form data
String mobile = request.getParameter("mobile");
String password = request.getParameter("password");


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    // Load the JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");
    
    // Establish connection
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    
    // Check owner credentials
    String sql = "SELECT owner_id, full_name, mobile FROM hostel_owner WHERE mobile = ? AND password = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, mobile);
    pstmt.setString(2, password); // In production, use password hashing
    
    rs = pstmt.executeQuery();
    
    if (rs.next()) {
        // Owner authenticated successfully
        int ownerId = rs.getInt("owner_id");
        String fullName = rs.getString("full_name");
        String ownerMobile = rs.getString("mobile");
        
        // Set session attributes
        session.setAttribute("ownerId", ownerId);
        session.setAttribute("ownerName", fullName);
        session.setAttribute("ownerMobile", ownerMobile);
        session.setAttribute("isOwnerLoggedIn", true);
        
        // Redirect to owner dashboard
        response.sendRedirect("owner/owner-dashboard.jsp");
    } else {
        // Invalid credentials
        session.setAttribute("error", "Invalid mobile number or password");
        response.sendRedirect("owner-login.jsp");
    }
} catch (Exception e) {
    e.printStackTrace();
    session.setAttribute("error", "Database error. Please try again later.");
    response.sendRedirect("owner-login.jsp");
} finally {
    // Close resources
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>