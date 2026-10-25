
package com.collegeevent.servlet;

import com.collegeevent.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("studentName");
        String email = request.getParameter("studentEmail");
        String studentId = request.getParameter("studentId");
        String eventId = request.getParameter("eventId");

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || studentId == null || studentId.trim().isEmpty()
                || eventId == null || eventId.trim().isEmpty()) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Please complete all fields."
            );
            return;
        }

        name = name.trim();
        email = email.trim();
        studentId = studentId.trim();

        try {
            int eventIdNumber = Integer.parseInt(eventId);

            try (Connection con = DBConnection.getConnection()) {

                // Check whether this student has already
                // registered for this event.
                String checkSql =
                    "SELECT id FROM registrations " +
                    "WHERE student_email = ? " +
                    "AND student_id = ? AND event_id = ?";

                try (PreparedStatement checkPs =
                         con.prepareStatement(checkSql)) {

                    checkPs.setString(1, email);
                    checkPs.setString(2, studentId);
                    checkPs.setInt(3, eventIdNumber);

                    try (ResultSet rs = checkPs.executeQuery()) {
                        if (rs.next()) {
                            showDuplicateMessage(response);
                            return;
                        }
                    }
                }

                // Insert registration if no duplicate exists.
                String insertSql =
                    "INSERT INTO registrations " +
                    "(student_name, student_email, student_id, event_id) " +
                    "VALUES (?, ?, ?, ?)";

                try (PreparedStatement insertPs =
                         con.prepareStatement(insertSql)) {

                    insertPs.setString(1, name);
                    insertPs.setString(2, email);
                    insertPs.setString(3, studentId);
                    insertPs.setInt(4, eventIdNumber);

                    insertPs.executeUpdate();
                }
            }

            response.sendRedirect(
                request.getContextPath() + "/success.jsp"
            );

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid event selected."
            );

        } catch (SQLException e) {

            // The database unique constraint also protects
            // against duplicate submissions arriving together.
            if ("23000".equals(e.getSQLState())) {
                showDuplicateMessage(response);
            } else {
                throw new ServletException(
                    "Registration failed. Please check the database.",
                    e
                );
            }
        }
    }

    private void showDuplicateMessage(HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html;charset=UTF-8");

        response.getWriter().println(
            "<!DOCTYPE html>" +
            "<html><head><title>Already Registered</title></head>" +
            "<body style='font-family:Arial;text-align:center;" +
            "padding:50px;'>" +
            "<h2>You have already registered for this event!</h2>" +
            "<p>You cannot register for the same event twice.</p>" +
            "<a href='events'>Back to Events</a>" +
            "</body></html>"
        );
    }
}
