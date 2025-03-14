package controller;

import DAO.ProductDAO;
import DAO.ProductCommentDAO;
import Model.Product;
import Model.ProductComment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/ProductDetail"})
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("id");
        
        if (productIdStr != null && !productIdStr.isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr);
                ProductDAO productDAO = new ProductDAO();
                ProductCommentDAO commentDAO = new ProductCommentDAO();
                
                // Get product details
                Product product = productDAO.getProductById(productId);
                
                if (product != null) {
                    // Get related products from same category
                    List<Product> relatedProducts = productDAO.getProductsByCategory(
                        product.getCategory().getCategoryID());
                    
                    // Remove current product from related products
                    relatedProducts.removeIf(p -> p.getProductID() == productId);
                    
                    // Get product comments
                    List<ProductComment> comments = commentDAO.getCommentsByProductId(productId);
                    int reviewCount = comments.size();
                    
                    request.setAttribute("product", product);
                    request.setAttribute("relatedProducts", relatedProducts);
                    request.setAttribute("comments", comments);
                    request.setAttribute("reviewCount", reviewCount);
                    request.getRequestDispatcher("ProductDetail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        // If product not found or invalid ID, redirect to products page
        response.sendRedirect("products.jsp");
    }
}
