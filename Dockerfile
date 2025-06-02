# Use official Python 3.10 slim image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# AWS CLI environment variables will be provided at runtime by Coolify or docker run
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION
ARG AWS_ENDPOINT_URL
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
ENV AWS_ENDPOINT_URL=${AWS_ENDPOINT_URL}

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install --no-cache-dir poetry
RUN pip install --no-cache-dir awscli

# Copy poetry project files and install dependencies
COPY pyproject.toml poetry.lock* ./
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --no-root

# Copy application source
COPY . .
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Expose port for FastAPI
EXPOSE 8000

# Launch the application
ENTRYPOINT ["./entrypoint.sh"]
