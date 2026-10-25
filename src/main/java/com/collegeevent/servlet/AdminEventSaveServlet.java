
package com.collegeevent.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.collegeevent.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-event-save")
public class AdminEventSaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Verify admin login
        HttpSession session = request.getSession(false);

        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute("adminLoggedIn"))) {

            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String eventDate = request.getParameter("eventDate");
        String venue = request.getParameter("venue");
        String category = request.getParameter("category");

        // Validate required fields
        if (title == null || title.trim().isEmpty()
                || eventDate == null || eventDate.trim().isEmpty()
                || venue == null || venue.trim().isEmpty()
                || category == null || category.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-events?error=missingfields");
            return;
        }

        title = title.trim();
        venue = venue.trim();
        category = category.trim();

        if (title.length() > 120 || venue.length() > 120
                || category.length() > 60
                || (description != null && description.length() > 500)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-events?error=invalidlength");
            return;
        }

        try {
            Date sqlDate = Date.valueOf(eventDate);

            try (Connection con = DBConnection.getConnection()) {

                if (id == null || id.trim().isEmpty()) {

                    // Add a new event
                    String sql = "INSERT INTO events "
                            + "(title, description, event_date, venue, category) "
                            + "VALUES (?, ?, ?, ?, ?)";

                    try (PreparedStatement ps =
                                 con.prepareStatement(sql)) {

                        ps.setString(1, title);
                        ps.setString(2,
                                description == null
                                        || description.trim().isEmpty()
                                        ? null : description.trim());
                        ps.setDate(3, sqlDate);
                        ps.setString(4, venue);
                        ps.setString(5, category);

                        ps.executeUpdate();
                    }

                    response.sendRedirect(
                            request.getContextPath()
                            + "/admin-events?success=added");

                } else {

                    // Update an existing event
                    int eventId = Integer.parseInt(id);

                    String sql = "UPDATE events SET "
                            + "title = ?, description = ?, event_date = ?, "
                            + "venue = ?, category = ? WHERE id = ?";

                    try (PreparedStatement ps =
                                 con.prepareStatement(sql)) {

                        ps.setString(1, title);
                        ps.setString(2,
                                description == null
                                        || description.trim().isEmpty()
                                        ? null : description.trim());
                        ps.setDate(3, sqlDate);
                        ps.setString(4, venue);
                        ps.setString(5, category);
                        ps.setInt(6, eventId);

                        int updated = ps.executeUpdate();

                        if (updated == 0) {
                            response.sendRedirect(
                                    request.getContextPath()
                                    + "/admin-events?error=notfound");
                            return;
                        }
                    }

                    response.sendRedirect(
                            request.getContextPath()
                            + "/admin-events?success=updated");
                }
            }

        } catch (IllegalArgumentException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-events?error=invaliddate");

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to save the event.", e);
        }
    }
}
