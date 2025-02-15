<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Cart" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession();
    List<Cart> cart = (List<Cart>) sessionObj.getAttribute("cart");
    double total = 0;
    if (cart != null) {
        for (Cart item : cart) {
            total += item.getQuantity() * item.getProduct().getPrice();
        }
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thanh Toán - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                    <li class="nav-item"><a class="nav-link" href="products.jsp">Sản Phẩm</a></li>
                    <li class="nav-item"><a class="nav-link active" href="checkout.jsp">Thanh Toán</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Checkout Form -->
    <section class="container checkout-container my-5">
        <h2 class="text-center mb-4">Thông Tin Thanh Toán</h2>
        <form action="processCheckout.jsp" method="post">
            <div class="mb-3">
                <label class="form-label">Họ và Tên</label>
                <input type="text" class="form-control" name="fullName" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Số Điện Thoại</label>
                <input type="text" class="form-control" name="phone" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Địa Chỉ Giao Hàng</label>
                <input type="text" class="form-control" name="address" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" required>
            </div>
            <h4 class="text-end">Tổng Cộng: <span class="text-success"><%= total %> VNĐ</span></h4>
            <div class="text-center mt-4">
                <button type="submit" class="btn btn-success w-100">Xác Nhận Thanh Toán</button>
            </div>
        </form>
    </section>

    <!-- Footer -->
    <footer class="footer bg-dark text-white text-center py-4">
        <p>&copy; 2025 PawHouse. Tất cả các quyền được bảo lưu.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>