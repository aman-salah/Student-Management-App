from pydantic import BaseModel

class ProfileResponse(BaseModel):
    id: int
    username: str
    email: str
    department: str
    role: str

    class Config:
        from_attributes = True