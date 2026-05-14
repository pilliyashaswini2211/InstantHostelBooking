<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InstantHostelBooking - Instant Hostel Booking for Students</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --dark-color: #5a5c69;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
        }
        
        .hero-section {
            background: linear-gradient(rgba(78, 115, 223, 0.8), rgba(78, 115, 223, 0.8)), 
                        url('https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            margin-bottom: 50px;
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            transition: transform 0.3s;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-success {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .testimonial-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--primary-color);
        }
        
        .how-it-works-step {
            position: relative;
            padding-left: 80px;
            margin-bottom: 30px;
        }
        
        .step-number {
            position: absolute;
            left: 0;
            top: 0;
            width: 60px;
            height: 60px;
            background-color: var(--primary-color);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="#">
                <i class="fas fa-home me-2"></i>InstantHostelBooking
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#how-it-works">How It Works</a>
                    </li>
                   
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    <li class="nav-item ms-lg-3">
                        <a class="btn btn-outline-primary" href="student-login.jsp">Student Login</a>
                    </li>
                    <li class="nav-item ms-lg-2">
                        <a class="btn btn-primary" href="owner-login.jsp">Hostel Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-4">Find Your Perfect Student Hostel</h1>
            <p class="lead mb-5">Book comfortable, affordable hostels near your college with just a few clicks</p>
            
            <div class="row justify-content-center">
                <div class="col-md-8">
                   
                       
                            <div class="text-center mt-4">
                        <a href="student-register.jsp" class="btn btn-warning btn-lg px-4">Get Started Now</a>
                    </div>
                        
                   
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold">Why Choose InstantHostelBooking?</h2>
                <p class="text-muted">We make finding and booking hostels simple and hassle-free</p>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon">
                                <i class="fas fa-map-marked-alt"></i>
                            </div>
                            <h4>Nearby Colleges</h4>
                            <p class="text-muted">Find hostels located close to your college campus with our detailed location mapping.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon">
                                <i class="fas fa-rupee-sign"></i>
                            </div>
                            <h4>Transparent Pricing</h4>
                            <p class="text-muted">No hidden charges. See complete fee structure with all facilities included.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon">
                                <i class="fas fa-images"></i>
                            </div>
                            <h4>Real Photos</h4>
                            <p class="text-muted">View actual photos of hostels, rooms and facilities before you book.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            <h4>Instant Booking</h4>
                            <p class="text-muted">Book your hostel instantly online without any paperwork.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon">
                                <i class="fas fa-star"></i>
                            </div>
                            <h4>Verified Listings</h4>
                            <p class="text-muted">All hostels are personally verified by our team for quality assurance.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon">
                                <i class="fas fa-headset"></i>
                            </div>
                            <h4>24/7 Support</h4>
                            <p class="text-muted">Our support team is always available to help you with any issues.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="py-5 bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold">How It Works</h2>
                <p class="text-muted">Get your hostel booked in just 3 simple steps</p>
            </div>
            
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="how-it-works-step">
                        <div class="step-number">1</div>
                        <div>
                            <h4>Search Hostels</h4>
                            <p class="text-muted">Enter your college name and city to find nearby hostels. Filter by price, facilities and distance from college.</p>
                        </div>
                    </div>
                    
                    <div class="how-it-works-step">
                        <div class="step-number">2</div>
                        <div>
                            <h4>Compare & Select</h4>
                            <p class="text-muted">View detailed information, photos and reviews of each hostel. Compare options and select your preferred one.</p>
                        </div>
                    </div>
                    
                    <div class="how-it-works-step">
                        <div class="step-number">3</div>
                        <div>
                            <h4>Book Online</h4>
                            <p class="text-muted">Complete the booking process online by paying security deposit. Receive instant confirmation.</p>
                        </div>
                    </div>
                    
                    
                </div>
            </div>
        </div>
    </section>

    

    <!-- Call to Action -->
    <section class="py-5 bg-primary text-white">
        <div class="container text-center">
            <h2 class="fw-bold mb-4">Ready to Find Your Perfect Hostel?</h2>
            <p class="lead mb-5">Join thousands of students who found their ideal accommodation through InstantHostelBooking</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="student-register.jsp" class="btn btn-light btn-lg px-4">Register as Student</a>
                <a href="owner-register.jsp" class="btn btn-outline-light btn-lg px-4">Register as Owner</a>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 mb-5 mb-lg-0">
                    <h2 class="fw-bold mb-4">Contact Us</h2>
                    <p class="text-muted mb-4">Have questions or need assistance? Reach out to our team.</p>
                    
                    <div class="mb-4">
                        <h5><i class="fas fa-envelope me-2 text-primary"></i> Email</h5>
                        <p class="text-muted">support@InstantHostelBooking.com</p>
                    </div>
                    
                    <div class="mb-4">
                        <h5><i class="fas fa-phone me-2 text-primary"></i> Phone</h5>
                        <p class="text-muted">+91 9876543210</p>
                    </div>
                    
                    <div class="mb-4">
                        <h5><i class="fas fa-map-marker-alt me-2 text-primary"></i> Address</h5>
                        <p class="text-muted">123 College Road, Bangalore, Karnataka - 560001</p>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <div class="card shadow">
                        <div class="card-body p-4">
                            <h4 class="mb-4">Send us a message</h4>
                            <form>
                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Your Name">
                                </div>
                                <div class="mb-3">
                                    <input type="email" class="form-control" placeholder="Your Email">
                                </div>
                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Subject">
                                </div>
                                <div class="mb-3">
                                    <textarea class="form-control" rows="4" placeholder="Your Message"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Send Message</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0">
                    <h5 class="mb-3">InstantHostelBooking</h5>
                    <p>The easiest way to find and book hostels near your college campus.</p>
                    <div class="social-icons">
                        <a href="#" class="text-white me-2"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-2"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white me-2"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                
                <div class="col-md-2 mb-4 mb-md-0">
                    <h5 class="mb-3">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#" class="text-white text-decoration-none">Home</a></li>
                        <li class="mb-2"><a href="#features" class="text-white text-decoration-none">Features</a></li>
                        <li class="mb-2"><a href="#how-it-works" class="text-white text-decoration-none">How It Works</a></li>
                        <li class="mb-2"><a href="#testimonials" class="text-white text-decoration-none">Testimonials</a></li>
                        <li><a href="#contact" class="text-white text-decoration-none">Contact</a></li>
                    </ul>
                </div>
                
                <div class="col-md-2 mb-4 mb-md-0">
                    <h5 class="mb-3">For Students</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="student-login.jsp" class="text-white text-decoration-none">Login</a></li>
                        <li class="mb-2"><a href="student-register.jsp" class="text-white text-decoration-none">Register</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Help Center</a></li>
                    </ul>
                </div>
                
                <div class="col-md-4">
                    <h5 class="mb-3">Newsletter</h5>
                    <p>Subscribe to get updates on new hostels and offers.</p>
                    <form class="d-flex">
                        <input type="email" class="form-control me-2" placeholder="Your Email">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </form>
                </div>
            </div>
            
            <hr class="my-4">
            
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2025 InstantHostelBooking. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="mb-0">
                        <a href="#" class="text-white text-decoration-none me-3">Privacy Policy</a>
                        <a href="#" class="text-white text-decoration-none">Terms of Service</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>