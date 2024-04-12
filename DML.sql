-- Populate Members Table
INSERT INTO Members (fname, lname, email, phone_number, gender, username, password)
VALUES 
('Ari', 'Rubin', 'ari.rubin@binboy.com', '647-222-3333', 'male', 'arriba', 'ari123'),
('Patrick', 'Wu', 'PatWu@WuHoo.ca', '416-823-4412', 'male', 'KrabbyPatty', 'pat123'),
('Kensley', 'Schonauer', 'Kenslay@middleville.com', '647-727-3345', 'female', 'kenslay', 'ken123');

-- Populate Trainers Table
INSERT INTO Trainers (fname, lname, email, phone_number, gender, username, password)
VALUES 
('Jason', 'Derulo', 'Derulo@gmail.com', '647-142-4534', 'male', 'jason', 'jas123'),
('Zendaya', 'Lastname', 'Zendaya@gmail.com', '416-432-9878', 'female', 'zendaya', 'zen123'),
('Bethany', 'Robinson', 'Robbie@gmail.com', '647-191-1732', 'female', 'beth', 'beth123');

-- Populate Admins Table
INSERT INTO Admins (fname, lname, email, phone_number, username, password)
VALUES 
('Doug', 'Dimmadome', 'Doug@Dimmadome.enterprises', '647-467-3322', 'digdug', 'dug123'),
('Rick', 'Man', 'Man@gmail.com', '416-777-5355', 'rick', 'rick123'),
('Harley', 'Parker', 'Harley@gmail.com', '647-932-4276', 'harhar', 'har123'),
('Sarah', 'Cruickshank', 'CruickedTeeth@gmail.com', '416-787-1486', 'sarahnWrap', 'sar123');

-- Populate Scehdule Table
INSERT INTO Schedule (trainer_id, day, start_time, end_time, session_type, availability)
VALUES 
(3, 'Monday', '16:00', '18:00', 'group', true),
(3, 'Tuesday', '8:30', '10:00', 'private', false),
(2, 'Tuesday', '9:00', '10:30', 'private', false),
(1, 'Friday', '11:00', '13:00', 'private', true),
(1, 'Tuesday', '10:00', '13:00', 'group', true);

-- Populate ScehduledMembers Table
INSERT INTO ScheduledMembers (schedule_id, trainer_id, member_id)
VALUES 
(1, 3, 1),
(1, 3, 2),
(2, 3, 3),
(3, 1, 2),
(5, 1, 3),
(5, 1, 1);

-- Populate FitnessGoals Table
INSERT INTO FitnessGoals (member_id, goal_weight, goal_calories, goal_sleep)
VALUES 
(1, 145, 2100, 8),
(2, 140, 2000, 7),
(3, 150, 2300, 9);

-- Populate HealthMetrics Table
INSERT INTO HealthMetrics (member_id, hours_slept, curr_weight, height, calories_consummed)
VALUES 
(1, 7, 230, 66, 1985),
(2, 8, 155, 72, 2543),
(3, 4, 168, 74, 2122);

-- Populate HealthStatistics Table
INSERT INTO HealthStatistics (member_id, hours_slept, curr_weight, height, calories_consummed)
VALUES 
(1, 7, 230, 66, 1985),
(2, 8, 155, 72, 2543),
(3, 4, 168, 74, 2122);

-- Populate Equipment Table
INSERT INTO Equipment (equip_name, model_year)
VALUES 
('Mats', '2023-01-01'),
('Treadmill', '2021-01-01'),
('Eliptical', '2022-01-01'),
('Weights', '2019-01-01'),
('Rower', '2017-01-01'),
('Indoor bike', '2016-01-01');

-- Populate Exercises Table
INSERT INTO Exercises (exercise, equipment_id)
VALUES 
('Sit-ups', 1),
('Push-ups', 1),
('Treadmill', 2),
('Eliptical', 3),
('Weights', 4),
('Rowing', 5),
('Cycling', 6);

-- Populate MemberRoutines Table
INSERT INTO MemberRoutines (member_id, exercise_id, reps, distance)
VALUES 
(1, 1, 5, NULL),
(1, 4, NULL, 2),
(1, 3, NULL, 3),
(2, 6, NULL, 2),
(2, 2, 10, NULL),
(3, 5, 8, NULL),
(3, 7, NULL, 2);

-- Populate FitnessAchievements Table
INSERT INTO FitnessAchievements(member_id, achievement, achievement_date)
VALUES
(1, 'Finished exercise routine Eliptical with distance 1km using the equipment: Eliptical', '2024-04-10 08:30:00'),
(1, 'Finished exercise routine Cycling with distance 0.5km using the equipment: Indoor bike', '2024-04-09 17:30:00'),
(2, 'Finished exercise routine Weights with 7 reps using the equipment: Weights', '2024-04-08 09:27:00'),
(3, 'Finished exercise routine Sit-ups with 3 reps using the equipment: Mats', '2024-04-07 14:30:00');

-- Populate TrainerAvailability Table
INSERT INTO TrainerAvailability (trainer_id, day, start_time, end_time)
VALUES
(1, 'Sunday', '0:00', '0:00'),
(1, 'Monday', '0:00', '0:00'),
(1, 'Tuesday', '11:00', '20:00'),
(1, 'Wednesday', '12:00', '20:00'),
(1, 'Thursday', '0:00', '0:00'),
(1, 'Friday', '10:00', '19:00'),
(1, 'Saturday', '11:00', '20:00'),

(2, 'Sunday', '7:00', '15:00'),
(2, 'Monday', '8:00', '17:00'),
(2, 'Tuesday', '9:00', '16:00'),
(2, 'Wednesday', '9:00', '16:00'),
(2, 'Thursday', '9:00', '16:00'),
(2, 'Friday', '0:00', '0:00'),
(2, 'Saturday', '7:00', '13:00'),

(3, 'Sunday', '13:00', '20:00'),
(3, 'Monday', '12:00', '20:00'),
(3, 'Tuesday', '8:00', '17:00'),
(3, 'Wednesday', '0:00', '0:00'),
(3, 'Thursday', '13:00', '20:00'),
(3, 'Friday', '7:00', '12:00'),
(3, 'Saturday', '10:00', '18:00');

-- Populate Maintenace Table
INSERT INTO Maintenance (equipment_id, last_checkup)
VALUES
(1, '2024-01-01'),
(2, '2024-02-13'),
(3, '2024-03-06'),
(4, '2024-02-25'),
(5, '2024-01-02'),
(6, '2024-02-22');

-- Populate Rooms Table
INSERT INTO Rooms (room_num, availability)
VALUES
(1, true),
(2, true),
(3, true),
(4, true),
(5, true),
(6, true),
(7, true),
(8, true),
(9, true),
(10, true),
(11, true),
(12, true),
(13, true),
(14, true),
(15, true),
(16, true),
(17, true),
(18, true),
(19, true),
(20, true),
(21, true),
(22, true),
(23, true),
(24, true),
(25, true),
(26, true),
(27, true),
(28, true),
(29, true),
(30, true);

-- Populate Prices Table
INSERT INTO Prices (session_type, price) 
VALUES
('group', 10),
('private', 20),

-- Populate Billing Table
INSERT INTO Billing (member_id, type, fee)
VALUES
(1, 'member fee', 50),
(2, 'member fee', 50),
(3, 'member fee', 50);