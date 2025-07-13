<%@ page import="model.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Profile - Thryft</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- CSS Files -->
  <link rel="stylesheet" href="assets/css/style.css">
  <link rel="stylesheet" href="assets/css/font-awesome.css">
  <link rel="stylesheet" href="assets/css/templatemo-hexashop.css">

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
      max-width: 900px;
      margin: 30px auto;
      padding: 30px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .profile-form {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group.full-width {
      grid-column: span 2;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    .form-group input, 
    .form-group textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
    }

    .form-group textarea {
      height: 100px;
      resize: vertical;
    }

    .form-actions {
      grid-column: span 2;
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
    }

    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
      transition: 0.3s;
    }

    .btn-primary {
      background-color: #ff6f61;
      color: white;
    }

    .btn-primary:hover {
      background-color: #e05a4e;
    }

    .btn-danger {
      background-color: #dc3545;
      color: white;
    }

    .btn-danger:hover {
      background-color: #c82333;
    }

    .btn-secondary {
      background-color: #6c757d;
      color: white;
    }

    .btn-secondary:hover {
      background-color: #5a6268;
    }

    .message {
      padding: 10px;
      margin-bottom: 20px;
      border-radius: 5px;
      text-align: center;
      grid-column: span 2;
    }

    .error {
      background-color: #f8d7da;
      color: #721c24;
    }

    .success {
      background-color: #d4edda;
      color: #155724;
    }

    .back-btn-container {
      display: flex;
      justify-content: flex-end;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

  <div class="admin-header">
    <h1>User Profile</h1>
  </div>
    

  <div class="admin-container">
      <div class="back-btn-container">
      <a href="dashboard.jsp" class="btn btn-secondary">
        Back to Dashboard <i class="fa fa-arrow-right"></i>
      </a>
    </div>

    
    <% User user = (User) request.getAttribute("user"); %>
    <% String error = (String) request.getAttribute("error"); %>
    <% String success = (String) request.getAttribute("success"); %>

    <% if (error != null) { %>
        <div class="message error"><%= error %></div>
    <% } %>

    <% if (success != null) { %>
        <div class="message success"><%= success %></div>
    <% } %>

    <form class="profile-form" action="profile" method="post">
      <input type="hidden" name="action" value="update">

      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required>
      </div>

      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
      </div>

      <div class="form-group full-width">
        <label for="address">Address</label>
        <textarea id="address" name="address"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
      </div>

      <div class="form-group">
        <label for="currentPassword">Current Password</label>
        <input type="password" id="currentPassword" name="currentPassword" placeholder="Enter current password to make changes">
      </div>

      <div class="form-group">
        <label for="newPassword">New Password</label>
        <input type="password" id="newPassword" name="newPassword" placeholder="Leave blank to keep current">
      </div>

      <div class="form-actions">
        <button type="submit" class="btn btn-primary">Update Profile</button>
        <button type="button" onclick="confirmDelete()" class="btn btn-danger">Delete Account</button>
      </div>
    </form>
  </div>

  <form id="deleteForm" action="profile" method="post" style="display: none;">
    <input type="hidden" name="action" value="delete">
  </form>

  <script>
    function confirmDelete() {
      if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
        document.getElementById('deleteForm').submit();
      }
    }
  </script>
</body>
</html>
