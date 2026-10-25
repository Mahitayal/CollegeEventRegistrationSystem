
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - College Events</title>
    

    <style>
    
    .dashboard-navigation {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    margin: 20px 0;
}

.nav-btn {
    display: inline-block;
    padding: 10px 18px;
    background-color: #2563eb;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-weight: bold;
}

.nav-btn:hover {
    background-color: #1d4ed8;
}

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f3f6fb;
            color: #222;
        }

        header {
            background: #172554;
            color: white;
            padding: 22px 6%;
        }

        header h1 {
            margin: 0;
        }

        main {
            max-width: 1150px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .cards {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 3px 12px #00000010;
            flex: 1;
            min-width: 180px;
        }

        .card p {
            color: #555;
            margin-bottom: 8px;
        }

        .card h2 {
            color: #1d4ed8;
            margin: 0;
            font-size: 32px;
        }

        .table-box {
            background: white;
            padding: 20px;
            border-radius: 12px;
            overflow-x: auto;
            box-shadow: 0 3px 12px #00000010;
        }

        input {
            padding: 10px;
            width: min(350px, 90%);
            margin: 10px 0 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            text-align: left;
            padding: 13px;
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
    </style>
</head>

<body>

<div class="dashboard-navigation">

    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-btn">🏠 Home</a>

    <a href="${pageContext.request.contextPath}/events" class="nav-btn">📅 View Events</a>

    <a href="${pageContext.request.contextPath}/admin-dashboard" class="nav-btn">🔄 Refresh Dashboard</a>
    
        <a href="${pageContext.request.contextPath}/admin-events"
   class="nav-btn">🗓️ Manage Events</a>

    <a href="${pageContext.request.contextPath}/admin-logout" class="nav-btn">🚪 Logout</a>
    

</div>


<header>
    <h1>College Event Registration</h1>
    <p>Admin Dashboard</p>
</header>

<main>

    <section class="cards">
        <div class="card">
            <p>Total Registrations</p>
            <h2><c:out value="${totalRegistrations}"/></h2>
        </div>

        <div class="card">
            <p>Total Events</p>
            <h2><c:out value="${totalEvents}"/></h2>
        </div>
    </section>

    <section class="table-box">
        <h2>Student Registrations</h2>

        <input type="text"
               id="search"
               placeholder="Search by name, email, ID or event..."
               onkeyup="filterTable()">

        <table id="registrationTable">
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Email</th>
                    <th>College ID</th>
                    <th>Event</th>
                    <th>Registration Date</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="r" items="${registrations}">
                    <tr>
                        <td><c:out value="${r.studentName}"/></td>
                        <td><c:out value="${r.email}"/></td>
                        <td><c:out value="${r.studentId}"/></td>
                        <td><c:out value="${r.eventTitle}"/></td>
                        <td><c:out value="${r.registeredAt}"/></td>
                    </tr>
                </c:forEach>

                <c:if test="${empty registrations}">
                    <tr>
                        <td colspan="5" class="empty">
                            No registrations found yet.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </section>

</main>

<script>
function filterTable() {
    const input = document.getElementById("search");
    const filter = input.value.toLowerCase();
    const rows = document.querySelectorAll("#registrationTable tbody tr");

    rows.forEach(row => {
        row.style.display =
            row.innerText.toLowerCase().includes(filter) ? "" : "none";
    });
}
</script>

</body>
</html>
