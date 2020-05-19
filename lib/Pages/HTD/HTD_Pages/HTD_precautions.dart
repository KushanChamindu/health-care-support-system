import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/HTD/AppBar.dart';
import 'package:healthcaresupportsystem/Pages/HTD/HTD_Pages/HTD_precaution_details.dart';
import 'package:healthcaresupportsystem/Pages/HTD/Style.dart';
class HTD_precautions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: ValueKey('HTD_precautionpage'),
      body:new Column(
        children: <Widget>[
          new GradientAppBar("Precautions",'/HTD_home'),
          new Body(),
        ],
      ),
    );
  }
}
// app bar

class Precaution{
  final String name;
  final String image;
  final String image1;
  final String description;
  const Precaution({this.name,this.image,this.description,this.image1});
}



//Disease ROW
class PrecautionRow extends StatelessWidget{

  final Precaution precaution;
  PrecautionRow(this.precaution);

  @override
  Widget build(BuildContext context) {
    final PrecautionThumbnail= new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Hero(
        tag:"disease-hero-${precaution.name}",
        child:new Image(
          image: new AssetImage(precaution.image),
          height: 92.0,
          width: 92.0,
        ),),
    );





    final precautionCardContent=new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(precaution.name,style: Style.headerTextStyle),
        ],
      ),
    );
    final precautionCard=new Container(
      child: precautionCardContent,
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
        new PageRouteBuilder(pageBuilder:(_,__,___)=> new DetailPage(precaution),)),
      child: new Container(
          height: 120,
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              precautionCard,
              PrecautionThumbnail,
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
        color: Colors.lightBlue[100],
        child: new CustomScrollView(
          scrollDirection:Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding :const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate:new SliverChildBuilderDelegate(
                        (context,index)=> new PrecautionRow(precautions[index]),
                    childCount:precautions.length
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
List<Precaution> precautions=[
  const Precaution(
    name: "Don't smoke or use tobacco",
    image:"assets/HTD/images/smoking.png",
    image1:"assets/HTD/images/precaution1.gif",
    description:"One of the best things you can do for your heart is to stop smoking or using smokeless tobacco. Even if you're not a smoker, be sure to avoid secondhand smoke.\nChemicals in tobacco can damage your heart and blood vessels.Cigarette smoke reduces the oxygen in your blood, which increases your blood pressure and heart rate because your heart has to work harder to supply enough oxygen to your body and brain.\nThere's good news though. Your risk of heart disease starts to drop in as little as a day after quitting. After a year without cigarettes, your risk of heart disease drops to about half that of a smoker. No matter how long or how much you smoked, you'll start reaping rewards as soon as you quit.",),
  const Precaution(
    name: "Aim for at least 30 to 60 minutes of activity daily",
    image:"assets/HTD/images/working.png",
    image1:"assets/HTD/images/precaution2.gif",
    description:"Regular, daily physical activity can lower your risk of heart disease.Physical activity helps you control your weight and reduce your chances of developing other conditions that may put a strain on your heart, such as high blood pressure, high cholesterol and type 2 diabetes.\nIf you haven't been active for a while, you may need to slowly work your way up to these goals, but in general, you should aim for at least:\n150 minutes a week of moderate aerobic exercise, such as walking at a brisk pace\n75 minutes a week of vigorous aerobic activity, such as running\nTwo or more strength training sessions a week\nEven shorter bouts of activity offer heart benefits, so if you can't meet those guidelines, don't give up. Just five minutes of moving can help, and activities such as gardening, housekeeping, taking the stairs and walking the dog all count toward your total. You don't have to exercise strenuously to achieve benefits, but you can see bigger benefits by increasing the intensity, duration and frequency of your workouts.",),
  const Precaution(
    name:"Eat a heart-healthy diet",
      image1:"assets/HTD/images/precaution3.gif",
    image:"assets/HTD/images/fruits.png",
    description:"A healthy diet can help protect your heart, improve your blood pressure and cholesterol, and reduce your risk of type 2 diabetes.A heart-healthy eating plan includes:\n Vegetables and fruits\n Beans or other legumes\n  Lean meats and fish\n Low-fat or fat-free dairy foods\n Whole grains \n Heathy fats such as Olive oil.\nTwo examples of heart-healthy food plans include the Dietary Approaches to Stop Hypertension (DASH) eating plan and the Mediterranean diet.Limit intaking sugar,salt,processed Carbohydrates,Alhocol,Saturated fats and trans fats."),
  const Precaution(
     name: "Maintain a healthy weight",
     image:"assets/HTD/images/weight.png",
     image1:"assets/HTD/images/precaution4.gif",
     description:"Being overweight — especially around your middle — increases your risk of heart disease. Excess weight can lead to conditions that increase your chances of developing heart disease — including high blood pressure, high cholesterol and type 2 diabetes.\nOne way to see if your weight is healthy is to calculate your body mass index (BMI), which uses your height and weight to determine whether you have a healthy or unhealthy percentage of body fat. A BMI of 25 or higher is considered overweight and is generally associated with higher cholesterol, higher blood pressure, and an increased risk of heart disease and stroke.\nWaist circumference also can be a useful tool to measure how much abdominal fat you have. Your risk of heart disease is higher if your waist measurement is greater than:\n   40 inches (101.6 centimeters, or cm) for men\n    35 inches (88.9 cm) for women\nEven a small weight loss can be beneficial. Reducing your weight by just 3% to 5% can help decrease certain fats in your blood (triglycerides), lower your blood sugar (glucose) and reduce your risk of type 2 diabetes. Losing even more helps lower your blood pressure and blood cholesterol level.",
  ),
  const Precaution(
    name: "Get good quality sleep",
    image:"assets/HTD/images/sleep.png",
    image1:"assets/HTD/images/precaution5.gif",
    description: "A lack of sleep can do more than leave you yawning; it can harm your health. People who don't get enough sleep have a higher risk of obesity, high blood pressure, heart attack, diabetes and depression.\nMost adults need at least seven hours of sleep each night. Make sleep a priority in your life. Set a sleep schedule and stick to it by going to bed and waking up at the same times each day. Keep your bedroom dark and quiet, so it's easier to sleep.\nIf you feel like you've been getting enough sleep but you're still tired throughout the day, ask your doctor if you need to be evaluated for obstructive sleep apnea, a condition that can increase your risk of heart disease. Signs of obstructive sleep apnea include loud snoring, stopping breathing for short times during sleep and waking up gasping for air. Treatments for obstructive sleep apnea may include losing weight if you're overweight or using a continuous positive airway pressure (CPAP) device that keeps your airway open while you sleep.",
),
  const Precaution(
    name: "Manage stress",
    image:"assets/HTD/images/stress.png",
    image1:"assets/HTD/images/precaution7.gif",
    description:"Some people cope with stress in unhealthy ways — such as overeating, drinking or smoking. Finding alternative ways to manage stress — such as physical activity, relaxation exercises or meditation — can help improve your health."),
  const Precaution(
    name: "Get regular health screenings",
    image:"assets/HTD/images/screening.png",
    image1:"assets/HTD/images/precaution6.gif",
    description:"High blood pressure and high cholesterol can damage your heart and blood vessels. But without testing for them, you probably won't know whether you have these conditions. Regular screening can tell you what your numbers are and whether you need to take action.\n   Blood pressure: Regular blood pressure screenings usually start in childhood. Starting at age 18, your blood pressure should be measured at least once every two years to screen for high blood pressure as a risk factor for heart disease and stroke.If you're between 18 and 39 and have risk factors for high blood pressure, you'll likely be screened once a year. People age 40 and older also are given a blood pressure test annually.\n   Cholesterol levels: Adults generally have their cholesterol measured at least once every four to six years. Cholesterol screening usually starts at age 20, though earlier testing may be recommended if you have other risk factors, such as a family history of early-onset heart disease.\n    Type 2 diabetes screening: Diabetes is a risk factor for heart disease. If you have risk factors for diabetes, such as being overweight or having a family history of diabetes, your doctor may recommend early screening. If your weight is normal and you don't have other risk factors for type 2 diabetes, screening is recommended beginning at age 45, with retesting every three years.\nIf you have a condition such as high cholesterol, high blood pressure or diabetes, your doctor may prescribe medications and recommend lifestyle changes. Make sure to take your medications as your doctor prescribes and follow a healthy-lifestyle plan."),
];
