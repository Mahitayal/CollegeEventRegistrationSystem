# College Event Registration System
A beginner-friendly Java web application using XML configuration, Servlets, JSP, CSS, Maven, and MySQL.

## Requirements
- JDK 11+
- Eclipse IDE for Enterprise Java and Web Developers (or Eclipse with Maven support)
- Apache Tomcat 9
- MySQL 8+

## Import into Eclipse
1. Extract the downloaded ZIP (do not import the ZIP file itself).
2. In Eclipse choose **File → Import → Maven → Existing Maven Projects**.
3. Browse to the extracted `CollegeEventRegistrationSystem` folder. The `pom.xml` should be visible in that folder.
4. Click **Finish**. If dependencies do not load, right-click project → **Maven → Update Project**.

## Database setup
1. Run `database/schema.sql` in MySQL Workbench or the MySQL command line.
2. Open `src/main/java/com/collegeevent/util/DBConnection.java` and set your MySQL username/password.
3. Start Tomcat 9 and run the project on the server.

Open: `http://localhost:8080/CollegeEventRegistrationSystem/`

This project uses `javax.servlet`, so use Tomcat 9 (not Tomcat 10/11 unless you migrate the imports to `jakarta.servlet`).
