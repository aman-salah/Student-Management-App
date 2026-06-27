from fastapi import FastAPI,APIRouter,Depends,Response,HTTPException,status
from sqlalchemy.orm import Session
from auth.schemas.user import UserCreate,UserResponse,UserLogin
from auth.models.user import User
from database import get_db
from auth.security import get_password_hash,verify_password
from auth.jwt_handler import create_access_token
from auth.dependencies import get_current_user
from auth.security import verify_password,get_password_hash


auth_router=APIRouter(prefix="/auth",tags=["Authentication"])

@auth_router.post("/signup",response_model=UserResponse)
def create_user(new_user:UserCreate,db:Session=Depends(get_db)):
    existing_user=db.query(User).filter(User.email==new_user.email).first()
    if existing_user:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,detail="email already exist")
    hashed_password=get_password_hash(new_user.password)
    role=("mentor" if new_user.email.lower().endswith("@fisat.ac.in") else "student")
    newuser=User(username=new_user.username,email=new_user.email,password=hashed_password,role=role,department=new_user.department)
    db.add(newuser)
    db.commit()
    db.refresh(newuser)

    return newuser

@auth_router.post("/login")
def user_login(user:UserLogin,db:Session=Depends(get_db)):
    existing_user=db.query(User).filter(User.email==user.email).first()
    if existing_user:
        check_password=verify_password(user.password,existing_user.password)
        print(check_password)
        
        
        if check_password:
            payload={"sub":existing_user.email}
            token=create_access_token(payload)
            return {
                    "access_token":token,
                    "token_type":"bearer",
                    "username":existing_user.username,
                    "email":existing_user.email,
                    "role":existing_user.role,
                    "department":existing_user.department
            }
            
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail="Wrong password ❌")
    raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail="User not Found ❌")
    
@auth_router.get("/me",response_model=UserResponse)
def current_user(current_user=Depends(get_current_user)):
    return current_user
    

