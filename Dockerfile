# Use an official Python 3.12 base image
FROM python:3.12-slim

# Set environment variables to prevent Python from writing .pyc files and to buffer stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    libffi-dev \
    libssl-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Copy project files into the container
COPY . /app

# Ensure you have setup.py or pyproject.toml for editable install
# If not using editable install, ensure requirements.txt doesn't have "file:///app"
# or replace it with just the required packages

# Upgrade pip, setuptools, wheel
RUN pip install --upgrade pip setuptools wheel

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose any required ports (optional)
EXPOSE 8080

# Set the default command (modify this based on your app)
CMD ["python"]
###