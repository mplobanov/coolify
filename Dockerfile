# Use official Python 3.10 slim image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

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
