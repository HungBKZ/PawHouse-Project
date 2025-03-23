<%-- 
    Document   : footer
    Created on : Feb 26, 2025, 10:56:37 AM
    Author     : hungv
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Footer -->
<footer class="footer bg-dark text-white py-5 mt-5">
    <div class="container">
        <div class="row">
            <!-- Thông tin liên hệ -->
            <div class="col-md-4">
                <h5 class="fw-bold">Liên hệ</h5>
                <p><i class="bi bi-geo-alt"></i> 123 Đường ABC, TP. Hồ Chí Minh</p>
                <p><i class="bi bi-phone"></i> 0123 456 789</p>
                <p><i class="bi bi-envelope"></i> support@pawhouse.com</p>
            </div>

            <!-- Giờ mở cửa -->
            <div class="col-md-4">
                <h5 class="fw-bold">Giờ mở cửa</h5>
                <p>Thứ 2 - Thứ 6: 8:00 - 20:00</p>
                <p>Thứ 7 - Chủ Nhật: 9:00 - 18:00</p>
            </div>

            <!-- Mạng xã hội & Google Maps -->
            <div class="col-md-4 text-center">
                <h5 class="fw-bold">Theo dõi chúng tôi</h5>
                <a href="https://www.facebook.com/profile.php?id=61555627029229&locale=vi_VN" class="text-white me-3"><i class="bi bi-facebook"></i></a>
                <a href="#" class="text-white me-3"><i class="bi bi-instagram"></i></a>
                <a href="#" class="text-white"><i class="bi bi-twitter"></i></a>
                <br>
                <!-- Google Maps -->
                <h5 class="mt-3 fw-bold">Địa chỉ trên bản đồ</h5>
                <iframe 
                    src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15679.833625152033!2d105.780323!3d10.028900!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a08822969e343d%3A0x2eb84b3cd4b3c67b!2zQ-G7lW5nIMSR4bqzbmcgQ-G7lW5nIFRo4buxIFBow7JuZw!5e0!3m2!1sen!2s!4v1700000000000!5m2!1sen!2s" 
                    width="100%" 
                    height="250" 
                    style="border:0; border-radius: 10px; box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.2);" 
                    allowfullscreen="" 
                    loading="lazy">
                </iframe>
            </div>
        </div>

        <hr class="my-4 text-white">
        <p class="text-center">© 2025 PawHouse. Tất cả các quyền được bảo lưu.</p>
    </div>
</footer>

<!-- CSS -->
<style>
    /* Footer */
    .footer {
        background: #222;
    }

    .footer a {
        color: #ffcc00;
        text-decoration: none;
        margin: 0 10px;
        display: inline-block;
    }

    .footer a:hover {
        color: #ff9900;
    }

    /* Map Responsive */
    .footer iframe {
        max-width: 100%;
        border-radius: 10px;
    }
</style>
