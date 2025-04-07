FROM python:3.10-slim

# Install AWS CLI
RUN apt update -y && apt install -y awscli

WORKDIR /app

COPY requirements.txt ./requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

RUN pip install --upgrade accelerate \
    && pip uninstall -y transformers accelerate \
    && pip install transformers accelerate

COPY . .

CMD ["python3", "app.py"]
