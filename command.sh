# структура проекта, включающую все необходимые файлы:
project/
├── docker-compose.yml
├── db/
│   ├── Dockerfile
│   ├── init.sql
├── app/
│   ├── Dockerfile
│   ├── main.py

# 1. docker-compose.yml
###################################
version: '3.8'

services:
  db:
    build:
      context: ./db
    container_name: postgres_container
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: okulovskiy
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

  app:
    build:
      context: ./app
    container_name: python_app
    depends_on:
      - db
volumes:
  db_data:
###################################
# 2. Файлы для PostgreSQL
# db/Dockerfile
###################################
FROM postgres:latest
COPY init.sql /docker-entrypoint-initdb.d/
###################################
db/init.sql
###################################
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
('Eva', 'Davis', 'Rome', 37),
('Tom', 'Harris', 'Sydney', 52),
('Lara', 'Jones', 'Madrid', 29),
('Mark', 'Clark', 'Toronto', 27),
('Jane', 'Taylor', 'Dubai', 33),
('Nina', 'Anderson', 'Vienna', 22),
('Jake', 'Martinez', 'Prague', 28),
('Sara', 'Roberts', 'Amsterdam', 36),
('Alex', 'Lee', 'Tokyo', 50),
('Ella', 'Perez', 'Oslo', 44),
('Leo', 'Turner', 'Cairo', 39),
('Mia', 'Morgan', 'Delhi', 21),
('Omar', 'Hill', 'Shanghai', 48),
('Noah', 'Adams', 'Cape Town', 35),
('Zara', 'Scott', 'Singapore', 26);
###################################
# 3. Файлы для Python
# app/Dockerfile
###################################
FROM python:3.9-slim

WORKDIR /app

COPY main.py .

RUN pip install psycopg2-binary

CMD ["python", "main.py"]
###################################
app/main.py
###################################
import psycopg2
import os

DB_HOST = os.getenv("DB_HOST", "db")
DB_NAME = os.getenv("DB_NAME", "okulovskiy")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "postgres")

query = """
    SELECT MIN(age) AS min_age, MAX(age) AS max_age
    FROM test_table
    WHERE LENGTH(name) < 6;
"""

def main():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD
        )
        cur = conn.cursor()
        cur.execute(query)
        result = cur.fetchone()
        print(f"Min age: {result[0]}, Max age: {result[1]}")
        cur.close()
        conn.close()
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
###################################
# Запуск
docker-compose up --build