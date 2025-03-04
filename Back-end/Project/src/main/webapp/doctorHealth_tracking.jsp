<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Theo Dõi Sức Khỏe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container my-5">
        <h2 class="text-center">Theo Dõi Sức Khỏe Thú Cưng</h2>

        <%-- Kết nối CSDL và lấy danh sách tình trạng sức khỏe thú cưng --%>
        <%
            String url = "jdbc:sqlserver://localhost:1433;databaseName=PawHouseProject;encrypt=false";
            String user = "sa";
            String password = "your_password"; // Thay bằng mật khẩu thực tế của bạn

            try {
                // Nạp driver và kết nối
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                try (Connection conn = DriverManager.getConnection(url, user, password);
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT PetID, PetName, OwnerName, HealthStatus FROM Pets")) {
        %>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Tên thú cưng</th>
                    <th>Chủ sở hữu</th>
                    <th>Tình trạng</th>
                </tr>
            </thead>
            <tbody>
                <% while(rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("PetID") %></td>
                    <td><%= rs.getString("PetName") %></td>
                    <td><%= rs.getString("OwnerName") %></td>
                    <td><%= rs.getString("HealthStatus") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <% 
                } // Kết thúc try-with-resources (tự động đóng kết nối)
            } catch (Exception e) { 
        %>
            <p class="text-danger">Lỗi khi truy xuất dữ liệu: <%= e.getMessage() %></p>
        <% } %>

        <a href="doctorIndex.jsp" class="btn btn-primary">Quay lại</a>
    </div>
</body>
</html>
