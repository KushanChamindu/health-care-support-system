import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import '../../Popupmenu.dart';
import '../shared/loading.dart';
import 'package:http/http.dart' as http;

class BreastCancerPrediction extends StatefulWidget {
  final BaseAuth auth=Auth();

  @override
  _BreastCancerPredictionState createState() => _BreastCancerPredictionState();
}

class _BreastCancerPredictionState extends State<BreastCancerPrediction> {
  final _formkey = GlobalKey<FormState>();

  String error ="";
  static const String BOT_URL = "https://breastcancerdetection.herokuapp.com/predict"; 
  bool loading =false;

  String radiusMean;
  String textureMean;
  String perimeterMean;
  String areaMean;
  String smoothnessMean;
  String compactnessMean;
  String concavityMean;
  String concavePointsMean;
  String symmetryMean;
  String fractalDimensionMean;
  String radiusSe;
  String textureSe;
  String perimeterSe;
  String areaSe;
  String smoothnessSe;
  String compactnessSe;
  String concavitySe;
  String concavePointsSe;
  String symmetrySe;
  String fractalDimensionSe;
  String radiusWorst;
  String textureWorst;
  String perimeterWorst;
  String areaWorst;
  String smoothnessWorst;
  String compactnessWorst;
  String concavityWorst;
  String concavePointsWorst;
  String symmetryWorst;
  String fractalDimentionWorst;

  @override
  Widget build(BuildContext context) {
    final UID args = ModalRoute.of(context).settings.arguments;
    return loading ? Loading() :Scaffold(
      appBar:AppBar(
        actions: <Widget>[
          Popupmenu(auth: widget.auth,)
        ],
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Predictions...- Breast Cancer",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        //centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body:Center(
        child: ListView(
          children: <Widget>[
            Image.asset(
            'assets/breast_cancer_image/predict.png',
            width: 600,
            height: 250,
            fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text(
              'Get acquainted with our system before getting started',
              style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Cairo',
                          backgroundColor: Colors.grey[300],
                          fontWeight: FontWeight.w100
              ),
              softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              child: FlatButton(
              onPressed: (){
                Navigator.pushNamed(context, '/predictionhelp');
              }, 
                child: Text('About'),
                color: Colors.lightBlueAccent,
           ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      "Take your time to fill the information (provide values atleast four decimal places)",
                      style: TextStyle(
                        fontSize: 18,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.red[800],
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      "Take your time to fill the information (provide values atleast four decimal places)",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),

            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Center(
                child: Form(
                  key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column (
                        children: <Widget>[
                          _buildText("Breast Radius"),
                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => radiusMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => radiusSe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => radiusWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in mm)/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ),
                        Column (
                        children: <Widget>[
                          _buildText("Texture of a Breast "),
                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => textureMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in un)/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => textureSe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in un)/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => textureWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in un)/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ), 
                        Column (
                        children: <Widget>[
                          _buildText("Breast Perimeter"),

                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => perimeterMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => perimeterSe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => perimeterWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in mm)/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ), 
                        Column (
                        children: <Widget>[
                          _buildText("Area of the Breast"),

                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => areaMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm(sq))/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => areaSe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm(sq))/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => areaWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in mm(sq))/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ), 
                        Column (
                        children: <Widget>[
                          _buildText("Smoothness of Breast"),

                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => smoothnessMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in un)/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => smoothnessSe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in un)/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => smoothnessWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in un)/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ), 
                        Column (
                        children: <Widget>[
                          _buildText("Breast Compactness"),

                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => compactnessMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in un)/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => compactnessSe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in un)/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => compactnessWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in un)/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ), 
                        Column (
                        children: <Widget>[
                          _buildText("Concavity in Breast"),

                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => concavityMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => concavitySe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => concavityWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in mm)/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ), 
                        Column (
                        children: <Widget>[
                          _buildText("Concave Points (Number of concave portions of the contour)"),

                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => concavePointsMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(""),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => concavePointsSe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(""),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => concavePointsWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(""),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ), 
                        Column (
                        children: <Widget>[
                          _buildText("Breast Symmetry"),

                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => symmetryMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => symmetrySe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => symmetryWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in mm)/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ), 
                        Column (
                        children: <Widget>[
                          _buildText("Fractal Dimension"),

                          Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Mean"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => fractalDimensionMean=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Se"),
                                          validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                          onChanged: (val){
                                            setState(() => fractalDimensionSe=val);
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("(in mm)/"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Worst"),
                                      validator: (val) => val.isEmpty ? 'Enter a value' : null,
                                      onChanged: (val){
                                            setState(() => fractalDimentionWorst=val);
                                          },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("(in mm)/"),
                              ),
                            ],
                          ),
                          SizedBox(height:20.0)
                        ],
                        ),  
                       ],
                     )

                )
                ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: FlatButton(
                child: Text("Predict"),
                color: Colors.lightBlueAccent,
                onPressed: () async{
                  if (_formkey.currentState.validate()){
                    setState(() => loading=true);

                    try{
                      final check = await InternetAddress.lookup("google.com");
                      if (check.isNotEmpty && check[0].rawAddress.isNotEmpty){
                        dynamic result = await _getResponse(args.uid);
                        if (result == null){
                          setState(() {
                          error='Connection error or information error';
                          loading=false;
                          });
                        }
                      }
                    }on SocketException catch(e){
                      setState(() {
                        error='Connection error or information error';
                        loading=false;
                      });
                    }

                  }
                }
                ),
            ),
              SizedBox(height: 6.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 16.0),
              )
          ],
        )
          )
      );
     
    
  }
http.Client _getClient(){
    return http.Client();
  }
Future _getResponse(String uid) async{
      var client = _getClient();
      try{
        client.post(BOT_URL, body:{'radiusMean':radiusMean ,'textureMean':textureMean,'perimeterMean':perimeterMean,'areaMean':areaMean,'smoothnessMean':smoothnessMean,'compactnessMean':compactnessMean,'concavityMean':concavityMean,'concavePointsMean':concavePointsMean,'symmetryMean':symmetryMean,'fractalDimensionMean':fractalDimensionMean,
                                  'radiusSe':radiusSe,'textureSe':textureSe,'perimeterSe':perimeterSe,'areaSe':areaSe,'smoothnessSe':smoothnessSe,'compactnessSe':compactnessSe,'concavitySe':concavitySe,'concavePointsSe':concavePointsSe,'symmetrySe':symmetrySe,'fractalDimensionSe':fractalDimensionSe,
                                  'radiusWorst':radiusWorst,'textureWorst':textureWorst,'perimeterWorst':perimeterWorst,'areaWorst':areaWorst,'smoothnessWorst':smoothnessWorst,'compactnessWorst':compactnessWorst,'concavityWorst':concavityWorst,'concavePointsWorst':concavePointsWorst,'symmetryWorst':symmetryWorst},)
        ..then((response){
          Map<String, dynamic> data = jsonDecode(response.body);
          _insertSingleItem(data['response'],uid);
           
          });
        client.close();
       return ('succes');
        
      }catch(e){
        print("Failed -> $e");
        client.close();
        return null;
      }
    }
  
void _insertSingleItem(String message,String uid){
  if (message=='0'){
    widget.auth.setBreastCancerPrediction(uid,3.0);
    Navigator.pushNamed(context, '/gresult'); 
  }else{
    widget.auth.setBreastCancerPrediction(uid,97.0);
    Navigator.pushNamed(context, '/bresult');
  }
  print(message);
  setState(() => loading=false);
  }

   Container _buildText(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
      child:Stack(
          children: <Widget>[
            // Stroked text as border.
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = Colors.green[800],
              ),
            ),
            // Solid text as fill.
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
    );
  }

}

