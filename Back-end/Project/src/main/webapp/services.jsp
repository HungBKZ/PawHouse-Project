<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Service" %>
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

    <!-- Danh sách dịch vụ -->
    <section class="container py-5">
        <h2 class="section-title text-center mb-4">Dịch Vụ Chăm Sóc Thú Cưng</h2>
        <div class="row">
            <% List<Service> serviceList = (List<Service>) request.getAttribute("serviceList");
               if (serviceList != null) {
                   for (Service service : serviceList) { %>
            <div class="col-md-4 mb-4">
                <div class="service-card shadow">
                    <img src="<%= service.getServiceImage() %>" class="card-img-top" alt="<%= service.getServiceName() %>">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= service.getServiceName() %></h5>
                        <p class="card-text"><%= service.getDescription() %></p>
                        <p class="price"><%= service.getPrice() %> VND</p>
                        <a href="bookService.jsp?id=<%= service.getServiceID() %>" class="btn btn-success w-100">Đặt Lịch</a>
                    </div>
                </div>
            </div>
            <% } } else { %>
            <p class="text-center">Không có dịch vụ nào.</p>
            <% } %>
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
