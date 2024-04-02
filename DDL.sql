-- create members table
CREATE TABLE Member(
    member_id SERIAL PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    birth_date DATE,
    join_date DATE DEFAULT CURRENT_DATE,
    gender VARCHAR(255) NOT NULL,

    -- login info
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) UNIQUE NOT NULL,

    -- health metrics
    resting_hr INT,
    avg_sleep INT,
    curr_weight INT,
    height INT,

    -- fitness goals
    goal_weight INT,
    distance INT,
    goal_time TIME
);

-- create trainers table
CREATE TABLE Trainer(
    trainer_id SERIAL PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    birth_date DATE,
    join_date DATE DEFAULT CURRENT_DATE,
    gender VARCHAR(255) NOT NULL,

    -- login info
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) UNIQUE NOT NULL
);

--create admins table
CREATE TABLE Admin(
    admin_id SERIAL PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    birth_date DATE,
    join_date DATE DEFAULT CURRENT_DATE,

    -- login info
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) UNIQUE NOT NULL
);

--create schedule table
CREATE TABLE Schedule(
    schedule_id SERIAL PRIMARY KEY,
    time_slot TIME NOT NULL, -- primary key option?
    member_id INT REFERENCES Member(member_id),
    trainer_id INT REFERENCES Trainer(trainer_id),

    -- not particularly neccessary since we already have trainer_id
    trainer_fname VARCHAR(255) NOT NULL,
    trainer_lname VARCHAR(255) NOT NULL,

    availability VARCHAR(255) NOT NULL,
    session_type VARCHAR(255) NOT NULL,

);

-- create dashboard table
CREATE TABLE Dashboard(
    dashboard_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES Member(member_id),

    -- health stats
    -- multiple attributes exercise routines
    -- multiple attributes fitness achievements
);

-- create booking table
CREATE TABLE Booking (
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
   working_orderVARCHAR(255) NOT NULL
);

-- create payment table
CREATE TABLE Payment (
   payment_id SERIAL PRIMARY KEY,
   member_id INT REFERENCES Member(member_id),
   member_fee INT NOT NULL

    -- group/single sessions?
    -- monthly or all at once??
);