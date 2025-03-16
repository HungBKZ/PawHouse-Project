<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Orders" %>
<%@ page import="DAO.OrderDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Khởi tạo DAO để lấy danh sách đơn hàng
    OrderDAO orderDAO = new OrderDAO();
    List<Orders> orderList = orderDAO.getAllOrders();

    // Định dạng tiền tệ
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Đơn Hàng - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f9f9f9;
            }

            .order-container {
                max-width: 800px;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .order-status {
                font-weight: bold;
            }

            .order-status.processing {
                color: orange;
            }
            .order-status.completed {
                color: green;
            }
            .order-status.cancelled {
                color: red;
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

        <!-- Đơn Hàng -->
        <section class="container order-container my-5">
            <h2 class="text-center mb-4">Danh Sách Đơn Hàng</h2>

            <% if (orderList != null && !orderList.isEmpty()) { %>
            <% for (Orders order : orderList) {%>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Mã Đơn Hàng: <%= order.getOrderID()%></h5>
                    <p>Trạng Thái: 
                        <span class="order-status 
                              <%= order.isOrderStatus() ? "completed" : "processing"%>">
                            <%= order.isOrderStatus() ? "Hoàn Thành" : "Đang Xử Lý"%>
                        </span>
                    </p>
                    <p class="fw-bold">Tổng Tiền: <span class="text-success"><%= currencyFormatter.format(order.getTotalAmount())%></span></p>
                </div>
            </div>
            <% } %>
            <% } else { %>
            <p class="text-center">Bạn chưa có đơn hàng nào.</p>
            <% }%>
        </section>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
