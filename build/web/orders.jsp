<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Orders - Thryft</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Nerd Font or Icon CSS (optional) -->

    <!-- Custom Style to Match user.jsp -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
        }

        .page-header {
            background-color: #2a2a2a;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }

        table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .alert {
            background-color: #d9edf7;
            color: #31708f;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
            text-align: center;
        }

        .btn-back {
            display: inline-block;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn-back:hover {
            background-color: #5a6268;
        }

        .back-wrapper {
            text-align: right;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="page-header">
        <h1><i class="fa fa-box"></i> Your Orders</h1>
    </div>

    <div class="container">
        <div class="back-wrapper">
            <a href="dashboard.jsp" class="btn-back">Back to Dashboard →</a>
        </div>

        <%
            List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");
            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm a");
        %>

        <%
            if (orders == null || orders.isEmpty()) {
        %>
            <div class="alert">You have no orders yet.</div>
        <%
            } else {
        %>
            <table>
                <thead>
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
