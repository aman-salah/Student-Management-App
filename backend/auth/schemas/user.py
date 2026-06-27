from pydantic import BaseModel
from fastapi import FastAPI

class UserCreate(BaseModel):
    username:str
    email:str
    password:str
    department:str

class UserLogin(BaseModel):
    email:str
    password:str

class UserResponse(BaseModel):
    id:int
    username:str
    email:str
