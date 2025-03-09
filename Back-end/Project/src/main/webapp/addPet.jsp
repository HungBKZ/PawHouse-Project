<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Thêm thú cưng</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

        <style>
            body {
                background: linear-gradient(to right, #f8f9fa, #e9ecef);
            }
            .form-box {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }
            .form-box h2 {
                color: #007bff;
            }
            .btn-primary {
                width: 100%;
                font-size: 18px;
                font-weight: bold;
            }
            .img-preview {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 10px;
                display: none;
            }
        </style>

        <script>
            function previewImage(event) {
                const output = document.getElementById('petImagePreview');
                output.src = URL.createObjectURL(event.target.files[0]);
                output.style.display = 'block';
            }
        </script>
        <script>
            function updateCategory() {
                let speciesSelect = document.getElementById("species");
                let categoryInput = document.getElementById("categoryID");

                // Tự động chọn categoryID dựa vào species
                let selectedSpecies = speciesSelect.value;
                if (selectedSpecies === "Chó") {
                    categoryInput.value = "1"; // Chó
                } else if (selectedSpecies === "Mèo") {
                    categoryInput.value = "2"; // Mèo
                } else if (selectedSpecies === "Bò sát") {
                    categoryInput.value = "3"; // Bò sát
                } else if (selectedSpecies === "Gặm nhấm") {
                    categoryInput.value = "4"; // Gặm nhấm
                }
            }
        </script>
    </head>

    <body>

        <!-- Navbar -->
        <%@ include file="includes/navbar.jsp" %>

        <div class="container mt-5">
            <div class="form-box">
                <h2 class="text-center"><i class="fas fa-paw"></i> Thêm thú cưng mới</h2>

                <!-- Form Thêm Thú Cưng -->
                <form action="AddPetServlet" method="post" enctype="multipart/form-data">
                    <!-- Tên thú cưng -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-tag"></i> Tên thú cưng</label>
                        <input type="text" name="petName" class="form-control" required>
                    </div>

                    <!-- Tuổi thú cưng -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-calendar-alt"></i> Tuổi</label>
                        <input type="number" name="age" class="form-control" required min="0">
                    </div>

                    <!-- Chọn Loài -->
                    <div class="mb-3">
                        <label class="form-label">Loài</label>
                        <select id="species" name="species" class="form-select" required onchange="updateCategory()">
                            <option value="Chó">Chó</option>
                            <option value="Mèo">Mèo</option>
                            <option value="Bò sát">Bò sát</option>
                            <option value="Gặm nhấm">Gặm nhấm</option>
                        </select>
                    </div>

                    <!-- Ẩn categoryID nhưng vẫn gửi giá trị lên server -->
                    <input type="hidden" id="categoryID" name="categoryID" value="1">


                    <!-- Giống thú cưng -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-dna"></i> Giống</label>
                        <input type="text" name="breed" class="form-control" required>
                    </div>

                    <!-- Giới tính -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-venus-mars"></i> Giới tính</label>
                        <select name="gender" class="form-select" required>
                            <option value="Đực">Đực</option>
                            <option value="Cái">Cái</option>
                        </select>
                    </div>

                    <!-- Ảnh thú cưng -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-image"></i> Ảnh thú cưng</label>
                        <input type="file" name="petImage" class="form-control" accept="image/*" onchange="previewImage(event)">
                        <img id="petImagePreview" class="img-preview mt-3">
                    </div>

                    <!-- Trạng thái nhận nuôi -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-heart"></i> Trạng thái nhận nuôi</label>
                        <select name="adoptionStatus" class="form-select">
                            <option value="Chưa nhận nuôi">Chưa nhận nuôi</option>
                            <option value="Đã nhận nuôi">Đã nhận nuôi</option>
                        </select>
                    </div>

                    <!-- Nút Gửi -->
                    <button type="submit" class="btn btn-primary"><i class="fas fa-plus-circle"></i> Thêm thú cưng</button>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
