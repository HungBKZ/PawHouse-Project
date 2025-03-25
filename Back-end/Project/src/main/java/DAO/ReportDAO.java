/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.OrderDetail;
import Model.ReportDTO;
import Model.ServiceDetail;
import Utils.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Timestamp;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

/**
 *
 * @author hungv
 */
public class ReportDAO extends DBContext {
    
    public ReportDTO getReport(Timestamp startDate, Timestamp endDate, String reportType) throws SQLException {
        ReportDTO report = new ReportDTO();
        report.setStartDate(startDate);
        report.setEndDate(endDate);
        report.setReportType(reportType);

        // Get total product revenue
        String productQuery = "SELECT COALESCE(SUM(od.Price * od.Quantity), 0) as Revenue " +
                            "FROM Orders o " +
                            "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                            "WHERE o.OrderDate BETWEEN ? AND ? " +
                            "AND o.OrderStatus = '1'";
        
        try (PreparedStatement stmt = connection.prepareStatement(productQuery)) {
            stmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                report.setProductRevenue(rs.getDouble("Revenue"));
            }
        }

        // Get total service revenue
        String serviceQuery = "SELECT COALESCE(SUM(a.Price), 0) as Revenue " +
                            "FROM Appointments a " +
                            "WHERE a.AppointmentDate BETWEEN ? AND ? " +
                            "AND a.AppointmentStatus = N'1'";
        
        try (PreparedStatement stmt = connection.prepareStatement(serviceQuery)) {
            stmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                report.setServiceRevenue(rs.getDouble("Revenue"));
            }
        }

        // Calculate total revenue
        report.setTotalRevenue(report.getProductRevenue() + report.getServiceRevenue());

        // Get total unique customers who made either orders or appointments
        String customerQuery = "SELECT COUNT(DISTINCT UserID) as TotalCustomers FROM (" +
                             "    SELECT DISTINCT o.UserID " +
                             "    FROM Orders o " +
                             "    WHERE o.OrderDate BETWEEN ? AND ? " +
                             "    AND o.OrderStatus = '1' " +
                             "    AND EXISTS (SELECT 1 FROM Users u WHERE u.UserID = o.UserID AND u.RoleID = 2) " +
                             "    UNION " +
                             "    SELECT DISTINCT a.CustomerID " +
                             "    FROM Appointments a " +
                             "    WHERE a.AppointmentDate BETWEEN ? AND ? " +
                             "    AND a.AppointmentStatus = N'1' " +
                             "    AND EXISTS (SELECT 1 FROM Users u WHERE u.UserID = a.CustomerID AND u.RoleID = 2) " +
                             ") as UniqueCustomers";
        
        try (PreparedStatement stmt = connection.prepareStatement(customerQuery)) {
            stmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
            stmt.setTimestamp(3, new java.sql.Timestamp(startDate.getTime()));
            stmt.setTimestamp(4, new java.sql.Timestamp(endDate.getTime()));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                report.setTotalCustomers(rs.getInt("TotalCustomers"));
            }
        }

        // Get time-based revenue data
        Map<String, Double> productRevenueMap = new LinkedHashMap<>();
        Map<String, Double> serviceRevenueMap = new LinkedHashMap<>();
        SimpleDateFormat sdf;
        String groupBy, dateSelect;

        switch (reportType.toLowerCase()) {
            case "monthly":
                sdf = new SimpleDateFormat("MM/yyyy");
                groupBy = "YEAR(OrderDate), MONTH(OrderDate)";
                dateSelect = "DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1)";
                break;
            case "yearly":
                sdf = new SimpleDateFormat("yyyy");
                groupBy = "YEAR(OrderDate)";
                dateSelect = "DATEFROMPARTS(YEAR(OrderDate), 1, 1)";
                break;
            default: // daily
                sdf = new SimpleDateFormat("dd/MM/yyyy");
                groupBy = "CAST(OrderDate AS DATE)";
                dateSelect = "CAST(OrderDate AS DATE)";
                break;
        }

        // Get product revenue by time period
        String productTimeQuery = "SELECT " + dateSelect + " as ReportDate, " +
                                "COALESCE(SUM(od.Price * od.Quantity), 0) as Revenue " +
                                "FROM Orders o " +
                                "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                                "WHERE o.OrderDate BETWEEN ? AND ? " +
                                "AND o.OrderStatus = '1' " +
                                "GROUP BY " + groupBy + " " +
                                "ORDER BY ReportDate";

        try (PreparedStatement stmt = connection.prepareStatement(productTimeQuery)) {
            stmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String dateKey = sdf.format(rs.getTimestamp("ReportDate"));
                productRevenueMap.put(dateKey, rs.getDouble("Revenue"));
            }
        }

        // Get service revenue by time period
        String serviceTimeQuery = "SELECT " + dateSelect.replace("OrderDate", "AppointmentDate") + " as ReportDate, " +
                                "COALESCE(SUM(Price), 0) as Revenue " +
                                "FROM Appointments " +
                                "WHERE AppointmentDate BETWEEN ? AND ? " +
                                "AND AppointmentStatus = N'1' " +
                                "GROUP BY " + groupBy.replace("OrderDate", "AppointmentDate") + " " +
                                "ORDER BY ReportDate";

        try (PreparedStatement stmt = connection.prepareStatement(serviceTimeQuery)) {
            stmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String dateKey = sdf.format(rs.getTimestamp("ReportDate"));
                serviceRevenueMap.put(dateKey, rs.getDouble("Revenue"));
            }
        }

        // Combine and align the data
        List<String> reportDates = new ArrayList<>();
        List<Double> productRevenues = new ArrayList<>();
        List<Double> serviceRevenues = new ArrayList<>();

        // Use all unique dates from both maps
        Set<String> allDates = new TreeSet<>();
        allDates.addAll(productRevenueMap.keySet());
        allDates.addAll(serviceRevenueMap.keySet());

        for (String date : allDates) {
            reportDates.add(date);
            productRevenues.add(productRevenueMap.getOrDefault(date, 0.0));
            serviceRevenues.add(serviceRevenueMap.getOrDefault(date, 0.0));
        }

        report.setReportDates(reportDates);
        report.setProductRevenues(productRevenues);
        report.setServiceRevenues(serviceRevenues);

        // Get order details
        List<OrderDetail> orderDetails = getOrderDetails(startDate, endDate);
        report.setOrderDetails(orderDetails);

        // Get service details
        List<ServiceDetail> serviceDetails = getServiceDetails(startDate, endDate);
        report.setServiceDetails(serviceDetails);

        return report;
    }

    private List<OrderDetail> getOrderDetails(Timestamp startDate, Timestamp endDate) throws SQLException {
        List<OrderDetail> details = new ArrayList<>();
        String query = "SELECT o.OrderID, o.OrderDate, u.FullName as CustomerName, " +
                      "p.ProductName, od.Quantity, od.Price, (od.Price * od.Quantity) as Total " +
                      "FROM Orders o " +
                      "JOIN Users u ON o.UserID = u.UserID " +
                      "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                      "JOIN Products p ON od.ProductID = p.ProductID " +
                      "WHERE o.OrderDate BETWEEN ? AND ? " +
                      "AND o.OrderStatus = '1' " +
                      "ORDER BY o.OrderDate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(rs.getInt("OrderID"));
                detail.setOrderDate(rs.getTimestamp("OrderDate"));
                detail.setCustomerName(rs.getString("CustomerName"));
                detail.setProductName(rs.getString("ProductName"));
                detail.setQuantity(rs.getInt("Quantity"));
                detail.setPrice(rs.getDouble("Price"));
                detail.setTotal(rs.getDouble("Total"));
                details.add(detail);
            }
        }
        return details;
    }

    private List<ServiceDetail> getServiceDetails(Timestamp startDate, Timestamp endDate) throws SQLException {
        List<ServiceDetail> details = new ArrayList<>();
        String query = "SELECT a.AppointmentID, a.AppointmentDate, u.FullName as CustomerName, " +
                      "s.ServiceName, a.Price " +
                      "FROM Appointments a " +
                      "JOIN Users u ON a.CustomerID = u.UserID " +
                      "JOIN Services s ON a.ServiceID = s.ServiceID " +
                      "WHERE a.AppointmentDate BETWEEN ? AND ? " +
                      "AND a.AppointmentStatus = N'1' " +
                      "ORDER BY a.AppointmentDate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ServiceDetail detail = new ServiceDetail();
                detail.setAppointmentId(rs.getInt("AppointmentID"));
                detail.setAppointmentDate(rs.getTimestamp("AppointmentDate"));
                detail.setCustomerName(rs.getString("CustomerName"));
                detail.setServiceName(rs.getString("ServiceName"));
                detail.setPrice(rs.getDouble("Price"));
                details.add(detail);
            }
        }
        return details;
    }
}
