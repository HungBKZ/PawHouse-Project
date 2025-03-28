<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Pet, Model.AdoptionHistory, Model.PetCategories" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>

<%
    Pet pet = (Pet) request.getAttribute("petDetail");
    List<AdoptionHistory> adoptionHistory = (List<AdoptionHistory>) request.getAttribute("adoptionHistory");

    if (pet == null) {
        response.sendRedirect("adoption.jsp?error=notfound");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết thú cưng</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>

            .pet-image {
                width: 100%;
                max-height: 400px;
                object-fit: cover;
                border-radius: 10px;
            }
            .btn-adopt {
                width: 100%;
                font-size: 18px;
            }
            .table th, .table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
                font-size: 14px;
            }
            .table th {
                background-color: #f4f4f4;
                color: #333;
                font-weight: bold;
            }
            .table td {
                background-color: #fff;
                color: #555;
            }
            .table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .table tr:hover {
                background-color: #f1f1f1;
            }
            .table .highlight {
                background-color: #f1f8e9;
            }
            .table .highlight:hover {
                background-color: #d9f7bf;
            }
            .table .column-date {
                width: 150px;
            }
            .table .column-vaccination {
                width: 180px;
            }
            .table .column-appointment-id {
                width: 100px;
            }
        </style>
    </head>
    <body>

        <%@ include file="includes/navbar.jsp" %>

        <div class="container">
            <div class="row">
                <!-- Ảnh thú cưng -->
                <div class="col-md-6">
                    <img src="<%= pet.getPetImage() != null ? pet.getPetImage() : "assets/img/default-pet.jpg"%>" class="pet-image">
                </div>

                <!-- Thông tin thú cưng -->
                <div class="col-md-6">
                    <h2 class="text-primary"><%= pet.getPetName()%></h2>
                    <p><strong>Loài:</strong> <%= pet.getSpecies()%></p>
                    <p><strong>Giống:</strong> <%= pet.getBreed()%></p>
                    <p><strong>Tuổi:</strong> <%= pet.getAge()%> năm</p>
                    <p><strong>Giới tính:</strong> <%= pet.getGender()%></p>
                    <p><strong>Trạng thái:</strong> 
                        <span class="badge bg-<%= pet.getAdoptionStatus().equals("Chưa nhận nuôi") ? "danger" : "success"%>">
                            <%= pet.getAdoptionStatus()%>
                        </span>
                    </p>

                    <% if (pet.getAdoptionStatus().equals("Chưa nhận nuôi")) {%>
                    <form action="AdoptPetServlet" method="post">
                        <input type="hidden" name="petId" value="<%= pet.getPetID()%>">
                        <button type="submit" class="btn btn-success btn-adopt">Nhận nuôi ngay</button>
                    </form>
                    <% } %>
                </div>
            </div>

            <!-- Lịch sử nhận nuôi -->
            <div class="mt-4">
                <h3 class="text-secondary">Lịch sử nhận nuôi</h3>
                <% if (adoptionHistory != null && !adoptionHistory.isEmpty()) { %>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Ngày nhận nuôi</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (AdoptionHistory history : adoptionHistory) {%>
                        <tr>
                            <td><%= history.getAdoptionDate()%></td>
                            <td><%= history.getAdoptionStatus()%></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <p class="text-muted">Chưa có lịch sử nhận nuôi.</p>
                <% }%>
            </div>


            <!-- Hồ sơ bệnh án -->
            <div class="mt-4">
                <h3 class="text-secondary">Hồ sơ bệnh án</h3>
                <c:if test="${not empty medicalRecords}">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th class="column-date">Ngày khám</th>
                                <th>Chẩn đoán</th>
                                <th>Điều trị</th>
                                <th>Đơn thuốc</th>
                                <th class="column-vaccination">Vacxin đã tiêm</th>
                                <th class="column-date">Vacxin kế</th>
                                <th>Cân nặng</th>
                                <th>Nhiệt độ</th>
                                <th>Ghi chú</th>
                                <th  class="column-appointment-id">Mã lịch hẹn</th>
                                <th>Bác sĩ</th>
                                <th>Số điện thoại Bác sĩ</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="record" items="${medicalRecords}">
                                <tr>
                                    <td class="column-date">  
                                        <c:choose>  
                                            <c:when test="${not empty record.recordDate}">  
                                                <fmt:formatDate value="${record.recordDate}" pattern="yyyy-MM-dd HH:mm:ss" />  
                                            </c:when>  
                                            <c:otherwise>  
                                                N/A  
                                            </c:otherwise>  
                                        </c:choose>  
                                    </td>
                                    <td><c:out value="${record.diagnosis}" /></td>
                                    <td><c:out value="${record.treatment}" /></td>
                                    <td><c:out value="${record.prescription}" /></td>
                                    <td class="column-vaccination"><c:out value="${record.vaccinationDetails}" /></td>
                                    <td class="column-date"><fmt:formatDate value="${record.nextVaccinationDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td><c:out value="${record.weight}" /></td>
                                    <td><c:out value="${record.temperature}" /></td>
                                    <td><c:out value="${record.notes}" /></td>
                                    <td><c:out value="${record.appointment.appointmentID}" /></td>
                                    <td><c:out value="${record.doctor.fullName}" /></td>
                                    <td><c:out value="${record.doctor.phone}" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <c:if test="${empty medicalRecords}">
                    <p class="text-muted">Chưa có hồ sơ bệnh án.</p>
                </c:if>
            </div>
        </div>

        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
