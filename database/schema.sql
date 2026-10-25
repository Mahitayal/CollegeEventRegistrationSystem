CREATE DATABASE IF NOT EXISTS college_event_db;
USE college_event_db;

CREATE TABLE IF NOT EXISTS events (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(120) NOT NULL,
  description VARCHAR(500),
  event_date DATE NOT NULL,
  venue VARCHAR(120) NOT NULL,
  category VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS registrations (
  id INT PRIMARY KEY AUTO_INCREMENT,
  student_name VARCHAR(120) NOT NULL,
  student_email VARCHAR(160) NOT NULL,
  student_id VARCHAR(40) NOT NULL,
  event_id INT NOT NULL,
  registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_registration_event FOREIGN KEY (event_id) REFERENCES events(id)
);

INSERT INTO events (title, description, event_date, venue, category) VALUES
('TechFest 2026', 'A day of coding, innovation, and technology.', '2026-11-18', 'Main Auditorium', 'Technology'),
('Cultural Night', 'Celebrate music, dance, and campus creativity.', '2026-11-25', 'Open Air Theatre', 'Cultural'),
('Startup Showcase', 'Meet student founders and explore new ideas.', '2026-12-03', 'Seminar Hall A', 'Business');
