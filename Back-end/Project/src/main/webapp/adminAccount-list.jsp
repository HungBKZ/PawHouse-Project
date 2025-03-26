<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Account" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Quản Lý Tài Khoản - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;600&display=swap" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        :root {
            --primary-color: #2c3e50; /* Xanh đậm trầm */
            --secondary-color: #34495e; /* Xanh xám nhạt */
            --success-color: #27ae60; /* Xanh lá trầm */
            --danger-color: #c0392b; /* Đỏ trầm */
            --light-bg: #ecf0f1; /* Màu nền nhạt */
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        body {
            background: #dfe4ea;
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
        }

        .navbar {
            background: var(--primary-color);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 500;
            color: #F19530; /* Màu cam cố định */
        }

        /* Đảm bảo không có hiệu ứng hover */
        .navbar-brand:hover {
            color: #F19530; /* Giữ nguyên màu khi hover */
        }

        .container {
            max-width: 1300px; /* Đồng bộ với account-container trước đó */
            margin: 2rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: var(--shadow);
            border: 1px solid #dcdcdc;
        }

        h2 {
            color: var(--primary-color);
            font-weight: 600;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.75rem;
            position: relative;
        }

        h2::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 2px;
            background: var(--primary-color);
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
        }

        .search-form .input-group {
            max-width: 400px;
            float: right;
        }

        .search-form .form-control {
            border: 1px solid #bdc3c7;
            border-radius: 5px 0 0 5px;
            padding: 8px 12px;
            transition: border-color 0.3s ease;
        }

        .search-form .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: none;
        }

        .search-form .btn {
            border-radius: 0 5px 5px 0;
            padding: 8px 16px;
            font-weight: 500;
            background: var(--primary-color);
            border: none;
            color: #ffffff;
            transition: background 0.3s ease;
        }

        .search-form .btn:hover {
            background: var(--secondary-color);
        }

        .table-container {
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
            width: 100%; /* Đảm bảo bảng chiếm toàn bộ chiều rộng container */
        }

        .table thead th {
            background: var(--primary-color);
            color: #ffffff;
            padding: 12px;
            font-weight: 500;
            text-align: center;
            font-size: 0.95rem;
            border-bottom: none;
        }

        .table td {
            padding: 12px 16px; /* Đồng bộ với account-table trước đó */
            vertical-align: middle;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
            background: #ffffff;
            transition: background 0.3s ease;
        }

        .table tr:hover td {
            background: #f5f6fa;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: 500;
            font-size: 0.85rem;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
        }

        .btn-success {
            background: var(--success-color);
            border: none;
        }

        .btn-danger {
            background: var(--danger-color);
            border: none;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .btn:disabled {
            background: #7f8c8d; /* Xám nhạt */
            opacity: 0.7;
            cursor: not-allowed;
        }

        .empty-state {
            text-align: center;
            padding: 2rem;
            color: var(--secondary-color);
        }

        .empty-state i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        @keyframes subtleFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .table tbody tr {
            animation: subtleFadeIn 0.4s ease-in;
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 1rem;
            }
            .table th, .table td {
                font-size: 0.85rem;
                padding: 8px;
            }
            .search-form .input-group {
                max-width: 100%;
                margin-top: 1rem;
                float: none;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
        </div>
    </nav>

    <div class="container">
        <h2>Quản Lý Tài Khoản</h2>

        <!-- Thanh tìm kiếm -->
        <div class="row mb-3 align-items-center">
            <div class="col-md-6">
                <!-- Không có nút thêm tài khoản, giữ chỗ trống để đồng bộ layout -->
            </div>
            <div class="col-md-6">
                <form method="get" action="/admin/accounts" class="search-form">
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Tìm kiếm theo Username" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                        <button class="btn" type="submit">Tìm</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Role</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Hoạt Động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Account> accounts = (List<Account>) request.getAttribute("accounts");
                        if (accounts != null && !accounts.isEmpty()) {
                            for (Account account : accounts) {
                    %>
                    <tr id="row-<%= account.getUserID()%>">
                        <td><%= account.getUserID()%></td>
                        <td><%= account.getRoleID()%></td>
                        <td><%= account.getUsername()%></td>
                        <td><%= account.getEmail()%></td>
                        <td id="status-<%= account.getUserID()%>">
                            <span class="badge <%= account.getUserStatus() ? "bg-success" : "bg-danger"%>">
                                <%= account.getUserStatus() ? "Hoạt Động" : "Không hoạt động"%>
                            </span>
                        </td>
                        <td>
                            <% if (account.getRoleID() == 1) { %>
                                <button class="btn btn-success" disabled>Admin</button>
                            <% } else { %>
                                <button class="btn <%= account.getUserStatus() ? "btn-danger" : "btn-success"%> toggle-status" 
                                        data-userid="<%= account.getUserID()%>" 
                                        data-status="<%= account.getUserStatus() ? 0 : 1%>">
                                    <%= account.getUserStatus() ? "Disable" : "Enable"%>
                                </button>
                            <% } %>
                        </td>
                    </tr>
                    <% }
                    } else { %>
                    <tr>
                        <td colspan="6" class="empty-state">
                            <i class="bi bi-person-x"></i>
                            <p class="h5">Không có dữ liệu tài khoản.</p>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".toggle-status").click(function () {
                var userID = $(this).data("userid");
                var newStatus = $(this).data("status");
                var button = $(this);

                $.post("/admin/accounts/update-status", { userID: userID, newStatus: newStatus }, function(response) {
                    if (response === "success") {
                        var statusCell = $("#status-" + userID);
                        if (newStatus === 0) {
                            statusCell.html('<span class="badge bg-danger">Không hoạt động</span>');
                            button.removeClass("btn-danger").addClass("btn-success").text("Enable").data("status", 1);
                        } else {
                            statusCell.html('<span class="badge bg-success">Hoạt Động</span>');
                            button.removeClass("btn-success").addClass("btn-danger").text("Disable").data("status", 0);
                        }
                    } else {
                        alert("Cập nhật thất bại!");
                    }
                }).fail(function() {
                    alert("Có lỗi xảy ra khi gửi yêu cầu đến server!");
                });
            });
        });
    </script>
</body>
</html>