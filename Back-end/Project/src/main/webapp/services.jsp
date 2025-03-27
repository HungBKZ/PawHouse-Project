<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Service" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:forEach var="service" items="${medicalList}">
                    <div class="col">
                        <div class="card h-100 service-card text-center">
                            <img src="${service.serviceImage}" class="card-img-top" alt="${service.serviceName}" style="height: 200px; object-fit: cover;">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${service.serviceName}</h5>
                                <p class="card-text">${service.description}</p>
                                <p class="price mt-auto fw-bold text-success"><fmt:formatNumber value="${service.price}" pattern="#,##0"/> VND</p>
                                <a href="BookService?id=${service.serviceID}" class="btn btn-custom mt-2 w-100">Đặt Lịch</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </section>

        <section class="container py-5">
            <h2 class="section-title">Dịch Vụ Spa</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:forEach var="service" items="${spaList}">
                    <div class="col">
                        <div class="card h-100 service-card text-center">
                            <img src="${service.serviceImage}" class="card-img-top" alt="${service.serviceName}" style="height: 200px; object-fit: cover;">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${service.serviceName}</h5>
                                <p class="card-text">${service.description}</p>
                                <p class="price mt-auto fw-bold text-success"><fmt:formatNumber value="${service.price}" pattern="#,##0"/> VND</p>
                                <a href="BookService?id=${service.serviceID}" class="btn btn-custom mt-2 w-100">Đặt Lịch</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
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
