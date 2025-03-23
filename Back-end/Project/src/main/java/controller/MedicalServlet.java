/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.ServiceDAO;
import Model.Service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "MedicalServlet", urlPatterns = {"/MedicalServlet"})
public class MedicalServlet extends HttpServlet {
 @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách dịch vụ từ database
        ServiceDAO serviceDAO = new ServiceDAO();
        List<Service> medicalList = serviceDAO.getServiceByType("Thú y");

        // Gửi danh sách dịch vụ đến trang JSP
        request.setAttribute("medicalList", medicalList);
        request.getRequestDispatcher("medical.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
