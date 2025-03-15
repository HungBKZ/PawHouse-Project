<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Service" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dịch Vụ - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f9f9f9;
            }
            .section-title {
                font-size: 2rem;
                font-weight: bold;
                text-transform: uppercase;
                color: #ff6600;
                text-align: center;
                margin-bottom: 20px;
            }
            .service-category {
                margin-bottom: 40px;
            }
            .service-card {
                background: white;
                padding: 15px;
                border-radius: 12px;
                text-align: center;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                transition: 0.3s;
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
            .price {
                font-size: 1.3rem;
                font-weight: bold;
                color: #ff6600;
            }
            .btn-custom {
                background: #ff6600;
                color: white;
                border: none;
            }
            .btn-custom:hover {
                background: #e65c00;
            }

            /* Lợi ích */
            .benefit-item i {
                font-size: 3rem;
                color: #ff6600;
            }

            /* Gói dịch vụ */
            .package-card {
                border-radius: 10px;
                padding: 20px;
                text-align: center;
                background: white;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                transition: 0.3s;
            }

            .package-card:hover {
                transform: translateY(-5px);
                box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
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
            <img src="./imgs/pet.jpg" class="w-100" alt="Dịch Vụ Thú Cưng" />
        </section>

        <section class="container py-5">
            <h2 class="section-title">Dịch Vụ Y Tế</h2>
            <div class="row">
                <c:forEach var="service" items="${medicalList}">
                    <div class="col-md-4 mb-4">
                        <div class="service-card">
                            <img src="${service.serviceImage}" alt="${service.serviceName}">
                            <h5>${service.serviceName}</h5>
                            <p>${service.description}</p>
                            <p class="price">${service.price} VND</p>
                            <a href="bookService.jsp?id=${service.serviceID}" class="btn btn-custom w-100">Đặt Lịch</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <section class="container py-5">
            <h2 class="section-title">Dịch Vụ Spa</h2>
            <div class="row">
                <c:forEach var="service" items="${spaList}">
                    <div class="col-md-4 mb-4">
                        <div class="service-card">
                            <img src="${service.serviceImage}" alt="${service.serviceName}">
                            <h5>${service.serviceName}</h5>
                            <p>${service.description}</p>
                            <p class="price">${service.price} VND</p>
                            <a href="bookService.jsp?id=${service.serviceID}" class="btn btn-custom w-100">Đặt Lịch</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>


        <!-- Gói dịch vụ phổ biến -->
        <section class="container py-5">
            <h2 class="section-title text-center mb-4">Gói Dịch Vụ Phổ Biến</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="package-card">
                        <h5>Gói Spa Toàn Diện</h5>
                        <p>Tắm, cắt tỉa, massage thư giãn cho thú cưng.</p>
                        <p class="price">500.000 VND</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="package-card">
                        <h5>Gói Khám Tổng Quát</h5>
                        <p>Kiểm tra sức khỏe, xét nghiệm cơ bản, tư vấn dinh dưỡng.</p>
                        <p class="price">300.000 VND</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="package-card">
                        <h5>Gói Tiêm Phòng</h5>
                        <p>Tiêm vaccine phòng bệnh, đảm bảo sức khỏe dài lâu.</p>
                        <p class="price">200.000 VND</p>
                    </div>
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
                            🐶 Dịch vụ có dành cho tất cả các loại thú cưng không?
                        </button>
                    </h2>
                    <div id="faqOne" class="accordion-collapse collapse show">
                        <div class="accordion-body">Có, chúng tôi cung cấp dịch vụ cho chó, mèo, thỏ, chim và các thú cưng khác.</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
