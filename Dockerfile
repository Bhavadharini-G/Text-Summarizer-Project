# Use Python 3.12 slim image
FROM python:3.12-slim

# Avoids prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and AWS CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    awscli \
    build-essential \
    git \
    curl \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    zlib1g-dev \
    libgl1-mesa-glx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements file first to leverage Docker cache
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Optional: Reinstall specific versions to avoid compatibility issues
RUN pip install --upgrade accelerate \
    && pip uninstall -y transformers accelerate \
    && pip install transformers==4.46.3 accelerate==1.0.1

# Copy the full application
COPY . .

# Run the application
CMD ["python3", "app.py"]
