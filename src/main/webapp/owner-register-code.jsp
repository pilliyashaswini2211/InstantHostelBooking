<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>


<%
// Database configuration
String dbUrl = "jdbc:mysql://localhost:3306/hosteldb";
String dbUser = "root";
String dbPassword = "";

// Get form data
String fullName = request.getParameter("fullName");
String mobile = request.getParameter("mobile");
String password = request.getParameter("password");

// Input validation
List<String> errors = new ArrayList<>();



if (!errors.isEmpty()) {
    session.setAttribute("errors", errors);
    response.sendRedirect("hostelOwnerRegister.jsp");
    return;
}

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    // Load the JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");
    
    // Establish connection
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    
    // Check if mobile already exists
    String checkSql = "SELECT owner_id FROM hostel_owner WHERE mobile = ?";
    pstmt = conn.prepareStatement(checkSql);
    pstmt.setString(1, mobile);
    rs = pstmt.executeQuery();
    
    if (rs.next()) {
        errors.add("Mobile number already registered");
        session.setAttribute("errors", errors);
        response.sendRedirect("hostelOwnerRegister.jsp");
        return;
    }
    
    // Insert new owner
    String insertSql = "INSERT INTO hostel_owner (full_name, mobile, password) VALUES (?, ?, ?)";
    pstmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
    pstmt.setString(1, fullName);
    pstmt.setString(2, mobile);
    pstmt.setString(3, password); // In production, use password hashing
    
    int affectedRows = pstmt.executeUpdate();
    
    if (affectedRows > 0) {
        // Get the generated owner_id
        ResultSet generatedKeys = pstmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            int ownerId = generatedKeys.getInt(1);
            
            // Set session attributes
            session.setAttribute("ownerId", ownerId);
            session.setAttribute("ownerName", fullName);
            session.setAttribute("ownerMobile", mobile);
            session.setAttribute("isOwnerLoggedIn", true);
            
            // Redirect to owner dashboard
            response.sendRedirect("owner/owner-dashboard.jsp");
        }
    } else {
        errors.add("Registration failed. Please try again.");
        session.setAttribute("errors", errors);
        response.sendRedirect("owner-register.jsp");
    }
} catch (Exception e) {
    e.printStackTrace();
    errors.add("Database error. Please try again later.");
    session.setAttribute("errors", errors);
    response.sendRedirect("hostelOwnerRegister.jsp");

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