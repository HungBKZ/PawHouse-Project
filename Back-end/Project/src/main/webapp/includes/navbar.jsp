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
<nav class="navbar navbar-expand-lg fixed-top navbar-custom">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">🐾 PawHouse</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Trang Chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="/Product">Sản Phẩm</a></li>
                <li class="nav-item"><a class="nav-link" href="/Service">Dịch Vụ</a></li>
                 <li class="nav-item"><a class="nav-link" href="about.jsp">Về Chúng Tôi</a></li>
                <li class="nav-item"><a class="nav-link" href="adoption.jsp">Nhận Nuôi</a></li>
                <li class="nav-item"><a class="nav-link" href="/Cart"><i class="bi bi-cart"></i> Giỏ Hàng</a></li>
            </ul>

            <% if (user == null && googleUsername == null) { %>
            <a class="btn btn-primary text-white px-4" href="login.jsp">Đăng Nhập</a>
            <% } else {%>
            <div class="dropdown">
                <button class="btn btn-outline-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle"></i> <%= googleUsername != null ? googleUsername : user.getFullName()%>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person"></i> Hồ sơ</a></li>
                    <li><a class="dropdown-item" href="orders.jsp"><i class="bi bi-receipt"></i> Đơn hàng</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="logout"><i class="bi bi-box-arrow-right"></i> Đăng Xuất</a></li>
                </ul>
            </div>
            <% }%>
        </div>
    </div>
</nav>

<!-- Thêm div để đẩy nội dung xuống -->
<div style="height: 70px;"></div>

<!-- CSS -->
<style>
    /* Navbar tùy chỉnh */
    .navbar-custom {
        position: fixed;
        width: 100%;
        top: 0;
        left: 0;
        z-index: 1000; /* Giúp navbar luôn nổi trên các phần khác */
        background: linear-gradient(135deg, #ffcc00, #ff9a00); /* Màu nền gradient */
    }

    .navbar-custom.scrolled {
        background: rgba(0, 0, 0, 1);
    }

    /* Logo */
    .navbar-brand {
        font-size: 1.5rem;
        color: #ffffff !important; /* Đổi màu chữ */
    }

    /* Màu chữ trong Navbar */
    .navbar-nav .nav-link {
        color: #ffffff !important; /* Màu trắng */
        font-size: 1.1rem;
        font-weight: bold;
        margin: 0 10px;
        transition: all 0.3s;
    }

    /* Hover cho Navbar */
    .navbar-nav .nav-link:hover {
        color: #2e2e2e !important; /* Đổi thành màu xám đậm khi hover */
        text-decoration: underline;
    }

    /* Màu chữ trong dropdown menu */
    .dropdown-menu {
        min-width: 200px;
        border-radius: 8px;
        overflow: hidden;
        background: #ffffff; /* Nền trắng */
        border: 1px solid #e0e0e0;
    }

    /* Đổi màu chữ trong dropdown */
    .dropdown-item {
        font-size: 1rem;
        padding: 10px 20px;
        color: #333 !important; /* Màu chữ xám đậm */
    }

    /* Hover trong dropdown */
    .dropdown-item:hover {
        background: #ffcc00;
        color: #000 !important;
    }

    /* Đổi màu chữ của "Đăng Xuất" */
    .dropdown-item.text-danger {
        color: red !important;
        font-weight: bold;
    }

    /* Hiệu ứng cuộn thay đổi nền */
    .navbar.scrolled {
        background: rgba(0, 0, 0, 0.9);
    }
</style>

<!-- Script giúp navbar thay đổi màu khi cuộn -->
<script>
    window.addEventListener("scroll", function () {
        let navbar = document.querySelector(".navbar-custom");
        if (window.scrollY > 50) {
            navbar.classList.add("scrolled");
        } else {
            navbar.classList.remove("scrolled");
        }
    });
</script>
