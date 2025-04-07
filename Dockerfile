FROM python:3.8-slim-buster

# Install AWS CLI and system dependencies
RUN apt update -y && apt install -y awscli build-essential

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Fix for potential version conflicts
RUN pip install --upgrade accelerate transformers

# Default command to run the app
CMD ["python3", "app.py"]
