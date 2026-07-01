import datetime
from datetime import datetime, timedelta, UTC
import jwt
from fastapi import HTTPException
from dotenv import load_dotenv
import os

load_dotenv()

SECRET_KEY=os.getenv("SECRET_KEY")
ALGORITHM=os.getenv("ALGORITHM")

def create_access_token(payload:dict):
    to_encode=payload
    expire = datetime.now(UTC) + timedelta(days=1)
    to_encode.update({"exp":expire})
    token=jwt.encode(payload,SECRET_KEY,ALGORITHM)
    return token

def decode_access_token(token):
    try:
        payload=jwt.decode(token,SECRET_KEY,algorithms=[ALGORITHM])
        email=payload.get("sub")
        return email
    except:
        raise HTTPException(
    status_code=401,
    detail="Could not validate credentials"
)
    
