<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đơn Hàng - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f5f7fa;
            }

            .order-container {
                max-width: 1000px;
                margin: 40px auto;
                padding: 25px;
                background: #ffffff;
                border-radius: 10px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            }

            .order-card {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 25px;
            }

            .order-status.completed {
                color: green;
                font-weight: bold;
            }

            .order-status.processing {
                color: orange;
                font-weight: bold;
            }

            .order-status.cancelled {
                color: red;
                font-weight: bold;
            }

            .product-img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .product-name {
                font-weight: 500;
            }

            .product-detail {
                margin-left: 15px;
            }

            .product-item {
                margin-bottom: 12px;
                display: flex;
                align-items: center;
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

        <div class="container order-container">
            <h2 class="text-center mb-4">Lịch Sử Đơn Hàng</h2>

            <c:choose>
                <c:when test="${not empty orderList}">
                    <c:forEach var="order" items="${orderList}">
                        <div class="order-card">
                            <div class="d-flex justify-content-between mb-2">
                                <div>
                                    <strong>Mã Đơn:</strong> #${order.orderID} <br/>
                                    <strong>Ngày đặt:</strong>
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                </div>
                                <div class="text-end">
                                    <span class="order-status
                                          <c:choose>
                                              <c:when test="${order.orderStatus == null}">cancelled</c:when>
                                              <c:when test="${order.orderStatus == 'true'}">completed</c:when>
                                              <c:when test="${order.orderStatus == 'false'}">processing</c:when>
                                          </c:choose>">
                                        <c:choose>
                                            <c:when test="${order.orderStatus == null}">Đã Từ Chối</c:when>
                                            <c:when test="${order.orderStatus == 'true'}">Hoàn Thành</c:when>
                                            <c:when test="${order.orderStatus == 'false'}">Đang Xử Lý</c:when>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>

                            <c:if test="${not empty order.notes}">
                                <p><strong>Ghi chú:</strong> <em>${order.notes}</em></p>
                            </c:if>

                            <hr/>
                            <h6 class="mb-3">Sản phẩm:</h6>
                            <c:if test="${empty order.orderDetails}">
                                <p class="text-danger">🚨 Không có chi tiết đơn hàng!</p>
                            </c:if>

                            <c:forEach var="detail" items="${order.orderDetails}">
                                <div class="product-item">
                                    <img class="product-img" src="${detail.product.productImage}" alt="${detail.product.productName}" />
                                    <div class="product-detail">
                                        <div class="product-name">${detail.product.productName}</div>
                                        <div>Số lượng: ${detail.quantity}</div>
                                        <div>Đơn giá: 
                                            <fmt:formatNumber value="${detail.price}" type="currency" currencyCode="VND"/>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <hr/>
                            <div class="d-flex justify-content-end">
                                <div class="total-price">Tổng tiền: 
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND"/>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="text-center">Bạn chưa có đơn hàng nào.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
