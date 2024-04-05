-- Populate Members Table
INSERT INTO Members (member_id, fname, lname, email, phone_number, gender, username, password)
VALUES 
(1, 'Ari', 'Rubin', 'ari.rubin@binboy.com', '647-222-3333', 'male', 'arriba', 'ari123'),
(2, 'Patrick', 'Wu', 'PatWu@WuHoo.ca', '416-823-4412', 'male', 'KrabbyPatty', 'pat123'),
(3, 'Kensley', 'Schonoaur', 'Kenslay@middleville.com', '647-727-3345', 'female', 'kenslay', 'ken123');

-- Populate Trainers Table
INSERT INTO Trainers (trainer_id, fname, lname, email, phone_number, gender, username, password)
VALUES 
(1, 'Jason', 'Derulo', 'Derulo@gmail.com', '647-142-4534', 'male', 'jason', 'jas123'),
(2, 'Zendaya', 'Lastname', 'Zendaya@gmail.com', '416-432-9878', 'female', 'zendaya', 'zen123'),
(3, 'Bethany', 'Robinson', 'Robbie@gmail.com', '647-191-1732', 'female', 'beth', 'beth123');

-- Populate Admins Table
INSERT INTO Admins (admin_id, fname, lname, email, phone_number, username, password)
VALUES 
(1, 'Doug', 'Dimmadome', 'Doug@Dimmadome.enterprises', '647-467-3322', 'digdug', 'dug123'),
(2, 'Rick', 'Man', 'Man@gmail.com', '416-777-5355', 'rick', 'rick123'),
(3, 'Harley', 'Parker', 'Harley@gmail.com', '647-932-4276', 'harhar', 'har123');

-- Populate Scehdule Table
INSERT INTO Schedule (schedule_id, trainer_id, day, time_slot, session_type, availability)
VALUES 
(1, 3, 'Monday', '16:00', 'group', true),
(2, 3, 'Tuesday', '8:30', 'private', false),
(3, 1, 'Tuesday', '9:00', 'private', false),
(4, 2, 'Friday', '11:00', 'private', true);

-- Populate ScehduledMembers Table
INSERT INTO ScheduledMembers (schedule_id, member_id)
VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 2);

-- Populate FitnessFile Table
INSERT INTO FitnessFile (member_id, avg_sleep, height, curr_weight, goal_weight, distance, goal_time)
VALUES 
(1, 8, 170, 200, 220, 5, 20),
(2, 5, 155, 150, 140, 10, 60),
(3, 9, 180, 140, 145, 7, 45);


