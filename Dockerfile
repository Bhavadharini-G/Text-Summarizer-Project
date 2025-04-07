FROM python:3.8-slim-buster

# Install AWS CLI
RUN apt update -y && apt install -y awscli

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt ./requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

# Optional: Upgrade and reinstall accelerate and transformers cleanly
RUN pip install --upgrade accelerate \
    && pip uninstall -y transformers accelerate \
    && pip install transformers accelerate

# Copy the rest of the app
COPY . .

# Run the app
CMD ["python3", "app.py"]
