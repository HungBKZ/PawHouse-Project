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
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f9f9f9;
            }

            .checkout-container {
                max-width: 600px;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .checkout-container h2 {
                font-weight: bold;
                color: #333;
            }

            .btn-success {
                font-size: 1.1rem;
                transition: 0.3s;
            }

            .btn-success:hover {
                transform: scale(1.05);
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

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

                <!-- Phương thức thanh toán -->
                <div class="mb-3">
                    <label class="form-label">Phương Thức Thanh Toán</label>
                    <select class="form-select" name="paymentMethod" required>
                        <option value="cod">Thanh toán khi nhận hàng (COD)</option>
                        <option value="momo">Ví MoMo</option>
                        <option value="bank">Chuyển khoản ngân hàng</option>
                    </select>
                </div>

                <!-- Hiển thị tổng cộng -->
                <div class="text-end">
                    <h4>Tổng Cộng: <span class="text-success"><%= total%> VNĐ</span></h4>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success w-100">Xác Nhận Thanh Toán</button>
                </div>
            </form>
        </section>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
