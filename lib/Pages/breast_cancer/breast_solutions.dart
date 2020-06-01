import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/Constant.dart';

import '../Popupmenu.dart';

class BC_Solutions extends StatelessWidget {
  final BaseAuth auth=Auth();

  @override
  Widget build(BuildContext context) {

    List precautions = [
      'Be physically active...Physical activity can help you maintain a healthy weight, which helps prevent breast cancer',
      'Limit alcohol.....The more alcohol you drink, the greater your risk of developing breast cancer. So, limit yourself to less than one drink a day, as even small amounts increase risk.',
      "Don't smoke'...... Evidence suggests a link between smoking and breast cancer risk, particularly in premenopausal womensyptoms 1",
      'Control your weight..... Being overweight or obese increases the risk of breast cancer',
      'Breast-feed.... The longer you breast-feed, the greater the protective effect',
      'Limit dose and duration of hormone therapy.... ',
      'Avoid exposure to radiation and environmental pollution.....',
    ];

    List image =[
      'assets/breast_cancer_image/physically.gif',
      'assets/breast_cancer_image/noalcohol.webp',
      'assets/breast_cancer_image/nosmoke.gif',
      'assets/breast_cancer_image/noweight.gif',
      'assets/breast_cancer_image/feed.gif',
      'assets/breast_cancer_image/Hormone_Therapy.jpg',
      'assets/breast_cancer_image/pollution.jpg',
    ];


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: ValueKey("BCSolutionBackButton"),
          icon: Icon(Icons.arrow_back),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          Popupmenu(auth: auth,)
        ],
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Precautions...- Breast Cancer",
            style: TextStyle(fontSize: 15),
          ),
        ),
        //centerTitle: true,
//        backgroundColor: Colors.lightBlue,
      ),
       body:ListView.builder(
           itemCount: precautions.length,
           itemBuilder: (context,index){
             return Card(
               child: Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Icon(Icons.blur_linear),
                   ),
                   Expanded(
                       child: Text(precautions[index],
                           style: TextStyle(
                             fontSize:17,
                             fontWeight: FontWeight.w800,
                             fontFamily: 'Cairo',
                           )
                       )
                   ),
                   Padding(
                     padding: const EdgeInsets.all(3.0),
                     child: Image.asset(image[index], width: 110,height: 100,),
                   ),
                 ],
               ),
             );
           }
       ),
    );
  }
}
