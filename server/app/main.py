from pathlib import Path
from dotenv import load_dotenv
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from app.routers import tickets
from datetime import datetime
from langchain_openai import ChatOpenAI

# Load environment variables
load_dotenv(dotenv_path=Path(__file__).parent.parent.parent / '.env')

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
    llm = ChatOpenAI()
    llm.invoke("Hello world!")
    return {"message": "Welcome to the FastAPI server"}
