/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.ProductDAO;
import Model.Product;
import Model.ProductCategories;
import java.io.IOException;
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
//@WebServlet("/RoomServlet")
@WebServlet(name = "ProductServlet", urlPatterns = {"/Product", "/product"})
public class ProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ProductDAO dao = new ProductDAO();
        
        // Get all categories for the filter dropdown
        List<ProductCategories> categories = dao.getAllCategories();
        request.setAttribute("categories", categories);
        System.out.println("Number of categories loaded: " + (categories != null ? categories.size() : "null"));
        
        // Get filtered products based on category if selected
        String categoryParam = request.getParameter("category");
        List<Product> productList;
        
        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                System.out.println("Filtering by category ID: " + categoryId);
                productList = dao.getProductsByCategory(categoryId);
                System.out.println("Found " + (productList != null ? productList.size() : "null") + " products in category " + categoryId);
            } catch (NumberFormatException e) {
                System.out.println("Invalid category ID format: " + categoryParam);
                productList = dao.getAll();
            }
        } else {
            System.out.println("No category filter, showing all products");
            productList = dao.getAll();
        }
        
        request.setAttribute("listP", productList);
        System.out.println("Total products being displayed: " + (productList != null ? productList.size() : "null"));
        
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        
        if (action.equals("/product")) {
            // Handle product detail page
            String productIdStr = request.getParameter("id");
            if (productIdStr != null && !productIdStr.isEmpty()) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    ProductDAO productDAO = new ProductDAO();
                    
                    // Get product details
                    Product product = productDAO.getProductById(productId);
                    
                    if (product != null) {
                        // Get related products from same category
                        List<Product> relatedProducts = productDAO.getProductsByCategory(product.getCategory().getCategoryID());
                        
                        request.setAttribute("product", product);
                        request.setAttribute("relatedProducts", relatedProducts);
                        request.getRequestDispatcher("ProductDetail.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            // If product not found or invalid ID, redirect to products page
            response.sendRedirect("products.jsp");
        } else {
            // Handle other product-related actions
            processRequest(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
