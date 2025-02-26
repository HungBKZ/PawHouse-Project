<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.Cart" %>
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
    </head>
    <body>
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
                        <% List<Cart> cart = (List<Cart>) session.getAttribute("cart");
                            if (cart != null && !cart.isEmpty()) {
                                for (Cart item : cart) {%>
                        <tr>
                            <td><img src="<%= item.getProduct().getProductImage()%>" class="cart-img" alt="<%= item.getProduct().getProductName()%>"></td>
                            <td><%= item.getProduct().getProductName()%></td>
                            <td class="price"><%= item.getProduct().getPrice()%> VNĐ</td>
                            <td><%= item.getQuantity()%></td>
                            <td class="total-price"><%= item.getQuantity() * item.getProduct().getPrice()%> VNĐ</td>
                            <td><a href="removeFromCart.jsp?id=<%= item.getProduct().getProductID()%>" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i></a></td>
                        </tr>
                        <%    }
                        } else { %>
                        <tr>
                            <td colspan="6">Giỏ hàng của bạn đang trống.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <div class="text-end">
                <h4>Tổng Cộng: <span class="text-success">
                        <% double total = 0;
                            if (cart != null) {
                                for (Cart item : cart) {
                                    total += item.getQuantity() * item.getProduct().getPrice();
                                }
                            }
                        %>
                        <%= total%> VNĐ</span></h4>
                <a href="checkout.jsp" class="btn btn-primary mt-3">Tiến Hành Thanh Toán</a>
            </div>
        </section>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>