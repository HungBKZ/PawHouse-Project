package controller;

import DAO.AccountDAO;
import Model.Account;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/accounts")
public class AdminAccountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        AccountDAO accountDAO = new AccountDAO();
        List<Account> accounts = accountDAO.getAllAccounts();

        // Debug kiểm tra số lượng tài khoản lấy được
        System.out.println("Số lượng tài khoản: " + (accounts != null ? accounts.size() : "null"));

        request.setAttribute("accounts", accounts);
        request.getRequestDispatcher("/adminAccount-list.jsp").forward(request, response);
    }
}
