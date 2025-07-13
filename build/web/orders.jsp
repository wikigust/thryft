<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Orders</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Your Orders</h2>
    <%
        List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm a");
    %>
    <%
        if (orders == null || orders.isEmpty()) {
    %>
        <div class="alert alert-info">You have no orders yet.</div>
    <%
        } else {
    %>
        <table class="table table-bordered">
            <thead class="thead-light">
            <tr>
                <th>#</th>
                <th>Product</th>
                <th>Quantity</th>
                <th>Total Price (RM)</th>
                <th>Status</th>
                <th>Ordered At</th>
            </tr>
            </thead>
            <tbody>
            <% for (Map<String, Object> order : orders) { %>
                <tr>
                    <td><%= order.get("id") %></td>
                    <td><%= order.get("product_name") %></td>
                    <td><%= order.get("quantity") %></td>
                    <td><%= String.format("%.2f", order.get("total_price")) %></td>
                    <td><%= order.get("status") %></td>
                    <td><%= sdf.format(order.get("created_at")) %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <%
        }
    %>
</div>
</body>
</html>
