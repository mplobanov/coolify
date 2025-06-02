from fastapi import FastAPI, Request
from uuid_generator import generate_uuid

app = FastAPI()

@app.get("/ping2")
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

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
