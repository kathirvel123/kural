from flask import Flask
from flask_socketio import SocketIO, emit
import text_to_speech
import base64
import os
from langchain_ollama import OllamaLLM
from langchain_core.prompts import ChatPromptTemplate
import text_to_speech
import os
templates="""
You are a Mentor,Read the input and correct any grammatical mistakes, or suggest a different way to phrase it. If the input is already correct, provide a response confirming it.

Here is the conversation history: {context}

Question: {Question}

Answer:
"""
model=OllamaLLM(model="llama3.2")
prompt=ChatPromptTemplate.from_template(templates)
chain=prompt|model
app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins="*")
memory=[]
def handlechat(text):
    result=chain.invoke({"context":memory,"Question":text})
    memory.append("User:"+text+'\n')
    memory.append("Mentor:"+result+'\n')
    text_to_speech.text_to_speech(result)



@app.route('/')
def index():
    return "Flask SocketIO Server is Running!"

# Function to convert text to speech and send back audio
def text_to_speech1(text):
    try:
        handlechat(text)
        audio_file = "output1.wav"

        # Convert audio to base64
        with open(audio_file, "rb") as f:
            audio_base64 = base64.b64encode(f.read()).decode("utf-8")

        # Send audio back to Flutter
        socketio.emit('audio_data', {'audio': audio_base64})
        print("📤 Sent audio response to Flutter")

        # Cleanup
        os.remove(audio_file)
    except Exception as e:
        print(f"⚠️ Error generating audio: {e}")

# Receive text from Flutter
@socketio.on('send_text')
def handle_text(data):
    text = data.get('text', '')
    print(f"📥 Received text: {text}")

    if text:
        text_to_speech1(text)

@socketio.on('connect')
def handle_connect():
    print("✅ Client connected")

@socketio.on('disconnect')
def handle_disconnect():
    print("❌ Client disconnected")

if __name__ == '__main__':
    socketio.run(app, host="0.0.0.0", port=5000, debug=True)
