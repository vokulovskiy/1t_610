CREATE TABLE test_table (
    name VARCHAR(10) NOT NULL CHECK (LENGTH(name) BETWEEN 4 AND 10),
    surname TEXT NOT NULL,
    city TEXT NOT NULL,
    age INT NOT NULL CHECK (age > 0 AND age <= 150)
);

INSERT INTO test_table (name, surname, city, age) VALUES
('Anna', 'Ivanova', 'Moscow', 25),
('John', 'Smith', 'New York', 32),
('Mike', 'Brown', 'London', 45),
('Lisa', 'Johnson', 'Paris', 30),
('Paul', 'Walker', 'Berlin', 41),
('Evva', 'Davis', 'Rome', 37),
('Tomas', 'Harris', 'Sydney', 52),
('Lara', 'Jones', 'Madrid', 29),
('Mark', 'Clark', 'Toronto', 27),
('Jane', 'Taylor', 'Dubai', 33),
('Nina', 'Anderson', 'Vienna', 22),
('Jake', 'Martinez', 'Prague', 28),
('Sara', 'Roberts', 'Amsterdam', 36),
('Alexander', 'Lee', 'Tokyo', 55),
('Ella', 'Perez', 'Oslo', 44),
('Leonid', 'Turner', 'Cairo', 39),
('Mila', 'Morgan', 'Delhi', 21),
('Omar', 'Hill', 'Shanghai', 48),
('Noah', 'Adams', 'Cape Town', 35),
('Zara', 'Scott', 'Singapore', 26);