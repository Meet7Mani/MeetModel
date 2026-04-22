from fastapi import FastAPI
from pydantic import BaseModel
import requests

app = FastAPI() 
conversation_history = []

class ChatRequest(BaseModel):
    message: str

@app.get("/")
def home():
    return {"message": "AI Backend is running 🚀"}

@app.post("/chat")
def chat(req: ChatRequest):

    global conversation_history
    
    conversation_history.append({
        "role": "user",
        "content": req.message
    })


    system_prompt = """
   You are a helpful AI assistant designed for Indian users.

- Give clear, practical answers
- Prefer examples relevant to India (₹, Indian laws, local context)
- Support simple explanations
- Be concise and conversational
- If user writes in Hindi or Punjabi or English or Hinglish or mixed language, respond naturally
"""

    prompt = system_prompt + "\n\n"

    for msg in conversation_history:
        if msg["role"] == "user":
            prompt += f"User: {msg['content']}\n"
        else:
            prompt += f"Assistant: {msg['content']}\n"

    prompt += "Assistant:"

    response = requests.post(
        "http://localhost:11434/api/generate",
        json={
            "model": "llama3",
            "prompt": prompt,
            "stream": False
        }
    )

    data = response.json()
    reply = data["response"]
    
    # 4. Store assistant reply
    conversation_history.append({
        "role": "assistant",
        "content": reply
    })
    
    # 5. Return response
    return {
        "reply": reply
    }