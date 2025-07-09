<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Product List</title>
    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
        }

        .admin-header {
            background-color: #2a2a2a;
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        .admin-container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .product-table th {
            background-color: #2a2a2a;
            color: white;
            padding: 15px;
            text-align: left;
        }

        .product-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
        }

        .product-table tr:hover {
            background-color: #f1f1f1;
        }

        .product-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .product-image {
            max-width: 80px;
            height: auto;
            border-radius: 4px;
        }

        .action-btn {
            display: inline-block;
            padding: 8px 15px;
            background-color: #ff6f61;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }

        .action-btn:hover {
            background-color: #e05a4e;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .add-product-btn {
            padding: 10px 20px;
            background-color: #2a2a2a;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }

        .add-product-btn:hover {
            background-color: #ff6f61;
        }
    </style>
    <script>
function confirmDelete(productName) {
    return confirm('Are you sure you want to permanently delete "' + productName + '"?\nThis action cannot be undone.');
}
</script>
</head>
<body>
    <div class="admin-header">
        <h1>Product Management</h1>
        <a href="admin.html" title="Admin Dashboard"><i class="fa fa-user" style="font-size: 20px;"></i></a>
    </div>
        
    <div class="admin-container">
            <c:if test="${not empty param.success}">
            <div style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 20px; border-radius: 4px;">
                ${param.success}
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div style="background-color: #f8d7da; color: #721c24; padding: 10px; margin-bottom: 20px; border-radius: 4px;">
                ${param.error}
            </div>
        </c:if>
        <div class="table-header">
            <h2>All Products</h2>
            <a href="addProduct.jsp" class="add-product-btn">+ Add New Product</a>
        </div>

        <table class="product-table">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td><img src="${product.imagePath}" alt="${product.name}" class="product-image"></td>
                        <td>${product.name}</td>
                        <td>RM${product.price}</td>
                        <td>${product.category}</td>
                        <td>
                        <a href="editProduct?id=${product.id}" class="action-btn">Edit</a>

                        <form action="deleteProduct" method="POST" style="display:inline;">
                            <input type="hidden" name="id" value="${product.id}">
                            <button type="submit" class="action-btn" 
                                    onclick="return confirmDelete('${product.name}')">
                                Delete
                            </button>
                        </form>
                    </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>