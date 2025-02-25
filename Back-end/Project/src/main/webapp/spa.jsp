<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Service" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dịch Vụ Spa & Grooming - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">PawHouse</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="index.jsp">Trang Chủ</a></li>
                        <li class="nav-item"><a class="nav-link active" href="spa.jsp">Dịch Vụ Spa</a></li>
                        <li class="nav-item"><a class="nav-link" href="services.jsp">Dịch Vụ</a></li>
                        <li class="nav-item"><a class="nav-link" href="cart.jsp"><i class="bi bi-cart"></i> Giỏ Hàng</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Banner -->
        <section class="container-fluid p-0">
            <img src="./imgs/spaban.jpg" class="w-100" alt="Dịch Vụ Spa & Grooming" />
        </section>

        <!-- Danh sách dịch vụ spa -->
        <section class="container py-5">
            <h2 class="text-center mb-4">Dịch Vụ Spa & Grooming Chuyên Nghiệp</h2>
            <div class="row">
                <% List<Service> spaServices = (List<Service>) request.getAttribute("spaServices");
                   if (spaServices != null) {
                       for (Service service : spaServices) { %>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <img src="<%= service.getServiceImage() %>" class="card-img-top" alt="<%= service.getServiceName() %>">
                        <div class="card-body text-center">
                            <h5 class="card-title"><%= service.getServiceName() %></h5>
                            <p class="card-text"><%= service.getDescription() %></p>
                            <p class="fw-bold text-primary"><%= service.getPrice() %> VND</p>
                            <a href="bookSpa.jsp?id=<%= service.getServiceID() %>" class="btn btn-success">Đặt Lịch</a>
                        </div>
                    </div>
                </div>
                <% } } else { %>
                <p class="text-center">Không có dịch vụ nào.</p>
                <% } %>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer bg-dark text-white text-center py-4">
            <p>&copy; 2025 PawHouse. Tất cả các quyền được bảo lưu.</p>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>