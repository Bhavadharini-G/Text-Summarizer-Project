FROM python:3.12

# Prevent interactive prompts during package install
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

# Copy requirements file
COPY requirements.txt .

# Remove torch-related packages (to install separately due to Python 3.12 constraints)
RUN grep -vE 'torch|torchaudio|torchvision' requirements.txt > tmp.txt && \
    mv tmp.txt requirements.txt && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Install PyTorch separately for Python 3.12
RUN pip install torch==2.2.2 torchvision==0.17.2 torchaudio==2.2.2 --index-url https://download.pytorch.org/whl/cpu

# Install latest transformers and accelerate cleanly
RUN pip install --upgrade transformers accelerate

# Copy the entire app
COPY . .

# Run the app
CMD ["python", "app.py"]
