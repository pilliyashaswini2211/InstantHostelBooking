import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/AddHostelServlet")
@MultipartConfig
public class AddHostelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
    	HttpSession session = request.getSession();
        int ownerId = Integer.parseInt(session.getAttribute("ownerId").toString());
        String hostelName = request.getParameter("hostelName");
        String hostelType = request.getParameter("hostelType");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String mobile = request.getParameter("mobile");
        String facilities = request.getParameter("facilities");
        double cost = Double.parseDouble(request.getParameter("cost"));
        String roomDetails = request.getParameter("roomDetails");
        String foodDetails = request.getParameter("foodDetails");
        int nearCollegeId =0;
        String  nearCollege= request.getParameter("nearCollege") ;
        
        String[] parts = nearCollege.split("-");
        nearCollegeId = Integer.parseInt(parts[parts.length - 1].trim());
        
        // Handle file uploads
        String pic1 = handleFileUpload(request.getPart("pic1"), request);
        String pic2 = handleFileUpload(request.getPart("pic2"), request);
        String pic3 = handleFileUpload(request.getPart("pic3"), request);
        String pic4 = handleFileUpload(request.getPart("pic4"), request);
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb?useSSL=false", "root", "");
            
            // SQL query
            String sql = "INSERT INTO hostel (owner_id, hostel_name, hostel_type, description, location, city, state, mobile, facilities, cost, room_details, food_details, near_college_id, pic1, pic2, pic3, pic4) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ownerId);
            pstmt.setString(2, hostelName);
            pstmt.setString(3, hostelType);
            pstmt.setString(4, description);
            pstmt.setString(5, location);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, mobile);
            pstmt.setString(9, facilities);
            pstmt.setDouble(10, cost);
            pstmt.setString(11, roomDetails);
            pstmt.setString(12, foodDetails);
            pstmt.setInt(13, nearCollegeId);
            pstmt.setString(14, pic1);
            pstmt.setString(15, pic2);
            pstmt.setString(16, pic3);
            pstmt.setString(17, pic4);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                request.getSession().setAttribute("message", "Hostel added successfully!");
            } else {
                request.getSession().setAttribute("message", "Failed to add hostel. Please try again.");
            }
            
            response.sendRedirect("owner/owner-dashboard.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            response.sendRedirect("add-hostel.jsp");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    private String handleFileUpload(Part filePart, HttpServletRequest request) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        
        String path = request.getServletContext().getRealPath("/");
        String str = path.substring(0, path.indexOf(".metadata") - 1);
        String str1 = path.substring(path.lastIndexOf("\\", path.length() - 2));
        path = str + str1 + "src/main/webapp";
       
        // Get application path
       
        String uploadPath = path  + "/uploads/";
        
        // Create upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        // Generate unique file name
        String fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Save file
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(uploadPath + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
        }
        
        // Return relative path
        return fileName;
    }
}