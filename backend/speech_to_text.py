import os
import torch
import numpy as np
import pyaudio
import wave
from faster_whisper import WhisperModel
import tempfile
device = "cuda" if torch.cuda.is_available() else "cpu"
model = WhisperModel("small", device=device, compute_type="int8")
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 16000
CHUNK = 1024
audio = pyaudio.PyAudio()
stream = audio.open(format=FORMAT, channels=CHANNELS, rate=RATE, 
                    input=True, frames_per_buffer=CHUNK)

print("Listening... Speak in English.")

try:
    while True:
        frames = []
        for _ in range(int(RATE / CHUNK * 3)):
            data = stream.read(CHUNK)
            frames.append(data)
        temp_audio = tempfile.NamedTemporaryFile(delete=False, suffix=".wav")
        temp_audio_name = temp_audio.name
        temp_audio.close()  
        with wave.open(temp_audio_name, 'wb') as wf:
            wf.setnchannels(CHANNELS)
            wf.setsampwidth(audio.get_sample_size(FORMAT))
            wf.setframerate(RATE)
            wf.writeframes(b''.join(frames))
        _, lang_info = model.transcribe(temp_audio_name, vad_filter=True)

        detected_lang = lang_info.language

        if detected_lang == "en":
            segments, _ = model.transcribe(temp_audio_name, vad_filter=True, language="en")
            for segment in segments:
                print(f"[{segment.start:.2f}s -> {segment.end:.2f}s] {segment.text}")
        else:
            print(f"Non-English speech detected ({detected_lang}). Please speak in English.")
        os.remove(temp_audio_name)

except KeyboardInterrupt:
    print("\nStopping...")
    stream.stop_stream()
    stream.close()
    audio.terminate()
