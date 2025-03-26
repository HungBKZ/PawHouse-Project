<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.ServiceAdmin" %>
<%@ page import="Model.ServiceCategories" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Dịch Vụ - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;600&display=swap" rel="stylesheet">
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
            max-width: 1200px;
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
            padding: 12px;
            vertical-align: middle;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
            background: #ffffff;
            transition: background 0.3s ease;
        }

        .table tr:hover td {
            background: #f5f6fa;
        }

        .table img {
            max-width: 50px;
            height: auto;
            border-radius: 4px;
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

        .btn-warning {
            background: #e67e22; /* Cam trầm */
            border: none;
        }

        .btn-danger {
            background: var(--danger-color);
            border: none;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .modal-content {
            border-radius: 8px;
            box-shadow: var(--shadow);
            border: 1px solid #dcdcdc;
        }

        .modal-header {
            background: var(--primary-color);
            color: #ffffff;
            border-bottom: none;
        }

        .modal-title {
            font-weight: 500;
        }

        .modal-body .form-label {
            font-weight: 500;
            color: var(--primary-color);
        }

        .modal-body .form-control, .modal-body .form-select {
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            padding: 8px 12px;
        }

        .modal-body .form-control:focus, .modal-body .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: none;
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
        <h2>Quản Lý Dịch Vụ</h2>
        <div class="row mb-3 align-items-center">
            <div class="col-md-6">
                <button class="btn btn-primary" onclick="openAddModal()">Thêm Dịch Vụ</button>
            </div>
            <div class="col-md-6">
                <form method="get" action="/admin/services" class="search-form">
                    <div class="input-group">
                        <input type="text" class="form-control" name="search" placeholder="Tìm kiếm tên dịch vụ" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                        <button class="btn" type="submit">Tìm</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Danh Mục</th>
                        <th>Tên Dịch Vụ</th>
                        <th>Mô Tả</th>
                        <th>Giá</th>
                        <th>Hình ảnh</th>
                        <th>Trạng Thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<ServiceAdmin> serviceList = (List<ServiceAdmin>) request.getAttribute("serviceList");
                       if (serviceList != null) {
                           for(ServiceAdmin service : serviceList) { %>
                    <tr>
                        <td><%= service.getServiceID() %></td>
                        <td><%= service.getCategoryName() %></td>
                        <td><%= service.getServiceName() %></td>
                        <td><%= service.getDescription() %></td>
                        <td><%= service.getPrice() %></td>
                        <td>
                            <% if (service.getServiceImage() != null && !service.getServiceImage().isEmpty()) { %>
                                <img src="<%= request.getContextPath() + "/" + service.getServiceImage() %>" alt="<%= service.getServiceName() %>">
                            <% } else { %>
                                Không có ảnh
                            <% } %>
                        </td>
                        <td><%= (service.getServiceStatus() == 1) ? "Hoạt động" : "Không hoạt động" %></td>
                        <td>
                            <div class="d-flex gap-2 justify-content-center">
                                <button class="btn btn-warning" onclick="openEditModal('<%= service.getServiceID() %>', '<%= service.getCategoryID() %>', '<%= service.getServiceName() %>', '<%= service.getDescription() %>', '<%= service.getPrice() %>', '<%= service.getServiceImage() %>', '<%= service.getServiceStatus() %>')">Sửa</button>
                                <button class="btn btn-danger" onclick="confirmDelete('<%= service.getServiceID() %>')">Xóa</button>
                            </div>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Thêm/Sửa Dịch Vụ -->
    <div class="modal fade" id="serviceModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="serviceForm" method="post" action="/admin/services" enctype="multipart/form-data">
                        <input type="hidden" id="action" name="action">
                        <input type="hidden" id="serviceId" name="id">
                        <input type="hidden" id="existingImage" name="existingImage">
                        <div class="mb-3">
                            <label class="form-label">Danh Mục</label>
                            <select class="form-select" id="categoryID" name="categoryID" required>
                                <% List<ServiceCategories> categoryList = (List<ServiceCategories>) request.getAttribute("categoryList");
                                   if (categoryList != null) {
                                       for (ServiceCategories category : categoryList) { %>
                                <option value="<%= category.getCategoryID() %>"><%= category.getCategoryName() %></option>
                                <% } } %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tên dịch vụ</label>
                            <input type="text" class="form-control" id="serviceName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô Tả</label>
                            <textarea class="form-control" id="description" name="description" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giá</label>
                            <input type="number" class="form-control" id="price" name="price" min="0" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Hình ảnh</label>
                            <input type="file" class="form-control" id="image" name="image">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Trạng Thái</label>
                            <select class="form-select" id="serviceStatus" name="status">
                                <option value="1">Hoạt động</option>
                                <option value="0">Không hoạt động</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success">Lưu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openAddModal() {
            document.getElementById("modalTitle").innerText = "Thêm Dịch Vụ";
            document.getElementById("action").value = "add";
            document.getElementById("serviceForm").reset();
            new bootstrap.Modal(document.getElementById("serviceModal")).show();
        }

        function openEditModal(id, category, name, description, price, image, status) {
            document.getElementById("modalTitle").innerText = "Sửa Dịch Vụ";
            document.getElementById("action").value = "update";
            document.getElementById("serviceId").value = id;
            document.getElementById("categoryID").value = category;
            document.getElementById("serviceName").value = name;
            document.getElementById("description").value = description;
            document.getElementById("price").value = price;
            document.getElementById("existingImage").value = image;
            document.getElementById("serviceStatus").value = status;
            new bootstrap.Modal(document.getElementById("serviceModal")).show();
        }

        function confirmDelete(id) {
            if (confirm("Bạn có chắc chắn muốn xóa dịch vụ này?")) {
                let form = document.createElement("form");
                form.method = "POST";
                form.action = "/admin/services";
                let actionInput = document.createElement("input");
                actionInput.type = "hidden";
                actionInput.name = "action";
                actionInput.value = "delete";
                let idInput = document.createElement("input");
                idInput.type = "hidden";
                idInput.name = "id";
                idInput.value = id;
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>