FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install dependencies
COPY requirements.txt .

RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -r requirements.txt


# Copy app code
COPY . .

# If using FastAPI + Uvicorn
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
