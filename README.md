# MeetModel
A full-stack conversational AI application built with an iOS frontend, Python backend, and a locally running large language model (LLM). The system mimics ChatGPT-style interaction with conversation memory, but runs entirely on your machine without external API dependencies.

🚀 Features
📱 Native iOS chat interface (UIKit + MVVM)
🧠 Local LLM integration using Ollama (no paid APIs)
🔁 Context-aware responses (conversation memory)
⚡ FastAPI backend for request handling
🔌 End-to-end architecture (App → API → Model → Response)
🔒 Fully local execution (privacy-friendly)

🏗️ Architecture
iOS App (Swift)
      ↓
FastAPI Backend (Python)
      ↓
Ollama (Local LLM - LLaMA/Mistral)
      ↓
AI Response
The iOS app sends user messages to the backend
Backend constructs a contextual prompt using conversation history
Prompt is passed to the local LLM via Ollama
Response is returned and displayed in the app

🧩 Tech Stack

Frontend (iOS)

Swift (UIKit)
MVVM Architecture
URLSession (async/await)

Backend

Python
FastAPI
Requests

AI Layer

Ollama
LLaMA / Mistral models (local inference)

🧠 How It Works

Instead of sending single messages, the backend maintains a conversation history:

User: Hello
Assistant: Hi!
User: What is AI?
Assistant:

This prompt is dynamically constructed and sent to the model, enabling:

Context awareness
Multi-turn conversations
More natural responses

⚙️ Setup
1. Install Ollama

Download from: https://ollama.com

ollama pull llama3
2. Run Backend
uvicorn main:app --reload
3. Run iOS App
Open project in Xcode
Run on Simulator (uses 127.0.0.1)
For real device, replace with your Mac’s IP

🔮 Future Improvements
Per-user chat sessions
Persistent storage (database)
Streaming responses (real-time typing effect)
Improved UI (chat bubbles, animations)
Domain-specific assistants (e.g. India-focused AI)

Build with ❤️ by Manpreet Singh
