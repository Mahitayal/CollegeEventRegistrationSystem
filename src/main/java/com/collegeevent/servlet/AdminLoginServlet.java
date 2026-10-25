package com.collegeevent.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Demo credentials for local development.
    // Replace these with secure credential storage before deployment.
    private static final String ADMIN_USERNAME = "";
    private static final String ADMIN_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null
                && ADMIN_USERNAME.equals(username)
                && ADMIN_PASSWORD.equals(password)) {

            // Create a new session after successful login.
            HttpSession oldSession = request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("adminLoggedIn", Boolean.TRUE);
            session.setMaxInactiveInterval(30 * 60);

            response.sendRedirect(
                request.getContextPath() + "/admin-dashboard"
            );

        } else {
            response.sendRedirect(
                request.getContextPath() + "/admin-login.jsp?error=1"
            );
        }
    }
}