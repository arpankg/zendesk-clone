from fastapi import APIRouter
from pydantic import BaseModel, Field
from typing import List, Dict, Optional, Any
from datetime import datetime
from pprint import pprint

class TicketEvent(BaseModel):
    id: str
    type: str = "message"
    content: str
    created_at: str
    created_by_uuid: str
    created_by_first_name: str
    created_by_last_name: str
    visibility: str = "public"
    attachments: List = []

class TicketFeedback(BaseModel):
    model_config = {
        "extra": "allow"
    }
    rating: Optional[int] = 0
    comment: Optional[str] = ""
    submitted_at: Optional[str] = None

class TicketHistory(BaseModel):
    events: List[Dict[str, Any]]

class CreateTicketRequest(BaseModel):
    id: str
    title: str
    description: str
    status: str = "new"
    priority: str = "medium"
    source_channel: str = "web"
    created_by: str
    customer_email: str
    tags: List[str] = []
    custom_fields: Dict = {}
    assigned_to: List = []
    ticket_history: TicketHistory
    internal_notes: Dict = {"notes": []}
    feedback: TicketFeedback = TicketFeedback()

router = APIRouter()

@router.post("/tickets/assign-to-agent")
async def create_ticket(ticket: CreateTicketRequest):
    # Print basic ticket info
    print(" New Ticket Created:")
    print(f" Title: {ticket.title}")
    print(f" Description: {ticket.description}")
    print(f"  Status: {ticket.status}")
    print(f" Priority: {ticket.priority}")
    print(f" Source: {ticket.source_channel}")
    print(f" Created By: {ticket.created_by}")
    print(f" Customer Email: {ticket.customer_email}")
    
    # Print lists and dicts
    print(f"  Tags: {ticket.tags}")
    print(f" Custom Fields: {ticket.custom_fields}")
    
    print("\n")  # Add some spacing after all the logs
    
    return {"message": "Hello World"}
