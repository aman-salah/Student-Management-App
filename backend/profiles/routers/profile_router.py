from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from auth.dependencies import get_current_user
from auth.models.user import User
from profiles.schemas.about import ProfileResponse

profile_router = APIRouter(
    prefix="/profile",
    tags=["Profile"]
)


@profile_router.get("/me", response_model=ProfileResponse)
def get_profile(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    return current_user