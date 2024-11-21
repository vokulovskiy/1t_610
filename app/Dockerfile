FROM python:3.12-slim

WORKDIR /app

COPY main.py .

RUN pip install psycopg2-binary

# CMD ["/bin/bash"]
CMD ["python", "main.py"]