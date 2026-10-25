
package com.collegeevent.servlet;

import com.collegeevent.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-events")
public class AdminEventsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether the admin is logged in
        HttpSession session = request.getSession(false);

        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute("adminLoggedIn"))) {

            response.sendRedirect(
                    request.getContextPath() + "/admin-login.jsp");
            return;
        }

        // Store all events retrieved from the database
        List<Map<String, Object>> events = new ArrayList<>();

        String sql = "SELECT id, title, description, event_date, "
                   + "venue, category "
                   + "FROM events "
                   + "ORDER BY event_date ASC, id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Map<String, Object> event = new HashMap<>();

                event.put("id", rs.getInt("id"));
                event.put("title", rs.getString("title"));
                event.put("description",
                          rs.getString("description"));
                event.put("eventDate",
                          rs.getDate("event_date"));
                event.put("venue", rs.getString("venue"));
                event.put("category", rs.getString("category"));

                events.add(event);
            }

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load events for the admin page.", e);
        }

        // Make the event list available to admin-events.jsp
        request.setAttribute("events", events);

        // Display the event management page
        request.getRequestDispatcher("/admin-events.jsp")
               .forward(request, response);
    }
}
