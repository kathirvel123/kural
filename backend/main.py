from langchain_ollama import OllamaLLM
from langchain_core.prompts import ChatPromptTemplate
import text_to_speech
import os
templates="""
Read the input and correct any grammatical mistakes, or suggest a different way to phrase it. If the input is already correct, provide a response confirming it.

Here is the conversation history: {context}

Question: {Question}

Answer:
"""
def handle_conversation():
    context=''
    while True:
        user=input("User:")
        if user.lower()=='exit':
            break
        result=chain.invoke({"context":context,"Question":user})
        text_to_speech.text_to_speech(result)
        os.startfile("output1.wav")
        print("Bot:"+result)
        context+=f"\nUser:{user}\nAI:{result}"


model=OllamaLLM(model="llama3.2")
prompt=ChatPromptTemplate.from_template(templates)
chain=prompt|model
handle_conversation()