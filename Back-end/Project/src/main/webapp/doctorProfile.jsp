<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hồ Sơ Cá Nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <h2 class="text-center">Hồ Sơ Cá Nhân</h2>
    <form>
        <div class="mb-3">
            <label class="form-label">Họ và tên</label>
            <input type="text" class="form-control" value="Bác sĩ Nguyễn Văn B">
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" value="doctor@pawhouse.com">
        </div>
        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" value="0123 456 789">
        </div>
        <button type="submit" class="btn btn-primary">Cập nhật</button>
    </form>
    <a href="doctorIndex.jsp" class="btn btn-secondary mt-3">Quay lại</a>
</div>
</body>
</html>
