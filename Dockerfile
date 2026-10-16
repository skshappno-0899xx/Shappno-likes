FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /data

EXPOSE 8080

ENV PORT=8080

CMD gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 300 --access-logfile - --error-logfile - index:app