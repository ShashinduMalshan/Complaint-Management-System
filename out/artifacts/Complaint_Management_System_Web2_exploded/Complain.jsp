<%@ page import="com.service.model.Complain" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint</title>
</head>
<body>

<h2>Submit a Complaint</h2>

<form method="post" action="submitComplaint">

    <input type="hidden" id="id" name="id">

    <label for="userId">User ID:</label><br>
    <input type="text" id="userId" name="userId" required><br><br>

    <label for="subject">Subject:</label><br>
    <input type="text" id="subject" name="subject" required><br><br>

    <label for="description">Description:</label><br>
    <textarea id="description" name="description" rows="4" cols="50" required></textarea><br><br>

    <input type="hidden" name="status" value="Pending">
    <input type="hidden" name="remarks" value="">

    <input type="submit" value="Submit Complaint">
     <button type="submit" name="action" value="create">Add</button>
    <button type="submit" name="action" value="update">Update</button>
    <button type="submit" name="action" value="delete" onclick="return confirm('Are you sure to delete?');">Delete</button>

</form>


<hr>

<h2>All Complaints</h2>
<table border="1" cellpadding="5">
    <tr>
        <th>ID</th><th>User ID</th><th>Subject</th><th>Description</th>
        <th>Status</th><th>Remarks</th><th>Created At</th>
    </tr>
    <%
        List<Complain> list = (List<Complain>) request.getAttribute("complaints");
        if (list != null) {
            for (Complain c : list) {
    %>
 <tr style="cursor:pointer;"
        onclick="fillForm('<%= c.getId() %>','<%= c.getUserId() %>','<%= c.getSubject() %>','<%= c.getDescription() %>','<%= c.getStatus() %>','<%= c.getRemarks() %>')">
        <td><%= c.getId() %></td>
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
 <script>
        function fillForm(id, userId, subject, description, status, remarks) {
            document.getElementById('id').value = id;
            document.getElementById('userId').value = userId;
            document.getElementById('subject').value = subject;
            document.getElementById('description').value = description;
            document.getElementById('status').value = status;
            document.getElementById('remarks').value = remarks;
        }
    </script>
</body>
</html>
