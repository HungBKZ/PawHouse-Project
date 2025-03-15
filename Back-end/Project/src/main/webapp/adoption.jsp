<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Pet" %>

<%
    List<Pet> adoptionList = (List<Pet>) request.getAttribute("adoptionList");
    if (adoptionList == null) {
        adoptionList = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách thú cưng</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .pet-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
            }

            .row {
                width: 100%;
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
            }

            .pet-card-container {
                flex: 1 1 calc(33.333% - 20px); /* Mỗi thẻ chiếm 1/3 hàng */
                max-width: 400px;
                min-width: 280px;
            }

            .pet-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease-in-out;
                overflow: hidden;
            }

            .pet-card.hidden {
                display: none !important; /* Ẩn hoàn toàn khi lọc */
            }

            .pet-image {
                width: 100%;
                height: 250px;
                object-fit: cover;
            }

        </style>
    </head>
    <body>

        <%@ include file="includes/navbar.jsp" %>

        <div class="container mt-4">
            <h2 class="text-center text-primary"><i class="fas fa-paw"></i> Danh sách thú cưng</h2>

            <!-- Bộ lọc -->
            <div class="row g-3">
                <div class="col-md-4">
                    <input type="text" id="searchPet" class="form-control" placeholder="Tìm kiếm theo tên..." onkeyup="filterPets()">
                </div>
                <div class="col-md-4">
                    <select id="categoryFilter" class="form-select" onchange="filterPets()">
                        <option value="all">Tất cả loài</option>
                        <option value="Chó">Chó</option>
                        <option value="Mèo">Mèo</option>
                        <option value="Bò sát">Bò sát</option>
                        <option value="Gặm nhấm">Gặm nhấm</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <select id="statusFilter" class="form-select" onchange="filterPets()">
                        <option value="all">Tất cả trạng thái</option>
                        <option value="Chưa nhận nuôi">Chưa nhận nuôi</option>
                        <option value="Đã nhận nuôi">Đã nhận nuôi</option>
                    </select>
                </div>
            </div>

            <!-- Danh sách thú cưng -->
            <div class="pet-container mt-4">
                <div class="row" id="petList">
                    <% for (Pet pet : adoptionList) {%>
                    <div class="col-md-4 mb-4 pet-card-container">
                        <div class="card pet-card shadow-sm" 
                             data-name="<%= pet.getPetName()%>" 
                             data-category="<%= pet.getSpecies()%>" 
                             data-status="<%= pet.getAdoptionStatus()%>">
                            <img src="<%= pet.getPetImage() != null ? pet.getPetImage() : "default.jpg"%>" class="pet-image">
                            <div class="card-body text-center">
                                <h5 class="card-title"><%= pet.getPetName()%></h5>
                                <p><strong>Loài:</strong> <%= pet.getSpecies()%></p>
                                <p><strong>Trạng thái:</strong> <%= pet.getAdoptionStatus()%></p>
                                <a href="PetDetailServlet?petId=<%= pet.getPetID()%>" class="btn btn-primary btn-sm">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <% }%>
                </div>
            </div>
        </div>
        <!-- Lợi ích nhận nuôi -->
        <section class="container py-5">
            <h2 class="section-title text-center mb-4">Lợi Ích Khi Nhận Nuôi</h2>
            <div class="row text-center">
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-heart-fill"></i>
                    <h5 class="mt-3">Mang Đến Yêu Thương</h5>
                    <p>Nhận nuôi giúp thú cưng có một mái ấm mới.</p>
                </div>
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-house-heart"></i>
                    <h5 class="mt-3">Cứu Một Mạng Sống</h5>
                    <p>Cung cấp nơi ở cho thú cưng bị bỏ rơi.</p>
                </div>
                <div class="col-md-4 benefit-item">
                    <i class="bi bi-emoji-smile"></i>
                    <h5 class="mt-3">Kết Bạn Đời</h5>
                    <p>Thú cưng là người bạn trung thành suốt đời.</p>
                </div>
            </div>
        </section>

        <!-- Câu hỏi thường gặp -->
        <section class="container py-5">
            <h2 class="section-title text-center mb-4">Câu Hỏi Thường Gặp</h2>
            <div class="accordion" id="faqAccordion">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faqOne">
                            🐶 Tôi cần chuẩn bị gì khi nhận nuôi?
                        </button>
                    </h2>
                    <div id="faqOne" class="accordion-collapse collapse show">
                        <div class="accordion-body">Bạn cần chuẩn bị môi trường sống tốt, thức ăn, chỗ ngủ và yêu thương thú cưng.</div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqTwo">
                            📋 Có cần ký hợp đồng nhận nuôi không?
                        </button>
                    </h2>
                    <div id="faqTwo" class="accordion-collapse collapse">
                        <div class="accordion-body">Có, bạn cần ký cam kết chăm sóc thú cưng đúng cách.</div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>
        <script>
            function filterPets() {
                let searchValue = document.getElementById("searchPet").value.toLowerCase();
                let categoryValue = document.getElementById("categoryFilter").value.toLowerCase();
                let statusValue = document.getElementById("statusFilter").value.toLowerCase();
                let petContainer = document.getElementById("petList");
                let petCards = document.querySelectorAll(".pet-card-container");

                let visiblePets = 0;
                petCards.forEach(card => {
                    let petCard = card.querySelector(".pet-card");
                    let petName = petCard.getAttribute("data-name").toLowerCase();
                    let petCategory = petCard.getAttribute("data-category").toLowerCase();
                    let petStatus = petCard.getAttribute("data-status").toLowerCase();

                    let matchSearch = petName.includes(searchValue);
                    let matchCategory = (categoryValue === "all" || petCategory === categoryValue);
                    let matchStatus = (statusValue === "all" || petStatus === statusValue);

                    if (matchSearch && matchCategory && matchStatus) {
                        card.style.display = "block";
                        visiblePets++;
                    } else {
                        card.style.display = "none";
                    }
                });

                // 🟢 Hiển thị thông báo nếu không tìm thấy kết quả
                let noResultsMessage = document.getElementById("noResultsMessage");
                if (!noResultsMessage) {
                    noResultsMessage = document.createElement("div");
                    noResultsMessage.id = "noResultsMessage";
                    noResultsMessage.classList.add("alert", "alert-warning", "text-center");
                    noResultsMessage.innerText = "Không có thú cưng nào phù hợp.";
                    petContainer.parentElement.appendChild(noResultsMessage);
                }
                noResultsMessage.style.display = (visiblePets === 0) ? "block" : "none";

                // 🟢 Cập nhật bố cục flexbox sau khi lọc
                setTimeout(() => {
                    petContainer.style.display = "none";  // Ẩn tạm
                    petContainer.offsetHeight;  // Kích hoạt reflow
                    petContainer.style.display = "flex"; // Hiển thị lại
                }, 10);
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
