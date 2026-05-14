<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page session="true"%>

        <% 
            // Get the hostel ID from the request parameter
            String hostelId = request.getParameter("id");
            
            if (hostelId != null) {
                Connection conn = null;
                PreparedStatement stmt = null;
                try {
                    // Database connection setup
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");

                    // Query to delete the hostel from the database
                    String sql = "DELETE FROM hostel WHERE hostel_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(hostelId));

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        // Successfully deleted
                       out.println("<script type='text/javascript'>alert('deleted successfully!');</script>");
                       response.sendRedirect("my-hostels.jsp");
                    } else {
                        // Hostel not found
                        out.println("<div class='alert alert-danger' role='alert'>Hostel not found!</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger' role='alert'>Error deleting hostel. Please try again later.</div>");
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<div class='alert alert-warning' role='alert'>Invalid hostel ID.</div>");
            }
        %>
        <!-- Redirect to the owner's hostel list page -->
        <a href="my-hostels.jsp" class="btn btn-primary">Back to My Hostels</a>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
