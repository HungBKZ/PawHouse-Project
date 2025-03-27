<%-- 
    Document   : appointmentList
    Created on : Mar 18, 2025, 1:18:08 AM
    Author     : hungv
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Appointment" %>
<%@ page import="Model.User" %>
<%@ page import="Model.Pet" %>
<%@ page import="Model.Service" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Appointment List</title>
</head>
<body>
    <h2>Appointment List</h2>
    
    <table border="1">
        <thead>
            <tr>
                <th>Pet Name</th>
                <th>Customer Name</th>
                <th>Doctor Name</th>
                <th>Service</th>
                <th>Appointment Date</th>
                <th>Status</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="appointment" items="${appointments}">
                <tr>
                    <td>${appointment.pet.petName}</td>
                    <td>${appointment.customer.userName}</td>
                    <td>${appointment.doctor.userName}</td>
                    <td>${appointment.service.serviceName}</td>
                    <td>${appointment.appointmentDate}</td>
                    <td>${appointment.appointmentStatus}</td>
                    <td><fmt:formatNumber value="${appointment.price}" pattern="#,##0"/> VND</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
</body>
</html>
