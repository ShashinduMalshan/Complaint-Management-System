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
            /*background: rgba(255, 255, 255, 0.15);*/
            backdrop-filter: blur(10px);
            padding: 1.5rem;
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 1550px;
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
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
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

        .form-control, .select-control {
            padding: 0.9rem 1rem 0.9rem 1rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 0.9rem;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .select-control {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="rgba(255,255,255,0.5)" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 0 top 50%;
        }

        .form-control:focus, .select-control:focus {
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

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        /* Optional hover effect */
        .btn-success:hover {
            background: linear-gradient(135deg, #218838, #1e9b7f);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
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
            max-width: 1550px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeIn 0.8s ease-out;
            overflow-x: auto;
            max-height: 750px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            min-width: 1135px;
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

        @media (max-width: 480px) {
            .container, .table-container {
                margin: 1.5rem;
                padding: 2rem 1.5rem;
            }

            .header h1 {
                font-size: 1.5rem;
            }

            .form-control, .select-control {
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
            <h1>Admin Panel</h1>
            <p>Manage user complaints and admin accounts</p>
        </div>


        <form method="post" action="admin">
            <input type="hidden" id="id" name="id">
            <input type="hidden" id="status" name="status">
            <input type="hidden" id="remarks" name="remarks">
            <input type="hidden" id="action" name="action">


            <div class="button-group">
                <button type="submit" name="action" value="addAdmin" class="btn btn-primary">Add Admin</button>
                <button class="btn-danger btn" onclick="window.location.href='LoginPage.jsp'">Logout</button>
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
                <th>Action</th>
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
                <%
                    String status = c.getStatus() != null ? c.getStatus().trim().toLowerCase() : "";
                %>
                <td>
                    <div class="form-group">
                        <label for="status_<%= c.getComId() %>">
                            <span class="icon status-icon"></span>
                            Status
                        </label>
                        <select id="status_<%= c.getComId() %>" name="status" class="select-control" onchange="document.getElementById('status').value = this.value;">
                            <option value="pending" <%= status.equals("pending") ? "selected=\"selected\"" : "" %>>Pending</option>
                            <option value="processing" <%= status.equals("processing") ? "selected=\"selected\"" : "" %>>Processing</option>
                            <option value="resolved" <%= status.equals("resolved") ? "selected=\"selected\"" : "" %>>Resolved</option>
                        </select>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <label for="remarks_<%= c.getComId() %>">
                            <span class="icon remarks-icon"></span>
                            Remarks
                        </label>
                        <input type="text" id="remarks_<%= c.getComId() %>" name="remarks" class="form-control"
                               value="<%= (c.getRemarks() != null) ? c.getRemarks() : "" %>"
                               onchange="document.getElementById('remarks').value = this.value;">
                    </div>
                </td>
                <td><%= c.getCreatedAt() %></td>
                <td>
                    <div class="button-group">

                        <button type="button" class="logout-btn btn-success" onclick="updateComplaint('<%= c.getComId() %>')">Update</button>
                        <button type="button" class="logout-btn btn-danger" onclick="deleteComplaint('<%= c.getComId() %>')">Delete</button>
                    </div>
                </td>
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
            document.getElementById('status').value = status;
            document.getElementById('remarks').value = remarks;
        }

        function updateComplaint(id) {
            const statusValue = document.getElementById('status_' + id).value;
            const remarksValue = document.getElementById('remarks_' + id).value;

            document.getElementById('id').value = id;
            document.getElementById('status').value = statusValue;
            document.getElementById('remarks').value = remarksValue;
            document.getElementById('action').value = 'update';

            document.forms[0].submit();
        }


        function deleteComplaint(id) {
            if (confirm("Are you sure you want to delete this complaint?")) {
                const statusValue = document.getElementById('status_' + id).value;

                document.getElementById('id').value = id;
                document.getElementById('status').value = statusValue;
                document.getElementById('action').value = 'delete';

                document.forms[0].submit();
            }
        }



    </script>
</body>
</html>