CREATE DATABASE IF NOT EXISTS poomsae_judging;
USE poomsae_judging;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('judge', 'admin') NOT NULL DEFAULT 'judge',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tournaments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  date DATE,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE rounds (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tournament_id INT,
  name VARCHAR(100),
  FOREIGN KEY (tournament_id) REFERENCES tournaments(id) ON DELETE CASCADE
);

CREATE TABLE athletes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  country VARCHAR(100),
  age INT
);

CREATE TABLE round_athletes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  round_id INT,
  athlete_id INT,
  poomsae_type VARCHAR(100),
  FOREIGN KEY (round_id) REFERENCES rounds(id) ON DELETE CASCADE,
  FOREIGN KEY (athlete_id) REFERENCES athletes(id) ON DELETE CASCADE
);

CREATE TABLE scores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  round_athlete_id INT,
  judge_id INT,
  technical_score DECIMAL(3,1),
  presentation_score DECIMAL(3,1),
  submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (round_athlete_id) REFERENCES round_athletes(id) ON DELETE CASCADE,
  FOREIGN KEY (judge_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE final_scores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  round_athlete_id INT,
  avg_technical DECIMAL(4,2),
  avg_presentation DECIMAL(4,2),
  total_score DECIMAL(5,2),
  FOREIGN KEY (round_athlete_id) REFERENCES round_athletes(id) ON DELETE CASCADE
);
