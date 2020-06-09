import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Popupmenu.dart';

class CKD_webview extends StatefulWidget {
  final BaseAuth auth = Auth();

  @override
  _CKD_webviewState createState() => _CKD_webviewState();
}

//key: ValueKey('webviewBackButton')
class _CKD_webviewState extends State<CKD_webview> {
  Widget _BuildTiles(List data, bool aboveTitle, bool belowDescription) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: ExpansionTile(
        leading: Icon(
          Icons.bubble_chart,
          color: Colors.black,
        ),
        title: Text(
          data[0],
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        children: <Widget>[
          aboveTitle == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data[1],
                    style: TextStyle(
                      fontSize: 15.5,
                      height: 1.2,
                      letterSpacing: 0.3,
                    ),
                  ),
                )
              : Container(),
          Column(
            children: _PointformData(data, aboveTitle),
          ),
          belowDescription == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data[data.length - 1],
                    style: TextStyle(
                      letterSpacing: 0.3,
                      height: 1.5,
                      fontSize: 15.5,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  List<Widget> _PointformData(List data, bool aboveTitle) {
    List<Widget> _listWidget = [];
    var a;
    for (var i = 2;
        i <= (aboveTitle == true ? data.length - 2 : data.length - 1);
        i = i + 2) {
      aboveTitle == false ? a = i - 1 : a = i;
      _listWidget.add(
        ListTile(
          title: Text(
            i % 2 == 0 ? data[a] : data[a + 1],
            style: TextStyle(
              height: 1.2,
              letterSpacing: 0.3,
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5),
            child: Text(
              i % 2 == 0 ? data[a + 1] : data[a + 2],
              style: TextStyle(
                height: 1.2,
                letterSpacing: 0.3,
                fontSize: 15.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
    return _listWidget;
  }

  List<Widget> _extraKnowledge(List data, String image, bool isDividerExist) {
    return [
      Image.asset(
        image,
        fit: BoxFit.fill,
        height: 300,
        width: MediaQuery.of(context).size.width,
      ),
      ListTile(
        title: Text(
          data[0],
          style: TextStyle(
            height: 1.2,
            letterSpacing: 0.3,
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 8,
          ),
          child: Text(
            data[1],
            style: TextStyle(
              height: 1.2,
              letterSpacing: 0.3,
              fontSize: 15.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      isDividerExist == true
          ? Divider(
              height: 10,
              color: Colors.black87,
            )
          : Container(),
    ];
  }

  List<String> Stages = [
    'Chronuc kidney disease Stages',
    'Changes in the Glomerular filtration rate (GFR) can assess how advanced the kidney disease is. In the UK, and many other countries, kidney disease stages are classified as follows:',
    'Stage 1',
    'GFR rate is normal. However, evidence of kidney disease has been detected.',
    'Stage 2',
    'GFR rate is lower than 90 milliliters, and evidence of kidney disease has been detected.',
    'Stage 3',
    'GFR rate is lower than 60 milliliters, regardless of whether evidence of kidney disease has been detected.',
    'Stage 4',
    'GRF rate is lower than 30 milliliters, regardless of whether evidence of kidney disease has been detected.',
    'Stage 5',
    'GFR rate is lower than 15 milliliters. Renal failure has occurred.',
    'The majority of patients with chronic kidney disease rarely progress beyond Stage 2. It is important for kidney disease to be diagnosed and treated early for serious damage to be prevented.' +
        '\n'
            'Patients with diabetes should have an annual test, which measures microalbuminuria (small amounts of protein) in urine. This test can detect early diabetic nephropathy (early kidney damage linked to diabetes).'
  ];
  List<String> Treatment = [
    'Treatment',
    'There is no current cure for chronic kidney disease. However, some therapies can help control the signs and symptoms, reduce the risk of complications, and slow the progression of the disease.' +
        '\n' +
        'Patients with chronic kidney disease typically need to take a large number of medications. Treatments include:',
    'Anemia treatment',
    'Hemoglobin is the substance in red blood cells that carries vital oxygen around the body. If hemoglobin levels are low, the patient has anemia.' +
        '\n' +
        'Some kidney disease patients with anemia will require blood transfusions. A patient with kidney disease will usually have to take iron supplements, either in the form of daily ferrous sulfate tablets, or occasionally in the form of injections.',
    'Phosphate balance',
    'People with kidney disease may not be able to eliminate phosphate from their body properly. Patients will be advised to reduce their nutritional phosphate intake – this usually means reducing consumption of dairy products, red meat, eggs, and fish.',
    'High blood pressure',
    'High blood pressure is a common problem for patients with chronic kidney disease. It is important to bring the blood pressure down to protect the kidneys, and subsequently slow down the progression of the disease.',
    'Skin itching',
    ' Antihistamines, such as chlorphenamine, may help alleviate symptoms of itching.',
    'Anti-sickness medications',
    'If toxins build up in the body because the kidneys don’t work properly, patients may feel sick (nausea). Medications such as cyclizine or metaclopramide help relieve sickness.',
    ' NSAIDs (nonsteroidal anti-inflammatory drugs)',
    'NSAIDs, such as aspirin or ibuprofen should be avoided and only taken if a doctor recommends them.',
    'End-stage treatment',
    'This is when the kidneys are functioning at less than 10-15 percent of normal capacity. Measures used so far – diet, medications, and treatments controlling underlying causes – are no longer enough. The kidneys of patients with end-stage kidney disease cannot keep up with the waste and fluid elimination process on their own – the patient will need dialysis or a kidney transplant in order to survive.' +
        '\n' +
        'Most doctors will try to delay the need for dialysis or a kidney transplant for as long as possible because they carry the risk of potentially serious complications.',
    'Kidney transplant',
    'The kidney donor and recipient should have the same blood type, cell-surface proteins and antibodies, in order to minimize the risk of rejection of the new kidney. Siblings or very close relatives are usually the best types of donors. If a living donor is not possible, the search will begin for a cadaver donor (dead person).',
  ];
  List<String> Diet = [
    'Diet',
    'Following a proper diet is vital for effective kidney failure treatment. Restricting the amount of protein in the diet may help slow down the progression of the disease.' +
        '\n' +
        'Diet may also help alleviate symptoms of nausea.' +
        '\n' +
        'Salt intake must be carefully regulated to control hypertension. Potassium and phosphorus consumption, over time, may also need to be restricted.',
    'Vitamin D',
    'Patients with kidney disease typically have low levels of vitamin D. Vitamin D is essential for healthy bones. The vitamin D we obtain from the sun or food has to be activated by the kidneys before the body can use it. Patients may be given alfacalcidol, or calcitriol.',
    'Fluid retention',
    ' People with chronic kidney disease need to be careful with their fluid intake. Most patients will be asked to restrict their fluid intake. If the kidneys do not work properly, the patient is much more susceptible to fluid build-up.',
  ];
  List<String> Causes = [
    'Causes',
    'Kidneys carry out the complex system of filtration in our bodies – excess waste and fluid material are removed from the blood and excreted from the body.' +
        '\n' +
        'In most cases, kidneys can eliminate most waste materials that our body produces. However, if the blood flow to the kidneys is affected, they are not working properly because of damage or disease, or if urine outflow is obstructed, problems can occur.' +
        '\n' +
        'In most cases, progressive kidney damage is the result of a chronic disease (a long-term disease), such as:',
    'Diabetes',
    'Chronic kidney disease is linked to diabetes types 1 and 2. If the patient’s diabetes is not well controlled, excess sugar (glucose) can accumulate in the blood. Kidney disease is not common during the first 10 years of diabetes; it more commonly occurs 15-25 years after diagnosis of diabetes.',
    'Hypertension (high blood pressure)',
    'High blood pressure can damage the glomeruli – parts of the kidney involved in filtering waste products.',
    'Obstructed urine flow ',
    'If urine flow is blocked it can back up into the kidney from the bladder (vesicoureteral reflux). Blocked urine flow increases pressure on the kidneys and undermines their function. Possible causes include an enlarged prostate, kidney stones, or a tumor.',
    'Kidney diseases',
    'Including polycystic kidney disease, pyelonephritis, or glomerulonephritis.',
    'Kidney artery stenosis',
    'The renal artery narrows or is blocked before it enters the kidney.',
    'Certain toxins ',
    'Including fuels, solvents (such as carbon tetrachloride), and lead (and lead-based paint, pipes, and soldering materials). Even some types of jewelry have toxins, which can lead to chronic kidney failure.',
    'Fetal developmental problem',
    'If the kidneys do not develop properly in the unborn baby while it is developing in the womb.',
    'Systemic lupus erythematosus ',
    'An autoimmune disease. The body’s own immune system attacks the kidneys as though they were foreign tissue.',
    ' Malaria and yellow fever',
    'Known to cause impaired kidney function.',
    'Some medications',
    'Overuse of, for example, NSAIDs (non-steroidal anti-inflammatory drugs), such as aspirin or ibuprofen.',
    'Illegal substance abuse',
    'Such as heroin or cocaine.',
    'Injury',
    'A sharp blow or physical injury to the kidney(s).',
  ];
  List<String> Diagnosis = [
    'Diagnosis',
    'A doctor will check for signs and ask the patient about symptoms. The following tests may also be ordered:',
    'Blood test ',
    'A blood test may be ordered to determine whether waste substances are being adequately filtered out. If levels of urea and creatinine are persistently high, the doctor will most likely diagnose end-stage kidney disease.',
    'Urine test',
    'A urine test helps find out whether there is either blood or protein in the urine.',
    'Kidney scans',
    'Kidney scans may include a magnetic resonance imaging (MRI) scan, computed tomography (CT) scan, or an ultrasound scan. The aim is to determine whether there are any blockages in the urine flow. These scans can also reveal the size and shape of the kidneys – in advanced stages of kidney disease the kidneys are smaller and have an uneven shape.',
    'Kidney biopsy',
    'A small sample of kidney tissue is extracted and examined for cell damage. An analysis of kidney tissue makes it easier to make a precise diagnosis of kidney disease.',
    'Chest X-ray ',
    'The aim here is to check for pulmonary edema (fluid retained in the lungs).',
    'Glomerular filtration rate (GFR)',
    'GFR is a test that measures the glomerular filtration rate – it compares the levels of waste products in the patient’s blood and urine. GFR measures how many milliliters of waste the kidneys can filter per minute. The kidneys of healthy individuals can typically filter over 90 ml per minute.'
  ];
  List<String> Prevention = [
    'Prevention',
    'Managing the chronic condition',
    'Some conditions increase the risk of chronic kidney disease (such as diabetes). Controlling the condition can significantly reduce the chances of developing kidney failure. Individuals should follow their doctor’s instructions, advice, and recommendations.',
    'Diet',
    'A healthy diet, including plenty of fruits and vegetables, whole grains, and lean meats or fish will help keep blood pressure down.',
    'Physical activity',
    'Regular physical exercise is ideal for maintaining healthy blood pressure levels; it also helps control chronic conditions such as diabetes and heart disease. Individuals should check with a doctor that an exercise program is suited to their age, weight, and health.',
    'Avoiding certain substances',
    'Including abusing alcohol and drugs. Avoid long-term exposure to heavy metals, such as lead. Avoid long-term exposure to fuels, solvents, and other toxic chemicals.'
  ];
  List<String> extra_1 = [
    'Normal kidney vs. diseased kidney',
    ' A normal kidney has about 1 million filtering units. Each unit, called a glomerulus, connects to a tubule, which collects urine. Conditions such as high blood pressure and diabetes take a toll on kidney function by damaging these filtering units and collecting tubules and causing scarring.'
  ];
  List<String> extra_2 = [
    'Polycystic kidney',
    "A healthy kidney (left) eliminates waste from the blood and maintains the body's normal chemical balance. Fluid-filled sacs (right), called cysts, characterize polycystic kidney disease."
  ];
  List<String> extra_3 = [
    'Kidney biopsy',
    'During a kidney biopsy, your doctor uses a needle to remove a small sample of kidney tissue for lab testing. The biopsy needle is inserted through your skin and is often directed using the guidance of an imaging device, such as ultrasound.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: ValueKey('webviewBackButton'),
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'CKD More info',
                style: TextStyle(fontSize: 15),
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
            auth: widget.auth,
          )
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 100,
                    child: Image.asset(
                      'assets/CKD_image/readingTime.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Image.asset(
                    'assets/CKD_image/raeadinf-time2.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                title: Text('Extra knowledge',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                leading: Icon(
                  Icons.bubble_chart,
                  color: Colors.black,
                ),
                children: <Widget>[
                  Column(
                    children: _extraKnowledge(extra_1,
                            'assets/CKD_image/diseases-kidney.jpg', true) +
                        _extraKnowledge(extra_2,
                            'assets/CKD_image/diseases-kidney-2.jpg', true) +
                        _extraKnowledge(extra_3,
                            'assets/CKD_image/diseases-kidney-3.jpg', false),
                  )
                ],
              ),
            ),
            _BuildTiles(Stages, true, true),
            _BuildTiles(Treatment, true, false),
            _BuildTiles(Diet, true, false),
            _BuildTiles(Causes, true, false),
            _BuildTiles(Diagnosis, true, false),
            _BuildTiles(Prevention, false, false),
            Card(
              child: ExpansionTile(
                leading: Icon(
                  Icons.bubble_chart,
                  color: Colors.black,
                ),
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8, 8, 8),
                  child: Text(
                    ' Video resources',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                      FlatButton.icon(onPressed: null, icon: Icon(Icons.launch), label: Text('ouahdh'),),
                        Container(
                          color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                ),
                                child: Text(
                                  'How kidneys work',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    height: 1.2,
                                    letterSpacing: 0.3,
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.launch),
                                onPressed: () async => await launch(
                                    'https://youtu.be/Jlcy3m_pYcw',
                                    forceWebView: false,
                                    forceSafariVC: false),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                ),
                                child: Text(
                                  'Hemodialysis',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    height: 1.2,
                                    letterSpacing: 0.3,
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.launch),
                                onPressed: () async => await launch(
                                    'https://youtu.be/IBzuIMNyBko',
                                    forceWebView: false,
                                    forceSafariVC: false),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                ),
                                child: Text(
                                  'Peritoneal dialysis',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    height: 1.2,
                                    letterSpacing: 0.3,
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.launch),
                                onPressed: () async => await launch(
                                    'https://youtu.be/HLoLBlfV2LM',
                                    forceWebView: false,
                                    forceSafariVC: false),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
