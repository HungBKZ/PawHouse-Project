/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import com.google.gson.Gson;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author hungv
 */
public class ReportDTO {
    private double totalRevenue;
    private double productRevenue;
    private double serviceRevenue;
    private int totalCustomers;
    private List<String> reportDates;
    private List<Double> productRevenues;
    private List<Double> serviceRevenues;
    private List<OrderDetail> orderDetails;
    private List<ServiceDetail> serviceDetails;
    private Timestamp startDate;
    private Timestamp endDate;
    private String reportType; // daily, monthly, yearly

    private static final Gson gson = new Gson();

    public ReportDTO() {
    }

    // Getters and Setters
    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public double getProductRevenue() {
        return productRevenue;
    }

    public void setProductRevenue(double productRevenue) {
        this.productRevenue = productRevenue;
    }

    public double getServiceRevenue() {
        return serviceRevenue;
    }

    public void setServiceRevenue(double serviceRevenue) {
        this.serviceRevenue = serviceRevenue;
    }

    public int getTotalCustomers() {
        return totalCustomers;
    }

    public void setTotalCustomers(int totalCustomers) {
        this.totalCustomers = totalCustomers;
    }

    public List<String> getReportDates() {
        return reportDates;
    }

    public void setReportDates(List<String> reportDates) {
        this.reportDates = reportDates;
    }

    public List<Double> getProductRevenues() {
        return productRevenues;
    }

    public void setProductRevenues(List<Double> productRevenues) {
        this.productRevenues = productRevenues;
    }

    public List<Double> getServiceRevenues() {
        return serviceRevenues;
    }

    public void setServiceRevenues(List<Double> serviceRevenues) {
        this.serviceRevenues = serviceRevenues;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public List<ServiceDetail> getServiceDetails() {
        return serviceDetails;
    }

    public void setServiceDetails(List<ServiceDetail> serviceDetails) {
        this.serviceDetails = serviceDetails;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    // Các phương thức chuyển đổi sang JSON
    public String getReportDatesJson() {
        return gson.toJson(reportDates);
    }

    public String getProductRevenuesJson() {
        return gson.toJson(productRevenues);
    }

    public String getServiceRevenuesJson() {
        return gson.toJson(serviceRevenues);
    }
}
