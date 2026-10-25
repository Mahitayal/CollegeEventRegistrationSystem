
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>${formTitle}</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px 15px;
            font-family: Arial, sans-serif;
            background: #f3f4f6;
            color: #1f2937;
        }

        .container {
            max-width: 650px;
            margin: 20px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        h1 {
            margin-top: 0;
            text-align: center;
            color: #1d4ed8;
        }

        label {
            display: block;
            margin: 18px 0 7px;
            font-weight: bold;
        }

        input, textarea, select {
            width: 100%;
            padding: 11px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 15px;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        button, .back-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
        }

        button {
            background: #2563eb;
            color: white;
        }

        button:hover {
            background: #1d4ed8;
        }

        .back-btn {
            background: #e5e7eb;
            color: #111827;
        }

        .error {
            color: #b91c1c;
            margin-top: 12px;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>${formTitle}</h1>

    <form action="${pageContext.request.contextPath}/admin-event-save"
          method="post">

        <input type="hidden"
               name="id"
               value="${eventId}">

        <label for="title">Event Title *</label>
        <input type="text"
               id="title"
               name="title"
               maxlength="120"
               value="${title}"
               required>

        <label for="description">Description</label>
        <textarea id="description"
                  name="description"
                  maxlength="500">${description}</textarea>

        <label for="eventDate">Event Date *</label>
        <input type="date"
               id="eventDate"
               name="eventDate"
               value="${eventDate}"
               required>

        <label for="venue">Venue *</label>
        <input type="text"
               id="venue"
               name="venue"
               maxlength="120"
               value="${venue}"
               required>

        <label for="category">Category *</label>
        <select id="category" name="category" required>
            <option value="">-- Select Category --</option>

            <option value="Technical"
                ${category == 'Technical' ? 'selected' : ''}>
                Technical
            </option>

            <option value="Cultural"
                ${category == 'Cultural' ? 'selected' : ''}>
                Cultural
            </option>

            <option value="Sports"
                ${category == 'Sports' ? 'selected' : ''}>
                Sports
            </option>

            <option value="Workshop"
                ${category == 'Workshop' ? 'selected' : ''}>
                Workshop
            </option>

            <option value="Other"
                ${category == 'Other' ? 'selected' : ''}>
                Other
            </option>
        </select>

        <div class="buttons">
            <button type="submit">Save Event</button>

            <a class="back-btn"
               href="${pageContext.request.contextPath}/admin-events">
                Cancel
            </a>
        </div>

    </form>

</div>

</body>
</html>
