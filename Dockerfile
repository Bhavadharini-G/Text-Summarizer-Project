# Base image with Python 3.12
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create working directory
WORKDIR /app

# System dependencies (you can add more like ffmpeg, git, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libffi-dev \
    libssl-dev \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install pip, setuptools, wheel first (Python 3.12 compatibility)
RUN pip install --upgrade pip setuptools wheel

# Copy dependency file
COPY requirements.txt .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy your source code into the container
COPY . .

# Expose your default app port (update as needed)
EXPOSE 8000

# Default command (update as needed, e.g. FastAPI or Flask)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
