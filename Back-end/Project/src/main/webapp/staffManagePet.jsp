<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Pets - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                padding-bottom: 70px;
            }
            .navbar {
                background-color: #0056b3;
                padding: 15px 0;
            }
            .navbar-brand, .nav-link {
                color: white !important;
                font-weight: 600;
            }
            .container {
                margin-top: 30px;
            }
            .table {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .table thead {
                background-color: #0056b3;
                color: white;
            }
            .status-available {
                background-color: #28a745; /* Xanh lá - Có sẵn */
                color: white;
            }
            .status-pending {
                background-color: #ffc107; /* Vàng - Đang chờ duyệt */
                color: black;
            }
            .status-adopted {
                background-color: #17a2b8; /* Xanh dương - Đã nhận nuôi */
                color: white;
            }
            .status-not-adopted {
                background-color: #6c757d; /* Xám - Chưa nhận nuôi */
                color: white;
            }

            .pet-image {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 50%;
            }
            footer {
                background-color: #0056b3;
                color: white;
                text-align: center;
                padding: 20px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
            }
        </style>

    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/staffDashboard"><i class="fas fa-paw"></i> PawHouse Staff</a>
                
            </div>
        </nav>

        <div class="container">
            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Bộ lọc tìm kiếm -->
            <div class="search-filters">
                <form id="searchForm" class="row g-3">
                    <div class="col-md-3">
                        <input type="text" class="form-control" id="searchInput" name="search" 
                               placeholder="Tìm kiếm theo tên, loài, giống..." autocomplete="off">
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" id="categoryFilter">
                            <option value="">Tất cả danh mục</option>
                            <option value="Chó">Chó</option>
                            <option value="Mèo">Mèo</option>
                            <option value="Bò sát">Bò sát</option>
                            <option value="Gặm nhấm">Gặm nhấm</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" id="statusFilter">
                            <option value="">Tất cả trạng thái</option>
                            <option value="Chưa nhận nuôi">Chưa nhận nuôi</option>
                            <option value="Đang chờ duyệt">Đang chờ duyệt</option>
                            <option value="Đã nhận nuôi">Đã nhận nuôi</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </form>
            </div>

            <!-- Nút Thêm Thú Cưng -->
            <div class="text-end mt-3">
                <a href="${pageContext.request.contextPath}/addStaffPet.jsp" class="btn btn-success">
                    <i class="fas fa-plus"></i> Thêm Thú Cưng
                </a>
            </div>
        </div>


        <!-- Bảng danh sách Pet -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Species</th>
                                <th>Breed</th>
                                <th>Age</th>
                                <th>Gender</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="petTableBody">
                            <c:forEach items="${petList}" var="pet">
                                <tr class="align-middle">
                                    <td>${pet.petID}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/${pet.petImage}" 
                                             alt="${pet.petName}" class="pet-image" 
                                             onerror="this.src='${pageContext.request.contextPath}/imgs/avatar/default-pet.jpg'">
                                    </td>
                                    <td>${pet.petName}</td>
                                    <td>${pet.category.categoryName}</td>
                                    <td>${pet.species}</td>
                                    <td>${pet.breed}</td>
                                    <td>${pet.age} years</td>
                                    <td>${pet.gender}</td>
                                    <td>
                                        <span class="badge 
                                              <c:choose>
                                                  <c:when test="${pet.adoptionStatus eq 'Chưa nhận nuôi'}">status-not-adopted</c:when>
                                                  <c:when test="${pet.adoptionStatus eq 'Đang chờ duyệt'}">status-pending</c:when>
                                                  <c:when test="${pet.adoptionStatus eq 'Đã nhận nuôi'}">status-adopted</c:when>
                                                  <c:otherwise>status-available</c:otherwise>
                                              </c:choose>">
                                            <c:choose>
                                                <c:when test="${pet.adoptionStatus eq 'Available'}">Chưa nhận nuôi</c:when>
                                                <c:when test="${pet.adoptionStatus eq 'Pending'}">Đang chờ duyệt</c:when>
                                                <c:when test="${pet.adoptionStatus eq 'Adopted'}">Đã nhận nuôi</c:when>
                                                <c:otherwise>${pet.adoptionStatus}</c:otherwise>
                                            </c:choose>
                                        </span>

                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/StaffPetServlet?action=edit&petID=${pet.petID}" 
                                               class="btn btn-warning btn-sm me-1">
                                                <i class="fas fa-edit"></i> 
                                            </a>



                                            <button type="button" class="btn btn-danger btn-sm" 
                                                    onclick="confirmDelete(${pet.petID})">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <script>
                        document.getElementById("searchInput").addEventListener("keyup", function () {
                            let input = this.value.toLowerCase();
                            let rows = document.querySelectorAll("#petTableBody tr");

                            rows.forEach(row => {
                                let petName = row.cells[2].textContent.toLowerCase(); // Cột chứa tên Pet
                                if (petName.includes(input)) {
                                    row.style.display = "";
                                } else {
                                    row.style.display = "none";
                                }
                            });
                        });
                    </script>
                </div>
            </div>
        </div>


        <footer>
            <p class="m-0">&copy; 2025 PawHouse. All rights reserved.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                        function confirmDelete(petId) {
                            if (confirm('Are you sure you want to delete this pet?')) {
                                window.location.href = '${pageContext.request.contextPath}/StaffPetServlet?action=delete&petID=' + petId;
                            }
                        }

                        // Auto-hide alerts after 5 seconds
                        document.addEventListener('DOMContentLoaded', function () {
                            setTimeout(function () {
                                const alerts = document.querySelectorAll('.alert');
                                alerts.forEach(function (alert) {
                                    const bsAlert = new bootstrap.Alert(alert);
                                    bsAlert.close();
                                });
                            }, 5000);
                        });
        </script>
        <script>
            document.getElementById("categoryFilter").addEventListener("change", function () {
                let selectedCategory = this.value.toLowerCase();
                let rows = document.querySelectorAll("#petTableBody tr");

                rows.forEach(row => {
                    let category = row.cells[3].textContent.toLowerCase(); // Cột chứa danh mục

                    if (selectedCategory === "" || category.includes(selectedCategory)) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            });
        </script>
        <script>
            document.getElementById("categoryFilter").addEventListener("change", filterPets);
            document.getElementById("statusFilter").addEventListener("change", filterPets);
            document.getElementById("searchInput").addEventListener("keyup", filterPets);

            function filterPets() {
                let selectedCategory = document.getElementById("categoryFilter").value.toLowerCase();
                let selectedStatus = document.getElementById("statusFilter").value.toLowerCase();
                let searchQuery = document.getElementById("searchInput").value.toLowerCase();

                let rows = document.querySelectorAll("#petTableBody tr");

                rows.forEach(row => {
                    let category = row.cells[3].textContent.toLowerCase(); // Cột danh mục
                    let status = row.cells[8].textContent.toLowerCase();  // Cột trạng thái
                    let petName = row.cells[2].textContent.toLowerCase(); // Cột tên pet

                    let categoryMatch = selectedCategory === "" || category.includes(selectedCategory);
                    let statusMatch = selectedStatus === "" || status.includes(selectedStatus);
                    let searchMatch = searchQuery === "" || petName.includes(searchQuery);

                    if (categoryMatch && statusMatch && searchMatch) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            }

        </script>
        <script>
            function confirmDelete(petId) {
                if (confirm('Bạn có chắc chắn muốn xóa thú cưng này không?')) {
                    window.location.href = '${pageContext.request.contextPath}/StaffPetServlet?action=delete&petID=' + petId;
                }
            }
        </script>
        <script>
            document.querySelectorAll(".editPetBtn").forEach(button => {
                button.addEventListener("click", function () {
                    let petID = this.getAttribute("data-petid");
                    let petName = this.getAttribute("data-petname");
                    let categoryID = this.getAttribute("data-categoryid");
                    let species = this.getAttribute("data-species");
                    let breed = this.getAttribute("data-breed");
                    let age = this.getAttribute("data-age");
                    let gender = this.getAttribute("data-gender");
                    let adoptionStatus = this.getAttribute("data-adoptionstatus");

                    document.getElementById("editPetID").value = petID;
                    document.getElementById("editPetName").value = petName;
                    document.getElementById("editCategory").value = categoryID;
                    document.getElementById("editSpecies").value = species;
                    document.getElementById("editBreed").value = breed;
                    document.getElementById("editAge").value = age;
                    document.getElementById("editGender").value = gender;
                    document.getElementById("editAdoptionStatus").value = adoptionStatus;

                    let editModal = new bootstrap.Modal(document.getElementById('editPetModal'));
                    editModal.show();
                });
            });
        </script>

    </body>
</html>
