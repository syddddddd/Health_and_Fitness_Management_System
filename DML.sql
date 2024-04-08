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
('Harley', 'Parker', 'Harley@gmail.com', '647-932-4276', 'harhar', 'har123');

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

-- Populate FitnessFile Table
INSERT INTO FitnessFiles (member_id, goal_weight, distance, goal_time)
VALUES 
(1, 220, 5, '01:00:00'),
(2, 140, 10, '01:30:00'),
(3, 145, 2, '00:30:00');

-- Populate HealthMetrics Table
INSERT INTO HealthMetrics (member_id, hours_slept, curr_weight, height, calories_consummed)
VALUES 
(1, 7, 230, 66, 1985),
(2, 8, 155, 72, 2543),
(3, 4, 168, 74, 2122);

-- Populate HealthMetrics Table
INSERT INTO HealthStatistics (member_id, hours_slept, curr_weight, height, calories_consummed)
VALUES 
(1, 7, 230, 66, 1985),
(2, 8, 155, 72, 2543),
(3, 4, 168, 74, 2122);

-- Populate Equipment Table
INSERT INTO Equipment (equip_name, model_year)
VALUES 
('mats', '2023-01-01'),
('treadmill', '2021-01-01'),
('eliptical', '2022-01-01'),
('weights', '2019-01-01'),
('rower', '2017-01-01'),
('indoor bike', '2016-01-01');

-- Populate Exercise Table
INSERT INTO Exercises (exercise, equipment_id, info)
VALUES 
('sit-ups', 1, 'Sets of 5 sit-ups'),
('push-ups', 1, 'Sets of 10 push-ups'),
('treadmill', 2, 'Running for 30 minutes'),
('eliptical', 3, 'Using the eliptical for 20 minutes'),
('weights', 4, 'Lift different weights for 5 sets'),
('rowing', 5, 'Rowing for 20 minutes'),
('cycling', 6, 'Use the indoor bicycle for 30 minutes');

-- Populate Equipment Table
INSERT INTO MemberRoutines (member_id, exercise_id)
VALUES 
(1, 1),
(1, 4),
(1, 3),
(2, 6),
(2, 2),
(3, 5),
(3, 6);

INSERT INTO RoomBooking (room_id, day, start_time, end_time)
VALUES
(1, 'Tuesday', '8:30')
(4, 'Monday', '16:00')
(4, 'Tuesday', '9:00')
(5, 'Friday', '11:00')