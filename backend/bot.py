import ollama
import os
import text_to_speech
import json
class EnglishMentor:
    def __init__(self, model="llama3.2", name="Lexi", memory_file="memory.json"):
        self.model = model
        self.name = name
        self.memory_file = memory_file
        self.history = self.load_memory()
        self.system_prompt = (
            f"You are {self.name}, an AI English mentor. Chat naturally, correct grammar, "
            "and suggest better phrasing while maintaining context."
        )

    def load_memory(self):
        """Load conversation history from a JSON file."""
        if os.path.exists(self.memory_file):
            with open(self.memory_file, "r") as file:
                try:
                    return json.load(file)
                except json.JSONDecodeError:
                    return []  # Return empty history if file is corrupted
        return []

    def save_memory(self):
        """Save conversation history to a JSON file."""
        with open(self.memory_file, "w") as file:
            json.dump(self.history, file, indent=4)

    def chat(self, user_input):
        self.history.append({"role": "user", "content": user_input})
        if len(self.history) > 10:
            self.history.pop(0)  # Limit memory size

        messages = [{"role": "system", "content": self.system_prompt}] + self.history
        response = ollama.chat(model=self.model, messages=messages)
        bot_reply = response['message']['content']

        self.history.append({"role": "assistant", "content": bot_reply})
        self.save_memory()  # Save after each conversation
        return bot_reply
if __name__ == "__main__":
    mentor = EnglishMentor()
    print("Lexi: Hi! Let's practice English. (Type 'exit' to quit)")

    while True:
        user_input = input("You: ")
        if user_input.lower() == "exit":
            print("Lexi: Goodbye! Keep practicing. 😊")
            break
        answer=mentor.chat(user_input)
        text_to_speech.text_to_speech(answer)
        os.startfile("output1.wav")
        print(f"Lexi: {answer}")
