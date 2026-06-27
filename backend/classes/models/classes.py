from sqlalchemy import Table,Column,ForeignKey,MetaData,Integer,String
from database import Base
from students.models.student import Student

metadata=MetaData()

class TeacherClass(Base):
    __tablename__="teacher_class"

    id=Column(Integer,primary_key=True,index=True)
    subject=Column(String,nullable=False)
    classname=Column(String,nullable=False)
    semester=Column(Integer,nullable=False)
    teacher_id=Column(Integer,ForeignKey("users.id"))

class Enrollment(Base):
    __tablename__="enrollment"

    id=Column(Integer,primary_key=True,index=True)
    class_id=Column(Integer,ForeignKey("teacher_class.id"))
    student_id=Column(String,ForeignKey("student.studid"))