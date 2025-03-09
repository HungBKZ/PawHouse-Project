<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>PawHouse - About Us</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <!-- Animate CSS (for wow effects) -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }
            .welcome-section {
                background: url('img/image.png') no-repeat center center/cover;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                text-align: center;
            }
            .welcome-content {
                background: rgba(0, 0, 0, 0.5);
                padding: 20px;
                border-radius: 10px;
            }
            .welcome-content h1 {
                font-size: 3rem;
                font-weight: bold;
            }
            .welcome-content p {
                font-size: 1.5rem;
            }
            .btn-homepage {
                margin-top: 20px;
                padding: 10px 20px;
                font-size: 1.2rem;
                border-radius: 5px;
            }
            .section-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #007bff;
            }
            .rounded.shadow {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .rounded.shadow:hover {
                transform: translateY(-10px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }
            .btn-square {
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 10%;
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-content">
                <h1>Chào Mừng Đến Với PawHouse</h1>
                <p>Chúng tôi cung cấp các sản phẩm và dịch vụ chất lượng nhất để chăm sóc thú cưng của bạn.</p>
                <p><strong>CHĂM SÓC THÚ CƯNG TOÀN DIỆN</strong></p> 
                <h2> Kéo xuống để biết thêm về chúng tôi </h2>
                <h2> Nhấn Back to Homepage để về trang chủ </h2>
                <a href="index.jsp" class="btn btn-primary btn-homepage">Back to Homepage</a>
            </div>
        </div>

        <!-- Team Section -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h6 class="section-title text-center text-primary text-uppercase">Our Team</h6>
                    <h1 class="mb-5">Explore Our <span class="text-primary text-uppercase">Staffs</span></h1>
                </div>
                <div class="row g-4">
                    <!-- Member 1 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="rounded shadow overflow-hidden">
                            <div class="position-relative">
                                <img class="img-fluid" src="imgs/avatar/avatar7.png" alt="Hoàng Huy">
                                <div class="position-absolute start-50 top-100 translate-middle d-flex align-items-center">
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.facebook.com/profile.php?id=100037327361860&mibextid=ZbWKwL">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.instagram.com/yuh_hhoang/profilecard/?igsh=dHlqNWhicDVzc25j">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="text-center p-4 mt-3">
                                <h5 class="fw-bold mb-0">Hoàng Huy</h5>
                                <small>Người Thiết Kế</small>
                            </div>
                        </div>
                    </div>
                    <!-- Member 2 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                        <div class="rounded shadow overflow-hidden">
                            <div class="position-relative">
                                <img class="img-fluid" src="imgs/avatar/avatar2.jpg" alt="Chấn Hưng">
                                <div class="position-absolute start-50 top-100 translate-middle d-flex align-items-center">
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.facebook.com/chan.hung.968591/">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.instagram.com/hunggomu15/">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="text-center p-4 mt-3">
                                <h5 class="fw-bold mb-0">Chấn Hưng</h5>
                                <small> Người Thiết Kế</small>
                            </div>
                        </div>
                    </div>
                    <!-- Member 3 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                        <div class="rounded shadow overflow-hidden">
                            <div class="position-relative">
                                <img class="img-fluid" src="imgs/avatar/avatar1.jpg" alt="Mỹ Linh">
                                <div class="position-absolute start-50 top-100 translate-middle d-flex align-items-center">
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.facebook.com/phan.thanh.hung.437591">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.instagram.com/accounts/login/?next=https%3A%2F%2Fwww.instagram.com%2Fzhungw_pt%2F%3Figsh%3DMWJ2Z2kxb29xejMxeg%253D%253D%26utm_source%3Dqr&is_from_rle">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="text-center p-4 mt-3">
                                <h5 class="fw-bold mb-0">Thành Hưng</h5>
                                <small>Trưởng Dự Án</small>
                            </div>
                        </div>
                    </div>
                    <!-- Member 4 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.7s">
                        <div class="rounded shadow overflow-hidden">
                            <div class="position-relative">
                                <img class="img-fluid" src="imgs/avatar/avatar3.png" alt="Chánh Huy">
                                <div class="position-absolute start-50 top-100 translate-middle d-flex align-items-center">
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.facebook.com/vo.chanh.huy.865130">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.instagram.com/phuctruongcm2004?igsh=cG4wOTltYjVsZDhm">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="text-center p-4 mt-3">
                                <h5 class="fw-bold mb-0">Chánh Huy</h5>
                                <small>Người Thiết Kế</small>
                            </div>
                        </div>
                    </div>
                    <!-- Member 5 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.9s">
                        <div class="rounded shadow overflow-hidden">
                            <div class="position-relative">
                                <img class="img-fluid" src="img/about_us/aboutHung.jpg" alt="Chấn Hưng">
                                <div class="position-absolute start-50 top-100 translate-middle d-flex align-items-center">
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.facebook.com/profile.php?id=100033289996509">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.instagram.com/hunggomu15/">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="text-center p-4 mt-3">
                                <h5 class="fw-bold mb-0">Phú Hưng</h5>
                                <small>Người Thiết Kế</small>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.9s">
                        <div class="rounded shadow overflow-hidden">
                            <div class="position-relative">
                                <img class="img-fluid" src="imgs/avatar/avatar4.png" alt="Hữu Tín">
                                <div class="position-absolute start-50 top-100 translate-middle d-flex align-items-center">
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.facebook.com/tin.tranhuu.18041">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a target="_blank" class="btn btn-square btn-primary mx-1" href="https://www.instagram.com/hunggomu15/">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="text-center p-4 mt-3">
                                <h5 class="fw-bold mb-0">Hữu Tín</h5>
                                <small>Người Thiết Kế</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Team End -->
        <%@ include file="includes/footer.jsp" %>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
        <!-- WOW JS (for animations) -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js"></script>
        <script>
            new WOW().init();
        </script>
    </body>
</html>