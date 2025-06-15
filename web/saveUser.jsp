<%--
  Created by IntelliJ IDEA.
  User: shasidu
  Date: 2025-06-15
  Time: 00.14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
  <meta charset="UTF-8">
  <title>Complaint Form</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">
  <h2 class="mb-4">Submit a Complaint</h2>
<form action="register" method="post">
    <input type="text" name="userId" required>
    <input type="text" name="name" required>
    <input type="password" name="password" required>
    <input type="submit" value="Register">
</form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
