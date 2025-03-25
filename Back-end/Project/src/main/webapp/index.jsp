<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>PawHouse - Chăm Sóc Thú Cưng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            /* Điều chỉnh chiều cao carousel */
            #heroCarousel .carousel-item img {
                height: 500px;
                object-fit: cover;
                transition: transform 0.5s ease-in-out;
            }

            /* Hiệu ứng zoom nhẹ khi chuyển slide */
            .carousel-item.active img {
                transform: scale(1.05);
            }

            /* Tiêu đề trên ảnh */
            .carousel-caption {
                background: rgba(0, 0, 0, 0.5);
                padding: 15px;
                border-radius: 10px;
                backdrop-filter: blur(5px);
                animation: fadeInUp 1s ease-in-out;
            }

            .carousel-caption h5 {
                font-size: 1.8rem;
                font-weight: bold;
                text-transform: uppercase;
            }

            .carousel-caption p {
                font-size: 1rem;
            }

            /* Chấm chỉ số hình ảnh */
            .carousel-indicators button {
                background-color: #ffcc00;
                width: 12px;
                height: 12px;
                border-radius: 50%;
                border: none;
                transition: all 0.3s ease-in-out;
            }

            .carousel-indicators .active {
                width: 16px;
                height: 16px;
                background-color: #ff9900;
            }

            /* Nút điều hướng */
            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                background-color: rgba(0, 0, 0, 0.5);
                padding: 15px;
                border-radius: 50%;
            }

            .carousel-control-prev-icon:hover,
            .carousel-control-next-icon:hover {
                background-color: rgba(0, 0, 0, 0.8);
            }

            /* Hiệu ứng chữ xuất hiện */
            @keyframes fadeInUp {
                from {
                    transform: translateY(20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            /* Hiệu ứng hover cho card */
            .card:hover {
                transform: scale(1.05);
                transition: 0.3s;
            }

            /* Hiệu ứng header */
            .carousel-caption {
                background: rgba(0, 0, 0, 0.6);
                padding: 10px;
                border-radius: 8px;
            }

            /* Đánh giá */
            .rating i {
                color: gold;
            }

            /* Footer */
            .footer {
                background: #222;
            }

            .footer a {
                color: #ffcc00;
                text-decoration: none;
                margin: 0 10px;
            }

            /* Phần Dịch Vụ */
            .service-card {
                border-radius: 12px;
                overflow: hidden;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            .service-card:hover {
                transform: translateY(-5px);
                box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
            }

            .service-card img {
                height: 230px;
                object-fit: cover;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            }

            .btn-custom {
                border-radius: 25px;
                padding: 8px 20px;
                transition: all 0.3s ease-in-out;
            }

            .btn-custom:hover {
                background: #ffcc00;
                color: black;
                border-color: #ffcc00;
            }

            /* Phần sản phẩm */
            .product-card {
                border-radius: 12px;
                overflow: hidden;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
            }

            .product-img {
                overflow: hidden;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            }

            .product-img img {
                height: 230px;
                object-fit: cover;
                transition: transform 0.3s ease-in-out;
            }

            .product-card:hover .product-img img {
                transform: scale(1.1);
            }

            .btn-custom {
                border-radius: 25px;
                padding: 8px 20px;
                transition: all 0.3s ease-in-out;
            }

            .btn-custom:hover {
                background: #ffcc00;
                color: black;
                border-color: #ffcc00;
            }

            /* Căn chỉnh video */
            .video-container {
                position: relative;
                overflow: hidden;
                border-radius: 15px; /* Bo góc */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Hiệu ứng đổ bóng */
            }

            .video-container video {
                width: 100%;
                height: auto;
                display: block;
            }


            /* Background gradient vàng nhẹ */
            body {
                background: linear-gradient(135deg, #f9e79f, #f7dc6f);
                min-height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
            }
            /* Card Styling */
            .card {
                border-radius: 15px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                transition: 0.3s;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            /* Section Title */
            h2 {
                font-weight: bold;
                color: #ff6600; /* Màu nâu sẫm */
                text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
            }
            /* Card Title */
            h5 {
                color: #e65c50; /* Màu nâu trầm */
            }

            /* Section Title */
            .section-title {
                font-weight: bold;
                font-size: 28px;
                color: #ff6600;
                text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
            }

            /* Step Progress */
            .step {
                text-align: center;
                position: relative;
                width: 100px;
                margin: 0 10px;
            }

            .circle {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: #121212;
                color: white;
                font-size: 18px;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
            }

            .line {
                width: 60px;
                height: 3px;
                background: #121212;
                flex: 1;
            }

            .step span {
                font-size: 14px;
                font-weight: bold;
                display: block;
                margin-top: 5px;
            }

            /* Dịch vụ đánh giá */
            .review-card {
                background: #ffcc00;
                padding: 15px;
                border-radius: 10px;
                text-align: center;
                transition: transform 0.3s;
                margin: 10px;
                width: 140px;
                height: 140px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            .service-icon {
                font-size: 40px;
                color: #333;
                margin-bottom: 10px;
            }

            .review-card:hover {
                transform: scale(1.05);
                box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
            }

            .review-card p {
                font-size: 14px;
                font-weight: bold;
                margin: 0;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .step {
                    width: 50px;
                }

                .line {
                    width: 30px;
                }

                .review-card {
                    width: 100px;
                    height: 100px;
                }

                .service-icon {
                    font-size: 30px;
                }

                .review-card p {
                    font-size: 12px;
                }
            }
        </style>

    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

        <!-- Giới thiệu -->
        <section class="container text-center py-5">
            <h2>Chào Mừng Đến Với PawHouse</h2>
            <p class="lead">Chúng tôi cung cấp các sản phẩm và dịch vụ chất lượng nhất để chăm sóc thú cưng của bạn.</p>
        </section>

        <!-- Carousel -->
        <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
            <!-- Chỉ số hình ảnh (dots) -->
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
            </div>

            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="./imgs/pet.jpg" class="d-block w-100" alt="Chăm sóc thú cưng">
                    <div class="carousel-caption">
                        <h5>Chăm Sóc Thú Cưng Toàn Diện</h5>
                        <p>Dịch vụ hàng đầu giúp thú cưng luôn khỏe mạnh và hạnh phúc.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="./imgs/spabanner.jpg" class="d-block w-100" alt="Dịch vụ spa">
                    <div class="carousel-caption">
                        <h5>Dịch Vụ Spa & Grooming</h5>
                        <p>Chăm sóc sắc đẹp cho thú cưng, giúp chúng luôn thơm tho và đáng yêu.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="./imgs/pet_banner.jpg" class="d-block w-100" alt="Nhận nuôi thú cưng">
                    <div class="carousel-caption">
                        <h5>Nhận Nuôi Thú Cưng</h5>
                        <p>Giúp các bé tìm được mái ấm yêu thương.</p>
                    </div>
                </div>
            </div>

            <!-- Nút điều hướng -->
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>

        <!-- Video Tutorial -->
        <section id="video-tutorial" class="container py-5">
            <h2 class="text-center mb-4">Hướng Dẫn Chăm Sóc Thú Cưng</h2>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="video-container">
                        <video autoplay loop muted playsinline controls>
                            <source src="imgs/video.mp4" type="video/mp4">
                            Trình duyệt của bạn không hỗ trợ video.
                        </video>
                    </div>
                </div>
            </div>
        </section>

        <!-- Sản Phẩm Nổi Bật -->
        <section id="products" class="container py-5">
            <h2 class="text-center mb-4">Sản Phẩm Nổi Bật</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <a href="/FoodProducts"><img src="./imgs/food.jpg" class="card-img-top" alt="Thức ăn"></a>
                        <div class="card-body text-center">
                            <h5 class="card-title">Thức Ăn Thú Cưng</h5>
                            <p class="card-text">Sản phẩm dinh dưỡng giúp thú cưng phát triển khỏe mạnh.</p>
                            <a href="/FoodProducts" class="btn btn-primary btn-custom">Tìm hiểu thêm</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <a href="/SuppliesProduct"><img src="./imgs/toy_.jpg" class="card-img-top" alt="Đồ chơi"></a>
                        <div class="card-body text-center">
                            <h5 class="card-title">Đồ Dùng Cho Thú Cưng</h5>
                            <p class="card-text">Đồ dùng hằng ngày, giúp thú cưng vui chơi và đảm bảo sức khỏe.</p>
                            <a href="/SuppliesProduct" class="btn btn-primary btn-custom">Tìm hiểu thêm</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <a href="/AccessoryProducts"><img src="./imgs/phukien.png" class="card-img-top" alt="Phụ kiện"></a>
                        <div class="card-body text-center">
                            <h5 class="card-title">Phụ Kiện Thú Cưng</h5>
                            <p class="card-text">Những món đồ không thể thiếu để chăm sóc thú cưng tốt hơn.</p>
                            <a href="/AccessoryProducts" class="btn btn-primary btn-custom">Tìm hiểu thêm</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Dịch Vụ -->
       <%
    User currentUser = getAuthenticatedUser(request);
    boolean isLoggedIn = (currentUser != null);
%>
 <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055;">
            <div id="loginToast" class="toast align-items-center text-bg-danger border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        Vui lòng đăng nhập để xem thông tin chi tiết dịch vụ.
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

   

        <!-- Giới thiệu -->
        <section class="container text-center py-5">
            <h2>Chào Mừng Đến Với PawHouse</h2>
            <p class="lead">Chúng tôi cung cấp các sản phẩm và dịch vụ chất lượng nhất để chăm sóc thú cưng của bạn.</p>
        </section>

        <!-- Dịch Vụ -->
        <section id="services" class="container py-5">
            <h2 class="text-center fw-bold mb-4">Dịch Vụ Chúng Tôi Cung Cấp</h2>
            <div class="row g-4">
                <!-- Thú Y -->
                <div class="col-md-4">
                    <div class="service-card card border-0 shadow">
                        <a href="<%= isLoggedIn ? "/MedicalServlet" : "#"%>"
                           onclick="<%= isLoggedIn ? "" : "showLoginToast(); return false;"%>">
                            <img src="./imgs/thuy.png" class="card-img-top" alt="Thú y">
                        </a>
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Thú Y</h5>
                            <p class="card-text">Dịch vụ khám chữa bệnh chuyên nghiệp giúp thú cưng khỏe mạnh.</p>
                            <a href="<%= isLoggedIn ? "/MedicalServlet" : "#"%>"
                               class="btn btn-primary btn-custom"
                               onclick="<%= isLoggedIn ? "" : "showLoginToast(); return false;"%>">
                                Tìm hiểu thêm
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Spa & Grooming -->
                <div class="col-md-4">
                    <div class="service-card card border-0 shadow">
                        <a href="<%= isLoggedIn ? "/SpaServlet" : "#"%>"
                           onclick="<%= isLoggedIn ? "" : "showLoginToast(); return false;"%>">
                            <img src="./imgs/spapet.jpg" class="card-img-top" alt="Spa">
                        </a>
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Spa & Grooming</h5>
                            <p class="card-text">Dịch vụ tắm, cắt tỉa lông, giúp thú cưng luôn sạch sẽ và đáng yêu.</p>
                            <a href="<%= isLoggedIn ? "/SpaServlet" : "#"%>"
                               class="btn btn-primary btn-custom"
                               onclick="<%= isLoggedIn ? "" : "showLoginToast(); return false;"%>">
                                Tìm hiểu thêm
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Nhận Nuôi -->
                <div class="col-md-4">
                    <div class="service-card card border-0 shadow">
                        <a href="<%= isLoggedIn ? "/AdoptionServlet" : "#"%>"
                           onclick="<%= isLoggedIn ? "" : "showLoginToast(); return false;"%>">
                            <img src="./imgs/takecare.jpg" class="card-img-top" alt="Nhận nuôi">
                        </a>
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Nhận Nuôi</h5>
                            <p class="card-text">Giúp thú cưng tìm mái ấm yêu thương, mang đến niềm vui cho gia đình bạn.</p>
                            <a href="<%= isLoggedIn ? "/AdoptionServlet" : "#"%>"
                               class="btn btn-primary btn-custom"
                               onclick="<%= isLoggedIn ? "" : "showLoginToast(); return false;"%>">
                                Tìm hiểu thêm
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>



        <script>
            // Đánh giá bằng sao
            document.querySelectorAll('.rating i').forEach((star, index) => {
                star.addEventListener('click', function () {
                    document.querySelectorAll('.rating i').forEach((s, i) => {
                        s.classList.toggle('bi-star-fill', i <= index);
                        s.classList.toggle('bi-star', i > index);
                    });
                });
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
    </body>
</html>
