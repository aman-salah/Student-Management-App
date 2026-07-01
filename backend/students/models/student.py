from sqlalchemy import Table,Column,MetaData,Integer,String,ForeignKey
from database import Base

metadata=MetaData()

class Student(Base):
    __tablename__="student"

    id=Column(Integer,primary_key=True,index=True)
    user_id=Column(Integer,ForeignKey("users.id"),nullable=True)
    name=Column(String,nullable=False)
    studid=Column(String,nullable=False,unique=True)
    department=Column(String,nullable=False)
    age=Column(Integer)
    email=Column(String,unique=True)
    contact=Column(String)
    