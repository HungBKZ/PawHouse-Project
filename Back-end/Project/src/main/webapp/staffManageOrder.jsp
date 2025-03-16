<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.Orders"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý đơn hàng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            function updateOrderStatus(orderID, status) {
                let message = status ? "Bạn có chắc muốn xác nhận đơn hàng này?" : "Bạn có chắc muốn hủy đơn hàng này?";
                if (confirm(message)) {
                    console.log("Sending request to update order ID: " + orderID + " to status: " + status);

                    $.ajax({
                        url: "staffManageOrder",
                        method: "POST",
                        data: {
                            action: "updateStatus",
                            orderID: orderID,
                            status: status
                        },
                        success: function (response) {
                            console.log("Response from server:", response);
                            if (response === "success") {
                                alert(status ? "Đã xác nhận đơn hàng thành công!" : "Đã hủy đơn hàng thành công!");
                                window.location.reload();
                            } else {
                                alert("Có lỗi xảy ra: " + response);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Error:", error);
                            alert("Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại sau!");
                        }
                    });
                }
            }
        </script>

        <style>
            body {
                background-color: #f8f9fa;
                padding-bottom: 70px;
            }
            .navbar {
                background-color: #0056b3;
            }
            .navbar-brand, .nav-link {
                color: white !important;
                font-weight: bold;
            }
            .container {
                margin-top: 30px;
            }
            .table {
                background-color: white;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .btn {
                margin: 2px;
            }
            footer {
                text-align: center;
                padding: 20px;
                background-color: #0056b3;
                color: white;
                position: fixed;
                width: 100%;
                bottom: 0;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/staffDashboard"><i class="fas fa-paw"></i> PawHouse Staff</a>

            </div>
        </nav>
        <div class="container mt-5">
            <h2 class="mb-4">Danh sách đơn hàng</h2>
            <% String error = (String) request.getAttribute("error");
                if (error != null) {%>
            <div class="alert alert-danger" role="alert">
                <%= error%>
            </div>
            <% } %>
            <table class="table table-bordered table-hover">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Khách hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Ghi chú</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Orders> orders = (List<Orders>) request.getAttribute("orders");
                        if (orders != null && !orders.isEmpty()) {
                            for (Orders order : orders) {
                    %>
                    <tr>
                        <td><%= order.getOrderID()%></td>
                        <td><%= order.getUser().getFullName()%></td>
                        <td><%= order.getOrderDate()%></td>
                        <td><%= String.format("%,.0f", order.getTotalAmount())%> VND</td>
                        <td><%= order.getNotes() != null ? order.getNotes() : ""%></td>
                        <td>
                            <% if (order.isOrderStatus()) { %>
                            <span class="badge bg-success">Đã xác nhận</span>
                            <% } else { %>
                            <span class="badge bg-warning">Chưa xác nhận</span>
                            <% } %>
                        </td>
                        <td>
                            <% if (!order.isOrderStatus()) {%>
                            <button class="btn btn-success btn-sm" onclick="updateOrderStatus(<%= order.getOrderID()%>, true)">
                                <i class="fas fa-check"></i> Xác nhận
                            </button>
                            <button class="btn btn-danger btn-sm" onclick="updateOrderStatus(<%= order.getOrderID()%>, false)">
                                <i class="fas fa-times"></i> Hủy
                            </button>
                            <% } %>
                        </td>
                    </tr>
                    <% }
                    } else { %>
                    <tr>
                        <td colspan="7" class="text-center">Không có đơn hàng nào</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
        <footer>
            <p>&copy; 2025 PawHouse. All rights reserved.</p>
        </footer>
        <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
