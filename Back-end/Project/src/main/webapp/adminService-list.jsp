<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.ServiceAdmin" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Dịch Vụ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
            </div>
        </nav>
        <div class="container mt-4">
            <h2 class="text-center">Quản Lý Dịch Vụ</h2>
            <button class="btn btn-primary mb-3" onclick="openAddModal()">Thêm Dịch Vụ</button>
            <table class="table table-bordered">
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
                        <td><%= service.getCategoryID() %></td>
                        <td><%= service.getServiceName() %></td>
                        <td><%= service.getDescription() %></td>
                        <td><%= service.getPrice() %></td>
                        <td>
                            <% if (service.getServiceImage() != null && !service.getServiceImage().isEmpty()) { %>
                                <img src="<%= request.getContextPath() + "/" + service.getServiceImage() %>" width="50">
                            <% } else { %>
                                Không có ảnh
                            <% } %>
                        </td>
                        <td><%= (service.getServiceStatus() == 1) ? "Hoạt động" : "Không hoạt động" %></td>
                        <td>
                            <button class="btn btn-warning" onclick="openEditModal('<%= service.getServiceID() %>', '<%= service.getCategoryID() %>', '<%= service.getServiceName() %>', '<%= service.getDescription() %>', '<%= service.getPrice() %>', '<%= service.getServiceImage() %>', '<%= service.getServiceStatus() %>')">Sửa</button>
                            <button class="btn btn-danger" onclick="confirmDelete('<%= service.getServiceID() %>')">Xóa</button>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
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
                                <select class="form-control" id="categoryID" name="categoryID" required>
                                    <% for(int i = 1; i <= 12; i++) { %>
                                        <option value="<%= i %>"><%= i %></option>
                                    <% } %>
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
                                <select class="form-control" id="serviceStatus" name="status">
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
