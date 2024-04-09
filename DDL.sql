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
    equipment_id INT REFERENCES Equipment(equipment_id),
    info TEXT
);

CREATE TABLE MemberRoutines(
    routine_id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES Exercises(exercise_id),
    member_id INT REFERENCES Members(member_id)
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
    --member_id INT REFERENCES Members(member_id),
    day VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    UNIQUE (trainer_id, day, start_time),
    CHECK (start_time <> end_time),

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
CREATE TABLE Payment (
   payment_id SERIAL PRIMARY KEY,
   member_id INT REFERENCES Members(member_id),
   member_fee INT NOT NULL

    -- group/single sessions?
    -- monthly or all at once??
);