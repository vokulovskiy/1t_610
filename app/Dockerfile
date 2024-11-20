FROM python:3.12-slim

WORKDIR /app

COPY main.py .

RUN pip install psycopg2-binary

CMD ["python", "main.py"]