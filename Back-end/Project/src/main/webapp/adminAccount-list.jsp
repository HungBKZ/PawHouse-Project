<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Account" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Quản Lý Tài Khoản - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #eef5f9;
                font-family: 'Arial', sans-serif;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .account-container {
                max-width: 1200px;
                margin: auto;
                background: #ffffff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                flex: 1;
            }
            .account-table th {
                background-color: #007bff;
                color: white;
                text-align: center;
            }
            .account-table td {
                vertical-align: middle;
                text-align: center;
            }
            h2 {
                color: #0056b3;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
            </div>
        </nav>

        <section class="container account-container my-5">
            <h2 class="text-center mb-4">Quản Lý Tài Khoản</h2>

            <!-- Thanh tìm kiếm -->
            <div class="mb-3">
                <form action="/admin/accounts" method="get" class="d-flex">
                    <input type="text" name="search" class="form-control me-2" placeholder="Tìm kiếm theo Username" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </form>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-hover account-table">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Role</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Hoạt Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Account> accounts = (List<Account>) request.getAttribute("accounts");
                            if (accounts != null && !accounts.isEmpty()) {
                                for (Account account : accounts) {
                        %>
                        <tr id="row-<%= account.getUserID()%>">
                            <td><%= account.getUserID()%></td>
                            <td><%= account.getRoleID()%></td>
                            <td><%= account.getUsername()%></td>
                            <td><%= account.getEmail()%></td>
                            <td id="status-<%= account.getUserID()%>">
                                <span class="badge <%= account.getUserStatus() ? "bg-success" : "bg-danger"%>">
                                    <%= account.getUserStatus() ? "Hoạt Động" : "Không hoạt động"%>
                                </span>
                            </td>
                            <td>
                                <% if (account.getRoleID() == 1) { %>
                                    <button class="btn btn-success btn-sm" disabled>Admin</button>
                                <% } else { %>
                                    <button class="btn <%= account.getUserStatus() ? "btn-danger" : "btn-success"%> btn-sm toggle-status" 
                                            data-userid="<%= account.getUserID()%>" 
                                            data-status="<%= account.getUserStatus() ? 0 : 1%>">
                                        <%= account.getUserStatus() ? "Disable" : "Enable"%>
                                    </button>
                                <% } %>
                            </td>
                        </tr>
                        <% }
                    } else { %>
                        <tr>
                            <td colspan="6" class="text-center text-danger">Không có dữ liệu tài khoản.</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </section>

        <%@ include file="includes/footer.jsp" %>

        <script>
            $(document).ready(function () {
                $(".toggle-status").click(function () {
                    var userID = $(this).data("userid");
                    var newStatus = $(this).data("status");
                    var button = $(this);

                    $.post("/admin/accounts/update-status", { userID: userID, newStatus: newStatus }, function(response) {
                        if (response === "success") {
                            var statusCell = $("#status-" + userID);
                            if (newStatus === 0) {
                                statusCell.html('<span class="badge bg-danger">Không hoạt động</span>');
                                button.removeClass("btn-danger").addClass("btn-success").text("Enable").data("status", 1);
                            } else {
                                statusCell.html('<span class="badge bg-success">Hoạt Động</span>');
                                button.removeClass("btn-success").addClass("btn-danger").text("Disable").data("status", 0);
                            }
                        } else {
                            alert("Cập nhật thất bại!");
                        }
                    });
                });
            });
        </script>
    </body>
</html>