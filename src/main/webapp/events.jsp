<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Events | CampusConnect</title><link rel="stylesheet" href="css/style.css"></head><body>
<header class="topbar"><a class="brand" href="index.jsp">Campus<span>Connect</span></a><nav><a href="index.jsp">Home</a><a class="active" href="events">Events</a></nav></header>
<main class="page"><p class="eyebrow">WHAT’S HAPPENING</p><h1 class="page-title">Find your next <span>favorite.</span></h1><p class="lead">Choose an event and register to be part of the action.</p>
<div class="event-grid"><%
ResultSet events = (ResultSet) request.getAttribute("events");
while (events != null && events.next()) {
 int id=events.getInt("id"); String title=events.getString("title"); String desc=events.getString("description");
 String date=events.getString("event_date"); String venue=events.getString("venue"); String category=events.getString("category");
%><article class="event-card"><div class="event-art"><span><%= category %></span><strong>✳</strong></div><div class="event-info"><p class="event-date"><%= date %> · <%= venue %></p><h2><%= title %></h2><p><%= desc == null ? "" : desc %></p>
<form action="register-form.jsp" method="get"><input type="hidden" name="eventId" value="<%= id %>"><input type="hidden" name="eventTitle" value="<%= title.replace("&","&amp;").replace("\"","&quot;") %>"><button class="button small" type="submit">Register now →</button></form></div></article><% } %></div>
<% if (events == null) { %><p>No events loaded. Please check your database setup.</p><% } %></main><footer>Made for campus life <span>© College Event Registration</span></footer></body></html>
