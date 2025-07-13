<%@ page import="java.util.*, model.bean.Product" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Thryft - Your Cart</title>

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/font-awesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-hexashop.css">
    <link rel="stylesheet" href="assets/css/owl-carousel.css">
    <link rel="stylesheet" href="assets/css/lightbox.css">

    <style>
      .section-heading {
        text-align: center;
        margin-bottom: 40px;
      }

      .item {
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        padding: 20px;
        margin-bottom: 20px;
        transition: transform 0.2s ease;
      }

      .item:hover {
        transform: translateY(-3px);
      }

      .cart-summary-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        background-color: #fff;
        border-radius: 12px;
        padding: 20px 30px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        margin: 30px auto;
      }

      .cart-summary-left p,
      .cart-summary-right h4 {
        margin: 0;
      }

      .cart-summary-right .btn-primary {
        margin-top: 10px;
        background-color: #ff6f61;
        border: none;
        padding: 10px 20px;
        border-radius: 6px;
        color: #fff;
        font-weight: bold;
        transition: background-color 0.3s ease;
      }

      .cart-summary-right .btn-primary:hover {
        background-color: #e65c4f;
      }

      .btn-secondary {
        background-color: #6c757d;
        color: white;
        padding: 10px 20px;
        border-radius: 6px;
        font-weight: 500;
        text-decoration: none;
        transition: background-color 0.3s ease;
      }

      .btn-secondary:hover {
        background-color: #5a6268;
      }
    </style>
  </head>
  <body>

    <!-- ***** Header Start ***** -->
    <%@ include file="header.jsp" %>
    <!-- ***** Header End ***** -->

    <!-- ***** Cart Section Start ***** -->
    <section class="section" id="cart" style="padding: 60px 0;">
      <div class="container">
        <div style="text-align: right; margin-bottom: 10px;">
          <a href="products" class="btn btn-secondary">
            <i class="fa fa-arrow-left"></i> Continue Shopping
          </a>
        </div>

        <div class="section-heading">
          <h2>Your Cart</h2>
          <span>Manage your selected items before checkout</span>
        </div>

        <%@ page import="model.bean.CartItem" %>
        <%
          List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
          Integer userId = (Integer) request.getAttribute("userId"); 
          double grandTotal = 0;
        %>

        <div class="row">
          <% if (cartItems == null || cartItems.isEmpty()) { %>
            <div class="col-lg-12 text-center">
              <h4>Your cart is empty.</h4>
            </div>
          <% } else {
              for (CartItem item : cartItems) {
                Product p = item.getProduct();
                int qty = item.getQuantity();
                double total = p.getPrice() * qty;
                grandTotal += total;
          %>
          <div class="col-12">
            <div class="item d-flex align-items-center">
              <div class="thumb" style="flex: 0 0 120px; margin-right: 20px; overflow: hidden;">
                <img src="<%= p.getImagePath() %>" alt="<%= p.getName() %>" style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
              </div>
              <div class="down-content" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
                <div style="flex-grow: 1;">
                  <h4><%= p.getName() %></h4>
                  <p>Category: <%= p.getCategory() %></p>
                  <p>RM <%= String.format("%.2f", p.getPrice()) %> x <%= qty %> = <strong>RM <%= String.format("%.2f", total) %></strong></p>
                </div>
                <div>
                  <form action="removeCartItem" method="POST">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Delete <%= p.getName() %>?')">
                      <i class="fa fa-trash"></i> Delete
                    </button>
                  </form>
                </div>
              </div>
            </div>
          </div>
          <% } } %>
        </div>

        <div class="cart-summary-row">
          <div class="cart-summary-left">
            <%
              String userAddress = (String) request.getAttribute("userAddress");
              if (userAddress != null && !userAddress.trim().isEmpty()) {
            %>
              <p><strong>Delivery Address:</strong> <%= userAddress %></p>
            <% } else { %>
              <p><strong>Please add a delivery address to continue with checkout.</strong></p>
            <% } %>
          </div>
          <div class="cart-summary-right">
            <h4>Total: RM <%= String.format("%.2f", grandTotal) %></h4>
            <% if (userAddress != null && !userAddress.trim().isEmpty()) { %>
              <form action="checkout" method="post">
                <input type="hidden" name="amount" value="<%= Math.round(grandTotal * 100) %>">
                <button type="submit" class="btn btn-primary">Checkout</button>
              </form>
            <% } %>
          </div>
        </div>
      </div>
    </section>

    <!-- ***** Footer Start ***** -->
    <%@ include file="footer.jsp" %>
    <!-- ***** Footer End ***** -->

    <!-- Scripts -->
    <script src="assets/js/jquery-2.1.0.min.js"></script>
    <script src="assets/js/popper.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/owl-carousel.js"></script>
    <script src="assets/js/accordions.js"></script>
    <script src="assets/js/datepicker.js"></script>
    <script src="assets/js/scrollreveal.min.js"></script>
    <script src="assets/js/waypoints.min.js"></script>
    <script src="assets/js/jquery.counterup.min.js"></script>
    <script src="assets/js/imgfix.min.js"></script>
    <script src="assets/js/slick.js"></script>
    <script src="assets/js/lightbox.js"></script>
    <script src="assets/js/isotope.js"></script>
    <script src="assets/js/custom.js"></script>
  </body>
</html>
