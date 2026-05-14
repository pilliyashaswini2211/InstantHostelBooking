<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Hostels | InstantHostelBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .action-btns .btn {
            margin-right: 5px;
        }
        .table-responsive {
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
 <%@ include file="menu.jsp" %>
    <div class="container" style="width:100%">
        <div class="row">
           
            
            <main class="col-md-12 ms-sm-auto col-lg-12">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">My Hostels</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="add-hostel.jsp" class="btn btn-sm btn-outline-primary">
                            <i class="fas fa-plus"></i> Add New Hostel
                        </a>
                    </div>
                </div>

                <% if (session.getAttribute("message") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= session.getAttribute("message") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("message"); %>
                <% } %>

                <div class="table-responsive">
                    <table id="hostelsTable" class="table table-striped table-hover" style="width:100%">
                        <thead class="table-dark">
                            <tr>
                    <th>Hostel ID</th>
                    <th>Hostel Name</th>
                    <th>Hostel Type</th>
                    <th>Description</th>
                    <th>Location</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Mobile</th>
                    <th>Facilities</th>
                    <th>Cost</th>
                    <th>Room Details</th>
                    <th>Food Details</th>
                    <th>Availability Status</th>
                    <th>Pic1</th>
                    <th>Pic2</th>
                    <th>Pic3</th>
                    <th>Pic4</th>
                    <th>Action</th>
                </tr>
                        </thead>
                        <tbody>
                            <%
                                int ownerId = (Integer) session.getAttribute("ownerId");
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hosteldb", "root", "");
                                    
                                    String sql = "SELECT * FROM hostel WHERE owner_id = ? ORDER BY hostel_id DESC";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setInt(1, ownerId);
                                    rs = pstmt.executeQuery();
                                    
                                    while (rs.next()) {
                                        String statusClass = "";
                                        switch(rs.getString("availability_status")) {
                                            case "Available": statusClass = "text-success"; break;
                                            case "Booked": statusClass = "text-danger"; break;
                                            case "Maintenance": statusClass = "text-warning"; break;
                                            default: statusClass = "text-info";
                                        }
                            %>
                             <tr>
                                    <td><%= rs.getInt("hostel_id") %></td>
                                    <td><%= rs.getString("hostel_name") %></td>
                                    <td><%= rs.getString("hostel_type") %></td>
                                    <td><%= rs.getString("description") %></td>
                                    <td><%= rs.getString("location") %></td>
                                    <td><%= rs.getString("city") %></td>
                                    <td><%= rs.getString("state") %></td>
                                    <td><%= rs.getString("mobile") %></td>
                                    <td><%= rs.getString("facilities") %></td>
                                    <td><%= rs.getDouble("cost") %></td>
                                    <td><%= rs.getString("room_details") %></td>
                                    <td><%= rs.getString("food_details") %></td>
                                    <td><%= rs.getString("availability_status") %></td>
                                    <td>
                                        <img src="../uploads/<%= rs.getString("pic1") %>" alt="Pic 1" width="100" height="100">
                                    </td>
                                     <td>
                                        <img src="../uploads/<%= rs.getString("pic2") %>" alt="Pic 2" width="100" height="100">
                                      </td> 
                                       <td>
                                       <img src="../uploads/<%= rs.getString("pic3") %>" alt="Pic 3" width="100" height="100">
                                      </td> 
                                       <td> 
                                        <img src="../uploads/<%= rs.getString("pic4") %>" alt="Pic 4" width="100" height="100">
                                    </td>
                                <td class="action-btns">
                                    <a href="edit-hostel.jsp?id=<%= rs.getInt("hostel_id") %>" class="btn btn-sm btn-primary">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <button class="btn btn-sm btn-danger delete-btn" data-id="<%= rs.getInt("hostel_id") %>">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </button>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                            %>
                            <tr>
                                <td colspan="8" class="text-center text-danger">Error loading hostels: <%= e.getMessage() %></td>
                            </tr>
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
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this hostel? This action cannot be undone.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="confirmDelete" class="btn btn-danger">Delete</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Initialize DataTable
            $('#hostelsTable').DataTable({
                responsive: true,
                order: [[0, 'desc']]
            });
            
            // Delete button click handler
            $('.delete-btn').click(function() {
                var hostelId = $(this).data('id');
                $('#confirmDelete').attr('href', 'delete-hostel.jsp?id=' + hostelId);
                $('#deleteModal').modal('show');
            });
        });
    </script>
</body>
</html>