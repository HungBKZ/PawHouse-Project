<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.IOException" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.http.HttpServlet" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
    // Lấy dữ liệu từ form
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String service = request.getParameter("service");
    String message = request.getParameter("message");

    // Cấu hình kết nối Database
    String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=PawHouseProject;user=sa;password=12345;encrypt=true;trustServerCertificate=true;";
    String dbUser = "sa";
    String dbPassword = "12345";

    Connection conn = null;
    PreparedStatement ps = null;
    
    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        // Câu lệnh SQL để chèn dữ liệu
        String sql = "INSERT INTO Messages (Name, Email, Service, MessageContent) VALUES (?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, service);
        ps.setString(4, message);
        
        int rows = ps.executeUpdate();
        
        if (rows > 0) {
            out.println("<script>alert('Tin nhắn của bạn đã được gửi thành công!'); window.location.href='index.jsp';</script>");
        } else {
            out.println("<script>alert('Gửi tin nhắn thất bại. Vui lòng thử lại!'); window.history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Lỗi hệ thống! Vui lòng thử lại sau.'); window.history.back();</script>");
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
