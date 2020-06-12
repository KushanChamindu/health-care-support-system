import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';

import '../../Popupmenu.dart';

class PredictionHelp extends StatefulWidget {
  final BaseAuth auth=Auth();

  @override
  _PredictionHelpState createState() => _PredictionHelpState();
}

class _PredictionHelpState extends State<PredictionHelp> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Popupmenu(auth: widget.auth,)
        ],
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "PredictionHelp- Breast Cancer",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        //centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
       body:ListView(
        children: <Widget>[
          _buildTextRow('What am I going to use..?'),
          _buildTextContainer('You are going to use machine learning model with a test accuracy of 97% to predict your breast cancer. '
                              'Do not hesitate to see your doctor if the outcome worsens. Be sure to maintain good habits.'),
          _buildTextRow('How does it work..?'),
          _buildTextContainer('Be sure to provide valid information. All input numbers only.'),
          _buildText('The Mean (Mean of the each measurement') ,
          _buildText('SE (Standard error of measerment)') ,
          _buildText('Worst (or largest - mean of the three largest values)') ,
          _buildTextRow('Some calculations you may need..'),
          _buildContainerColumn('Breast Radius', 'mean of distances from center to points on the perimeter','assets/breast_cancer_image/RA.jpg'),
          _buildContainerColumn('Texture', 'standard deviation of gray-scale values','assets/breast_cancer_image/DCIS-1.jpg'),
          _buildContainerColumn('Perimeter', '','assets/breast_cancer_image/pe.jpg'),
          _buildContainerColumn('Area', '','assets/breast_cancer_image/DCIS-1.jpg'),
          _buildContainerColumn('Smoothness', 'local variation in radius lengths','assets/breast_cancer_image/DCIS-1.jpg'),
          _buildContainerColumn('Compactness' , 'perimeter² / area — 1.0','assets/breast_cancer_image/DCIS-1.jpg'),
          _buildContainerColumn('Concavity','severity of concave portions of the contourBreast Radius','assets/breast_cancer_image/DCIS-1.jpg'),
          _buildContainerColumn('Concave points','number of concave portions of the contour','assets/breast_cancer_image/cp.png'),
          _buildContainerColumn('Symmetry', '','assets/breast_cancer_image/sy.jpg'),
          _buildContainerColumn('Fractal dimension','“coastline approximation” — 1','assets/breast_cancer_image/fd.png'),

        ],
      )
    );
  }

  Row _buildTextRow(String label) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    label ,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),   
              ],
            ),
          ),
        ),
      ],
    );
  }

 Container _buildTextContainer(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 0, 24, 24),
      child: Text(
        text,
            style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Cairo',
            ),
        softWrap: true,  
      ),
    );
  }

   Container _buildText(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0.0, 24),
      child: Text(
        text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            fontFamily: 'Cairo',
            backgroundColor: Colors.grey[400],
          ),
        ),
    );
  }

  Column _buildContainerColumn(String label,String description, String url) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:Text(
                  label,
                  style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        fontFamily: 'Cairo',
                      ),
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:Text(
                description,
                style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Cairo',
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 15),
              child: Container(
                child: Image.asset(
                url,
                  width: 555,
                  height: 259,
                fit: BoxFit.cover,
          ),
              ),
            ),
          ],

     
    );
  }
}