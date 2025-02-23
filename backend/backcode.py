from flask import Flask
from flask_cors import CORS  # Import CORS for HTTP
from flask_socketio import SocketIO, emit

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your_secret_key'

# Enable CORS for HTTP requests
CORS(app, resources={r"/*": {"origins": "*"}})

# Enable CORS for WebSockets
socketio = SocketIO(app, cors_allowed_origins="*")  

@socketio.on('connect')
def handle_connect():
    print("✅ Client connected")
    emit('server_response', {'message': 'Connected to Flask WebSocket'})

@socketio.on('disconnect')
def handle_disconnect():
    print("❌ Client disconnected")

@socketio.on('message')
def handle_message(data):
    print(f"📩 Received message: {data}")
    emit('server_response', {'message': f"Server received: {data}"}, broadcast=True)

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000, debug=True, use_reloader=False)
