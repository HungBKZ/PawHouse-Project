<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Pet" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dịch Vụ Nhận Nuôi - PawHouse</title>
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

        /* Pet Card */
        .pet-card {
            background: white;
            padding: 15px;
            border-radius: 12px;
            text-align: center;
            transition: 0.3s;
            position: relative;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .pet-card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
        }

        .pet-card img {
            max-width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 12px;
        }

        .pet-card h5 {
            font-weight: bold;
            margin-top: 10px;
            font-size: 1.2rem;
        }

        .pet-card .btn {
            font-size: 1rem;
            transition: 0.3s;
        }

        .pet-card .btn:hover {
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
        <img src="./imgs/bannerpet.jpg" class="w-100" alt="Dịch Vụ Nhận Nuôi" />
    </section>

    <!-- Danh sách thú cưng cần nhận nuôi -->
    <section class="container py-5">
        <h2 class="section-title text-center mb-4">Thú Cưng Đang Chờ Nhận Nuôi</h2>
        <div class="row">
            <% List<Pet> petList = (List<Pet>) request.getAttribute("petList");
               if (petList != null) {
                   for (Pet pet : petList) { %>
            <div class="col-md-4 mb-4">
                <div class="pet-card shadow">
                    <img src="<%= pet.getPetImage() %>" class="card-img-top" alt="<%= pet.getPetName() %>">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= pet.getPetName() %></h5>
                        <p class="card-text">Tuổi: <%= pet.getAge() %> tháng</p>
                        <p class="card-text">Giống: <%= pet.getBreed() %></p>
                        <a href="adoptPet.jsp?id=<%= pet.getPetID() %>" class="btn btn-success w-100">Nhận Nuôi</a>
                    </div>
                </div>
            </div>
            <% } } else { %>
            <p class="text-center">Hiện chưa có thú cưng nào cần nhận nuôi.</p>
            <% } %>
        </div>
    </section>

    <!-- Lợi ích nhận nuôi -->
    <section class="container py-5">
        <h2 class="section-title text-center mb-4">Lợi Ích Khi Nhận Nuôi</h2>
        <div class="row text-center">
            <div class="col-md-4 benefit-item">
                <i class="bi bi-heart-fill"></i>
                <h5 class="mt-3">Mang Đến Yêu Thương</h5>
                <p>Nhận nuôi giúp thú cưng có một mái ấm mới.</p>
            </div>
            <div class="col-md-4 benefit-item">
                <i class="bi bi-house-heart"></i>
                <h5 class="mt-3">Cứu Một Mạng Sống</h5>
                <p>Cung cấp nơi ở cho thú cưng bị bỏ rơi.</p>
            </div>
            <div class="col-md-4 benefit-item">
                <i class="bi bi-emoji-smile"></i>
                <h5 class="mt-3">Kết Bạn Đời</h5>
                <p>Thú cưng là người bạn trung thành suốt đời.</p>
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
                        🐶 Tôi cần chuẩn bị gì khi nhận nuôi?
                    </button>
                </h2>
                <div id="faqOne" class="accordion-collapse collapse show">
                    <div class="accordion-body">Bạn cần chuẩn bị môi trường sống tốt, thức ăn, chỗ ngủ và yêu thương thú cưng.</div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqTwo">
                        📋 Có cần ký hợp đồng nhận nuôi không?
                    </button>
                </h2>
                <div id="faqTwo" class="accordion-collapse collapse">
                    <div class="accordion-body">Có, bạn cần ký cam kết chăm sóc thú cưng đúng cách.</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
