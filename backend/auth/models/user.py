from sqlalchemy import Table,Column,MetaData,Computed,Integer,String
from database import Base


metadata=MetaData()

class User(Base):
    __tablename__="users"

    id=Column(Integer,primary_key=True,index=True)
    username=Column(String,nullable=False)
    email=Column(String,unique=True,nullable=False)
    password=Column(String,nullable=False)
    role=Column(String,nullable=False)
    department=Column(String,nullable=False)