package controller;

import DAO.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@WebServlet("/admin/accounts/update-status")
public class UpdateAccountStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            int newStatus = Integer.parseInt(request.getParameter("newStatus"));

            AccountDAO accountDAO = new AccountDAO();
            boolean updated = accountDAO.updateAccountStatus(userID, newStatus);

            if (updated) {
                out.print("success");
            } else {
                out.print("error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("error");
        }
        out.flush();
    }
}
