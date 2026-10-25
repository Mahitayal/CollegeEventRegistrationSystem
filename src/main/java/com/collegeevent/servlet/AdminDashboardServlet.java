
package com.collegeevent.servlet;

import com.collegeevent.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
    	
    	HttpSession session = request.getSession(false);

    	if (session == null
    	        || !Boolean.TRUE.equals(session.getAttribute("adminLoggedIn"))) {

    	    response.sendRedirect(
    	        request.getContextPath() + "/admin-login.jsp"
    	    );
    	    return;
    	}

        List<Map<String, String>> registrations = new ArrayList<>();

        int totalRegistrations = 0;
        int totalEvents = 0;

        try (Connection con = DBConnection.getConnection()) {

            // Count registrations
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM registrations");
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalRegistrations = rs.getInt(1);
                }
            }

            // Count events
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM events");
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalEvents = rs.getInt(1);
                }
            }

            // Get registration details
            String sql =
                "SELECT r.student_name, r.student_email, " +
                "r.student_id, e.title, r.registered_at " +
                "FROM registrations r " +
                "JOIN events e ON r.event_id = e.id " +
                "ORDER BY r.registered_at DESC";

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, String> row = new HashMap<>();

                    row.put("studentName", rs.getString("student_name"));
                    row.put("email", rs.getString("student_email"));
                    row.put("studentId", rs.getString("student_id"));
                    row.put("eventTitle", rs.getString("title"));
                    row.put("registeredAt",
                            rs.getString("registered_at"));

                    registrations.add(row);
                }
            }

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load the admin dashboard.", e);
        }

        request.setAttribute("totalRegistrations", totalRegistrations);
        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("registrations", registrations);

        request.getRequestDispatcher("/admin-dashboard.jsp")
               .forward(request, response);
    }
}

