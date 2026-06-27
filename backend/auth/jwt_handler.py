import datetime
from datetime import datetime, timedelta, UTC
import jwt
from fastapi import HTTPException


SECRET_KEY="09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7265"
ALGORITHM="HS256"

def create_access_token(payload:dict):
    to_encode=payload
    expire = datetime.now(UTC) + timedelta(minutes=30)
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
    
