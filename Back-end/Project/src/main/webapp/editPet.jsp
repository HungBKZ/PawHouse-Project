<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Pet" %>

<%
    Pet pet = (Pet) request.getAttribute("pet");
    if (pet == null) {
        response.sendRedirect("myPet.jsp?error=notfound");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa thú cưng</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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
            display: block;
        }
        .alert {
            display: none;
        }
    </style>

    <script>
        function previewImage(event) {
            const output = document.getElementById('petImagePreview');
            output.src = URL.createObjectURL(event.target.files[0]);
            output.style.display = 'block';
        }

        function updateCategory() {
            let speciesSelect = document.getElementById("species");
            let categoryInput = document.getElementById("categoryID");

            let selectedSpecies = speciesSelect.value.toLowerCase();
            if (selectedSpecies === "chó") {
                categoryInput.value = "1";
            } else if (selectedSpecies === "mèo") {
                categoryInput.value = "2";
            } else if (selectedSpecies === "bò sát") {
                categoryInput.value = "3";
            } else if (selectedSpecies === "gặm nhấm") {
                categoryInput.value = "4";
            } else {
                categoryInput.value = "5";
            }
        }

        window.onload = function() {
            updateCategory();
        };
    </script>
</head>
<body>

    <%@ include file="includes/navbar.jsp" %>

    <div class="container mt-5">
        <div class="form-box">
            <h2 class="text-center"><i class="fas fa-paw"></i> Chỉnh sửa thông tin thú cưng</h2>

            <!-- Hiển thị thông báo -->
            <% String success = request.getParameter("success");
                if ("updated".equals(success)) { %>
                <div class="alert alert-success text-center">Cập nhật thú cưng thành công!</div>
            <% } else if ("error".equals(success)) { %>
                <div class="alert alert-danger text-center">Cập nhật thất bại. Vui lòng thử lại!</div>
            <% } %>

            <form action="EditPetServlet" method="post" enctype="multipart/form-data">
                <!-- ID Thú Cưng (Ẩn) -->
                <input type="hidden" name="petId" value="<%= pet.getPetID()%>">

                <div class="mb-3">
                    <label class="form-label">Tên thú cưng</label>
                    <input type="text" name="petName" class="form-control" required value="<%= pet.getPetName()%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Tuổi</label>
                    <input type="number" name="age" class="form-control" required min="0" value="<%= pet.getAge()%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Loài</label>
                    <input type="text" name="species" id="species" class="form-control" required value="<%= pet.getSpecies()%>" oninput="updateCategory()">
                </div>

                <!-- Ẩn categoryID nhưng vẫn gửi giá trị -->
                <input type="hidden" id="categoryID" name="categoryID" value="1">

                <div class="mb-3">
                    <label class="form-label">Giống</label>
                    <input type="text" name="breed" class="form-control" required value="<%= pet.getBreed()%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Giới tính</label>
                    <select name="gender" class="form-select" required>
                        <option value="Đực" <%= pet.getGender().equals("Đực") ? "selected" : ""%>>Đực</option>
                        <option value="Cái" <%= pet.getGender().equals("Cái") ? "selected" : ""%>>Cái</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Ảnh hiện tại</label>
                    <img id="petImagePreview" src="<%= pet.getPetImage()%>" class="img-preview mt-2">
                </div>

                <!-- Giữ ảnh cũ nếu không có ảnh mới -->
                <input type="hidden" name="existingImage" value="<%= pet.getPetImage()%>">

                <div class="mb-3">
                    <label class="form-label">Chọn ảnh mới (nếu có)</label>
                    <input type="file" name="petImage" class="form-control" accept="image/*" onchange="previewImage(event)">
                </div>

                <div class="mb-3">
                    <label class="form-label">Trạng thái nhận nuôi</label>
                    <select name="adoptionStatus" class="form-select">
                        <option value="Chưa nhận nuôi" <%= pet.getAdoptionStatus().equals("Chưa nhận nuôi") ? "selected" : ""%>>Chưa nhận nuôi</option>
                        <option value="Đã nhận nuôi" <%= pet.getAdoptionStatus().equals("Đã nhận nuôi") ? "selected" : ""%>>Đã nhận nuôi</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Cập nhật</button>
            </form>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>
