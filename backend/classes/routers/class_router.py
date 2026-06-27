from datetime import time

from fastapi import FastAPI,APIRouter,Depends,Response,HTTPException,status
from sqlalchemy.orm import Session
from sqlalchemy import or_
from classes.schemas.classes import ClassCreate ,EnrollmentCreate,ClassResponse
from classes.models.classes import TeacherClass,Enrollment
from database import get_db
from typing import List
from students.models.student import Student
from auth.models.user import User
from auth.dependencies import get_current_user

class_router=APIRouter(prefix="/classes",tags=["Classes"])

#create a class
@class_router.post("/create",response_model=ClassResponse)
def create_class(room:ClassCreate,db:Session=Depends(get_db),current_user:User=Depends(get_current_user)):
    new_class=TeacherClass(subject=room.subject,classname=room.classname,semester=room.semester,teacher_id=current_user.id)
    db.add(new_class)
    db.commit()
    db.refresh(new_class)
    return new_class

#delete a class
@class_router.delete("/delete/{class_id}")
def delete_class(class_id:int,db:Session=Depends(get_db)):
    class_to_delete=db.query(TeacherClass).filter(TeacherClass.id==class_id).first()
    db.delete(class_to_delete)
    db.commit()
    return {"message":"class deleted successfully"}

#get all classes
@class_router.get("/all",response_model=List[ClassResponse])
def get_all_classes(db:Session=Depends(get_db),current_user:User=Depends(get_current_user)):
    classes=db.query(TeacherClass).filter(TeacherClass.teacher_id==current_user.id).all()
    return classes

#add student to class
@class_router.post("/enroll",response_model=EnrollmentCreate)
def add_student(student:EnrollmentCreate,db:Session=Depends(get_db)):
    new_enrollment=Enrollment(class_id=student.class_id,student_id=student.student_id)
    db.add(new_enrollment)
    db.commit()
    db.refresh(new_enrollment)
    return new_enrollment

#get students in a class
@class_router.get("/{class_id}/students")
def class_students(class_id:int,db:Session=Depends(get_db)):
    enrollments=db.query(Enrollment).filter(Enrollment.class_id==class_id).all()
    students=[]
    for enrollment in enrollments:
        student=db.query(Student).filter(Student.studid==enrollment.student_id).first()
        if student:
            students.append(student)
    return students

#remove a student from class
@class_router.delete("/{class_id}/student/{student_id}")
def remove_student(
    class_id: int,
    student_id: str,
    db: Session = Depends(get_db)
):
    enrollment = db.query(Enrollment).filter(
        Enrollment.class_id == class_id,
        Enrollment.student_id == student_id
    ).first()

    if not enrollment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Student not enrolled in this class"
        )

    db.delete(enrollment)
    db.commit()

    return {
        "message": "Student removed from class successfully"
    }
