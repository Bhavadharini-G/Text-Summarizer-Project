FROM python:3.12

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# System dependencies
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

# Copy and install dependencies (except PyTorch first)
COPY requirements.txt .

# Remove torch-related packages to install separately
RUN sed -i '/torch/d' requirements.txt && \
    sed -i '/torchaudio/d' requirements.txt && \
    sed -i '/torchvision/d' requirements.txt && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Install PyTorch separately for Python 3.12
RUN pip install torch==2.2.2 torchvision==0.17.2 torchaudio==2.2.2 --index-url https://download.pytorch.org/whl/cpu

# Install transformers + accelerate cleanly
RUN pip install --upgrade accelerate transformers

# Copy the rest of the app
COPY . .

# Run the app
CMD ["python", "app.py"]
