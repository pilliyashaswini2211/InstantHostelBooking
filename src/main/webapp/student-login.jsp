<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Login</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            max-width: 450px;
        }
        .login-header {
            background-color: #1cc88a;
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
        .btn-success {
            background-color: #1cc88a;
            border-color: #1cc88a;
        }
        .form-control:focus {
            border-color: #1cc88a;
            box-shadow: 0 0 0 0.25rem rgba(28, 200, 138, 0.25);
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card login-card mx-auto">
                    <div class="card-header py-4 text-center login-header">
                        <h3><i class="fas fa-user-graduate me-2"></i>Student Login</h3>
                    </div>
                    <div class="card-body p-4">
                        <%-- Display error messages if any --%>
                        <% if (session.getAttribute("error") != null) { %>
                            <div class="alert alert-danger mb-4">
                                <%= session.getAttribute("error") %>
                            </div>
                            <% session.removeAttribute("error"); %>
                        <% } %>

                        <form action="student-login-code.jsp" method="post">
                            <div class="mb-3">
                                <label for="mobile" class="form-label">Mobile Number</label>
                                <input type="tel" class="form-control" id="mobile" name="mobile" pattern="[0-9]{10}" required>
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="d-grid gap-2 mb-3">
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </button>
                            </div>
                         <!--    <div class="text-center mb-3">
                                <a href="#" class="text-decoration-none">Forgot Password?</a>
                            </div>  -->
                            <hr class="my-4">
                            <div class="text-center">
                                <p class="mb-0">Don't have an account? <a href="student-register.jsp">Register here</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
