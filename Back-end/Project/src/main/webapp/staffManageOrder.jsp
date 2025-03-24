<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.Orders"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Đơn Hàng - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
                font-family: 'Poppins', sans-serif;
                min-height: 100vh;
                padding-bottom: 100px;
                overflow-x: hidden;
            }
            .navbar {
                background: linear-gradient(90deg, #007bff, #004085);
                padding: 1.2rem 2rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }
            .navbar-brand {
                color: #fff !important;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                transition: all 0.3s ease;
            }
            .navbar-brand:hover {
                color: #ffd700 !important;
                transform: scale(1.05);
            }
            .container {
                margin-top: 50px;
                max-width: 1400px;
                animation: fadeIn 0.8s ease-in-out;
            }
            h2 {
                color: #0056b3;
                font-weight: 700;
                margin-bottom: 30px;
                letter-spacing: 1px;
            }
            .table {
                background: #fff;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                animation: slideUp 1s ease-out;
            }
            .table thead {
                background: linear-gradient(90deg, #007bff, #0056b3);
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .table th, .table td {
                vertical-align: middle;
                padding: 15px;
            }
            .table-hover tbody tr:hover {
                background-color: #e9ecef;
                transition: background-color 0.3s ease;
            }
            .badge.bg-success {
                background: #28a745 !important;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 600;
            }
            .badge.bg-warning {
                background: #ffc107 !important;
                color: #000 !important;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 600;
            }
            .btn-success, .btn-danger {
                border-radius: 25px;
                padding: 8px 15px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-success {
                background: #28a745;
                border: none;
            }
            .btn-success:hover {
                background: #218838;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
            }
            .btn-danger {
                background: #dc3545;
                border: none;
            }
            .btn-danger:hover {
                background: #c82333;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
            }
            .alert {
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                animation: slideIn 0.5s ease-in-out;
            }
            footer {
                background: linear-gradient(90deg, #0056b3, #003d80);
                color: #fff;
                text-align: center;
                padding: 20px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
                box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.2);
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            @keyframes slideUp {
                from {
                    transform: translateY(50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            @keyframes slideIn {
                from {
                    transform: translateX(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/staffDashboard"><i class="fas fa-paw"></i> PawHouse</a>
            </div>
        </nav>

        <div class="container mt-5">
            <h2><i class="fas fa-shopping-cart"></i> Danh Sách Đơn Hàng</h2>

            <% String error = (String) request.getAttribute("error");
            if (error != null) {%>
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle"></i> <%= error%>
            </div>
            <% } %>

            <table class="table table-bordered table-hover">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Khách Hàng</th>
                        <th>Ngày Đặt</th>
                        <th>Tổng Tiền</th>
                        <th>Ghi Chú</th>
                        <th>Trạng Thái</th>
                        <th>Hành Động</th>
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
                        <td><%= order.getNotes() != null ? order.getNotes() : "Không có"%></td>
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
                                <i class="fas fa-check"></i> Xác Nhận
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
            <p>© 2025 PawHouse. Mọi quyền được bảo lưu.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
    </body>
</html>