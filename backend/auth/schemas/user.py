from pydantic import BaseModel,EmailStr
from fastapi import FastAPI
from typing import Literal

class UserCreate(BaseModel):
    username:str
    email:str
    password:str
    department:str
    role:Literal["mentor","student"]

class UserLogin(BaseModel):
    email:str
    password:str
    role: Literal["mentor", "student"]
    password:str
    department:str

class UserLogin(BaseModel):
    email:str
    password:str
    role: Literal["mentor", "student"]

class UserResponse(BaseModel):
    id:int
    username:str
    email:str
    role:str
