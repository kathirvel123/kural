import torch
from faster_whisper import WhisperModel

# Detect GPU and adjust settings
device = "cuda" if torch.cuda.is_available() else "cpu"
compute_type = "float16" if device == "cuda" else "int8"

# Load the model with optimal settings
model = WhisperModel("large-v3", device=device, compute_type=compute_type, cpu_threads=8)

# Transcribe with optimizations
segments, info = model.transcribe(
    "output1.wav",
    beam_size=1,          # Lower beam size for faster processing
    vad_filter=True       # Enable VAD to skip silent parts
)

# Display transcription results
for segment in segments:
    print(f"[{segment.start:.2f}s -> {segment.end:.2f}s] {segment.text}")
