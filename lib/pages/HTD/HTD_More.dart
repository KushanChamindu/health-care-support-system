import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaredecision/pages/AppBar.dart';
import 'package:healthcaredecision/pages/HTD/HTD_details.dart';

class HTD_More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        body:new Column(
          children: <Widget>[
            new GradientAppBar("More Info",'/home'),
            new Body(),
          ],
        ),
      );
    }
}
// app bar

class Disease{
  final String name;
  final String image;
  final String image1;
  final String description;
  const Disease({this.name,this.image,this.image1,this.description});
}



//Disease ROW
class DiseaseRow extends StatelessWidget{

  final Disease disease;
  DiseaseRow(this.disease);

  @override
  Widget build(BuildContext context) {
    final DiseaseThumbnail= new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Hero(
        tag:"disease-hero-${disease.name}",
        child:new Image(
        image: new AssetImage(disease.image),
        height: 92.0,
        width: 92.0,
      ),),
    );

    final baseTextStyle = const TextStyle(
        fontFamily: 'Poppins'
    );
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400
    );
    final subHeaderTextStyle = regularTextStyle.copyWith(
        fontSize: 12.0
    );
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w600
    );



    final diseaseCardContent=new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(disease.name,style: headerTextStyle),
        ],
      ),
    );
    final diseaseCard=new Container(
      child: diseaseCardContent,
      height: 124,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Colors.lightBlue[900],
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new GestureDetector(onTap: ()=> Navigator.of(context).push(
        new PageRouteBuilder(pageBuilder:(_,__,___)=> new DetailPage(disease),)),
      child: new Container(
        height: 120,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            diseaseCard,
            DiseaseThumbnail,
          ],
        )),
    );//for routing
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        color: Colors.lightBlue[500],
        child: new CustomScrollView(
          scrollDirection:Axis.vertical,
         shrinkWrap: false,
         slivers: <Widget>[
          new SliverPadding(
              padding :const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
              delegate:new SliverChildBuilderDelegate(
                  (context,index)=> new DiseaseRow(diseases[index]),
                  childCount:diseases.length
            ),
),
),
],
),
),
);
}
}
List<Disease> diseases=[
    const Disease(
        name: "How the heart functions?",
        image:"assets/images/function.png",
        image1:"assets/images/heartfunction.gif",
        description:"The heart is an amazing organ. It pumps oxygen and nutrient-rich blood throughout your body to sustain life. This fist-sized powerhouse beats (expands and contracts) 100,000 times per day, pumping five or six quarts of blood each minute, or about 2,000 gallons per day.Your heart is a key part of your cardiovascular system, which also includes all your blood vessels that carry blood from the heart to the body and then back to the heart.\nHow Does Blood Travel Through the Heart?\nAs the heart beats, it pumps blood through a system of blood vessels, called the circulatory system. The vessels are elastic, muscular tubes that carry blood to every part of the body.Blood is essential. In addition to carrying fresh oxygen from the lungs and nutrients to the body's tissues, it also takes the body's waste products, including carbon dioxide, away from the tissues. This is necessary to sustain life and promote the health of all parts of the body.",),
    const Disease(
        name: "Heart Disease and the Doctor's Exam",
        image:"assets/images/diagnosis.png",
        image1:"assets/images/more1.gif",
        description:"Some standard and simple exams can give your doctor the first clues on whether you have heart disease.\nDuring your visit, your doctor will:\nListen to your heart:      \n Your doctor will use a stethoscope to hear your heartbeat.The opening and closing of your heart's valves make a 'LUB DUB' noise.The doctor can check your heart and valve health and hear your heart's rate and rhythm by listening to those sounds.\nCheck your blood pressure\n      He’ll feel your pulse to check your heart's rate and rhythm. Each pulse matches with a heartbeat that pumps blood into your arteries. The force of the pulse also helps the doctor know the strength of blood flow to different areas of your body.You can tell how fast your heart is beating by feeling your pulse. Your heart rate is the number of beats in 1 minute.To measure your pulse, all you need is a watch with a second hand."),
    const Disease(
        name: "When Do I Need a Chest X-Ray for Heart Disease?",
        image:"assets/images/chest.png",
        image1:"assets/images/chestxray.gif",
        description:"Your doctor has several ways to try to diagnose your heart disease. One of those is a chest X-ray\nIt uses a small amount of radiation to produce an image of your heart, lungs, and blood vessels.Your doctor uses a chest X-ray to:Look at your chest bones, heart, and lungsSee if your pacemaker, defibrillator, or other heart devices are in place\n check on any catheters and chest tubes you may have"),

    const Disease(
        name: "Heart Disease and Stress Tests",
        image:"assets/images/stresstest.png",
        image1:"assets/images/stresstest.gif",
        description:"A stress test can determine your risk of having heart disease. A doctor or trained technician performs the test. He’ll learn how much your heart can manage before an abnormal rhythm starts or blood flow to your heart muscle drops./nThere are different types of these. The exercise stress test -- also known as an exercise electrocardiogram, treadmill test, graded exercise test, or stress EKG -- is used most often. It lets your doctor know how your heart responds to being pushed. You’ll walk on a treadmill or pedal a stationary bike. It’ll get more difficult as you go. Your electrocardiogram, heart rate, and blood pressure will be tracked throughout.",),
    const Disease(
        name: "Echocardiogram",
        image:"assets/images/endo.png",
        image1:"assets/images/endotest.gif",
        description:"An echocardiogram is a test that uses ultrasound to show how your heart muscle and valves are working.The sound waves make moving pictures of your heart so your doctor can get a good look at its size and shape. You might hear them call it “echo” for short.Why Do I Need an Echocardiogram?\nYour doctor may order an echocardiogram to:\nLook for heart disease\nMonitor heart valve disease over time\nSee how well medical or surgical treatments are working",),
];
