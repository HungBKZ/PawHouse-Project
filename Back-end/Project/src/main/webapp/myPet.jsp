<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thú cưng của tôi</title>
        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background: linear-gradient(to right, #f8f9fa, #e9ecef);
            }
            .pet-card {
                transition: transform 0.3s ease-in-out, box-shadow 0.3s;
                border-radius: 10px;
                width: 100%;
                max-width: 300px;
            }
            .pet-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }
            .pet-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 10px 10px 0 0;
            }
            .status-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.9rem;
                font-weight: 500;
            }
            .status-completed {
                background-color: #d4edda;
                color: #155724;
            }
            .status-in-progress {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-pending {
                background-color: #f8d7da;
                color: #721c24;
            }
            .status-none {
                background-color: #e2e3e5;
                color: #383d41;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="includes/navbar.jsp" %>

        <div class="container mt-5">
            <h2 class="text-primary text-center"><i class="fas fa-paw"></i> Thú cưng của tôi</h2>
            <hr>

            <c:set var="petCount" value="${fn:length(petList)}" />

            <div class="d-flex 
                 <c:choose>
                     <c:when test="${petCount == 1}">justify-content-center</c:when>
                     <c:when test="${petCount == 2}">justify-content-between</c:when>
                     <c:otherwise>justify-content-start</c:otherwise>
                 </c:choose> 
                 flex-wrap gap-4">

                <c:choose>
                    <c:when test="${not empty petList}">
                        <div class="row row-cols-1 row-cols-md-3 g-4">
                            <c:forEach var="pet" items="${petList}">
                                <div class="col">
                                    <div class="card h-100 pet-card shadow-sm">
                                        <img src="${not empty pet.petImage ? pet.petImage : 'assets/img/default-pet.jpg'}"
                                             class="card-img-top pet-image" alt="${pet.petName}" style="height: 200px; object-fit: cover;">
                                        <div class="card-body d-flex flex-column text-center">
                                            <h5 class="card-title text-primary">${pet.petName}</h5>
                                            <p class="card-text mb-1"><strong>Loài:</strong> ${pet.species}</p>
                                            <p class="card-text mb-1"><strong>Giống:</strong> ${pet.breed}</p>
                                            <p class="card-text mb-1"><strong>Giới tính:</strong> ${pet.gender}</p>
                                            <p class="card-text mb-1"><strong>Tuổi:</strong> ${pet.age} năm</p>

                                            <p class="card-text mb-1">
                                                <strong>Trạng thái nhận nuôi:</strong>
                                                <span class="${pet.adoptionStatus eq 'Đã nhận nuôi' ? 'text-success fw-bold' : 'text-warning'}">
                                                    ${pet.adoptionStatus}
                                                </span>
                                            </p>

                                            <c:set var="serviceStatus" value="${empty pet.inUseService ? 'Chưa từng sử dụng dịch vụ' : pet.inUseService}" />
                                            <c:set var="statusClass" value="status-none" />
                                            <c:choose>
                                                <c:when test="${serviceStatus eq 'Hoàn thành'}">
                                                    <c:set var="statusClass" value="status-completed" />
                                                </c:when>
                                                <c:when test="${serviceStatus eq 'Đang tiến hành'}">
                                                    <c:set var="statusClass" value="status-in-progress" />
                                                </c:when>
                                                <c:when test="${serviceStatus eq 'Chưa từng sử dụng dịch vụ'}">
                                                    <c:set var="statusClass" value="status-none" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="statusClass" value="status-pending" />
                                                </c:otherwise>
                                            </c:choose>

                                            <p class="card-text mt-auto">
                                                <strong>Trạng thái dịch vụ:</strong><br>
                                                <span class="badge ${statusClass}">${serviceStatus}</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="alert alert-info text-center" role="alert">
                                Bạn chưa có thú cưng nào trong danh sách.
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <!-- Bootstrap & JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
