import urllib
import json
import os
import  pandas as pd

from flask import Flask
from flask import request
from flask import make_response
import pickle

# Flask app should start in global layout
app = Flask(__name__)
model=pickle.load(open('model.pkl','rb')) 
global a
a=[]
@app.route('/webhook', methods=['POST'])
def webhook():
    req = request.get_json(silent=True, force=True)
    res = json.dumps(req['queryResult']['parameters'], indent=4)
    int_features=json.loads(res)
    a.append(int_features)
    
    if(len(a)==13):
         
        r=get_data(a)
        print(r)
        r=json.dumps(r)
        
        result = make_response(r)
        print(result)
        result.headers['Content-Type'] = 'application/json'
        return result
    else:
        return None
    
     
    
     
    #r = make_response(result)
    #r.headers['Content-Type'] = 'application/json'
     
 
def get_data(int_features):
   dic={}
   for d in int_features:
        dic={**dic,**d} 
   final_features=pd.DataFrame({'age':[int(dic['age'][0]['amount'])],'sex':[int(dic['sex'])],'cp':[int(dic['cp'])],'trestbps':[int(dic['trestbps'])],'chol':[int(dic['chol'])],'fbs':[int(dic['fbs'])],'restecg':[int(dic['restecg'])],'thalach':[int(dic['thalach'])],'exang':[int(dic['exang'])],'oldpeak':[float(dic['oldpeak'])],'slope':[float(dic['slope'])],'ca':[int(dic['ca'])],'thal':[int(dic['thal'])]})
   prediction=model.predict_proba(final_features)
   #output='{0:.{1}f}'.format(prediction[0][1],2)
   output=prediction[0][1]*100
   if output >=50:
        pred='You have '+ str(output)+'%'+' possibility of having heart disease.Please take immediate action to cure your self.'
   elif 30<=output<=50:
        pred='You have '+ str(output)+'%'+' possibility of having heart disease.Please take any actions and precautions to not to get a heart disease.'
   elif output<=30:
        pred='You have '+ str(output)+'%'+' possibility of having heart disease.You are safe'
     
    
   return {
       "fulfillmentText" : pred,
   }
 

 
     
if __name__ == '__main__':
    port = int(os.getenv('PORT', 80))

    print ("Starting app on port %d" %(port))

    app.run(debug=True, port=port, host='0.0.0.0')
