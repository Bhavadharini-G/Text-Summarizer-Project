FROM python:3.12

ENV DEBIAN_FRONTEND=noninteractive

# Install system packages
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

WORKDIR /app

COPY requirements.txt .

# 🛠 Filter only exact torch-related lines (safe even if words like "tokenizers" exist)
RUN awk '!/^torch==/ && !/^torchaudio==/ && !/^torchvision==/' requirements.txt > clean_requirements.txt && \
    mv clean_requirements.txt requirements.txt && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# ✅ Install PyTorch manually for Python 3.12
RUN pip install torch==2.2.2 torchvision==0.17.2 torchaudio==2.2.2 --index-url https://download.pytorch.org/whl/cpu

# ✅ Install transformers and accelerate cleanly
RUN pip install --upgrade transformers accelerate

COPY . .

CMD ["python", "app.py"]
