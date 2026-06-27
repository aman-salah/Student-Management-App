from fastapi import Depends,HTTPException
from auth.jwt_handler import decode_access_token
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from database import get_db
from auth.models.user import User

oauth2_scheme=OAuth2PasswordBearer(tokenUrl="/auth/login")

def get_current_user(token:str=Depends(oauth2_scheme),db:Session=Depends(get_db)):
    email=decode_access_token(token)
    user=db.query(User).filter(User.email==email).first()
    if not user:
        raise HTTPException(
            status_code=401,
            detail="Could not validate credentials"
        )
    return user

