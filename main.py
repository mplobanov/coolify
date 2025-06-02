from fastapi import FastAPI, Request
from uuid_generator import generate_uuid
import os
import json

app = FastAPI()

@app.get("/ping")
async def ping(request: Request):
    """
    Return details about the incoming HTTP request.
    """
    return {
        "method": request.method,
        "url": str(request.url),
        "headers": dict(request.headers),
        "client": {
            "host": request.client.host,
            "port": request.client.port
        }
    }

@app.get("/uuid")
async def get_uuid():
    """
    Return a fresh UUID4 string.
    """
    return {"uuid": generate_uuid()}

@app.get("/buckets")
async def list_buckets():
    """
    List all S3 buckets using AWS CLI.
    """
    cmd = "aws s3api list-buckets --query 'Buckets[].Name' --output json"
    result = os.popen(cmd).read()
    try:
        buckets = json.loads(result)
    except json.JSONDecodeError:
        buckets = []
    return {"buckets": buckets}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
