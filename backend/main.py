from fastapi import FastAPI
from database import Base,engine
from auth.models.user import User
from auth.routers.auth import auth_router
from students.routers.student_router import student_router
from dashboard.routers.dashboard_router import dashboard_router
from profiles.routers.profile_router import profile_router
from students.models.student import Student
from classes.routers.class_router import class_router

app=FastAPI()
app.include_router(auth_router)
app.include_router(student_router)
app.include_router(class_router)
app.include_router(dashboard_router)
app.include_router(profile_router)

Base.metadata.create_all(bind=engine)

