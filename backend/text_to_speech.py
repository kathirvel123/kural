import torch
from kokoro import KPipeline
import soundfile as sf
import numpy as np
device = "cuda" if torch.cuda.is_available() else "cpu"
pipeline = KPipeline(lang_code='a', device=device)

def text_to_speech(text, output_file="output1.wav", voice="af_heart", speed=1):
    generator = pipeline(text, voice=voice, speed=speed, split_pattern=r'\n+')
    audio_data = []
    for _, _, audio in generator:
        audio_data.append(audio)
    final_audio = np.concatenate(audio_data)
    sf.write(output_file, final_audio, 24000)
    print(f"Audio saved as {output_file}")


