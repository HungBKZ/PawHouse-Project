<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
                flex: 1 1 calc(33.333% - 20px);
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
            <form method="get" action="AdoptionServlet">
                <div class="row g-3">
                    <!-- Tìm kiếm -->
                    <div class="col-md-4">
                        <input type="text" name="search" id="searchPet" class="form-control"
                               placeholder="Tìm kiếm theo tên..."
                               value="${param.search}" onkeyup="filterPets()">
                    </div>

                    <!-- Bộ lọc Loài -->
                    <div class="col-md-4">
                        <select name="category" id="categoryFilter" class="form-select" onchange="filterPets()">
                            <option value="all">Tất cả loài</option>
                            <c:forEach var="category" items="${categoriesList}">
                                <option value="${category.categoryName}" 
                                        ${param.category == category.categoryName ? 'selected' : ''}>
                                    ${category.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Bộ lọc Trạng thái -->
                    <div class="col-md-4">
                        <select name="filter" id="statusFilter" class="form-select" onchange="this.form.submit()">
                            <option value="adoptionList" ${param.filter == 'adoptionList' ? 'selected' : ''}>Chưa nhận nuôi</option>
                            <option value="pendingAdoptionList" ${param.filter == 'pendingAdoptionList' ? 'selected' : ''}>Đang chờ duyệt</option>
                        </select>
                    </div>
                </div>
            </form>

            <!-- Danh sách thú cưng -->
            <div class="pet-container mt-4">
                <div class="row" id="petList">
                    <c:forEach var="pet" items="${petList}">
                        <div class="col-md-4 mb-4 pet-card-container">
                            <div class="card pet-card shadow-sm"
                                 data-name="${pet.petName.toLowerCase()}" 
                                 data-category="${pet.species.toLowerCase()}" 
                                 data-status="${pet.adoptionStatus.toLowerCase()}">
                                <img src="${not empty pet.petImage ? pet.petImage : 'default.jpg'}" class="pet-image">
                                <div class="card-body text-center">
                                    <h5 class="card-title">${pet.petName}</h5>
                                    <p><strong>Loài:</strong> ${pet.species}</p>
                                    <p><strong>Trạng thái:</strong> ${pet.adoptionStatus}</p>
                                    <a href="PetDetailServlet?petId=${pet.petID}" class="btn btn-primary btn-sm">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>



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

        <%@ include file="includes/footer.jsp" %>

        <script>
            function filterPets() {
                let searchValue = document.getElementById("searchPet").value.toLowerCase();
                let categoryValue = document.getElementById("categoryFilter").value.toLowerCase();
                let petContainer = document.getElementById("petList");
                let petCards = document.querySelectorAll(".pet-card-container");

                let visiblePets = 0;
                petCards.forEach(card => {
                    let petCard = card.querySelector(".pet-card");
                    let petName = petCard.getAttribute("data-name").toLowerCase();
                    let petCategory = petCard.getAttribute("data-category").toLowerCase();

                    let matchSearch = petName.includes(searchValue);
                    let matchCategory = (categoryValue === "all" || petCategory === categoryValue);

                    if (matchSearch && matchCategory) {
                        card.style.display = "block";
                        visiblePets++;
                    } else {
                        card.style.display = "none";
                    }
                });

                let noResultsMessage = document.getElementById("noResultsMessage");
                if (!noResultsMessage) {
                    noResultsMessage = document.createElement("div");
                    noResultsMessage.id = "noResultsMessage";
                    noResultsMessage.classList.add("alert", "alert-warning", "text-center");
                    noResultsMessage.innerText = "Không có thú cưng nào phù hợp.";
                    petContainer.parentElement.appendChild(noResultsMessage);
                }
                noResultsMessage.style.display = (visiblePets === 0) ? "block" : "none";
            }

// Giữ trạng thái bộ lọc khi tải lại trang
            document.addEventListener("DOMContentLoaded", function () {
                filterPets();
            });

        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
