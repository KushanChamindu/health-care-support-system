import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Popupmenu.dart';

class CKDMessageAbout extends StatelessWidget {
  final BaseAuth auth = Auth();

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
                    label,
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
      padding: const EdgeInsets.fromLTRB(32, 0, 24, 5),
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

  Column _buildContainerColumn(String label, String description, String url) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
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
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
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
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: ValueKey('CKDDiscriptionBackButton'),
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Prediction help - CKD',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 4, 0, 4),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/CKD_image/Doctor.png',
                  ),
                  radius: 20,
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Popupmenu(
            auth: auth,
          )
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildTextRow('How do I get predictions?'),
              Align(
                alignment: Alignment.topRight,
                  child: Image.asset(
                'assets/CKD_image/get_predict_idea.png',
                height: 160,
                width: 100,
              )),
              Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: _buildTextContainer(
                    'First of all you should get blood and urea reports. Then message with doctor for get predictions. When you prompt predictions doctor ask some questions. You can find answers from the urea report, blood reports or your past disease.'),
              ),
            ],
          ),
          _buildTextContainer(
              'After answering all questions doctor put your details to the Medical Machine learning model which has 96% test accuracy'),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/CKD_image/doctor_question.png',
                  height: 160,
                  width: 140,

                ),
              ),
              _buildTextRow(
                  'What if you don\'t understand what the doctor is asking?'),
              Padding(
                padding: const EdgeInsets.only(top:90),
                child: _buildTextContainer('Here we explain, what will doctor ask from you... If do not understand please read more info of CKD.'),
              ),
            ],
          ),
          _buildContainerColumn('Blood Pressure', 'When your heart beats, it pumps blood round your body to give it the energy and oxygen it needs. As the blood moves, it pushes against the sides of the blood vessels. The strength of this pushing is your blood pressure. If your blood pressure is too high, it puts extra strain on your arteries (and your heart) and this may lead to heart attacks and strokes', 'assets/CKD_image/bloodPreasure.jpg'),
          FlatButton.icon(
            icon: Icon(Icons.launch),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed: () async => await launch(
                'https://www.heart.org/en/health-topics/high-blood-pressure/understanding-blood-pressure-readings',
                forceWebView: false,
                forceSafariVC: false),
            label: Text('More Info about Blood preasure'),),
          SizedBox(
            height: 20,
          ),
          _buildContainerColumn('Albumin Level', 'Albumin is a protein made by your liver. Albumin helps keep fluid in your bloodstream so it doesn\'t leak into other tissues. It is also carries various substances throughout your body, including hormones, vitamins, and enzymes. Low albumin levels can indicate a problem with your liver or kidneys.', ''),
        ],
      ),
    );
  }
}
