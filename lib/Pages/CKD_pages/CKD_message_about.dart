import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Popupmenu.dart';

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
            child: url != null
                ? Image.asset(
              url,
              fit: BoxFit.cover,
            )
                : null,
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
                padding: const EdgeInsets.only(top: 50.0),
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
                padding: const EdgeInsets.only(top: 90),
                child: _buildTextContainer(
                    'Here we explain, what will doctor ask from you... If do not understand please read more info of CKD.'),
              ),
            ],
          ),
          _buildContainerColumn(
              'Blood Pressure',
              'When your heart beats, it pumps blood round your body to give it the energy and oxygen it needs. As the blood moves, it pushes against the sides of the blood vessels. The strength of this pushing is your blood pressure. If your blood pressure is too high, it puts extra strain on your arteries (and your heart) and this may lead to heart attacks and strokes',
              'assets/CKD_image/bloodPreasure.jpg'),
          FlatButton.icon(
            icon: Icon(Icons.launch),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed: () async =>
            await launch(
                'https://www.heart.org/en/health-topics/high-blood-pressure/understanding-blood-pressure-readings',
                forceWebView: false,
                forceSafariVC: false),
            label: Text('More Info about Blood preasure'),
          ),
          SizedBox(
            height: 20,
          ),
          _buildContainerColumn(
              'Albumin Level',
              'Albumin is a protein made by your liver. Albumin helps keep fluid in your bloodstream '
                  'so it doesn\'t leak into other tissues. It is also carries various substances throughout your body, '
                  'including hormones, vitamins, and enzymes. Low albumin levels can indicate a problem with your liver or kidneys.'
                  ' The reference range for albumin concentrations in serum is approximately 35–50 g/L (3.5–5.0 g/dL). \n \u2055  Level zero -> below 3.5 g/dl'
                  '\n \u2055  Level one -> 3.5-3.875‬ g/dl'
                  '\n \u2055  Level two -> 3.875‬-4.25 g/dl'
                  '\n \u2055  Level three -> 4.25-4.625‬ g/dl'
                  '\n \u2055  Level four -> 4.625-5 g/dl'
                  '\n \u2055  Level Five -> above 5 g/dl',
              'assets/CKD_image/AlbuminLevels.jpg'),
          _buildContainerColumn(
              'Pus Cell clumps',
              'Normal numbers of pus cells are up to 5 in males and may be up to 10 in females. 𝙏𝙝𝙚 𝙥𝙧𝙚𝙨𝙚𝙣𝙘𝙚 𝙤𝙛 𝙥𝙪𝙨 𝙘𝙚𝙡𝙡𝙨 𝙞𝙣 𝙪𝙧𝙞𝙣𝙚 𝙞𝙨 𝙖𝙡𝙨𝙤 𝙘𝙖𝙡𝙡𝙚𝙙 𝙥𝙮𝙪𝙧𝙞𝙖, 𝙖𝙣𝙙 𝙞𝙨 𝙙𝙚𝙛𝙞𝙣𝙚𝙙 𝙖𝙨 >10 𝙥𝙪𝙨 𝙘𝙚𝙡𝙡𝙨 / 𝙢𝙞𝙘𝙧𝙤𝙡𝙞𝙩𝙧𝙚 𝙤𝙛 𝙪𝙧𝙞𝙣𝙚. Increased number of pus cells may reveal some destructive or healing process in the urinary tract, anywhere from kidney to the bladder. It usually is taken as indicative of an infection. Acute infections are most common cause of increased pus cells and get back to normal after couple of days of treatment.',
              null),
          _buildContainerColumn(
              'Blood Glucose Random',
              'A random glucose test is one method for measuring the amount of glucose or sugar circulating in a person’s blood.'
                  '\n Random glucose testing measures the levels of glucose in the blood at any given point in the day.'
                  '\nMany blood tests for diabetes involve either fasting or continuous monitoring, but this test does not.',
              'assets/CKD_image/bgr.png'),
          _buildContainerColumn(
              'Blood Urea concentration',
              'Results of the blood urea nitrogen test are measured in milligrams per deciliter (mg/dL) in the United States and in millimoles per liter (mmol/L) internationally. In general, around 7 to 20 mg/dL (2.5 to 7.1 mmol/L) is considered normal.'
                  'But normal ranges may vary, depending on the reference range used by the lab, and your age. Ask your doctor to explain your results.'
                  'Urea nitrogen levels tend to increase with age. Infants have lower levels than other people do, and the range in children varies.',
              'assets/CKD_image/bu.jpg'),
          _buildContainerColumn(
              'Sodium level',
              'A sodium blood test is pretty straightforward: It measures the amount of sodium in your blood.'
                  'Sodium is key to helping send electrical signals between cells and controlling the amount of fluid in your body. Your body needs it for your cells to work the right way.'
                  'Most foods have sodium in them. The most common form is sodium chloride, found in table salt. Your body loses a certain amount of sodium each day through sweat and when you go to the bathroom.'
                  '\n𝘼 𝙣𝙤𝙧𝙢𝙖𝙡 𝙗𝙡𝙤𝙤𝙙 𝙨𝙤𝙙𝙞𝙪𝙢 𝙡𝙚𝙫𝙚𝙡 𝙞𝙨 𝙗𝙚𝙩𝙬𝙚𝙚𝙣 135 𝙖𝙣𝙙 145 𝙢𝙞𝙡𝙡𝙞𝙚𝙦𝙪𝙞𝙫𝙖𝙡𝙚𝙣𝙩𝙨 𝙥𝙚𝙧 𝙡𝙞𝙩𝙚𝙧 (𝙢𝙀𝙦/𝙇)..'
                  '',
              null),
          _buildContainerColumn('Potassium level',
              'In the right amounts, the mineral potassium helps your nerves and muscles “talk” to each other, moves nutrients into and waste out of your cells, and helps your heart function.'
              'Kidney disease is a common cause of a high potassium level. Either high or low potassium levels can cause heart problems. Low potassium can cause muscle cramps.'
                  '\n𝗬𝗼𝘂𝗿 𝗯𝗼𝗱𝘆 𝘀𝗵𝗼𝘂𝗹𝗱 𝗺𝗮𝗶𝗻𝘁𝗮𝗶𝗻 𝗮 𝘀𝗽𝗲𝗰𝗶𝗳𝗶𝗰 𝗮𝗺𝗼𝘂𝗻𝘁 𝗼𝗳 𝗽𝗼𝘁𝗮𝘀𝘀𝗶𝘂𝗺 𝗶𝗻 𝘁𝗵𝗲 𝗯𝗹𝗼𝗼𝗱, 𝗿𝗮𝗻𝗴𝗶𝗻𝗴 𝗳𝗿𝗼𝗺 𝟯.𝟲 𝘁𝗼 𝟱.𝟮 𝗺𝗶𝗹𝗹𝗶𝗺𝗼𝗹𝗲𝘀 𝗽𝗲𝗿 𝗹𝗶𝘁𝗲𝗿 (𝗺𝗺𝗼𝗹/𝗟)',
              null),
          _buildContainerColumn('Hemoglobin concentration', '', 'assets/CKD_image/hemo.jpg'),
          _buildContainerColumn('Red Blood Cell Count', '', 'assets/CKD_image/rbc.jpg'),
          _buildContainerColumn('Diabetes Mellitus ', 'For more details visit Diabetes section',null)
        ],
      ),
    );
  }
}
