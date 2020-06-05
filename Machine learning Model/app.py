import numpy as np
from flask import Flask, request, jsonify, render_template
import pickle

app= Flask(__name__)
model = pickle.load(open("model.pkl","rb"))

@app.route("/")
def home():
    return render_template("index.html")



@app.route("/predict",methods=["POST"])
def predict():
    features=[float(x) for x in request.form.values()]
    features_final=[np.array(features)]
    prediction= model.predict(features_final)
    if prediction == [1]:
        prediction = "has diabetes"
    else:
        prediction = "has no diabetes"

    return render_template("index.html",pred="The person {}".format(prediction))

if __name__ == "__main__":
    app.run(debug=True)

    
