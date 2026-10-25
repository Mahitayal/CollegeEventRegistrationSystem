<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CampusConnect | College Events</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="topbar">
    <a class="brand" href="index.jsp">Campus<span>Connect</span></a>

    <nav>
        <a href="index.jsp">Home</a>
        <a href="events">Events</a>
        <a href="${pageContext.request.contextPath}/admin-dashboard">Admin</a>
    </nav>
</header>

<main>
    <section class="hero">
        <div class="hero-copy">
            <p class="eyebrow">YOUR CAMPUS. YOUR MOMENT.</p>

            <h1>Make memories.<br>
                <span>Find your people.</span>
            </h1>

            <p class="lead">
                Discover campus events, explore your interests, and save your spot in just a few clicks.
            </p>

            <a class="button" href="events">
                Explore events <span aria-hidden="true">→</span>
            </a>
        </div>

        <div class="hero-card">
            <div class="orb"></div>

            <div class="event-chip">✦ CAMPUS HIGHLIGHTS</div>

            <div class="card-content">
                <p>COMING TOGETHER</p>

                <h2>Big ideas.<br>Good energy.</h2>

                <div class="card-bottom">
                    <span>Discover · Connect · Create</span>
                    <span>✳</span>
                </div>
            </div>
        </div>
    </section>

    <section class="features">
        <div>
            <span class="feature-icon">◎</span>
            <h3>Find your thing</h3>
            <p>From tech talks to cultural nights, there’s something for everyone.</p>
        </div>

        <div>
            <span class="feature-icon">↗</span>
            <h3>Save your spot</h3>
            <p>Register for events easily with a simple student sign-up.</p>
        </div>

        <div>
            <span class="feature-icon">✳</span>
            <h3>Be part of it</h3>
            <p>Meet people, try something new, and make campus count.</p>
        </div>
    </section>
</main>

<footer>
    Made for campus life
    <span>© College Event Registration</span>
</footer>

</body>
</html>