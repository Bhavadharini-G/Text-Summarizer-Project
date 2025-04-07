FROM python:3.8-slim-buster

# Install required system packages
RUN apt update -y && apt install -y awscli build-essential gcc libffi-dev libssl-dev

# Set working directory
WORKDIR /app

# Copy requirements first (use Docker cache)
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt || (echo "❌ pip failed, dumping requirements.txt:" && cat requirements.txt)

# Copy rest of the codebase
COPY . .

# Optional cleanup: force reinstall to handle version issues
RUN pip install --upgrade accelerate && \
    pip uninstall -y transformers accelerate && \
    pip install transformers accelerate

# Run the application
CMD ["python3", "app.py"]
