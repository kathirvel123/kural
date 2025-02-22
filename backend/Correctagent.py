import ollama
import json

class GrammarCorrector:
    def __init__(self, model="llama3.2"):
        self.model = model
        self.system_prompt = (
            "You are an AI English mentor. Your task is to analyze a user's sentence and identify grammar mistakes. "
            "For each mistake, suggest the correct phrase. Ignore AI responses and process only user messages. "
            "Return the result in a JSON format with 'original', 'correction', and 'explanation'."
        )

    def analyze_conversation(self, conversation):
        results = []
        for entry in conversation:
            if "user" in entry:  # Only process user messages
                user_message = entry["user"]
                response = ollama.chat(model=self.model, messages=[
                    {"role": "system", "content": self.system_prompt},
                    {"role": "user", "content": f"Analyze this sentence: '{user_message}'"}
                ])
                
                # Extract AI response
                corrected_text = response['message']['content']
                
                results.append({
                    "original": user_message,
                    "correction": corrected_text
                })

        return results

    def process_json_file(self, input_file, output_file):
        with open(input_file, "r") as file:
            conversation = json.load(file)  # Load JSON file
        
        corrections = self.analyze_conversation(conversation)

        with open(output_file, "w") as file:
            json.dump(corrections, file, indent=4)  # Save corrections to file

        print(f"Corrections saved to {output_file}")

# Example Usage
if __name__ == "__main__":
    corrector = GrammarCorrector()
    
    input_json = "conversation.json"  # Your input file
    output_json = "corrections.json"  # Output file with grammar fixes
    
    corrector.process_json_file(input_json, output_json)
