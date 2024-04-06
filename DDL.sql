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

-- create dashboard table
CREATE TABLE Dashboard(
    dashboard_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES Members(member_id)

    -- health stats


    -- multiple attributes exercise routines
    -- multiple attributes fitness achievements
);

CREATE TABLE Exercises(
    exercise_id SERIAL PRIMARY KEY,
    exercise VARCHAR(255) NOT NULL,
    info TEXT
);

CREATE TABLE MemberRoutines(
    routine_id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES Exercises(exercise_id),
    --dashboard_id INT REFERENCES Dashboard(dashboard_id),
    exercise VARCHAR(255) NOT NULL
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
    time_slot TIME NOT NULL,
    UNIQUE (trainer_id, day, time_slot),

    availability BOOLEAN NOT NULL,
    session_type VARCHAR(255) NOT NULL

);

CREATE TABLE ScheduledMembers(
    -- need table id??
    table_id SERIAL PRIMARY KEY,
    schedule_id INT REFERENCES Schedule(schedule_id),
    trainer_id INT REFERENCES Trainers(trainer_id),
    member_id INT REFERENCES Members(member_id)
);

-- create booking table
CREATE TABLE RoomBooking(
    booking_id SERIAL PRIMARY KEY,
    time_slot DATE DEFAULT CURRENT_DATE,
    room_id INT NOT NULL
    -- need to create a room table? aka keep track of number, capacity and equipment
);

-- create equipment table????

-- create maintenance table
CREATE TABLE Maintenance (
   maintenance_id SERIAL PRIMARY KEY,
   equipment_id INT NOT NULL, -- could be a reference to a table
   equip_name VARCHAR(255) NOT NULL,
   model_year DATE DEFAULT CURRENT_DATE,
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