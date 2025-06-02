# fastapi_project

Basic FastAPI application providing two endpoints:

- **GET /ping**: Returns request metadata (method, URL, headers, client host/port).  
- **GET /uuid**: Generates and returns a new UUID4 string via `uuid_generator.py`.

## Usage

Run locally:
```
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Build Docker image:
```
docker build -t fastapi_project .
```

Deploy via Coolify by connecting to this GitHub repository.
