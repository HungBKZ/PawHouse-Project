<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="auth.jsp" %>
<%
    User user = getAuthenticatedUser(request);
    String googleUsername = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {

        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                googleUsername = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
                break;
            }
        }

    }

%>



<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">PawHouse</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Trang Chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="products.jsp">Sản Phẩm</a></li>
                <li class="nav-item"><a class="nav-link" href="services.jsp">Danh Sách</a></li>
                <li class="nav-item"><a class="nav-link" href="adoption.jsp">Nhận Nuôi</a></li>
                <li class="nav-item"><a class="nav-link" href="cart.jsp"><i class="bi bi-cart"></i> Giao Hàng</a></li>
                    <% if (user == null && googleUsername == null) { %>
                <li class="nav-item"><a class="nav-link btn btn-primary text-white" href="login.jsp">Đăng Nhập</a></li>
                    <% } else {%>
                <li class="nav-item">
                    <span class="nav-link">Chào Mừng, <%= googleUsername != null ? googleUsername : user.getFullName()%></span>
                </li>
                <li class="nav-item"><a class="nav-link btn btn-danger text-white" href="logout">Đăng Xuất</a></li>
                    <% }%>
            </ul>
        </div>
    </div>
</nav>
