package com.collegeevent.servlet;

import com.collegeevent.util.DBConnection;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class EventServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT id,title,description,event_date,venue,category FROM events ORDER BY event_date");
             ResultSet rs = ps.executeQuery()) {
            request.setAttribute("events", rs);
            request.getRequestDispatcher("/events.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Could not load events. Check MySQL settings and database setup.", e);
        }
    }
}
