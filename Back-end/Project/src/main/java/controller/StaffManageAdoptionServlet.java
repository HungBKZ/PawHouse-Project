package controller;

import DAO.AdoptionDAO;
import Model.AdoptionHistory;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "StaffManageAdoptionServlet", urlPatterns = {"/staffManageAdoption"})
public class StaffManageAdoptionServlet extends HttpServlet {

    private AdoptionDAO adoptionDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        adoptionDAO = new AdoptionDAO();
        System.out.println("StaffManageAdoptionServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Processing GET request to /staffManageAdoption");
        
        String status = request.getParameter("status");
        String dateStr = request.getParameter("date");
        String successMsg = request.getParameter("success");
        String errorMsg = request.getParameter("error");
        
        System.out.println("Filter parameters - status: " + status + ", date: " + dateStr);
        
        List<AdoptionHistory> adoptions;
        
        try {
            // Get adoptions based on filters
            if (status != null && !status.isEmpty() || dateStr != null && !dateStr.isEmpty()) {
                System.out.println("Getting filtered adoptions");
                adoptions = adoptionDAO.getFilteredAdoptions(status, dateStr);
            } else {
                System.out.println("Getting all adoptions");
                adoptions = adoptionDAO.getAllAdoptions();
            }
            
            System.out.println("Found " + (adoptions != null ? adoptions.size() : 0) + " adoptions");
            
            // Set messages for user feedback
            if (successMsg != null) {
                request.setAttribute("successMessage", "Cập nhật trạng thái nhận nuôi thành công!");
            }
            if (errorMsg != null) {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật trạng thái nhận nuôi!");
            }
            
            request.setAttribute("adoptions", adoptions);
            request.getRequestDispatcher("/staffManageAdoption.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra khi tải danh sách nhận nuôi");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Processing POST request to /staffManageAdoption");
        
        String action = request.getParameter("action");
        int adoptionId = Integer.parseInt(request.getParameter("adoptionId"));
        String notes = request.getParameter("notes");
        
        System.out.println("Action: " + action + ", AdoptionID: " + adoptionId);
        
        String status = "";
        boolean success = false;
        
        try {
            if ("approve".equals(action)) {
                status = "Approved";
                // First update adoption status
                success = adoptionDAO.updateAdoptionStatus(adoptionId, status, notes);
                if (success) {
                    // Then update pet status if adoption update was successful
                    success = adoptionDAO.updatePetAdoptionStatus(adoptionId, "Đã nhận nuôi");
                }
            } else if ("reject".equals(action)) {
                status = "Rejected";
                success = adoptionDAO.updateAdoptionStatus(adoptionId, status, notes);
                if (success) {
                    // Reset pet status to available if rejection was successful
                    success = adoptionDAO.updatePetAdoptionStatus(adoptionId, "Chưa nhận nuôi");
                }
            }
            
            System.out.println("Update " + (success ? "successful" : "failed") + " for adoption " + adoptionId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/staffManageAdoption?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/staffManageAdoption?error=true");
            }
        } catch (Exception e) {
            System.out.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/staffManageAdoption?error=true");
        }
    }
}