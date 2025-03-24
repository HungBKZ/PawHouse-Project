<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Thông Tin Đơn Hàng - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f9f9f9;
            }

            .checkout-container {
                max-width: 900px;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .checkout-container h2 {
                font-weight: bold;
                color: #333;
            }

            .btn-success {
                font-size: 1.1rem;
                transition: 0.3s;
            }

            .btn-success:hover {
                transform: scale(1.05);
            }

            h2 {
                color: #555;
                font-size: 1.2rem;
                margin-bottom: 10px;
            }

            p {
                font-size: 0.8rem;
                color: #333;
                margin: 5px 0;
            }

            /* Style for the table */
            .table-container {
                max-width: 900px;
                margin: 0 auto;
                background-color: white;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                border-radius: 8px 8px 0px 0px;
                overflow: hidden;
            }

            /* Table header styling */
            th {
                background-color: #FFEB3B;
                padding: 12px 15px;
                text-align: center;
                font-weight: bold;
            }

            /* Table row styling */
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:nth-child(odd) {
                background-color: white;
            }

            /* Chỉ tạo border cho các dòng */
            tr {
                border-bottom: 1px solid #ddd; /* Đường viền cho các hàng */
            }

            td {
                padding: 12px 15px;
                text-align: left;
                font-size: 1rem;
                color: #333;
            }

            /* Adding style for the image column */
            td img {
                width: 50px;
                height: 50px;
                object-fit: cover; /* Ensures images are properly cropped */
                border-radius: 4px; /* Optional: rounds the corners of the images */
            }

            /* Hover effect for rows */
            tr:hover {
                background-color: #e0f7fa;
            }

            /* Dòng tổng */
            .summary-row {
                font-weight: bold;
                font-size: 1.2rem;
                padding: 12px 15px;
                border-top: 2px solid #333; /* Viền trên cho dòng tổng */
            }

            tr:last-child {
                border-bottom: 0px;
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

        <!-- Checkout Form -->
        <section class="mb-5 checkout-container my-5">
            <h1 class="text-center mb-5">Thông Tin Đơn Hàng</h1>

            <!-- Thông tin người mua -->
            <div class="mb-5">
                <hr/>
                <h2 class="mb-1">Thông Tin Người Mua Hàng</h2>
                <p><strong>Họ tên:</strong> ${user.fullName}</p>
                <p><strong>Địa chỉ:</strong> ${user.address}</p>
                <p><strong>Số điện thoại:</strong> ${user.phone}</p>
                <p><strong>Email:</strong> ${user.email}</p>
            </div>


            <!-- Thông tin cửa hàng -->
            <div class="mb-5">
                <hr/>
                <h2 class="mb-1">Thông Tin Cửa Hàng</h2>
                <p><strong>Cửa hàng:</strong> PawHouse</p>
                <p><strong>Địa chỉ:</strong> 31/18 Huynh Phan Ho, TP.Can Tho</p>
                <p><strong>Số điện thoại:</strong> 077-296-7049</p>
                <p><strong>Email:</strong>group3vodich@pawhouse.com</p>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="table-container mb-3">
                <hr/>
                <h2>Danh Sách Sản Phẩm</h2>
                <table>
                    <thead>
                        <tr>
                            <th></th> <!-- Cột ảnh -->
                            <th>Tên Sản Phẩm</th>
                            <th>Giá</th>
                            <th>Số Lượng</th>
                            <th class="text-end">Thành Tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="orderDetail" items="${lstOrderDetails}">
                            <tr>
                                <td><img src="${orderDetail.product.productImage}" alt="${orderDetail.product.productName}"></td>
                                <td>${orderDetail.product.productName}</td>
                                <td class="text-center">${orderDetail.price}</td>
                                <td class="text-center">${orderDetail.quantity}</td>
                                <td class="text-end">${orderDetail.price * orderDetail.quantity}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="summary-row">
                <div style="display: flex">
                    <div class="w-50"><h5><strong class="text-left">Tổng Số Sản Phẩm</strong></h5></div>
                    <div class="w-50 text-end"><h5><strong class="text-success">${totalItem}</strong></h5></div>
                </div>
                <div style="display: flex">
                    <div class="w-50"><h5><strong class="text-left">Tổng Tiền</strong></h5></div>
                    <div class="w-50 text-end"><h5><strong class="text-success">${totalAmount}đ</strong></h5></div>
                </div>
            </div>

            <div class="text-center mt-4">
                <a class="btn btn-success w-100" href="Checkout?type=checkout">Thanh toán</a>
            </div>
        </form>
    </section>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
