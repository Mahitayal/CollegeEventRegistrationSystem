
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Events | CampusConnect</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fb;
            color: #222;
        }

        header {
            background: #172554;
            color: white;
            padding: 22px 6%;
        }

        main {
            max-width: 1150px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .navigation {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }

        .btn {
            display: inline-block;
            padding: 11px 17px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            cursor: pointer;
            font-size: 14px;
        }

        .btn:hover {
            background: #1d4ed8;
        }

        .panel {
            background: white;
            padding: 22px;
            border-radius: 12px;
            box-shadow: 0 3px 12px #00000010;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 13px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #eff6ff;
        }

        .empty {
            padding: 25px;
            text-align: center;
            color: #666;
        }

        .message {
            padding: 12px;
            margin-bottom: 18px;
            border-radius: 6px;
        }

        .success-message {
            background: #dcfce7;
            color: #166534;
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
        }

        .description {
            max-width: 300px;
            overflow-wrap: anywhere;
        }

        .delete-btn {
            background: #dc2626;
        }

        .delete-btn:hover {
            background: #b91c1c;
        }

        .actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .actions form {
            display: inline;
            margin: 0;
        }
    </style>
</head>

<body>

<header>
    <h1>CampusConnect</h1>
    <p>Admin Event Management</p>
</header>

<main>

    <div class="navigation">

        <a class="btn"
           href="${pageContext.request.contextPath}/admin-dashboard">
            ← Admin Dashboard
        </a>

        <a class="btn"
           href="${pageContext.request.contextPath}/index.jsp">
            🏠 Home
        </a>

        <a class="btn"
           href="${pageContext.request.contextPath}/admin-logout">
            🚪 Logout
        </a>

    </div>

    <section class="panel">

        <h2>Manage Events</h2>

        <%-- Success messages --%>

        <c:if test="${param.success == 'added'}">
            <div class="message success-message">
                Event added successfully!
            </div>
        </c:if>

        <c:if test="${param.success == 'updated'}">
            <div class="message success-message">
                Event updated successfully!
            </div>
        </c:if>

        <c:if test="${param.success == 'deleted'}">
            <div class="message success-message">
                Event deleted successfully!
            </div>
        </c:if>

        <%-- Error messages --%>

        <c:if test="${param.error == 'notfound'}">
            <div class="message error-message">
                The requested event was not found.
            </div>
        </c:if>

        <c:if test="${param.error == 'invalidid'}">
            <div class="message error-message">
                Invalid event ID.
            </div>
        </c:if>

        <c:if test="${param.error == 'missingfields'}">
            <div class="message error-message">
                Please fill in all required fields.
            </div>
        </c:if>

        <c:if test="${param.error == 'invalidlength'}">
            <div class="message error-message">
                One or more fields exceed the allowed length.
            </div>
        </c:if>

        <c:if test="${param.error == 'invaliddate'}">
            <div class="message error-message">
                Please enter a valid event date.
            </div>
        </c:if>

        <p>
            Use this page to view and manage the events stored in your database.
        </p>

        <a class="btn"
           href="${pageContext.request.contextPath}/admin-event-form">
            ➕ Add New Event
        </a>

        <br><br>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Venue</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="event" items="${events}">
                    <tr>

                        <td>
                            <c:out value="${event.id}"/>
                        </td>

                        <td>
                            <c:out value="${event.title}"/>
                        </td>

                        <td class="description">
                            <c:out value="${event.description}"/>
                        </td>

                        <td>
                            <c:out value="${event.eventDate}"/>
                        </td>

                        <td>
                            <c:out value="${event.venue}"/>
                        </td>

                        <td>
                            <c:out value="${event.category}"/>
                        </td>

                        <td>
                            <div class="actions">

                                <%-- Edit event --%>

                                <a class="btn"
                                   href="${pageContext.request.contextPath}/admin-event-form?id=${event.id}">
                                    Edit
                                </a>

                                <%-- Delete event --%>

                                <form
                                    action="${pageContext.request.contextPath}/admin-event-delete"
                                    method="post"
                                    onsubmit="return confirm('Are you sure you want to delete this event?');">

                                    <input type="hidden"
                                           name="id"
                                           value="${event.id}">

                                    <button type="submit"
                                            class="btn delete-btn">
                                        Delete
                                    </button>

                                </form>

                            </div>
                        </td>

                    </tr>
                </c:forEach>

                <c:if test="${empty events}">
                    <tr>
                        <td colspan="7" class="empty">
                            No events found.
                        </td>
                    </tr>
                </c:if>

            </tbody>
        </table>

    </section>

</main>

</body>
</html>
