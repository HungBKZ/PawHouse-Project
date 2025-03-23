<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify OTP - Password Reset</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #FFF3CD; /* Màu nền vàng nhạt */
                text-align: center;
            }

            .container {
                background-color: white;
                width: 40%;
                margin: 100px auto;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            .card-header {
                background-color: #FF8000; /* Màu cam */
                color: white;
                border-radius: 10px 10px 0 0;
                padding: 15px;
                font-size: 24px;
                font-weight: bold;
            }

            .form-group label {
                color: #FF8000; /* Màu cam */
                font-weight: bold;
                font-size: 16px;
            }

            .form-control {
                width: 80%;
                padding: 10px;
                margin: 10px auto;
                border: 2px solid #FF8000;
                border-radius: 5px;
                font-size: 16px;
                text-align: center;
            }

            .btn-primary {
                background-color: #FF8000; /* Màu cam */
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 18px;
                cursor: pointer;
                width: 50%;
                margin-top: 15px;
            }

            .btn-primary:hover {
                background-color: #E67300;
            }

            .alert-danger {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="card">
                <div class="card-header">
                    Verify OTP
                </div>
                <div class="card-body">
                    <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                    <p>
                       Chúng tôi đã gửi mã OTP đến Email của bạn, Hãy check Email và nhập mã OTP xuống dưới đây!
                    </p>
                    <form action="forgotPassword" method="post">
                        <input type="hidden" name="action" value="verifyOTP">
                        <div class="form-group">
                            <label for="otp">Nhập Mã OTP</label>
                            <input type="text" class="form-control" id="otp" name="otp" required
                                   placeholder="Nhập 6 số OTP" maxlength="6" pattern="[0-9]{6}">
                        </div>
                        <button type="submit" class="btn btn-primary">Xác Thực</button>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
