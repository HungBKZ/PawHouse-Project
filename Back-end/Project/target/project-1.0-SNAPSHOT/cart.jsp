<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.CartItem" %>
<%@ page import="Model.User" %>
<%@ page import="DAO.UserDAO" %>
<%@ page import="Utils.PasswordHasher" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Check for authenticated user
    User user = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("authToken")) {
                String decodedValue = PasswordHasher.decodeBase64(cookie.getValue());
                String[] parts = decodedValue.split(":");
                if (parts.length == 2) {
                    String email = parts[0];
                    UserDAO userDAO = new UserDAO();
                    user = userDAO.getUserByEmail(email);
                }
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Giỏ Hàng - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            .cart-img {
                max-width: 100px;
                height: auto;
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <%@ include file="includes/navbar.jsp" %>

        <!-- Giỏ Hàng -->
        <section class="container my-5">
            <h2 class="text-center mb-4">Giỏ Hàng Của Bạn</h2>
            <div class="table-responsive">
                <table class="table text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>Hình Ảnh</th>
                            <th>Sản Phẩm</th>
                            <th>Giá</th>
                            <th>Số Lượng</th>
                            <th>Tổng</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                            if (cart != null && !cart.isEmpty()) {
                                for (CartItem item : cart) {%>
                        <tr>
                            <td><img src="<%= item.getProduct().getProductImage()%>" class="cart-img" alt="<%= item.getProduct().getProductName()%>"></td>
                            <td><%= item.getProduct().getProductName()%></td>
                            <td class="price"><%= item.getProduct().getPrice()%> VNĐ</td>
                            <td>
                                <div class="input-group" style="max-width: 150px; margin: 0 auto;">
                                    <button class="btn btn-outline-secondary btn-sm" type="button" onclick="updateQuantity(<%= item.getProduct().getProductID()%>, -1)">-</button>
                                    <input type="text" class="form-control text-center" value="<%= item.getQuantity()%>" readonly>
                                    <button class="btn btn-outline-secondary btn-sm" type="button" onclick="updateQuantity(<%= item.getProduct().getProductID()%>, 1)">+</button>
                                </div>
                            </td>
                            <td class="total-price"><%= item.getTotal()%> VNĐ</td>
                            <td>
                                <form action="cart" method="POST" style="display: inline;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="productId" value="<%= item.getProduct().getProductID()%>">
                                    <button type="submit" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i></button>
                                </form>
                            </td>
                        </tr>
                        <%    }
                        } else { %>
                        <tr>
                            <td colspan="6">
                                <div class="text-center py-4">
                                    <i class="bi bi-cart-x" style="font-size: 3rem;"></i>
                                    <p class="mt-3">Giỏ hàng của bạn đang trống.</p>
                                    <a href="Product" class="btn btn-primary">Tiếp Tục Mua Sắm</a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% if (cart != null && !cart.isEmpty()) { %>
            <div class="text-end">
                <h4>Tổng Cộng: <span class="text-success">
                        <% double total = 0;
                            for (CartItem item : cart) {
                                total += item.getTotal();
                            }
                        %>
                        <%= total%> VNĐ</span></h4>
                <div class="mt-3">
                    <a href="Product" class="btn btn-outline-primary">Tiếp Tục Mua Sắm</a>
                    <a href="checkout.jsp" class="btn btn-primary ms-2">Tiến Hành Thanh Toán</a>
                </div>
            </div>
            <% } %>
        </section>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function updateQuantity(productId, change) {
                fetch('cart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=update&productId=' + productId + '&change=' + change
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    }
                });
            }
        </script>
    </body>
</html>