<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thành công!</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .success-icon {
                margin-top: 50px;
                font-size: 8rem;
                color: #28a745;
            }
        </style>
    </head>
    <body>
        <div class="container text-center">
            <div class="success-icon mb-3">
                ✅
            </div>
            <h2 class="text-success">Thành công!</h2>
            <c:if test="${type eq 'appointment'}">
                <p class="lead">Bạn đã đặt lịch hẹn thành công!</p>
                <p class="lead">Hẹn gặp lại bạn tại PawHouse!</p>
            </c:if>
            <c:if test="${type eq 'checkout'}">
                <p class="lead">Bạn đã đặt hàng thành công!</p>
                <p class="lead">Hiện tại PawHouse chỉ hỗ trợ thanh toán và nhận hàng tại cửa hàng!</p>
                <p class="lead">Bạn vui lòng đến PawHouse để hoàn tất đơn hàng bạn nhé!</p>
                <h4>PawHouse xin cảm ơn!</h4>
            </c:if>
            <a href="index.jsp" class="btn btn-outline-success mt-4">Quay về trang chủ</a>
            <!--<a href="viewAppointment.jsp" class="btn btn-outline-success mt-4 ms-2">Xem lịch hẹn</a>-->
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
