<%-- 
    Document   : userList
    Created on : Jul 6, 2025, 8:55:09 PM
    Author     : tr45h
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Management</title>
    <script>
    function confirmDelete(username) {
        return confirm('Are you sure you want to permanently delete "' + username + '"?\nThis action cannot be undone.');
    }
    </script>
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
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .user-table th {
            background-color: #2a2a2a;
            color: white;
            padding: 12px;
            text-align: left;
        }
        .user-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .user-table tr:hover {
            background-color: #f1f1f1;
        }
        .admin-badge {
            background-color: #28a745;
            color: white;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
        }
        .action-btn {
            display: inline-block;
            padding: 6px 12px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 5px;
            font-size: 14px;
        }
        .action-btn:hover {
            opacity: 0.9;
        }
        .delete-btn {
            background-color: #dc3545;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>

<body>
    <div class="admin-header">
        <h1>User Management</h1>
    </div>

    <div class="admin-container">
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">
                ${param.success}
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">
                ${param.error}
            </div>
        </c:if>

        <table class="user-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>
                            <c:if test="${user.admin}">
                                <span class="admin-badge">Admin</span>
                            </c:if>
                            <c:if test="${not user.admin}">
                                User
                            </c:if>
                        </td>
                        <td>
                            <a href="editUser?id=${user.id}" class="action-btn">Edit</a>
                            <form action="deleteUser" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="${user.id}">
                                <button type="submit" class="action-btn delete-btn" 
                                        onclick="return confirm('Are you sure you want to delete ${user.username}?')">
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