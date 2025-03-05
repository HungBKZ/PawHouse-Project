<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác thực OTP</title>
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

        h2 {
            color: #FF8000; /* Màu cam giống tiêu đề "Chào Mừng Đến Với PawHouse" */
            font-size: 24px;
            font-weight: bold;
        }

        p {
            color: red;
        }

        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border: 2px solid #FF8000;
            border-radius: 5px;
            font-size: 16px;
        }

        button {
            background-color: #FF8000; /* Màu cam giống menu */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
        }

        button:hover {
            background-color: #E67300;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Xác Thực OTP</h2>
        <% if (request.getParameter("error") != null) { %>
            <p><%= request.getParameter("error") %></p>
        <% } %>
        <form action="verifyOTP" method="post">
            <input type="text" name="otp" placeholder="Nhập mã OTP" required>
            <button type="submit">Xác Nhận</button>
        </form>
    </div>
</body>
</html>
