<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Spa & Grooming - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                padding-bottom: 70px;
            }
            .navbar {
                background-color: #0056b3;
                padding: 15px 0;
            }
            .navbar-brand, .nav-link {
                color: white !important;
                font-weight: 600;
            }
            .container {
                margin-top: 30px;
            }
            .table {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .table thead {
                background-color: #0056b3;
                color: white;
            }
            .pet-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 50%;
            }
            .status-pending {
                background-color: #ffc107;
                color: black;
            }
            .status-confirmed {
                background-color: #28a745;
                color: white;
            }
            .status-completed {
                background-color: #17a2b8;
                color: white;
            }
            .status-cancelled {
                background-color: #dc3545;
                color: white;
            }
            .badge {
                font-size: 0.9em;
                padding: 8px 12px;
            }
            .price {
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/staffIndex.jsp">
                    <i class="fas fa-paw"></i> PawHouse Staff
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/StaffPetServlet?action=list">
                                <i class="fas fa-paw"></i> Quản lý thú cưng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/StaffAppointmentServlet?action=list">
                                <i class="fas fa-calendar-check"></i> Quản lý Spa & Grooming
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <!-- Thông báo thành công/lỗi -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> <c:out value="${successMessage}"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> <c:out value="${errorMessage}"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card mb-4">
                <div class="card-body">
                    <h2 class="card-title mb-4">
                        <i class="fas fa-calendar-check"></i> Quản lý lịch hẹn Spa & Grooming
                    </h2>
                    
                    <!-- Bộ lọc -->
                    <form id="filterForm" class="row g-3 mb-4">
                        <div class="col-md-3">
                            <input type="text" class="form-control" id="searchInput" 
                                   placeholder="Tìm theo tên khách hàng, thú cưng...">
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" id="statusFilter">
                                <option value="">Tất cả trạng thái</option>
                                <option value="Pending">Chờ xác nhận</option>
                                <option value="Confirmed">Đã xác nhận</option>
                                <option value="Completed">Hoàn thành</option>
                                <option value="Cancelled">Đã hủy</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <input type="date" class="form-control" id="dateFilter">
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search"></i> Tìm kiếm
                            </button>
                        </div>
                    </form>

                    <!-- Bảng lịch hẹn -->
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Thú cưng</th>
                                    <th>Khách hàng</th>
                                    <th>Dịch vụ</th>
                                    <th>Ngày hẹn</th>
                                    <th>Giá</th>
                                    <th>Trạng thái</th>
                                    <th>Ghi chú</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody id="appointmentTableBody">
                                <c:forEach items="${appointments}" var="appointment">
                                    <tr>
                                        <td><c:out value="${appointment.appointmentID}"/></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/${appointment.pet.petImage}" 
                                                     alt="<c:out value="${appointment.pet.petName}"/>" 
                                                     class="pet-image me-2"
                                                     onerror="this.src='${pageContext.request.contextPath}/imgs/pet/default-pet.jpg'">
                                                <div>
                                                    <strong><c:out value="${appointment.pet.petName}"/></strong><br>
                                                    <small><c:out value="${appointment.pet.breed}"/></small>
                                                </div>
                                            </div>
                                        </td>
                                        <td><c:out value="${appointment.customer.username}"/></td>
                                        <td>
                                            <c:out value="${appointment.service.serviceName}"/><br>
                                            <small class="text-muted"><c:out value="${appointment.service.description}"/></small>
                                        </td>
                                        <td>
                                            <fmt:formatDate type="date" value="${appointment.appointmentDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td class="price">
                                            <fmt:formatNumber type="currency" value="${appointment.price}" maxFractionDigits="0"/>₫
                                        </td>
                                        <td>
                                            <c:set var="status" value="${appointment.appointmentStatus}"/>
                                            <span class="badge status-${status.toLowerCase()}">
                                                <c:out value="${statusMap[status]}"/>
                                            </span>
                                        </td>
                                        <td><c:out value="${appointment.notes}"/></td>
                                        <td>
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-warning btn-sm update-btn" 
                                                        data-appointment='{"id": "${appointment.appointmentID}", "status": "<c:out value="${appointment.appointmentStatus}"/>", "notes": "<c:out value="${appointment.notes}"/>"}'>
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button type="button" class="btn btn-danger btn-sm delete-btn" 
                                                        data-appointment-id="${appointment.appointmentID}">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal cập nhật trạng thái -->
        <div class="modal fade" id="updateModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Cập nhật trạng thái cuộc hẹn</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="updateForm">
                            <input type="hidden" id="updateAppointmentId" name="appointmentId">
                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" id="updateStatus" name="status" required>
                                    <option value="Pending">Chờ xác nhận</option>
                                    <option value="Confirmed">Đã xác nhận</option>
                                    <option value="Completed">Hoàn thành</option>
                                    <option value="Cancelled">Đã hủy</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ghi chú</label>
                                <textarea class="form-control" id="updateNotes" name="notes" rows="3"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" onclick="updateAppointment()">Cập nhật</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            const AppointmentManager = {
                init() {
                    this.bindEvents();
                    this.setupAutoHideAlerts();
                },

                bindEvents() {
                    // Xử lý nút cập nhật
                    document.querySelectorAll('.update-btn').forEach(button => {
                        button.addEventListener('click', () => {
                            const data = JSON.parse(button.dataset.appointment);
                            this.openUpdateModal(data);
                        });
                    });

                    // Xử lý nút xóa
                    document.querySelectorAll('.delete-btn').forEach(button => {
                        button.addEventListener('click', () => {
                            const id = button.dataset.appointmentId;
                            this.confirmDelete(id);
                        });
                    });

                    // Xử lý form lọc
                    const filterForm = document.getElementById('filterForm');
                    if (filterForm) {
                        filterForm.addEventListener('submit', (e) => {
                            e.preventDefault();
                            this.filterAppointments();
                        });
                    }
                },

                openUpdateModal(data) {
                    document.getElementById('updateAppointmentId').value = data.id;
                    document.getElementById('updateStatus').value = data.status;
                    document.getElementById('updateNotes').value = data.notes;
                    const modal = new bootstrap.Modal(document.getElementById('updateModal'));
                    modal.show();
                },

                confirmDelete(id) {
                    if (confirm('Bạn có chắc chắn muốn xóa cuộc hẹn này không?')) {
                        window.location.href = 'StaffAppointmentServlet?action=delete&appointmentId=' + encodeURIComponent(id);
                    }
                },

                filterAppointments() {
                    const searchValue = document.getElementById('searchInput').value.toLowerCase();
                    const statusValue = document.getElementById('statusFilter').value;
                    const dateValue = document.getElementById('dateFilter').value;
                    
                    document.querySelectorAll('#appointmentTableBody tr').forEach(row => {
                        const customerName = row.cells[2].textContent.toLowerCase();
                        const petName = row.cells[1].querySelector('strong').textContent.toLowerCase();
                        const status = row.cells[6].textContent.trim();
                        const date = row.cells[4].textContent;
                        
                        const matchesSearch = !searchValue || customerName.includes(searchValue) || petName.includes(searchValue);
                        const matchesStatus = !statusValue || status.includes(statusValue);
                        const matchesDate = !dateValue || date.includes(dateValue);
                        
                        row.style.display = (matchesSearch && matchesStatus && matchesDate) ? '' : 'none';
                    });
                },

                setupAutoHideAlerts() {
                    document.querySelectorAll('.alert').forEach(alert => {
                        setTimeout(() => {
                            alert.classList.remove('show');
                            setTimeout(() => alert.remove(), 150);
                        }, 5000);
                    });
                }
            };

            // Khởi tạo khi trang đã tải xong
            document.addEventListener('DOMContentLoaded', () => AppointmentManager.init());
        </script>
    </body>
</html>
