<%-- 
    Document   : appointmentCreate
    Created on : Mar 18, 2025, 1:17:20 AM
    Author     : hungv
--%>
<%@ page import="Model.Pet" %>
<%@ page import="Model.Service" %>
<%@ page import="Model.User" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Appointment</title>
</head>
<body>
    <h2>Create Appointment</h2>

    <form action="AppointmentServlet" method="post">
        Pet ID: 
        <select name="petId">
            <c:forEach var="pet" items="${pets}">
                <option value="${pet.petID}">${pet.petName}</option>
            </c:forEach>
        </select><br />
        
        Appointment Date: <input type="date" name="appointmentDate" /><br />
        
        Service: 
        <select name="serviceId">
            <c:forEach var="service" items="${services}">
                <option value="${service.serviceID}">${service.serviceName}</option>
            </c:forEach>
        </select><br />
        
        Customer: 
        <select name="customerId">
            <c:forEach var="customer" items="${customers}">
                <option value="${customer.userID}">${customer.userName}</option>
            </c:forEach>
        </select><br />
        
        Staff: 
        <select name="staffId">
            <c:forEach var="staff" items="${staffList}">
                <option value="${staff.userID}">${staff.userName}</option>
            </c:forEach>
        </select><br />
        
        Doctor: 
        <select name="doctorId">
            <c:forEach var="doctor" items="${doctors}">
                <option value="${doctor.userID}">${doctor.userName}</option>
            </c:forEach>
        </select><br />
        
        Notes: <textarea name="notes"></textarea><br />
        
        Price: <input type="text" name="price" /><br />
        
        <input type="submit" value="Create Appointment" />
    </form>

</body>
</html>

