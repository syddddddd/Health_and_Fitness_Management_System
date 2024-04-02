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
    time_slot PRIMARY KEY TIME NOT NULL,
    member_id INT REFERENCES Member(member_id),
    trainer_id INT REFERENCES Trainer(trainer_id),

    -- not particularly neccessary since we already have trainer_id
    trainer_fname VARCHAR(255) NOT NULL,
    trainer_lname VARCHAR(255) NOT NULL,

    availability VARCHAR(255) NOT NULL,
    session_type VARCHAR(255) NOT NULL,

);

-- personal info table for all of them???
-- keep track of things like names, emails, phones, birth_date, sex