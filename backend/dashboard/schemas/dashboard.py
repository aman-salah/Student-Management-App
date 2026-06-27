from pydantic import BaseModel

class DashboardStats(BaseModel):
    total_students:int
    total_classes:int
    