
package com.collegeevent.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.collegeevent.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-event-delete")
public class AdminEventDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Verify that the admin is logged in
        HttpSession session = request.getSession(false);

        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute("adminLoggedIn"))) {

            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String id = request.getParameter("id");

        // Validate event ID
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-events?error=invalidid");
            return;
        }

        try {
            int eventId = Integer.parseInt(id);

            if (eventId <= 0) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-events?error=invalidid");
                return;
            }

            String sql = "DELETE FROM events WHERE id = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, eventId);

                int deleted = ps.executeUpdate();

                if (deleted > 0) {
                    response.sendRedirect(
                            request.getContextPath()
                            + "/admin-events?success=deleted");
                } else {
                    response.sendRedirect(
                            request.getContextPath()
                            + "/admin-events?error=notfound");
                }
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-events?error=invalidid");

        } catch (SQLException e) {

            // A database constraint may prevent deletion when
            // registrations still refer to this event.
            throw new ServletException(
                    "Unable to delete the event. It may have registrations.",
                    e);
        }
    }
}
