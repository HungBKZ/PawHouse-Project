<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dịch Vụ Spa & Grooming - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f9f9f9;
            }

            /* Banner */
            .banner img {
                max-height: 400px;
                object-fit: cover;
            }

            /* Tiêu đề */
            .section-title {
                font-size: 2rem;
                font-weight: bold;
                color: #333;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            /* Service Card */
            .service-card {
                background: white;
                padding: 15px;
                border-radius: 12px;
                text-align: center;
                transition: 0.3s;
                position: relative;
                overflow: hidden;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .service-card:hover {
                transform: translateY(-5px);
                box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
            }

            .service-card img {
                max-width: 100%;
                height: 250px;
                object-fit: cover;
                border-radius: 12px;
            }

            .service-card h5 {
                font-weight: bold;
                margin-top: 10px;
                font-size: 1.2rem;
            }

            .service-card .price {
                font-size: 1.3rem;
                font-weight: bold;
                color: #ff6600;
            }

            .service-card .btn {
                font-size: 1rem;
                transition: 0.3s;
            }

            .service-card .btn:hover {
                transform: scale(1.05);
            }

            /* Lợi ích */
            .benefit-item i {
                font-size: 3rem;
                color: #ff6600;
            }

            /* Quy trình */
            .process-item i {
                font-size: 3rem;
                color: #17a2b8;
            }

            /* Accordion */
            .accordion-button {
                font-size: 1.1rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

        <!-- Banner -->
        <section class="container-fluid p-0 banner">
            <img src="./imgs/spaban.jpg" class="w-100" alt="Dịch Vụ Spa & Grooming" />
        </section>

        <!-- Danh sách dịch vụ Spa -->
        <section class="container py-5">
            <h2 class="section-title text-center mb-4">Dịch Vụ Spa & Grooming Chuyên Nghiệp</h2>
            <div class="row">
                <c:choose>
                    <c:when test="${not empty spaList}">
                        <c:forEach var="service" items="${spaList}">
                            <div class="col-md-4 mb-4">
                                <div class="service-card shadow d-flex flex-column h-100">
                                    <img src="${service.serviceImage}" class="card-img-top" alt="${service.serviceName}">
                                    <div class="card-body text-center d-flex flex-column flex-grow-1">
                                        <h5 class="card-title">${service.serviceName}</h5>
                                        <p class="card-text">${service.description}</p>
                                        <p class="price mt-auto"><fmt:formatNumber value="${service.price}" pattern="#,##0"/> VND</p>
                                        <a href="BookService?id=${service.serviceID}" class="btn btn-success w-100 mt-2">Đặt Lịch</a>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center">Không có dịch vụ nào.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Lợi ích dịch vụ -->
        <section class="container py-5">
            <h2 class="section-title text-center mb-4">Lợi Ích Khi Sử Dụng Dịch Vụ Spa & Grooming</h2>
            <div class="row text-center">
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-stars"></i>
                    <h5 class="mt-3">Chăm Sóc Toàn Diện</h5>
                    <p>Giúp thú cưng luôn sạch sẽ, khỏe mạnh và thơm tho.</p>
                </div>
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-scissors"></i>
                    <h5 class="mt-3">Tạo Kiểu Chuyên Nghiệp</h5>
                    <p>Cắt tỉa lông theo phong cách, phù hợp với từng giống thú cưng.</p>
                </div>
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-heart-fill"></i>
                    <h5 class="mt-3">Chăm Sóc Nhẹ Nhàng</h5>
                    <p>Sử dụng sản phẩm an toàn, phù hợp với mọi loại da.</p>
                </div>
            </div>
        </section>

        <!-- Câu hỏi thường gặp -->
        <section class="container py-5">
            <h2 class="section-title text-center mb-4">Câu Hỏi Thường Gặp</h2>
            <div class="accordion" id="faqAccordion">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faqOne">
                            🐶 Dịch vụ tắm cho thú cưng mất bao lâu?
                        </button>
                    </h2>
                    <div id="faqOne" class="accordion-collapse collapse show">
                        <div class="accordion-body">Thời gian trung bình từ 30 - 60 phút tùy kích thước thú cưng.</div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqTwo">
                            🏥 Có cần đặt lịch trước không?
                        </button>
                    </h2>
                    <div id="faqTwo" class="accordion-collapse collapse">
                        <div class="accordion-body">Chúng tôi khuyến khích đặt lịch trước để phục vụ tốt nhất.</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
