from datetime import time

from fastapi import FastAPI,APIRouter,Depends,Response,HTTPException,status
from sqlalchemy.orm import Session
from sqlalchemy import or_
from students.schemas.student import StudentAdd,StudentUpdate
from database import get_db
from students.models.student import Student
from typing import List
from auth.models.user import User
from auth.dependencies import get_current_user

student_router=APIRouter(prefix="/students",tags=["Students"])

#add a student
@student_router.post("/add_student",response_model=StudentAdd)
def add_student(student:StudentAdd,db:Session=Depends(get_db)):
    existing_student=db.query(Student).filter(
    or_(
        Student.studid == student.studid,
        Student.email == student.email,
    )
).first()
    if existing_student:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,detail="student already exist")
    new_student=Student(name=student.name,studid=student.studid,department=student.department,age=student.age,email=student.email,contact=student.contact)
    db.add(new_student)
    db.commit()
    db.refresh(new_student)
    return new_student

#get all students
@student_router.get("/get_all_students",response_model=List[StudentAdd])
def get_all_students(current_user:User=Depends(get_current_user),db:Session=Depends(get_db)):
    
    students=db.query(Student).filter(Student.department==current_user.department).all()
    return students

#get student by studid
@student_router.get("/get_student/{studid}",response_model=StudentAdd)
def get_student_id(studid:str,db:Session=Depends(get_db)):
    student=db.query(Student).filter(Student.studid==studid).first()
    if student:
        return student
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,detail="student doest not exist")

#update student by studid
@student_router.patch("/update_student/{studid}",response_model=StudentAdd)
def update_student_id(studid:str,updated_student:StudentUpdate,db:Session=Depends(get_db)):
    student=db.query(Student).filter(Student.studid==studid).first()
    if not student:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Student not found"
        )
    updated_data=updated_student.model_dump(exclude_unset=True)
    for key,val in updated_data.items():
        setattr(student,key,val)
    
    db.commit()
    db.refresh(student)
    return student

#delete student by id
@student_router.delete("/delete_student/{studid}")
def delete_student_id(studid:str,db:Session=Depends(get_db)):
    student=db.query(Student).filter(Student.studid==studid).first()
    if not student:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
            detail="Student not found")
    db.delete(student)
    db.commit()
    return{"message":"Student deleted successfully"}
    