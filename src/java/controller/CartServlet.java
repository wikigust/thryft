package controller;

import model.bean.CartItem;
import model.bean.DatabaseConnection;
import model.bean.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // Handle Add to Cart
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try {
            Connection conn = DatabaseConnection.initializeDatabase();

            // Check if item already in cart
            String checkSql = "SELECT quantity FROM cart_items WHERE user_id=? AND product_id=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Update quantity
                int existingQty = rs.getInt("quantity");
                String updateSql = "UPDATE cart_items SET quantity=? WHERE user_id=? AND product_id=?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setInt(1, existingQty + quantity);
                updateStmt.setInt(2, userId);
                updateStmt.setInt(3, productId);
                updateStmt.executeUpdate();
                updateStmt.close();
            } else {
                // Insert new item
                String insertSql = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, productId);
                insertStmt.setInt(3, quantity);
                insertStmt.executeUpdate();
                insertStmt.close();
            }

            rs.close();
            checkStmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect to cart page after adding item
        // Forward back to products.jsp with success message
        request.setAttribute("cartSuccess", true);
        response.sendRedirect("products?cartSuccess=true");

    }

    // Display Cart Page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> cartItems = new ArrayList<>();

        try {
            Connection conn = DatabaseConnection.initializeDatabase();

            String sql = "SELECT ci.quantity, p.* FROM cart_items ci JOIN products p ON ci.product_id = p.id WHERE ci.user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setName(rs.getString("NAME"));
                p.setPrice(rs.getDouble("PRICE"));
                p.setImagePath(rs.getString("IMAGE_PATH"));
                p.setCategory(rs.getString("CATEGORY"));

                int quantity = rs.getInt("quantity");

                cartItems.add(new CartItem(p, quantity));
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        String cartSuccess = request.getParameter("cartSuccess");
        if ("true".equals(cartSuccess)) {
            request.setAttribute("cartSuccess", true);
        }


        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
