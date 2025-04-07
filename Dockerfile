FROM python:3.10

# Avoids prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# System dependencies for Python + ML/AI tools
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

# Copy requirements and remove PyTorch lines
COPY requirements.txt .

RUN sed -i '/^torch==/d' requirements.txt && \
    sed -i '/^torchaudio==/d' requirements.txt && \
    sed -i '/^torchvision==/d' requirements.txt

# Install all dependencies (except torch group)
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install torch CPU version separately (compatible with Py 3.10)
RUN pip install torch==2.4.1 torchvision==0.20.0 torchaudio==2.4.1 --index-url https://download.pytorch.org/whl/cpu

# Transformers, Accelerate
RUN pip install transformers==4.46.3 accelerate==1.0.1

# Copy app code
COPY . .

# Default run command (adjust app.py if needed)
CMD ["python", "app.py"]
