<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.MedicalRecords"%>
<%@page import="Model.Pet"%>
<%@page import="Model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ bệnh án</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2b6cb0;
            --secondary-color: #4299e1;
            --accent-color: #90cdf4;
            --background-color: #f7fafc;
            --text-color: #2d3748;
        }
        
        body {
            background-color: var(--background-color);
            color: var(--text-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .table {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .table thead {
            background-color: var(--primary-color);
            color: white;
        }
        
        .table th {
            font-weight: 600;
            padding: 1rem;
            border-bottom: none;
        }
        
        .table td {
            padding: 1rem;
            vertical-align: middle;
        }
        
        .table tbody tr:hover {
            background-color: #f8fafc;
        }
        
        .pet-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .pet-image {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .pet-details {
            display: flex;
            flex-direction: column;
        }
        
        .pet-name {
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .pet-breed {
            font-size: 0.875rem;
            color: #718096;
        }
        
        .owner-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .owner-icon {
            color: var(--primary-color);
        }
        
        .diagnosis-cell {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .btn-view {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 6px;
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-view:hover {
            background-color: var(--secondary-color);
            color: white;
            transform: translateY(-1px);
        }
        
        .record-date {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.25rem;
        }
        
        .date {
            font-weight: 600;
        }
        
        .time {
            font-size: 0.875rem;
            color: #718096;
        }
        
        .page-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .btn-back {
            background-color: #718096;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 0.5rem 1rem;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-back:hover {
            background-color: #4a5568;
            color: white;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <h2 class="page-title">Danh sách hồ sơ bệnh án</h2>

    <div class="table-responsive">
        <table class="table">
            <thead>
            <tr>
                <th>Mã</th>
                <th>Thú cưng</th>
                <th>Chủ sở hữu</th>
                <th>Chẩn đoán</th>
                <th>Dấu hiệu sinh tồn</th>
                <th>Ngày khám</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<MedicalRecords> list = (List<MedicalRecords>) request.getAttribute("records");
                if (list != null && !list.isEmpty()) {
                    for (MedicalRecords r : list) {
            %>
            <tr>
                <td>#<%= r.getRecordID() %></td>
                <td>
                    <div class="pet-info">
                        <% if (r.getPet().getPetImage() != null && !r.getPet().getPetImage().isEmpty()) { %>
                            <img src="<%= r.getPet().getPetImage() %>" alt="<%= r.getPet().getPetName() %>" class="pet-image">
                        <% } else { %>
                            <img src="https://via.placeholder.com/40" alt="No image" class="pet-image">
                        <% } %>
                        <div class="pet-details">
                            <span class="pet-name"><%= r.getPet().getPetName() %></span>
                            <span class="pet-breed"><%= r.getPet().getSpecies() %> - <%= r.getPet().getBreed() %></span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="owner-info">
                        <i class="fas fa-user owner-icon"></i>
                        <%= r.getPet().getOwner().getFullName() %>
                    </div>
                </td>
                <td>
                    <div class="diagnosis-cell" title="<%= r.getDiagnosis() %>">
                        <%= r.getDiagnosis() %>
                    </div>
                </td>
                <td>
                    <div class="vital-signs">
                        <i class="fas fa-weight me-1"></i> <%= r.getWeight() %> kg
                        <br>
                        <i class="fas fa-thermometer-half me-1"></i> <%= r.getTemperature() %>°C
                    </div>
                </td>
                <td>
                    <div class="record-date">
                        <span class="date">
                            <fmt:formatDate value="<%= r.getRecordDate() %>" pattern="dd/MM/yyyy"/>
                        </span>
                        <span class="time">
                            <fmt:formatDate value="<%= r.getRecordDate() %>" pattern="HH:mm"/>
                        </span>
                    </div>
                </td>
                <td>
                    <a href="medical-record/<%= r.getRecordID() %>" class="btn-view">
                        <i class="fas fa-eye"></i>
                        Chi tiết
                    </a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7" class="text-center text-danger">
                    <i class="fas fa-info-circle me-2"></i>
                    Không có hồ sơ nào.
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="text-center mt-4">
        <a href="doctorIndex.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i>
            Quay lại
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
