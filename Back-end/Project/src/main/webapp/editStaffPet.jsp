<%-- 
    Document   : editStaffPet
    Created on : Mar 12, 2025, 5:58:37 PM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Pet - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 30px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            footer {
                background-color: #0056b3;
                color: white;
                text-align: center;
                padding: 15px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2 class="text-center mb-4">Chỉnh Sửa Thú Cưng</h2>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/StaffPetServlet" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="petID" value="${pet.petID}">

                <label for="petName">Tên thú cưng:</label>
                <input type="text" class="form-control" id="petName" name="petName" value="${pet.petName}" required>

                <label for="categoryID">Danh mục:</label>
                <select class="form-select" id="categoryID" name="categoryID">
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.categoryID}" ${category.categoryID == pet.category.categoryID ? 'selected' : ''}>${category.categoryName}</option>
                    </c:forEach>
                </select>

                <label for="species">Loài:</label>
                <input type="text" class="form-control" id="species" name="species" value="${pet.species}" required>

                <label for="breed">Giống:</label>
                <input type="text" class="form-control" id="breed" name="breed" value="${pet.breed}" required>

                <label for="age">Tuổi:</label>
                <input type="number" class="form-control" id="age" name="age" value="${pet.age}" required>

                <label for="gender">Giới tính:</label>
                <select class="form-select" id="gender" name="gender">
                    <option value="Đực" ${pet.gender == 'Đực' ? 'selected' : ''}>Đực</option>
                    <option value="Cái" ${pet.gender == 'Cái' ? 'selected' : ''}>Cái</option>
                </select>

                <label for="adoptionStatus">Trạng thái:</label>
                <select class="form-select" id="adoptionStatus" name="adoptionStatus">
                    <option value="Chưa nhận nuôi" ${pet.adoptionStatus == 'Chưa nhận nuôi' ? 'selected' : ''}>Chưa nhận nuôi</option>
                    <option value="Đang chờ duyệt" ${pet.adoptionStatus == 'Đang chờ duyệt' ? 'selected' : ''}>Đang chờ duyệt</option>
                    <option value="Đã nhận nuôi" ${pet.adoptionStatus == 'Đã nhận nuôi' ? 'selected' : ''}>Đã nhận nuôi</option>
                </select>

                <label for="petImage">Hình ảnh:</label>
                <input type="text" class="form-control" id="petImage" name="petImage" value="${pet.petImage}">

                <button type="submit" class="btn btn-primary mt-3">Lưu thay đổi</button>
            </form>

        </div>

        <footer>
            <p class="m-0">&copy; 2025 PawHouse. All rights reserved.</p>
        </footer>

    </body>
</html>
