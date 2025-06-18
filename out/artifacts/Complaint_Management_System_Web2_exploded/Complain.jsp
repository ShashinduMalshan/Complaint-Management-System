<%--
  Created by IntelliJ IDEA.
  User: shasidu
  Date: 2025-06-16
  Time: 00:45
  Enhanced UI version for Submit Complaint with Scrollable Table, Non-Transparent Table Header, ID/Username in Same Row, and Logout Button
--%>
<%@ page import="com.service.model.Complain" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Complaint - Complaint Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 2rem;
            overflow-x: hidden;
        }

        .container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 2.5rem;
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 800px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeIn 0.8s ease-out;
            margin-bottom: 2rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }

        .header h1 {
            color: #fff;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
        }

        .logout-btn {
            position: absolute;
            top: 0;
            right: 0;
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }





        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .flex-group {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .flex-group .form-group {
            flex: 1;
            min-width: 200px;
        }

        .form-group label {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
            font-size: 0.85rem;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }

        .form-control {
            width: 100%;
            padding: 0.9rem 1rem 0.9rem 2.5rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 0.9rem;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .form-control:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.2);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff6b6b, #ff8e53);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }

        .btn-primary::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        .btn-primary:hover::after {
            left: 100%;
        }

        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
        }

        .table-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 1000px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeIn 0.8s ease-out;
            overflow-x: auto;
            max-height: 500px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            min-width: 800px;
            border-collapse: collapse;
            color: #fff;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }

        th {
            background: #2c3e50;
            font-weight: 600;
            font-size: 0.9rem;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        tr {
            cursor: pointer;
            transition: background 0.3s ease;
            background: none;
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .icon {
            position: absolute;
            left: 0.8rem;
            top: 2.5rem;
            width: 1.2rem;
            height: 1.2rem;
            background-size: contain;
            background-repeat: no-repeat;
            opacity: 0.7;
        }

        .user-icon {
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0iI2ZmZmZmZiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTEyIDEyQzE0LjIwOTEgMTIgMTYgMTAuMjA5MSAxNiA4QzE2IDUuNzkwODYgMTQuMjA5MSA0IDEyIDRDOS43OTA4NiA0IDggNS43OTA4NiA4IDhDOCAxMC4yMDkxIDkuNzkwODYgMTIgMTIgMTJaIiBmaWxsPSIjZmZmZmZmIi8+CjxwYXRoIGQ9Ik0xMiAxNEM5LjMzIDEzLjk5IDcgMTYuMzIgNyAxOVYyMEg3QzEwLjMzIDIwIDEzLjY3IDIwIDE3IDIwVjE5QzE3IDE2LjMzIDE0LjY3IDE0IDE0LjAxIDE0QzEzLjMzIDE0IDEyLjY3IDE0IDEyIDE0WiIgZmlsbD0iI2ZmZmZmZiIvPgo8L3N2Zz4K');
        }

        .subject-icon {
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTMgM0g1VjVIM1YzeiBNMyAxMUg1VjEzSDNWMTE7IE0zIDE5SDVWMjFIM1YxOTsgTTcgM0g5VjVIN1V6IE03IDExSDlWMTNIN1YxMTsgTTcgMTlIOVYyMUg3VjE5OyBNMTEgM0gxM1Y1SDE1VjNIMTNaIE0xMSAxMUgxM1YxM0gxNVYxMUgxM1Y5SDE3VjExSDE1VjEzSDE3VjE1SDEzVjEzSDE1VjExSDEzVjdIMTVWMTFIMTFWMTNaIE0xMSAxOUgxM1YyMUgxNVYxOUgxM1YxN0gxNVYxOUgxM1YxNUgxN1YxOUgxM1YyMUgxMVYxOXoiIGZpbGw9IiNmZmZmZmYiLz4KPC9zdmc+Cg==');
        }

        .description-icon {
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTMgM0g5VjVIM1YzeiBNMyAxMUg5VjEzSDNWMTE7IE0zIDE5SDlWMjFIM1YxOTsgTTEzIDNIMTVWNUgxM1YzOyBNMTMgMTFIMTVWMTNIMTVWMTFIMTNaIE0xMyAxOUgxNVYyMUgxM1YxOXoiIGZpbGw9IiNmZmZmZmYiLz4KPC9zdmc+Cg==');
        }

        .required {
            color: #ff6b6b;
            font-size: 0.8rem;
        }

        @media (max-width: 480px) {
            .container, .table-container {
                margin: 1.5rem;
                padding: 2rem 1.5rem;
            }

            .header h1 {
                font-size: 1.5rem;
            }

            .form-control {
                padding: 0.8rem 1rem 0.8rem 2.2rem;
            }

            .icon {
                top: 2.3rem;
                left: 0.7rem;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            th, td {
                padding: 0.8rem;
                font-size: 0.85rem;
            }

            .flex-group {
                flex-direction: column;
            }

            .logout-btn {
                position: static;
                width: 100%;
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Submit a Complaint</h1>
            <p>File a new complaint or manage existing ones</p>
            <button class="logout-btn" onclick="window.location.href='LoginPage.jsp'">Logout</button>
        </div>
        <%
//            String userId = request.getParameter("id");
//            String username = request.getParameter("name");
            String username = (String) session.getAttribute("name");
            String userId = (String) session.getAttribute("id");
        %>

        <form method="post" action="submitComplaint">
            <input type="hidden" id="id" name="id">
            <input type="hidden" id="status" name="status">
            <input type="hidden" id="remarks" name="remarks">

            <div class="flex-group">
                <div class="form-group">
                    <label for="userId">
                        <span class="icon user-icon"></span>
                        ID <span class="required">*</span>
                    </label>
                    <input type="text" id="userId" name="userId" class="form-control" value="<%= userId != null ? userId : "" %>" readonly>
                </div>
                <div class="form-group">
                    <label for="username">
                        <span class="icon user-icon"></span>
                        Username <span class="required">*</span>
                    </label>
                    <input type="text" id="username" name="username" class="form-control" value="<%= username != null ? username : "" %>" readonly>
                </div>
            </div>

            <div class="form-group">
                <label for="subject">
                    <span class="icon subject-icon"></span>
                    Subject <span class="required">*</span>
                </label>
                <input type="text" id="subject" name="subject" class="form-control" required placeholder="Enter complaint subject">
            </div>

            <div class="form-group">
                <label for="description">
                    <span class="icon description-icon"></span>
                    Description <span class="required">*</span>
                </label>
                <textarea id="description" name="description" class="form-control" required placeholder="Describe your complaint"></textarea>
            </div>

            <input type="hidden" name="role" value="<%= username != null ? username : "" %>">

            <div class="button-group">
                <button type="submit" name="action" value="create" class="btn btn-primary">Add</button>
                <button type="submit" name="action" value="update" class="btn btn-primary">Update</button>
                <button type="submit" name="action" value="delete" class="btn btn-danger" onclick="return confirm('Are you sure to delete?');">Delete</button>
            </div>
        </form>
    </div>

    <div class="table-container">
        <div class="header">
            <h1>All Complaints</h1>
            <p>Click on a complaint to edit</p>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>User ID</th>
                <th>Subject</th>
                <th>Description</th>
                <th>Status</th>
                <th>Remarks</th>
                <th>Created At</th>
            </tr>
            <%
                List<Complain> list = (List<Complain>) request.getAttribute("complaints");
                if (list != null) {
                    for (Complain c : list) {
            %>
            <tr style="cursor:pointer;"
                onclick="fillForm('<%= c.getComId() %>','<%= c.getUserId() %>','<%= c.getSubject() %>','<%= c.getDescription() %>','<%= c.getStatus() %>','<%= c.getRemarks() %>')">
                <td><%= c.getComId() %></td>
                <td><%= c.getUserId() %></td>
                <td><%= c.getSubject() %></td>
                <td><%= c.getDescription() %></td>
                <td><%= c.getStatus() %></td>
                <td><%= c.getRemarks() %></td>
                <td><%= c.getCreatedAt() %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>

    <script>
        function fillForm(id, userId, subject, description, status, remarks) {
            document.getElementById('id').value = id;
            document.getElementById('userId').value = userId;
            document.getElementById('subject').value = subject;
            document.getElementById('description').value = description;
            document.getElementById('status').value = status;
            document.getElementById('remarks').value = remarks;
            // Keep the username as is - don't clear it
        }
    </script>
</body>
</html>
