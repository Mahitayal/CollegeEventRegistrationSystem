
package com.collegeevent.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.collegeevent.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-event-form")
public class AdminEventFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin login
        HttpSession session = request.getSession(false);

        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute("adminLoggedIn"))) {

            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String id = request.getParameter("id");

        // No ID means the admin wants to add a new event
        if (id == null || id.trim().isEmpty()) {
            request.setAttribute("formTitle", "Add New Event");
            request.getRequestDispatcher("/admin-event-form.jsp")
                   .forward(request, response);
            return;
        }

        // An ID means the admin wants to edit an existing event
        try {
            int eventId = Integer.parseInt(id);

            String sql = "SELECT id, title, description, event_date, "
                       + "venue, category FROM events WHERE id = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, eventId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        request.setAttribute("eventId",
                                rs.getInt("id"));
                        request.setAttribute("title",
                                rs.getString("title"));
                        request.setAttribute("description",
                                rs.getString("description"));
                        request.setAttribute("eventDate",
                                rs.getDate("event_date"));
                        request.setAttribute("venue",
                                rs.getString("venue"));
                        request.setAttribute("category",
                                rs.getString("category"));

                        request.setAttribute("formTitle",
                                "Edit Event");

                        request.getRequestDispatcher(
                                "/admin-event-form.jsp")
                               .forward(request, response);

                    } else {
                        response.sendRedirect(
                                request.getContextPath()
                                + "/admin-events?error=notfound");
                    }
                }
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-events?error=invalidid");

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load event details.", e);
        }
    }
}
