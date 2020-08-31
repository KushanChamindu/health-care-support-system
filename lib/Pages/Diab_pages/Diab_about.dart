import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutube/flutube.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';

import '../Popupmenu.dart';

class Diab_about extends StatefulWidget {
  BaseAuth auth=Auth();
  @override
  _Diab_aboutState createState() => _Diab_aboutState();
}


class _Diab_aboutState extends State<Diab_about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: <Widget>[
          Popupmenu(auth: widget.auth,)
        ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Align(
          alignment: Alignment.center,
            child: Text(
              'About Diabetes',
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),
            ),
          ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 4, 0, 4),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/Diab_images/Doctor.png',
                    ),
                    radius: 20,
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ),] ,
      ),
        backgroundColor: Colors.grey[850],
    ),
      body: SingleChildScrollView(
        

          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              ),


                  Text(
                      'Facts about Diabetes that you should know',
                      style: TextStyle(

                        fontSize: 30,
                        color: Colors.amberAccent,
                        fontFamily: 'BalsamiqSans',

                      ),
                      textAlign: TextAlign.center
                  ),

                  Divider(height: 20,color: Colors.white,),

                  Text('What is Diabetes?',style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:'BalsamiqSans',decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double ,),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Image.asset('assets/Diab_images/diabbg.png',


                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Diabetes is one of the most common health disorders found all over the world. Approximately one in every 25 people are affected by Diabetes and a large population is predisposed to suffer from it. With all the advancements in modern medicine, we have failed to find a cure for it. We do not even know the exact causes of Diabetes. Today it has affected the entire world irrespective of the lifestyle, age and geographical loaction. \n\nDiabetes is a metabolic disorder. It is associated with a hormone called \‘insulin\' which is secreted by a gland known as \‘pancreas\' situated near the lower border of the stomach. Diabetes arises either from \‘deficiency of insulin\' or from \‘inability of cells to utilize the available insulin\'. It is basically the \‘lack of action\' of insulin that brings about Diabetes. This disorder affects the whole metabolism of the body. Modern sciences have failed to explain with certainty why the pancreas stops the production of insulin or why body cells develop resistance to insulin.',
                    style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
                  ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Causes of Diabetes',style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:'BalsamiqSans',decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double ,),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(child: Image.asset('assets/Diab_images/diabbg2.jpg', )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                 child: Text('The causes of diabetes are still not known but there are certain predisposing factors that considerably increase the chances of developing diabetes. Some predisposing factors are',
                   style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
          ),
              Row(children: <Widget>[
                new MyBullet(),
                Text('Obesity',style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Montserrat'),),
              ],),
              Row(children: <Widget>[
                new MyBullet(),
                Text('A sedentary lifestyle with very less physical activity',style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Montserrat'),),
              ],),
              Row(children: <Widget>[
                new MyBullet(),
                Text('Family history of diabetes',style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Montserrat'),),
              ],),
              Row(children: <Widget>[
                new MyBullet(),
                Text('Old Age',style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Montserrat'),),
              ],),
              Row(children: <Widget>[
                new MyBullet(),
                Text('Eating foods which contain excessive carbohydrates',style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Montserrat'),),

              ],),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('What actually happens!!!',style: TextStyle(color: Colors.white,fontSize: 25,fontFamily:'BalsamiqSans',decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double ,),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(child: Image.asset('assets/Diab_images/what_actually.jpeg', )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('When we eat food, it is digested in the digestive tract beginning from the mouth. Complex food is broken down into simpler foods such as glucose, amino acids, fatty acids, vitamins, etc. which can be absorbed in the blood. In a normal human being, the glucose produced in this way is acted upon by a hormone called insulin which helps in taking this glucose to all body cells for their energy needs and converts the \‘leftover\' glucose into glycogen. Thus, the chief role of insulin is to regulate the glucose level in the blood. Sometimes, for unknown reasons, either the Pancreas gland stops producing insulin or the body cells develop the inability to utilize the available insulin, thereby causing glucose level in the blood to rise which eventually results in diabetes. More than 90% of all diabetics suffer from the type of diabetes that is caused by the inability of body cells to utilize the available insulin to regulate the glucose level.\n\nWhen body cells do not receive glucose for their energy needs, they begin to starve. To supplement the energy needs, the body starts disintegrating the stored fats and proteins leading to loss of weight, fatigue, weakness and several other complications.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
//              MyApp(),







            ],

          ),
        )
      ,



    );
  }
}
class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 4, 3),
      child: new Container(
        height: 8.0,
        width: 8.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final List<String> playlist = <String>[
    'https://www.youtube.com/watch?v=JAjZv41iUJU',

  ];
  int currentPos;
  String stateText;

  @override
  void initState() {
    currentPos = 0;
    stateText = "Video not started";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  return Column(
          children: <Widget>[

            FluTube.playlist(
              playlist,
              autoInitialize: true,
              aspectRatio: 16 / 9,
              allowMuting: false,
              looping: true,

              deviceOrientationAfterFullscreen: [
                DeviceOrientation.portraitUp,
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
              systemOverlaysAfterFullscreen: SystemUiOverlay.values,
              onVideoStart: () {
                setState(() {
                  stateText = 'Video started playing!';
                });
              },
              onVideoEnd: () {
                setState(() {
                  stateText = 'Video ended playing!';
                  if((currentPos + 1) < playlist.length)
                    currentPos++;
                });
              },
            ),
          Text (stateText),
          ],
        );

  }
}

