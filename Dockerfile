FROM python:3.12

# Prevent interactive prompts during package installation
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

# Set the working directory
WORKDIR /app

# Copy requirements first for Docker layer caching
COPY requirements.txt .

# Remove incompatible torch packages (will install separately)
RUN sed -i '/^torch==/d' requirements.txt && \
    sed -i '/^torchaudio==/d' requirements.txt && \
    sed -i '/^torchvision==/d' requirements.txt

# Upgrade pip and install the cleaned dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install torch separately (CPU version) - compatible with Python 3.12
RUN pip install torch==2.4.1 torchvision==0.20.0 torchaudio==2.4.1 --index-url https://download.pytorch.org/whl/cpu

# Install transformers and accelerate separately (to avoid version conflicts)
RUN pip install transformers==4.46.3 accelerate==1.0.1

# Copy the rest of your application
COPY . .

# Command to run the app (replace app.py with your actual entry point if different)
CMD ["python", "app.py"]
