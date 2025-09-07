from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse
from fastapi.staticfiles import StaticFiles
from google.auth.transport import requests
from google.oauth2 import id_token
import google.auth.exceptions
import os
from dotenv import load_dotenv
import json
from typing import Optional

load_dotenv()

app = FastAPI()

# Get allowed origins from environment variable or use defaults
allowed_origins = os.getenv("ALLOWED_ORIGINS", "http://localhost:3000,https://localhost:3000").split(",")

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
    expose_headers=["*"],
)

GOOGLE_CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")

# Mount static files for serving the built frontend
static_dir = os.path.join(os.path.dirname(__file__), "..", "frontend", "out")
if os.path.exists(static_dir):
    app.mount("/static", StaticFiles(directory=static_dir), name="static")

@app.get("/api")
def read_root():
    return {"message": "OAuth Backend API"}

@app.post("/auth/google")
async def google_auth(token: dict):
    try:
        # Verify the token
        idinfo = id_token.verify_oauth2_token(
            token["credential"], 
            requests.Request(), 
            GOOGLE_CLIENT_ID
        )
        
        # Extract user info
        user_info = {
            "id": idinfo["sub"],
            "email": idinfo["email"],
            "name": idinfo["name"],
            "picture": idinfo.get("picture", "")
        }
        
        return {"success": True, "user": user_info}
    
    except ValueError as e:
        raise HTTPException(status_code=400, detail="Invalid token")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/auth/verify")
async def verify_auth(user_id: Optional[str] = None):
    if not user_id:
        raise HTTPException(status_code=401, detail="Not authenticated")
    return {"authenticated": True, "user_id": user_id}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)