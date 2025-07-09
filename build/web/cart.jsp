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
    
    <title>Hexashop - Product Listing Page</title>


    <!-- Additional CSS Files -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">

    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">

    <link rel="stylesheet" href="assets/css/templatemo-hexashop.css">

    <link rel="stylesheet" href="assets/css/owl-carousel.css">

    <link rel="stylesheet" href="assets/css/lightbox.css">
<!--

TemplateMo 571 Hexashop

https://templatemo.com/tm-571-hexashop

-->
    </head>
    
    <body>
    
    <!-- ***** Preloader Start ***** -->
    <div id="preloader">
        <div class="jumper">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>  
    <!-- ***** Preloader End ***** -->
    
    
    <!-- ***** Header Area Start ***** -->
    <header class="header-area header-sticky">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav class="main-nav">
                        <!-- ***** Logo Start ***** -->
                        <a href="index.html" class="logo">
                            <img src="assets/images/logo.png">
                        </a>
                        <!-- ***** Logo End ***** -->
                        <!-- ***** Menu Start ***** -->
                        <ul class="nav">
                            <li class="scroll-to-section"><a href="#top" class="active">Home</a></li>
                            <li class="scroll-to-section"><a href="#men">Men's</a></li>
                            <li class="scroll-to-section"><a href="#women">Women's</a></li>
                            <li><a href="products">Products</a></li>
                            <%
                                String user = (String) session.getAttribute("username");
                                if (user != null) {
                            %>
                                <li>
                                    <a href="cart">
                                        <i class='fas fa-cart-plus' style='font-size:18px; padding-bottom:0px; padding-top: 10px; margin-bottom: 0px;'></i>
                                    </a>
                                </li>
                                <li>
                                    <a href="dashboard.jsp" title="User Dashboard">
                                        <i class="fa fa-user" style="font-size: 20px;"></i> <!-- Font Awesome Icon -->
                                    </a>
                                </li>
                            <%
                                } else {
                            %>
                                <li><a href="login.jsp">Login</a></li>
                            <%
                                }
                            %>
                        </ul>        
                        <!-- ***** Menu End ***** -->
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- ***** Header Area End ***** -->
    
    <!-- ***** Products Area Starts ***** -->
    <section class="section" id="products">
        <div class="container" style="margin-top:30px;">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>Your Cart</h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <%@ page import="model.bean.CartItem, model.bean.Product" %>
            <%
                List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                double grandTotal = 0;
            %>

            <div class="row" style="" >
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
                <div class="col-12 mb-4">
                    <div class="item d-flex align-items-center" style="border: 1px solid #ddd; border-radius: 8px; margin-top:0px; margin-bottom:0px; padding: 15px;">
                        <div class="thumb" style="flex: 0 0 120px; margin-right: 20px;">
                            <img src="<%= p.getImagePath() %>" alt="<%= p.getName() %>" style="width: 160px; height: 160px; object-fit: cover; border-radius: 6px;">
                        </div>
                        <div class="down-content">
                            <h4 style="margin: 0;"><%= p.getName() %></h4>
                            <p style="margin: 5px 0;">Category: <%= p.getCategory() %></p>
                            <p style="margin: 0;">RM <%= String.format("%.2f", p.getPrice()) %> x <%= qty %> = <strong>RM <%= String.format("%.2f", total) %></strong></p>
                        </div>
                    </div>
                </div>
                <% } %>

                <div class="col-lg-12 text-right mt-4">
                    <h4>Total: RM <%= String.format("%.2f", grandTotal) %></h4>
                    <!-- Add checkout or continue shopping buttons if needed -->
                    <form action="checkout" method="post">
                        <%
                            long grandTotalInSen = Math.round(grandTotal * 100);
                        %>
                        <input type="hidden" name="amount" value="<%= grandTotalInSen %>">
                        <button type="submit" class="btn btn-primary">Checkout</button>
                    </form>
                </div>
                <% } %>
            </div>

        </div>
    </section>
    <!-- ***** Products Area Ends ***** -->
    
    <!-- ***** Footer Start ***** -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="first-item">
                        <div class="logo">
                            <img src="assets/images/white-logo.png" alt="hexashop ecommerce templatemo">
                        </div>
                        <ul>
                            <li><a href="#">16501 Collins Ave, Sunny Isles Beach, FL 33160, United States</a></li>
                            <li><a href="#">hexashop@company.com</a></li>
                            <li><a href="#">010-020-0340</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3">
                    <h4>Shopping &amp; Categories</h4>
                    <ul>
                        <li><a href="#">Men’s Shopping</a></li>
                        <li><a href="#">Women’s Shopping</a></li>
                        <li><a href="#">Kid's Shopping</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h4>Useful Links</h4>
                    <ul>
                        <li><a href="#">Homepage</a></li>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Help</a></li>
                        <li><a href="#">Contact Us</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h4>Help &amp; Information</h4>
                    <ul>
                        <li><a href="#">Help</a></li>
                        <li><a href="#">FAQ's</a></li>
                        <li><a href="#">Shipping</a></li>
                        <li><a href="#">Tracking ID</a></li>
                    </ul>
                </div>
                <div class="col-lg-12">
                    <div class="under-footer">
                        <p>Copyright © 2022 HexaShop Co., Ltd. All Rights Reserved. 
                        
                        <br>Design: <a href="https://templatemo.com" target="_parent" title="free css templates">TemplateMo</a></p>
                        <ul>
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            <li><a href="#"><i class="fa fa-behance"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    

    <!-- jQuery -->
    <script src="assets/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script src="assets/js/popper.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Plugins -->
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
    
    <!-- Global Init -->
    <script src="assets/js/custom.js"></script>

  </body>

</html>
<style>
    .thumb img {
    width: 360px;      /* Or whatever size fits your layout */
    height: 360px;
    object-fit: cover; /* Ensures image fills the box while maintaining crop */
    border-radius: 8px; /* Optional: rounded corners */
}

</style>
