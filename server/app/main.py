from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from app.routers import tickets
from datetime import datetime

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# Include routers
app.include_router(tickets.router)

@app.get("/api/ping")
async def ping():
    return {"status": "acknowledged"}

@app.post("/webhook/customer-support")
async def webhook_handler(request: Request):
    data = await request.json()
    print(" Webhook received at:", datetime.now())
    print(" Webhook data:")
    print(data)
    return {"status": "received"}

@app.get("/")
async def root():
    return {"message": "Welcome to the FastAPI server"}
