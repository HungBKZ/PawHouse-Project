<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hồ Sơ Bệnh Án</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container my-5">
        <h2 class="text-center">Hồ Sơ Bệnh Án</h2>

        <%-- Kết nối CSDL và lấy dữ liệu --%>
        <%
            String url = "jdbc:sqlserver://localhost:1433;databaseName=PawHouseProject;encrypt=false";
            String user = "sa";
            String password = "your_password"; // Thay bằng mật khẩu thực tế của bạn
            
            try {
                // Nạp driver và kết nối
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                try (Connection conn = DriverManager.getConnection(url, user, password);
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT MedicalRecordID, PetName, OwnerName, Diagnosis, Treatment FROM MedicalRecords")) {
        %>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Tên thú cưng</th>
                    <th>Chủ sở hữu</th>
                    <th>Chẩn đoán</th>
                    <th>Điều trị</th>
                </tr>
            </thead>
            <tbody>
                <% while(rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("MedicalRecordID") %></td>
                    <td><%= rs.getString("PetName") %></td>
                    <td><%= rs.getString("OwnerName") %></td>
                    <td><%= rs.getString("Diagnosis") %></td>
                    <td><%= rs.getString("Treatment") %></td>
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
