<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Pet" %>

<%
    List<Pet> petList = (List<Pet>) request.getAttribute("myPets");
    Boolean isStaffObj = (Boolean) request.getAttribute("isStaff");
    boolean isStaff = isStaffObj != null ? isStaffObj : false;
    String successMessage = (String) request.getAttribute("successMessage");
    
    // Redirect to servlet if accessed directly
    if (petList == null) {
        response.sendRedirect("MyPet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thú cưng của tôi</title>
        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Custom CSS -->
        <style>
            body {
                background: linear-gradient(to right, #f8f9fa, #e9ecef);
            }

            .pet-card {
                transition: transform 0.3s ease-in-out, box-shadow 0.3s;
                border-radius: 10px;
            }
            .pet-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }
            .pet-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 10px 10px 0 0;
            }
            .card-body {
                padding: 20px;
            }
            .card-title {
                font-size: 1.5rem;
                font-weight: bold;
            }
            .status-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.9rem;
                font-weight: 500;
            }
            .status-completed {
                background-color: #d4edda;
                color: #155724;
            }
            .status-in-progress {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-pending {
                background-color: #f8d7da;
                color: #721c24;
            }
            .status-none {
                background-color: #e2e3e5;
                color: #383d41;
            }
            .alert-info {
                background-color: #d1ecf1;
                border-color: #bee5eb;
                color: #0c5460;
                padding: 15px;
                border-radius: 10px;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="includes/navbar.jsp" %>

        <div class="container mt-5">
            <% if (successMessage != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> <%= successMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-primary"><i class="fas fa-paw"></i> Thú cưng của tôi</h2>
                <% if (isStaff) { %>
                    <a href="addPet.jsp" class="btn btn-success"><i class="fas fa-plus-circle"></i> Thêm thú cưng</a>
                <% } %>
            </div>
            <div class="row">
                <% if (petList != null && !petList.isEmpty()) {
                        for (Pet pet : petList) { %>
                <div class="col-md-4 mb-4">
                    <div class="card pet-card shadow-sm">
                        <img src="<%= (pet.getPetImage() != null && !pet.getPetImage().isEmpty()) ? pet.getPetImage() : "assets/img/default-pet.jpg"%>" 
                             alt="<%= pet.getPetName()%>" class="pet-image">
                        <div class="card-body">
                            <h5 class="card-title text-primary"><%= pet.getPetName()%></h5>
                            <p class="card-text"><strong>Loài:</strong> <%= pet.getSpecies()%></p>
                            <p class="card-text"><strong>Giới tính:</strong> <%= pet.getGender()%></p>
                            <p class="card-text">
                                <strong>Trạng thái nhận nuôi:</strong> 
                                <span class="<%= pet.getAdoptionStatus().equals("Đã nhận nuôi") ? "text-success" : "text-warning" %>">
                                    <%= pet.getAdoptionStatus()%>
                                </span>
                            </p>
                            <p class="card-text">
                                <strong>Trạng thái dịch vụ:</strong><br>
                                <% 
                                    String serviceStatus = pet.getInUseService();
                                    String statusClass = "";
                                    if (serviceStatus == null || serviceStatus.equals("Chưa từng sử dụng dịch vụ")) {
                                        statusClass = "status-none";
                                    } else if (serviceStatus.equals("Hoàn thành")) {
                                        statusClass = "status-completed";
                                    } else if (serviceStatus.equals("Đang tiến hành")) {
                                        statusClass = "status-in-progress";
                                    } else {
                                        statusClass = "status-pending";
                                    }
                                %>
                                <span class="status-badge <%= statusClass %>">
                                    <%= serviceStatus != null ? serviceStatus : "Chưa từng sử dụng dịch vụ" %>
                                </span>
                            </p>
                            <% if (isStaff) { %>
                            <div class="btn-action mt-3">
                                <a href="MyPet?action=edit&petId=<%= pet.getPetID()%>" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <a href="MyPet?action=delete&petId=<%= pet.getPetID()%>" 
                                   class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa thú cưng này?');">
                                    <i class="fas fa-trash-alt"></i> Xóa
                                </a>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% }
                } else { %>
                <div class="col-12">
                    <div class="alert alert-info text-center" role="alert">
                        <% if (isStaff) { %>
                            Chưa có thú cưng nào. <a href="addPet.jsp" class="alert-link">Thêm thú cưng mới</a> ngay!
                        <% } else { %>
                            Bạn chưa có thú cưng nào trong danh sách.
                        <% } %>
                    </div>
                </div>
                <% } %>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
