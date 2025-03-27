<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dịch Vụ Thú Y - PawHouse</title>
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
            <img src="./imgs/banner.png" class="w-100" alt="Dịch Vụ Thú Y" />
        </section>

        <!-- Danh sách dịch vụ thú y -->
        <section class="container py-5">
            <h2 class="section-title text-center mb-4">Dịch Vụ Thú Y Chuyên Nghiệp</h2>
            <div class="row">
                <c:choose>
                    <c:when test="${not empty medicalList}">
                        <c:forEach var="service" items="${medicalList}">
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
            <h2 class="section-title text-center mb-4">Lợi Ích Khi Sử Dụng Dịch Vụ Thú Y Tại PawHouse</h2>
            <div class="row text-center">
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-heart-pulse"></i>
                    <h5 class="mt-3">Bác Sĩ Thú Y Giỏi</h5>
                    <p>Đội ngũ bác sĩ chuyên nghiệp, tận tâm và giàu kinh nghiệm.</p>
                </div>
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-shield-check"></i>
                    <h5 class="mt-3">Thiết Bị Hiện Đại</h5>
                    <p>Trang bị đầy đủ máy móc xét nghiệm, chẩn đoán hình ảnh hiện đại.</p>
                </div>
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-emoji-smile"></i>
                    <h5 class="mt-3">Chăm Sóc Tận Tâm</h5>
                    <p>Chăm sóc thú cưng như người thân trong gia đình.</p>
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
                            🐶 Thú cưng của tôi có cần tiêm phòng không?
                        </button>
                    </h2>
                    <div id="faqOne" class="accordion-collapse collapse show">
                        <div class="accordion-body">Có! Tiêm phòng giúp bảo vệ thú cưng khỏi bệnh nguy hiểm.</div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqTwo">
                            🏥 Tôi có thể đặt lịch ngoài giờ không?
                        </button>
                    </h2>
                    <div id="faqTwo" class="accordion-collapse collapse">
                        <div class="accordion-body">Có, vui lòng liên hệ để đặt lịch ngoài giờ.</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
