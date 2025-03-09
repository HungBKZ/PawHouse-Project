<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Pet, Model.AdoptionHistory, Model.PetCategories" %>
<%@ page import="java.util.List" %>

<%
    Pet pet = (Pet) request.getAttribute("petDetail");
    List<AdoptionHistory> adoptionHistory = (List<AdoptionHistory>) request.getAttribute("adoptionHistory");

    if (pet == null) {
        response.sendRedirect("adoption.jsp?error=notfound");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết thú cưng</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        
        .pet-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
        .btn-adopt {
            width: 100%;
            font-size: 18px;
        }
    </style>
</head>
<body>

    <%@ include file="includes/navbar.jsp" %>

    <div class="container">
        <div class="row">
            <!-- Ảnh thú cưng -->
            <div class="col-md-6">
                <img src="<%= pet.getPetImage() != null ? pet.getPetImage() : "assets/img/default-pet.jpg" %>" class="pet-image">
            </div>

            <!-- Thông tin thú cưng -->
            <div class="col-md-6">
                <h2 class="text-primary"><%= pet.getPetName() %></h2>
                <p><strong>Loài:</strong> <%= pet.getSpecies() %></p>
                <p><strong>Giống:</strong> <%= pet.getBreed() %></p>
                <p><strong>Tuổi:</strong> <%= pet.getAge() %> năm</p>
                <p><strong>Giới tính:</strong> <%= pet.getGender() %></p>
                <p><strong>Trạng thái:</strong> 
                    <span class="badge bg-<%= pet.getAdoptionStatus().equals("Chưa nhận nuôi") ? "danger" : "success" %>">
                        <%= pet.getAdoptionStatus() %>
                    </span>
                </p>

                <% if (pet.getAdoptionStatus().equals("Chưa nhận nuôi")) { %>
                    <form action="AdoptPetServlet" method="post">
                        <input type="hidden" name="petId" value="<%= pet.getPetID() %>">
                        <button type="submit" class="btn btn-success btn-adopt">Nhận nuôi ngay</button>
                    </form>
                <% } %>
            </div>
        </div>

        <!-- Lịch sử nhận nuôi -->
        <div class="mt-4">
            <h3 class="text-secondary">Lịch sử nhận nuôi</h3>
            <% if (adoptionHistory != null && !adoptionHistory.isEmpty()) { %>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Ngày nhận nuôi</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (AdoptionHistory history : adoptionHistory) { %>
                            <tr>
                                <td><%= history.getAdoptionDate() %></td>
                               <td><%= history.getAdoptionStatus() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p class="text-muted">Chưa có lịch sử nhận nuôi.</p>
            <% } %>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
