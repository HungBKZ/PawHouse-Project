<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Thú Cưng - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Thêm Thú Cưng Mới</h2>

            <!-- Form thêm thú cưng -->
            <form action="StaffPetServlet?action=add" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">Tên thú cưng</label>
                    <input type="text" class="form-control" name="petName" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Loại</label>
                    <select class="form-select" name="categoryID" required>
                        <option value="">Chọn loại thú cưng</option>
                        <option value="1">Chó</option>
                        <option value="2">Mèo</option>
                        <option value="3">Bò sát</option>
                        <option value="4">Gặm nhấm</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Loài</label>
                    <input type="text" class="form-control" name="species" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Giống</label>
                    <input type="text" class="form-control" name="breed" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Tuổi</label>
                    <input type="number" class="form-control" name="age" required min="0">
                </div>

                <div class="mb-3">
                    <label class="form-label">Giới tính</label>
                    <select class="form-select" name="gender" required>
                        <option value="Đực">Đực</option>
                        <option value="Cái">Cái</option>
                    </select>
                </div>

                <!-- Input file để tải ảnh -->
                <div class="mb-3">
                    <label class="form-label">Ảnh</label>
                    <input type="file" class="form-control" name="petImage" accept="image/*" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Trạng thái nhận nuôi</label>
                    <select class="form-select" name="adoptionStatus">
                        <option value="Chưa nhận nuôi">Chưa nhận nuôi</option>
                        <option value="Đã nhận nuôi">Đã nhận nuôi</option>
                        <option value="Đang xử lý">Đang xử lý</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Chủ sở hữu (Nhập Email)</label>
                    <input type="email" class="form-control" name="ownerEmail" placeholder="Nhập email chủ sở hữu (nếu có)">
                </div>

                <div class="mb-3">
                    <label class="form-label">Dịch vụ sử dụng</label>
                    <select class="form-select" name="inUseService">
                        <option value="NULL">Chưa dùng dịch vụ</option>
                        <c:forEach var="service" items="${services}">
                            <option value="${service.serviceID}">${service.serviceName}</option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Thêm Thú Cưng</button>
            </form>


        </div>
        <script>
            document.getElementById("emailInput").addEventListener("blur", function () {
                let email = this.value.trim();

                // Nếu không nhập email, đặt userID về null
                if (email === "") {
                    document.getElementById("userID").value = "";
                    return;
                }

                fetch('${pageContext.request.contextPath}/StaffPetServlet?action=getUserID&email=' + encodeURIComponent(email))
                        .then(response => response.json())
                        .then(data => {
                            if (data.userID) {
                                document.getElementById("userID").value = data.userID;
                            } else {
                                alert("Chưa có tài khoản này! Hãy kiểm tra lại email.");
                                document.getElementById("userID").value = "";
                            }
                        })
                        .catch(error => console.error("Lỗi khi lấy UserID:", error));
            });
        </script>

    </body>
</html>
