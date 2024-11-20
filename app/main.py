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