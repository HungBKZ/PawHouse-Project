
<%@ page import="Model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PawHouse - Chăm Sóc Thú Cưng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">PawHouse</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">Trang Chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="products.jsp">Sản Phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Dịch Vụ</a></li>
                    <li class="nav-item"><a class="nav-link" href="adoption.jsp">Nhận Nuôi</a></li>
                    <li class="nav-item"><a class="nav-link" href="cart.jsp"><i class="bi bi-cart"></i> Giỏ Hàng</a></li>
                    <% User user = (User) session.getAttribute("loggedInUser"); %>
                    <% if (user == null) { %>
                        <li class="nav-item"><a class="nav-link btn btn-primary text-white" href="login.jsp">Đăng Nhập</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="profile.jsp"><i class="bi bi-person-circle"></i> <%= user.getFullName() %></a></li>
                        <li class="nav-item"><a class="nav-link" href="logout.jsp">Đăng Xuất</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Carousel -->
    <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="./imgs/care.jpg" class="d-block w-100" alt="Chăm sóc thú cưng">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Chăm Sóc Thú Cưng Toàn Diện</h5>
                </div>
            </div>
            <div class="carousel-item">
                <img src="./imgs/spa.jpg" class="d-block w-100" alt="Dịch vụ spa">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Dịch Vụ Spa & Grooming</h5>
                </div>
            </div>
            <div class="carousel-item">
                <img src="./imgs/R.jpg" class="d-block w-100" alt="Nhận nuôi thú cưng">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Nhận Nuôi Thú Cưng</h5>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
        </button>
    </div>
    
    <!-- Product Section -->
    <section id="products" class="container py-5">
        <h2 class="text-center mb-4">Sản Phẩm Nổi Bật</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <a href="food.jsp"><img src="./imgs/food.jpg" class="card-img-top" alt="Thức ăn"></a>
                    <div class="card-body">
                        <h5 class="card-title">Thức Ăn Thú Cưng</h5>
                        <p class="card-text">Sản phẩm dinh dưỡng giúp thú cưng phát triển khỏe mạnh.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <a href="toy.jsp"><img src="./imgs/toy_.jpg" class="card-img-top" alt="Đồ chơi"></a>
                    <div class="card-body">
                        <h5 class="card-title">Đồ Chơi Thú Cưng</h5>
                        <p class="card-text">Giúp thú cưng vui chơi và rèn luyện sức khỏe.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <a href="accessory.jsp"><img src="./imgs/phukien.png" class="card-img-top" alt="Phụ kiện"></a>
                    <div class="card-body">
                        <h5 class="card-title">Phụ Kiện Thú Cưng</h5>
                        <p class="card-text">Những món đồ không thể thiếu để chăm sóc thú cưng tốt hơn.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Services Section -->
    <section id="services" class="container py-5">
      <h2 class="text-center mb-4">Dịch Vụ Chúng Tôi Cung Cấp</h2>
      <div class="row">
        <div class="col-md-4">
          <div class="card">
            <a href="./doctor.html"
              ><img src="./imgs/thuy.png" class="card-img-top" alt="Thú y"
            /></a>
            <div class="card-body">
              <h5 class="card-title">Thú Y</h5>
              <p class="card-text">Dịch vụ khám chữa bệnh cho thú cưng.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card">
            <a href="./spa.html"
              ><img src="./imgs/spapet.jpg" class="card-img-top" alt="Spa"
            /></a>
            <div class="card-body">
              <h5 class="card-title">Spa & Grooming</h5>
              <p class="card-text">Chăm sóc và làm đẹp cho thú cưng.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card">
            <a href="./adoption.html">
              <img
                src="./imgs/takecare.jpg"
                class="card-img-top"
                alt="Nhận nuôi"
            /></a>
            <div class="card-body">
              <h5 class="card-title">Nhận Nuôi</h5>
              <p class="card-text">Giúp thú cưng tìm kiếm ngôi nhà mới.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Booking Section -->
    <div class="container mt-5">
      <h2 id="reviews" class="text-center">Đánh giá</h2>
      <form class="mt-2">
        <div class="row">
          <div class="col-md-4">
            <input type="text" class="form-control" placeholder="Your Name *" />
          </div>

          <div class="col-md-4">
            <input
              type="email"
              class="form-control"
              placeholder="Your Email *"
            />
          </div>

          <div class="col-md-4">
            <select class="form-select">
              <option>Select a Service</option>
              <option>Thú y</option>
              <option>Spa & Grooming</option>
              <option>Nhận nuôi</option>
            </select>
          </div>
        </div>

        <div class="mt-5">
          <textarea
            class="form-control"
            rows="5"
            placeholder="Please write your comment"
          ></textarea>
        </div>

        <div class="mt-3">
          <button class="btn btn-warning px-5">
            <b style="color: aliceblue">Send Message</b>
          </button>
        </div>
      </form>
    </div>

    <!-- Footer -->
    <footer class="footer bg-dark text-white text-center py-4">
        <p>&copy; 2025 PawHouse. Tất cả các quyền được bảo lưu.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
