from fastapi import APIRouter
from pydantic import BaseModel, Field
from typing import List, Dict, Optional
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

class TicketHistory(BaseModel):
    events: List[TicketEvent]

class TicketFeedback(BaseModel):
    rating: int = 0
    comment: str = ""
    submitted_at: Optional[str] = None

class CreateTicketRequest(BaseModel):
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

@router.post("/tickets/create")
async def create_ticket(ticket: CreateTicketRequest):
    # Print basic ticket info
    print("🎫 New Ticket Created:")
    print(f"📝 Title: {ticket.title}")
    print(f"📄 Description: {ticket.description}")
    print(f"🏷️  Status: {ticket.status}")
    print(f"⭐ Priority: {ticket.priority}")
    print(f"📱 Source: {ticket.source_channel}")
    print(f"👤 Created By: {ticket.created_by}")
    print(f"📧 Customer Email: {ticket.customer_email}")
    
    # Print lists and dicts
    print(f"🏷️  Tags: {ticket.tags}")
    print(f"🔧 Custom Fields: {ticket.custom_fields}")
    print(f"👥 Assigned To: {ticket.assigned_to}")
    
    # Print ticket history events
    print("📜 Ticket History:")
    for event in ticket.ticket_history.events:
        print(f"  🕐 Event ID: {event.id}")
        print(f"  📝 Type: {event.type}")
        print(f"  💬 Content: {event.content}")
        print(f"  ⏰ Created At: {event.created_at}")
        print(f"  👤 Created By: {event.created_by_first_name} {event.created_by_last_name}")
        print(f"  👁️  Visibility: {event.visibility}")
        print(f"  📎 Attachments: {event.attachments}")
        print("  ---")
    
    # Print internal notes
    print(f"📝 Internal Notes: {ticket.internal_notes}")
    
    # Print feedback
    print("⭐ Feedback:")
    print(f"  Rating: {ticket.feedback.rating}")
    print(f"  Comment: {ticket.feedback.comment}")
    print(f"  Submitted At: {ticket.feedback.submitted_at}")
    
    print("\n")  # Add some spacing after all the logs
    
    return {"message": "Hello World"}
