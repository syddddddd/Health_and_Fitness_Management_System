-- create members table
CREATE TABLE Members(
    member_id SERIAL PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE,
    gender VARCHAR(255) NOT NULL,

    -- login info
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
  
);

-- CHECK (fname <> '')

-- create trainers table
CREATE TABLE Trainers(
    trainer_id SERIAL PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE,
    gender VARCHAR(255) NOT NULL,

    -- login info
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
  
);

--create admins table
CREATE TABLE Admins(
    admin_id SERIAL PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    birth_date DATE,
    join_date DATE DEFAULT CURRENT_DATE,

    -- login info
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE FitnessFiles(
    file_id SERIAL PRIMARY KEY,

    -- fitness goals
    goal_weight INT,
    distance INT,
    goal_time TIME,

    member_id INT REFERENCES Members(member_id)
);

CREATE TABLE HealthMetrics(
    health_metric_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES Members(member_id),
    hours_slept INT,
    curr_weight INT,
    height INT,
    calories_consummed INT
);

CREATE TABLE HealthStatistics(
    health_stats_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES Members(member_id),
    hours_slept INT,
    curr_weight INT,
    height INT,
    calories_consummed INT
);

CREATE TABLE Equipment(
    equipment_id SERIAL PRIMARY KEY,
    equip_name VARCHAR(255) NOT NULL,
    model_year DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Exercises(
    exercise_id SERIAL PRIMARY KEY,
    exercise VARCHAR(255) NOT NULL,
    equipment_id INT REFERENCES Equipment(equipment_id)
);

CREATE TABLE MemberRoutines(
    routine_id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES Exercises(exercise_id),
    member_id INT REFERENCES Members(member_id),
    reps INT,
    distance INT
);

CREATE TABLE FitnessAchievements(
    achievements_id INT,
    member_id INT REFERENCES Members(member_id),
    achievements VARCHAR(255) NOT NULL
);

--create schedule table
CREATE TABLE Schedule(
    schedule_id SERIAL PRIMARY KEY,
    trainer_id INT REFERENCES Trainers(trainer_id),
    day VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    --UNIQUE (trainer_id, day, start_time),
    CHECK (start_time < end_time),

    availability BOOLEAN NOT NULL,
    session_type VARCHAR(255) NOT NULL,
    room_num INT

);

CREATE TABLE ScheduledMembers(
    table_id SERIAL PRIMARY KEY,
    schedule_id INT REFERENCES Schedule(schedule_id),
    trainer_id INT REFERENCES Trainers(trainer_id),
    member_id INT REFERENCES Members(member_id)
);

CREATE TABLE TrainerAvailability(
    availability_id SERIAL PRIMARY KEY,
    trainer_id INT REFERENCES Trainers(trainer_id),
    day VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL 
);

-- create rooms table
CREATE TABLE Rooms(
    room_num INT NOT NULL PRIMARY KEY,
    availability BOOLEAN
    -- need to create a room table? aka keep track of number, capacity and equipment
);

-- create equipment table????

-- create maintenance table
CREATE TABLE Maintenance (
   maintenance_id SERIAL PRIMARY KEY,
   equipment_id INT REFERENCES Equipment(equipment_id),
   purchase_date DATE DEFAULT CURRENT_DATE,
   last_checkup DATE DEFAULT CURRENT_DATE,
   working_order VARCHAR(255) NOT NULL
);

-- create payment table
CREATE TABLE MemberFee (
   payment_id SERIAL PRIMARY KEY,
   member_id INT REFERENCES Members(member_id),
   member_fee INT NOT NULL,
   paid BOOLEAN
);

CREATE TABLE GroupFees (
    group_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES Members(member_id),
    schedule_id INT REFERENCES Schedule(schedule_id),
    group_fee INT,
    paid BOOLEAN
);

CREATE TABLE PrivateFees (
    private_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES Members(member_id),
    schedule_id INT REFERENCES Schedule(schedule_id),
    private_fee INT,
    paid BOOLEAN
);

-- check if schedule overlaps with existing schedule
CREATE OR REPLACE FUNCTION checkOverlap()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM SCHEDULE
        WHERE trainer_id = NEW.trainer_id
          AND day = NEW.day
          AND NOT (NEW.start_time >= end_time OR NEW.end_time <= start_time)
    ) THEN
        RAISE EXCEPTION 'Schedule overlaps with existing schedules';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER scheduleOverlapTrigger
BEFORE INSERT ON Schedule
FOR EACH ROW
EXECUTE FUNCTION checkOverlap();

-- check if schedule matches trainer's availability 
CREATE OR REPLACE FUNCTION checkAvailability()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM TrainerAvailability
        WHERE trainer_id = NEW.trainer_id
          AND day = NEW.day
          AND (NEW.start_time < start_time OR NEW.end_time > end_time)
          AND NOT (start_time != '00:00' OR end_time != '00:00')
    ) THEN
        RAISE EXCEPTION 'Not within trainer availability';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER checkAvailabilityTrigger
BEFORE INSERT ON SCHEDULE
FOR EACH ROW
EXECUTE FUNCTION checkAvailability();

CREATE OR REPLACE FUNCTION validAvailability()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM TrainerAvailability
        WHERE trainer_id = NEW.trainer_id
          AND day = NEW.day
          AND ((NEW.start_time = '00:00' AND NEW.end_time != '00:00') OR (NEW.start_time != '00:00' AND NEW.end_time = '00:00'))
    ) THEN
        RAISE EXCEPTION 'Not within trainer availability';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER validAvailabilityTrigger
BEFORE UPDATE ON TrainerAvailability
FOR EACH ROW
EXECUTE FUNCTION validAvailability();


CREATE TABLE Testing (
    day SERIAL PRIMARY KEY,
    time INT
);

DO $$
DECLARE
    day_value INT;
BEGIN
    day_value := CASE
        WHEN day = 'Sunday' THEN 1
        WHEN day = 'Monday' THEN 2
        WHEN day = 'Tuesday' THEN 3
        WHEN day = 'Wednesday' THEN 4
        WHEN day = 'Thursday' THEN 5
        WHEN day = 'Friday' THEN 6
        WHEN day = 'Saturday' THEN 7
        ELSE 8
    END;

    RAISE NOTICE 'The value of day_value is: %', day_value;
END;
$$;

INSERT INTO Schedule (trainer_id, day, start_time, end_time, session_type, availability)
VALUES 
(2, 'Sunday', '8:00', '10:00', 'group', true);

UPDATE TrainerAvailability SET start_time = '00:00', end_time = '12:00' WHERE trainer_id=3 AND day = 'Sunday'

UPDATE INTO TrainerAvailability (trainer_id, day, start_time, end_time)
VALUES
(3, 'Sunday', '0:00', '12:00')