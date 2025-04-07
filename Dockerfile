FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements-cleaned.txt ./requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy rest of the code
COPY . .

# Expose port and run
EXPOSE 8000
CMD ["python3", "app.py"]
