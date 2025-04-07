# Base Python image
FROM python:3.12

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    wget \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    libgl1-mesa-glx \
    libjpeg-dev \
    zlib1g-dev \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    awscli \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and clean it to separate torch packages
COPY requirements.txt .

# Remove torch-related lines (we’ll install them separately due to Py 3.12)
RUN awk '!/^torch==/ && !/^torchaudio==/ && !/^torchvision==/' requirements.txt > clean_requirements.txt && \
    mv clean_requirements.txt requirements.txt

# Upgrade pip and install general Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install PyTorch stack (CPU-only version from PyTorch repo)
RUN pip install torch==2.4.1 torchvision==0.20.0 torchaudio==2.4.1 --index-url https://download.pytorch.org/whl/cpu

# Reinstall transformers and accelerate to avoid conflicts
RUN pip install --upgrade transformers==4.46.3 accelerate==1.0.1

# Copy app source code
COPY . .

# Default run command
CMD ["python", "app.py"]
