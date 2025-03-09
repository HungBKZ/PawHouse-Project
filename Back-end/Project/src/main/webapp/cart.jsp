<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Giỏ Hàng - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        /* Làm to checkbox */
        .product-checkbox {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .select-all-checkbox {
            width: 22px;
            height: 22px;
            cursor: pointer;
        }

        /* Nút xóa đẹp hơn */
        .btn-delete {
            background-color: #ff4d4d;
            border: none;
            color: white;
            padding: 6px 12px;
            font-size: 16px;
            border-radius: 5px;
            transition: 0.3s;
        }

        .btn-delete:hover {
            background-color: #e60000;
        }

        /* Hiệu ứng hover */
        tbody tr:hover {
            background-color: #f8f9fa;
        }

        /* Căn giữa nội dung trong bảng */
        table th, table td {
            vertical-align: middle;
            text-align: center;
        }

        /* Tổng tiền đẹp hơn */
        .total-amount {
            font-size: 22px;
            font-weight: bold;
            color: #28a745;
        }
    </style>

    <script>
        function selectAll(source) {
            let checkboxes = document.querySelectorAll('.product-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = source.checked;
            });
            updateTotal();
        }

        function updateTotal() {
            let total = 0;
            document.querySelectorAll('.product-checkbox:checked').forEach(checkbox => {
                let price = parseFloat(checkbox.getAttribute("data-price"));
                let quantity = parseInt(checkbox.getAttribute("data-quantity"));
                total += price * quantity;
            });
            document.getElementById("totalAmount").innerText = total.toLocaleString() + " VNĐ";
        }

        function submitSelected() {
            let selectedProducts = [];
            document.querySelectorAll('.product-checkbox:checked').forEach(checkbox => {
                selectedProducts.push(checkbox.value);
            });

            if (selectedProducts.length === 0) {
                alert("Vui lòng chọn ít nhất một sản phẩm để thanh toán!");
                return;
            }

            let form = document.getElementById("checkout-form");
            form.elements["selectedProducts"].value = selectedProducts.join(",");
            form.submit();
        }
    </script>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>

    <section class="container my-5">
        <h2 class="text-center mb-4">🛒 Giỏ Hàng Của Bạn</h2>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th><input type="checkbox" class="select-all-checkbox" onclick="selectAll(this)"></th>
                        <th>Hình Ảnh</th>
                        <th>Sản Phẩm</th>
                        <th>Giá</th>
                        <th>Số Lượng</th>
                        <th>Tổng</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty cartList}">
                            <c:forEach var="cart" items="${cartList}">
                                <c:set var="subtotal" value="${cart.quantity * cart.product.price}" />
                                <tr>
                                    <td>
                                        <input type="checkbox" class="product-checkbox" value="${cart.product.productID}" 
                                               data-price="${cart.product.price}" data-quantity="${cart.quantity}" 
                                               onclick="updateTotal()">
                                    </td>
                                    <td><img src="${cart.product.productImage}" width="80" class="img-thumbnail"></td>
                                    <td>${cart.product.productName}</td>
                                    <td>${cart.product.price} VNĐ</td>
                                    <td>${cart.quantity}</td>
                                    <td>${subtotal} VNĐ</td>
                                    <td>
                                        <a href="DeleteFromCart?id=${cart.product.productID}" class="btn btn-delete">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7">Giỏ hàng của bạn đang trống.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <div class="text-end">
            <h4>Tổng Cộng: <span class="total-amount" id="totalAmount">0 VNĐ</span></h4>
            <form id="checkout-form" action="checkout.jsp" method="POST">
                <input type="hidden" name="selectedProducts">
                <button type="button" class="btn btn-primary mt-3" onclick="submitSelected()">
                    <i class="fas fa-credit-card"></i> Tiến Hành Thanh Toán
                </button>
            </form>
        </div>
    </section>

    <%@ include file="includes/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
