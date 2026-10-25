<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Login | CampusConnect</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #eef2ff, #dbeafe);
        }

        .login-container {
            width: 90%;
            max-width: 400px;
            padding: 35px;
            background: white;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
        }

        .login-container h1 {
            margin-top: 0;
            margin-bottom: 10px;
            color: #1e3a8a;
            text-align: center;
        }

        .subtitle {
            margin-bottom: 25px;
            color: #64748b;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #334155;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 15px;
        }

        input:focus {
            outline: 2px solid #93c5fd;
            border-color: #2563eb;
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #2563eb;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="login-container">
        <h1>Admin Login</h1>
        <p class="subtitle">CampusConnect Administration</p>
        
        <% if ("1".equals(request.getParameter("logout"))) { %>
    <p style="color: #15803d; text-align: center;">
        You have been logged out successfully.
    </p>
<% } %>

        <% if ("1".equals(request.getParameter("error"))) { %>
    <p style="color: #dc2626; text-align: center;">
        Invalid username or password. Please try again.
    </p>
<% } %>

        <form action="${pageContext.request.contextPath}/admin-login" method="post">
            <label for="username">Username</label>
            <input type="text" id="username" name="username"
                   placeholder="Enter admin username" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   placeholder="Enter admin password" required>

            <button type="submit">Login</button>
        </form>

        <a class="back-link"
           href="${pageContext.request.contextPath}/index.jsp">
            ← Back to Home
        </a>
    </div>

</body>
</html>