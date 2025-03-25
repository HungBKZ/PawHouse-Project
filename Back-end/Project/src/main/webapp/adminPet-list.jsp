<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Thú Cưng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .table img {
                max-width: 80px;
                height: auto;
            }
            .modal-body label {
                font-weight: bold;
            }
        </style>
        <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>
        <script>
            function confirmDelete(petId, petName) {
                if (confirm('Bạn chắc chắn muốn xóa thú cưng "' + petName + '"?')) {
                    window.location.href = '${pageContext.request.contextPath}/admin/pets?action=delete&id=' + petId;
                }
            }

            function fillCategory() {
                let species = document.getElementById("species").value;
                let categoryID;
                switch (species) {
                    case "Chó":
                        categoryID = 1;
                        break;
                    case "Mèo":
                        categoryID = 2;
                        break;
                    case "Bò Sát":
                        categoryID = 3;
                        break;
                    case "Gậm Nhấm":
                        categoryID = 4;
                        break;
                    default:
                        categoryID = 1;
                }
                document.getElementById("categoryID").value = categoryID;
            }

            function toggleUserIDField() {
                const adoptionStatus = document.getElementById("adoptionStatus").value;
                const userIDSelect = document.getElementById("userID");

                if (adoptionStatus === "Chưa nhận nuôi" || adoptionStatus === "Đang chờ duyệt") {
                    userIDSelect.disabled = true;
                    userIDSelect.value = ""; // Đặt thành rỗng để gửi null
                } else if (adoptionStatus === "Đã nhận nuôi") {
                    userIDSelect.disabled = false;
                }
            }

            function openModal(petID, species, petName, breed, age, gender, adoptionStatus, userID, inUseService) {
                document.getElementById("petForm").reset();
                if (petID) {
                    document.getElementById("petID").value = petID;
                    document.getElementById("name").value = petName;
                    document.getElementById("species").value = species;
                    document.getElementById("breed").value = breed;
                    document.getElementById("age").value = age;
                    document.getElementById("gender").value = gender;
                    document.getElementById("adoptionStatus").value = adoptionStatus || "Chưa nhận nuôi";
                    document.getElementById("userID").value = userID || ""; // Để rỗng nếu null
                    document.getElementById("inUseService").value = inUseService || "";
                    document.getElementById("action").value = "update";
                    document.getElementById("modalTitle").textContent = "Cập nhật Thú Cưng";
                } else {
                    document.getElementById("petID").value = "";
                    document.getElementById("action").value = "add";
                    document.getElementById("modalTitle").textContent = "Thêm Thú Cưng Mới";
                    document.getElementById("userID").value = ""; // Để rỗng khi thêm mới
                }
                fillCategory();
                toggleUserIDField();
                new bootstrap.Modal(document.getElementById('petModal')).show();
            }

            setTimeout(function () {
                document.querySelectorAll('.alert').forEach(function (alert) {
                    var bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        </script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
            </div>
        </nav>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Quản lý Thú Cưng</h2>

            <!-- Thanh tìm kiếm -->
            <form method="get" action="${pageContext.request.contextPath}/admin/pets" class="mb-4">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label for="petName" class="form-label">Tên thú cưng</label>
                        <input type="text" class="form-control" id="petName" name="petName" value="${param.petName}" placeholder="Nhập tên thú cưng">
                    </div>
                    <div class="col-md-4">
                        <label for="species" class="form-label">Loài</label>
                        <select class="form-select" id="species" name="species">
                            <option value="">Tất cả</option>
                            <option value="Chó" ${param.species == 'Chó' ? 'selected' : ''}>Chó</option>
                            <option value="Mèo" ${param.species == 'Mèo' ? 'selected' : ''}>Mèo</option>
                            <option value="Bò Sát" ${param.species == 'Bò Sát' ? 'selected' : ''}>Bò Sát</option>
                            <option value="Gậm Nhấm" ${param.species == 'Gậm Nhấm' ? 'selected' : ''}>Gậm Nhấm</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                    </div>
                    <div class="col-md-2">
                        <a href="${pageContext.request.contextPath}/admin/pets" class="btn btn-secondary w-100">Xóa bộ lọc</a>
                    </div>
                </div>
            </form>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <p class="text-info mb-0">Tổng số thú cưng: ${fn:length(petList)}</p>
                <button onclick="openModal(null, null, null, null, null, null, null, null, null)" class="btn btn-success">
                    <i class="fas fa-plus"></i> Thêm thú cưng
                </button>
            </div>

            <table class="table table-bordered table-hover">
                <thead class="table-dark text-center">
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Loài</th>
                        <th>Giống</th>
                        <th>Tuổi</th>
                        <th>Giới tính</th>
                        <th>Ảnh</th>
                        <th>Nhận nuôi</th>
                        <th>UserID</th>
                        <th>Dịch vụ</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody class="text-center align-middle">
                    <c:forEach var="pet" items="${petList}">
                        <tr>
                            <td>${pet.petID}</td>
                            <td>${pet.petName}</td>
                            <td>${pet.species}</td>
                            <td>${pet.breed}</td>
                            <td>${pet.age}</td>
                            <td>${pet.gender}</td>
                            <td>
                                <c:if test="${not empty pet.petImage}">
                                    <img src="${pageContext.request.contextPath}/${pet.petImage}" alt="${pet.petName}">
                                </c:if>
                            </td>
                            <td>${pet.adoptionStatus}</td>
                            <td>${pet.userID != null ? pet.userID : 'Không xác định'}</td>
                            <td>${pet.inUseService != null ? pet.inUseService : 'Không xác định'}</td>
                            <td>
                                <button class="btn btn-sm btn-primary mb-1" 
                                        onclick="openModal(
                                            '${pet.petID}',
                                            '${pet.species}',
                                            '${pet.petName}',
                                            '${pet.breed}',
                                            '${pet.age}',
                                            '${pet.gender}',
                                            '${pet.adoptionStatus}',
                                            '${pet.userID}',
                                            '${pet.inUseService}'
                                            )">
                                    <i class="fas fa-edit"></i> Sửa
                                </button>
                                <button onclick="confirmDelete('${pet.petID}', '${pet.petName}')" 
                                        class="btn btn-sm btn-danger mb-1">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="modal fade" id="petModal" tabindex="-1" aria-labelledby="petModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalTitle">Thông tin Thú Cưng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form id="petForm" method="post" action="${pageContext.request.contextPath}/admin/pets" enctype="multipart/form-data">
                            <div class="modal-body">
                                <input type="hidden" id="petID" name="id">
                                <input type="hidden" id="categoryID" name="categoryID">
                                <input type="hidden" id="action" name="action">

                                <div class="mb-3">
                                    <label for="name">Tên thú cưng:</label>
                                    <input class="form-control" id="name" name="name" required>
                                </div>

                                <div class="mb-3">
                                    <label for="species">Loài:</label>
                                    <select class="form-select" id="species" name="species" onchange="fillCategory()" required>
                                        <option value="Chó">Chó</option>
                                        <option value="Mèo">Mèo</option>
                                        <option value="Bò Sát">Bò Sát</option>
                                        <option value="Gậm Nhấm">Gậm Nhấm</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="breed">Giống:</label>
                                    <input class="form-control" id="breed" name="breed" required>
                                </div>

                                <div class="mb-3">
                                    <label for="age">Tuổi:</label>
                                    <input type="number" class="form-control" id="age" name="age" min="0" max="20" required>
                                </div>

                                <div class="mb-3">
                                    <label for="gender">Giới tính:</label>
                                    <select class="form-select" id="gender" name="gender" required>
                                        <option value="Đực">Đực</option>
                                        <option value="Cái">Cái</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="image">Ảnh thú cưng:</label>
                                    <input type="file" class="form-control" id="image" name="image">
                                </div>

                                <div class="mb-3">
                                    <label for="adoptionStatus">Trạng thái nhận nuôi:</label>
                                    <select class="form-select" id="adoptionStatus" name="adoptionStatus" onchange="toggleUserIDField()" required>
                                        <option value="Chưa nhận nuôi">Chưa nhận nuôi</option>
                                        <option value="Đang chờ duyệt">Đang chờ duyệt</option>
                                        <option value="Đã nhận nuôi">Đã nhận nuôi</option>
                                    </select>
                                </div>

                                <div class="mb-3" id="userIDField">
                                    <label for="userID">UserID:</label>
                                    <select class="form-select" id="userID" name="userID" disabled>
                                        <option value="">Không xác định (NULL)</option>
                                        <c:forEach var="userId" items="${userIds}">
                                            <option value="${userId}">${userId}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="inUseService">Trạng thái dịch vụ:</label>
                                    <select class="form-select" id="inUseService" name="inUseService">
                                        <option value="">Không xác định (NULL)</option>
                                        <option value="Chưa tiến hành">Chưa tiến hành</option>
                                        <option value="Đang tiến hành">Đang tiến hành</option>
                                        <option value="Hoàn thành">Hoàn thành</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button type="submit" class="btn btn-success">Lưu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>