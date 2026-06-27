from pydantic import BaseModel
from fastapi import FastAPI
from typing import Optional

class StudentAdd(BaseModel):
    #id:int
    name:str
    studid:str
    department:str
    age:int
    email:str
    contact:str
    

class StudentUpdate(BaseModel):
    name: Optional[str] = None
    studid:Optional[str]=None
    department:Optional[str]= None
    age: Optional[int] = None
    email: Optional[str] = None
    contact: Optional[str] = None


