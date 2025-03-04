<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi Tiết Lịch Hẹn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <h2 class="text-center">Chi Tiết Lịch Hẹn</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>#</th>
                <th>Khách hàng</th>
                <th>Thú cưng</th>
                <th>Thời gian</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Nguyễn Văn A</td>
                <td>Lucky (Chó)</td>
                <td>10:00 AM</td>
                <td>Đang chờ</td>
                <td>
                    <button class="btn btn-success">Xác nhận</button>
                    <button class="btn btn-danger">Hủy</button>
                </td>
            </tr>
        </tbody>
    </table>
    <a href="doctorIndex.jsp" class="btn btn-primary">Quay lại</a>
</div>
</body>
</html>
