#!/bin/sh
set -e

# Configure AWS CLI from environment variables
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set region "$AWS_DEFAULT_REGION"
aws configure set endpoint_url "$AWS_ENDPOINT_URL"

# Launch FastAPI via Uvicorn
exec uvicorn main:app --host 0.0.0.0 --port 8000
