<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Lịch Hẹn - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f5f7fa;
            }

            .appointment-container {
                max-width: 1000px;
                margin: 40px auto;
                padding: 25px;
                background: #ffffff;
                border-radius: 10px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            }

            .appointment-card {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 25px;
            }

            .appointment-status.confirmed {
                color: green;
                font-weight: bold;
            }

            .appointment-status.pending {
                color: orange;
                font-weight: bold;
            }

            .appointment-status.cancelled {
                color: red;
                font-weight: bold;
            }

            .pet-img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .pet-info {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 10px;
            }

            .total-price {
                font-size: 1.1rem;
                font-weight: bold;
                color: #28a745;
            }
        </style>
    </head>
    <body>

        <%@ include file="includes/navbar.jsp" %>

        <div class="container appointment-container">
            <h2 class="text-center mb-4">Lịch Sử Đặt Lịch Hẹn</h2>

            <c:choose>
                <c:when test="${not empty appointmentList}">
                    <c:forEach var="a" items="${appointmentList}">
                        <div class="appointment-card">
                            <div class="d-flex justify-content-between mb-2">
                                <div>
                                    <strong>Mã Lịch Hẹn:</strong> #${a.appointmentID} <br/>
                                    <strong>Ngày hẹn:</strong>
                                    <fmt:formatDate value="${a.appointmentDate}" pattern="dd/MM/yyyy HH:mm" />
                                </div>
                                <div class="text-end">
                                    <span class="appointment-status
                                          <c:choose>
                                              <c:when test="${a.appointmentStatus == null}">cancelled</c:when>
                                              <c:when test="${a.appointmentStatus =='1'}">confirmed</c:when>
                                              <c:when test="${a.appointmentStatus == '0'}">pending</c:when>
                                          </c:choose>">
                                        <c:choose>
                                            <c:when test="${a.appointmentStatus == null}">Đã Từ Chối</c:when>
                                            <c:when test="${a.appointmentStatus == '1'}">Đã Duyệt</c:when>
                                            <c:when test="${a.appointmentStatus == '0'}">Đang Xử Lý</c:when>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>

                            <c:choose>
                                <c:when test="${not empty a.notes}">
                                    <p><strong>Ghi chú:</strong> <em>${a.notes}</em></p>
                                </c:when>
                                <c:otherwise>
                                    <p><strong>Ghi chú:</strong> <em>Không có ghi chú nào.</em></p>
                                </c:otherwise>
                            </c:choose>


                            <hr/>
                            <h6 class="mb-3">Thông tin thú cưng & dịch vụ:</h6>

                            <div class="pet-info">
                                <img class="pet-img" src="${a.pet.petImage}" alt="${a.pet.petName}" />
                                <div>
                                    <div><strong>Tên thú cưng:</strong> ${a.pet.petName}</div>
                                    <div><strong>Dịch vụ:</strong> ${a.service.serviceName}</div>
                                    <div><strong>Giá:</strong>
                                        <fmt:formatNumber value="${a.price}" type="currency" currencySymbol="₫" />
                                    </div>
                                </div>
                            </div>

                            <div>
                                <strong>Người phụ trách:</strong>
                                <c:choose>
                                    <c:when test="${not empty a.doctor}">
                                        Bác sĩ: ${a.doctor.fullName}
                                    </c:when>
                                    <c:when test="${not empty a.staff}">
                                        Nhân viên: ${a.staff.fullName}
                                    </c:when>
                                    <c:otherwise>
                                        Đang chờ phân công
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div>
                                <strong>Ngày đặt:</strong>
                                <fmt:formatDate value="${a.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="text-center">Bạn chưa có lịch hẹn nào.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
