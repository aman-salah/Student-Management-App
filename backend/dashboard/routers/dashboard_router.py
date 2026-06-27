from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from auth.models.user import User
from auth.dependencies import get_current_user
from students.models.student import Student
from classes.models.classes import TeacherClass
from dashboard.schemas.dashboard import DashboardStats

dashboard_router=APIRouter(prefix="/dashboard",tags=["Dashboard"])

@dashboard_router.get("/stats",response_model=DashboardStats)
def get_dashboard_stats(current_user:User=Depends(get_current_user),db:Session=Depends(get_db)):

    total_students=db.query(Student).filter(Student.department==current_user.department).count()
    total_classes=db.query(TeacherClass).filter(TeacherClass.teacher_id==current_user.id).count()

    return {
        "total_students": total_students,
        "total_classes": total_classes,
    }