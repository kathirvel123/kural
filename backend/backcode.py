from flask import Flask
app=Flask('__init__')

@app.route("/login",method=["POST","GET"])
def home():
    return "kathirvel"


if __name__=="__main__":
    app.run(debug=True)