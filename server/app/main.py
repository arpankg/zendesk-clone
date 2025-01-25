from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import tickets

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

@app.get("/")
async def root():
    return {"message": "Welcome to the FastAPI server"}
