from flask import Flask
from flask_socketio import SocketIO, emit
import text_to_speech
import base64
import os
from langchain_ollama import OllamaLLM
from langchain_core.prompts import ChatPromptTemplate

app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins="*")

# Store memory per user session
user_memory = {}

# Strict prompt for grammar correction
TEMPLATE = """
You are a friendly and engaging grammar teacher. Your goal is to help users improve their communication by correcting grammatical mistakes and rephrasing sentences naturally. 

🔹 If the user's sentence is incorrect, explain the mistake in a polite and encouraging way, then provide a corrected version.
🔹 If the sentence is correct, confirm it warmly and naturally.
🔹 Always maintain a conversational tone and keep the session engaging.
🔹 Keep track of the conversation history and remember past corrections.
🔹 Occasionally, ask the user to repeat previous sentences to check their improvement.
🔹 If they repeat a mistake, guide them patiently until they say it correctly.

### Conversation History:
{context}

👤 **User:** {Question}

📝 **Your Response:**

"""

# Initialize language model
model = OllamaLLM(model="llama3.2")
prompt = ChatPromptTemplate.from_template(TEMPLATE)
chain = prompt | model


def handle_chat(user_id, text):
    """Processes user input and corrects grammar while maintaining short memory."""
    global user_memory

    # Keep only the last 5 messages per user
    memory = user_memory.get(user_id, [])[-10:]

    # Generate corrected response
    response = chain.invoke({"context": memory, "Question": text})

    # Update user memory
    memory.append(f"User: {text}\n")
    memory.append(f"Mentor: {response}\n")
    user_memory[user_id] = memory  # Save back to dictionary

    # Convert text to speech
    text_to_speech.text_to_speech(response)  # Ensure this function generates `output1.wav`
    return response


@app.route('/')
def index():
    return "Flask SocketIO Server is Running!"


def text_to_speech1(user_id, text):
    """Handles text-to-speech conversion and sends audio back."""
    try:
        response = handle_chat(user_id, text)
        audio_file = "output1.wav"

        if os.path.exists(audio_file):
            with open(audio_file, "rb") as f:
                audio_base64 = base64.b64encode(f.read()).decode("utf-8")

            # Send audio response back to Flutter
            socketio.emit('audio_data', {'audio': audio_base64, 'user_id': user_id})
            print(f"📤 Sent audio response to user {user_id}")

            # Cleanup
            os.remove(audio_file)
        else:
            print("⚠️ Audio file not found!")

    except Exception as e:
        print(f"⚠️ Error generating audio: {e}")


@socketio.on('send_text')
def handle_text(data):
    """Receives text from Flutter and processes it."""
    text = data.get('text', '').strip()
    user_id = data.get('user_id')  # Unique ID for user session

    if not user_id:
        print("⚠️ Missing user_id!")
        return

    print(f"📥 Received text from user {user_id}: {text}")

    if text:
        text_to_speech1(user_id, text)
        emit('ack', {'status': 'received', 'user_id': user_id}, broadcast=True)


@socketio.on('connect')
def handle_connect():
    print("✅ Client connected")


@socketio.on('disconnect')
def handle_disconnect():
    """Clears user memory when they exit."""
    user_id = None  # Replace this with actual logic to fetch user ID
    if user_id and user_id in user_memory:
        del user_memory[user_id]
        print(f"🗑️ Cleared memory for user {user_id}")

    print("❌ Client disconnected")


if __name__ == '__main__':
    socketio.run(app, host="0.0.0.0", port=5000, debug=True)
