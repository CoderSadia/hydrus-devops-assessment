from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import time
import os

app = FastAPI(title="Hydrus API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
async def health():
    return {"status": "ok", "timestamp": time.time()}

@app.get("/api/items")
async def get_items():
    return [
        {"id": 1, "name": "Item 1", "description": "First item"},
        {"id": 2, "name": "Item 2", "description": "Second item"},
        {"id": 3, "name": "Item 3", "description": "Third item"},
    ]

@app.get("/api/info")
async def info():
    return {
        "app": "Hydrus API",
        "version": "1.0.0",
        "env": os.getenv("APP_ENV", "development"),
    }
