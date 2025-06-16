<%--
  Created by IntelliJ IDEA.
  User: shasidu
  Date: 2025-06-16
  Time: 01:11
  Enhanced UI version for registration page
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Complaint Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 2.5rem;
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .register-header h1 {
            color: #fff;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .register-header p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
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

        .register-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #ff6b6b, #ff8e53);
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }

        .register-btn::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        .register-btn:hover::after {
            left: 100%;
        }

        .form-footer {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-footer p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.85rem;
            margin-bottom: 0.5rem;
        }

        .form-footer a {
            color: #ff6b6b;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .form-footer a:hover {
            color: #ff8e53;
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
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTEyIDEyQzE0LjIwOTEgMTIgMTYgMTAuMjA5MSAxNiA4QzE2IDUuNzkwODYgMTQuMjA91IDQgMTIgNEM5Ljc5MDg2IDQgOCAwNS43OTA4NiA4IDhDOCAxMC4yMDkxIDkuNzkwODYgMTIgMTIgMTJaIiBmaWxsPSIjZmZmZmZmIi8+CjxwYXRoIGQ9Ik0xMiAxNEM5LjMzIDEzLjk5IDcgMTYuMzIgNyAxOVYyMEg3QzEwLjMzIDIwIDEzLjY3IDIwIDE3IDIwVjE5QzE3IDE2LjMzIDE0LjY3IDE0IDE0LjAxIDE0QzEzLjM0IDE0IDEyLjY3IDE0IDEyIDE0WiIgZmlsbD0iI2ZmZmZmZiIvPgo8L3N2Zz4K');
        }

        .id-icon {
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTMgN0MyLjQ0NzcyIDcgMiA3LjQ0NzcyIDIgOFYxNkMyIDE2LjU1MjMgMi40NDc3MiAxNyAzIDE3SDIxQzIxLjU1MjMgMTcgMjIgMTYuNTUyMyAyMiAxNlY4QzIyIDcuNDQ3NzIgMjEuNTUyMyA3IDIxIDdIM1pNNSAxMVYxM0g3VjExSDVaTTkgMTFWMTNIMTFWMTFIOVpNMTMgMTFWMTNIMTVWMTFIMTNaTTE3IDExVjEzSDE5VjExSDE3WiIgZmlsbD0iI2ZmZmZmZiIvPgo8L3N2Zz4K');
        }

        .lock-icon {
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTYgMTBWOEM2IDUuNzkgNy43OSA0IDEwIDRIMTRDMTYuMjEgNCA4IDUuNzkgMTggOFYxMCIgc3Ryb2tlPSIjZmZmZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPgo8cGF0aCBkPSJNNSAxMEMzLjM0IDEwIDMuMzQgMjAgNSAyMEgxOUMyMC42NiAyMCAyMC42NiAxMCAxOSAxMEg1WiIgZmlsbD0iI2ZmZmZmZiIvPgo8L3N2Zz4K');
        }

        .error-message {
            background: rgba(231, 76, 60, 0.2);
            color: #ffcccc;
            padding: 0.8rem 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(231, 76, 60, 0.3);
            font-size: 0.85rem;
            text-align: center;
            animation: shake 0.3s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .required {
            color: #ff6b6b;
            font-size: 0.8rem;
        }

        @media (max-width: 480px) {
            .register-container {
                margin: 1.5rem;
                padding: 2rem 1.5rem;
            }

            .register-header h1 {
                font-size: 1.5rem;
            }

            .form-control {
                padding: 0.8rem 1rem 0.8rem 2.2rem;
            }

            .icon {
                top: 2.3rem;
                left: 0.7rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h1>Create Account</h1>
            <p>Join the Complaint Management System</p>
        </div>

        <%-- Display error message if exists --%>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <div class="error-message">
            <%= errorMessage %>
        </div>
        <%
            }
        %>

        <form action="register" method="post">

            <div class="form-group">
                <label for="name">
                    <span class="icon user-icon"></span>
                    Name <span class="required">*</span>
                </label>
                <input type="text" id="name" name="name" class="form-control" required placeholder="Enter your name">
            </div>

            <div class="form-group">
                <label for="password">
                    <span class="icon lock-icon"></span>
                    Password <span class="required">*</span>
                </label>
                <input type="password" id="password" name="password" class="form-control" required placeholder="Enter your password">
            </div>

            <button type="submit" class="register-btn">
                Register
            </button>
        </form>

        <div class="form-footer">
            <p>Already have an account? <a href="LoginPage.jsp">Sign in here</a></p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>