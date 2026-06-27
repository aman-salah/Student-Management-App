from pydantic import BaseModel
from fastapi import FastAPI
from typing import Optional

class ClassCreate(BaseModel):
    subject:str
    classname:str
    semester:int

class ClassResponse(BaseModel):
    id:int
    subject:str
    classname:str
    semester:int
    class Config:
        from_attributes = True
    
class EnrollmentCreate(BaseModel):
    class_id:int
    student_id:str

