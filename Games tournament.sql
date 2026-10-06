CREATE DATABASE games;
USE games;
CREATE TABLE Cricket
(
    Player_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Role VARCHAR(30),
    Age INT,
    Runs INT,
    Sixes INT,
    Fours INT,
    Wickets INT,
    Points INT
);

INSERT INTO Cricket
(Player_ID, Name, Role, Age, Runs, Sixes, Fours, Wickets, Points)
VALUES
(1, 'Rahul', 'Batsman', 24, 1500, 56, 68, 0, 1500),
(2, 'Mahesh', 'Batsman', 27, 1200, 63, 78, 0, 1200),
(3, 'Kiran', 'Batsman', 25, 3400, 48, 56, 0, 3400),
(4, 'Ganesh', 'Bowler', 29, 650, 18, 23, 25, 650),
(5, 'Suresh', 'Bowler', 31, 340, 12, 56, 30, 340),
(6, 'Ramu', 'Bowler', 26, 750, 52, 23, 45, 750),
(7, 'Srinu', 'Batsman', 23, 4500, 69, 78, 0, 4500),
(8, 'Bala', 'Bowler', 24, 550, 25, 56, 35, 550),
(9, 'Bharani', 'Batsman', 22, 1563, 73, 83, 0, 1563),
(10, 'Moksha', 'Bowler', 21, 363, 15, 23, 45, 363),
(11, 'Raju', 'Batsman', 28, 689, 43, 52, 0, 689);

SELECT * FROM Cricket;
CREATE TABLE Kabbadi
(
    Player_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Role VARCHAR(30),
    Age INT,
    Points INT,
    SuperRaid INT,
    SuperTackle INT,
    HighFive INT,
    SuperTen INT
);

INSERT INTO Kabbadi
(Player_ID, Name, Role, Age, Points, SuperRaid, SuperTackle, HighFive, SuperTen)
VALUES
(12, 'Pardeep Narwal', 'Raider', 27, 156, 8, 0, 0, 5),
(13, 'Naveen Kumar', 'Raider', 25, 178, 12, 0, 0, 7),
(14, 'Manjeet', 'Raider', 24, 132, 6, 0, 0, 3),
(15, 'Arjun Deshwal', 'Raider', 26, 165, 10, 0, 0, 6),
(16, 'Aslam Inamdar', 'All-Rounder', 24, 124, 5, 18, 2, 3),
(17, 'Mohammadreza Chiyaneh', 'All-Rounder', 23, 148, 7, 25, 4, 4),
(18, 'Fazel Atrachali', 'Defender', 30, 82, 0, 38, 8, 0),
(19, 'Surjeet Singh', 'Defender', 28, 76, 0, 35, 7, 0);

SELECT * FROM Kabbadi;

CREATE TABLE KhoKho
(
    Player_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Role VARCHAR(30),
    Age INT,
    Points INT,
    Dives INT,
    Pole_Dive INT,
    Touches INT,
    Catches INT
);

INSERT INTO KhoKho
(Player_ID, Name, Role, Age, Points, Dives, Pole_Dive, Touches, Catches)
VALUES
(22, 'Amit Kumar', 'Attacker', 23, 125, 18, 7, 32, 14),
(23, 'Rahul Singh', 'Attacker', 24, 142, 21, 9, 38, 16),
(24, 'Vijay Sharma', 'Defender', 27, 98, 12, 5, 18, 22),
(25, 'Arjun Reddy', 'Attacker', 22, 135, 19, 8, 35, 15),
(26, 'Rohit Kumar', 'Defender', 25, 105, 14, 6, 21, 25),
(27, 'Kiran Patel', 'All-Rounder', 24, 118, 16, 7, 29, 20),
(28, 'Suresh Yadav', 'Defender', 28, 92, 11, 4, 17, 23),
(29, 'Manoj Verma', 'Attacker', 23, 130, 20, 8, 34, 13),
(30, 'Naveen Rao', 'All-Rounder', 26, 115, 15, 6, 27, 19),
(31, 'Deepak Singh', 'Defender', 29, 88, 10, 4, 15, 24);

SELECT * FROM KhoKho;

CREATE TABLE Volleyball
(
    Player_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Role VARCHAR(30),
    Age INT,
    Points INT,
    Aces INT,
    Blocks INT,
    Digs INT,
    Kills INT
);

INSERT INTO Volleyball
(Player_ID, Name, Role, Age, Points, Aces, Blocks, Digs, Kills)
VALUES
(32, 'Arjun Kumar', 'Outside Hitter', 24, 185, 12, 18, 45, 125),
(33, 'Rahul Singh', 'Setter', 25, 95, 8, 10, 52, 35),
(34, 'Vijay Sharma', 'Middle Blocker', 27, 160, 6, 42, 18, 105),
(35, 'Rohit Reddy', 'Opposite Hitter', 23, 178, 15, 25, 30, 118),
(36, 'Amit Kumar', 'Libero', 22, 72, 4, 2, 85, 5),
(37, 'Kiran Patel', 'Outside Hitter', 24, 172, 14, 20, 48, 115),
(38, 'Suresh Yadav', 'Middle Blocker', 28, 148, 5, 38, 16, 98),
(39, 'Manoj Verma', 'Setter', 23, 102, 10, 12, 58, 42),
(40, 'Naveen Rao', 'Opposite Hitter', 26, 190, 18, 27, 34, 130),
(41, 'Deepak Singh', 'Libero', 29, 68, 3, 1, 92, 4);

SELECT * FROM Volleyball;

CREATE TABLE Football
(
    Player_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Role VARCHAR(30),
    Age INT,
    Points INT,
    Goals INT,
    Assists INT,
    Shots INT,
    Tackles INT
);

INSERT INTO Football
(Player_ID, Name, Role, Age, Points, Goals, Assists, Shots, Tackles)
VALUES
(42, 'sahit kumar', 'Forward', 24, 85, 18, 9, 42, 5),
(43, 'anandh raj', 'Midfielder', 25, 72, 10, 15, 35, 28),
(44, 'Vijay patel', 'Defender', 27, 58, 4, 6, 18, 45),
(45, 'shiva reddy', 'Forward', 23, 92, 22, 11, 48, 4),
(46, 'vishal ', 'Goalkeeper', 22, 65, 0, 2, 3, 38),
(47, 'suraj ', 'Midfielder', 24, 78, 12, 18, 39, 32),
(48, 'ramesh', 'Defender', 28, 55, 3, 5, 15, 51),
(49, 'jeevan josh', 'Forward', 23, 88, 20, 8, 45, 6),
(50, 'naveed', 'Midfielder', 26, 75, 9, 17, 31, 35),
(51, 'akshay kumar', 'Defender', 29, 60, 2, 7, 14, 48);

SELECT * FROM Football;

CREATE TABLE Players
(
    Player_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Sport VARCHAR(20) NOT NULL,
    Role VARCHAR(50),
    Age INT,
    Points INT
);

-- Cricket Players
INSERT INTO Players VALUES
(1, 'Rahul', 'Cricket', 'Batsman', 24, 1500),
(2, 'Mahesh', 'Cricket', 'Batsman', 27, 1200),
(3, 'Kiran', 'Cricket', 'Batsman', 25, 3400),
(4, 'Ganesh', 'Cricket', 'Bowler', 29, 650),
(5, 'Suresh', 'Cricket', 'Bowler', 31, 340),
(6, 'Ramu', 'Cricket', 'Bowler', 26, 750),
(7, 'Srinu', 'Cricket', 'Batsman', 23, 4500),
(8, 'Bala', 'Cricket', 'Bowler', 24, 550),
(9, 'Bharani', 'Cricket', 'Batsman', 22, 1563),
(10, 'Moksha', 'Cricket', 'Bowler', 21, 363),
(11, 'Raju', 'Cricket', 'Batsman', 28, 689);

INSERT INTO Players VALUES
(12, 'Pardeep Narwal', 'Kabaddi', 'Raider', 27, 156),
(13, 'Naveen Kumar', 'Kabaddi', 'Raider', 25, 178),
(14, 'Manjeet', 'Kabaddi', 'Raider', 24, 132),
(15, 'Arjun Deshwal', 'Kabaddi', 'Raider', 26, 165),
(16, 'Aslam Inamdar', 'Kabaddi', 'All-Rounder', 24, 124),
(17, 'Mohammadreza Chiyaneh', 'Kabaddi', 'All-Rounder', 23, 148),
(18, 'Fazel Atrachali', 'Kabaddi', 'Defender', 30, 82),
(19, 'Surjeet Singh', 'Kabaddi', 'Defender', 28, 76);

INSERT INTO Players VALUES
(22, 'Amit Kumar', 'Kho-Kho', 'Attacker', 23, 125),
(23, 'Rahul Singh', 'Kho-Kho', 'Attacker', 24, 142),
(24, 'Vijay Sharma', 'Kho-Kho', 'Defender', 27, 98),
(25, 'Arjun Reddy', 'Kho-Kho', 'Attacker', 22, 135),
(26, 'Rohit Kumar', 'Kho-Kho', 'Defender', 25, 105),
(27, 'Kiran Patel', 'Kho-Kho', 'All-Rounder', 24, 118),
(28, 'Suresh Yadav', 'Kho-Kho', 'Defender', 28, 92),
(29, 'Manoj Verma', 'Kho-Kho', 'Attacker', 23, 130),
(30, 'Naveen Rao', 'Kho-Kho', 'All-Rounder', 26, 115),
(31, 'Deepak Singh', 'Kho-Kho', 'Defender', 29, 88);

INSERT INTO Players VALUES
(32, 'Arjun Kumar', 'Volleyball', 'Outside Hitter', 24, 185),
(33, 'Rahul Singh', 'Volleyball', 'Setter', 25, 95),
(34, 'Vijay Sharma', 'Volleyball', 'Middle Blocker', 27, 160),
(35, 'Rohit Reddy', 'Volleyball', 'Opposite Hitter', 23, 178),
(36, 'Amit Kumar', 'Volleyball', 'Libero', 22, 72),
(37, 'Kiran Patel', 'Volleyball', 'Outside Hitter', 24, 172),
(38, 'Suresh Yadav', 'Volleyball', 'Middle Blocker', 28, 148),
(39, 'Manoj Verma', 'Volleyball', 'Setter', 23, 102),
(40, 'Naveen Rao', 'Volleyball', 'Opposite Hitter', 26, 190),
(41, 'Deepak Singh', 'Volleyball', 'Libero', 29, 68);

INSERT INTO Players VALUES
(42, 'sahit kumar', 'Football', 'Forward', 24, 85),
(43, 'anandh raj', 'Football', 'Midfielder', 25, 72),
(44, 'Vijay patel', 'Football', 'Defender', 27, 58),
(45, 'shiva reddy', 'Football', 'Forward', 23, 92),
(46, 'vishal', 'Football', 'Goalkeeper', 22, 65),
(47, 'suraj ', 'Football', 'Midfielder', 24, 78),
(48, 'ramesh', 'Football', 'Defender', 28, 55),
(49, 'jeevan josh', 'Football', 'Forward', 23, 88),
(50, 'Naveed', 'Football', 'Midfielder', 26, 75),
(51, 'akshay kumar', 'Football', 'Defender', 29, 60);

SELECT * FROM Players;

CREATE VIEW Tournament AS
SELECT
    Player_ID,
    Name,
    Sport,
    Role,
    Age,
    Points
FROM Players
WHERE Points = (
    SELECT MAX(Points)
    FROM Players
);

SELECT * FROM Tournament;

CREATE VIEW Young_Best_Players AS
SELECT
    Player_ID,
    Name,
    Sport,
    Role,
    Age,
    Points
FROM Players
WHERE Age <= 25
AND Points >= (
    SELECT AVG(Points)
    FROM Players
);

SELECT * FROM Young_Best_Players;

SELECT
    Player_ID,
    Name,
    Sport,
    Role,
    Age,
    Points
FROM Players
ORDER BY Points DESC
LIMIT 10;

SELECT
    Player_ID,
    Name,
    Sport,
    Role,
    Age,
    Points
FROM Players
ORDER BY Age ASC, Points DESC
LIMIT 10;
SHOW TABLES;

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';