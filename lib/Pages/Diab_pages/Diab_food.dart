import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';

import '../Popupmenu.dart';

class Diab_food extends StatelessWidget {
  BaseAuth auth=Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          actions: <Widget>[
            Popupmenu(auth: auth,)
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Food Behaviours',
                  style: TextStyle(fontSize: 20),
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
          backgroundColor: Colors.grey[850],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Understanding how food affects your blood sugar',style: TextStyle(color: Colors.amberAccent,fontSize: 25,fontFamily:'BalsamiqSans',),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Image.asset('assets/Diab_images/food.jpg',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Food has a direct effect on blood glucose. Some foods raise blood glucose more than others. An important part of managing diabetes is knowing what and how much to eat, and following an eating plan that fits your lifestyle while helping to control blood glucose. The three main nutrients found in foods are carbohydrates (carbs), proteins and fats.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Carbohydrates (carbs)',
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Carbs are the starches, sugar and fiber in foods such as grains, fruits, vegetables, milk products and sweets. They raise blood glucose faster and higher than other nutrients in foods: proteins and fats. Knowing what foods contain carbs and the amount of carbs in a meal is helpful for blood glucose control. Choosing carbs from healthy sources like vegetables, fruits and whole grains (high fiber) are preferred over carbs from sources with added sugars, fat and salt.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Proteins',
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Proteins are a necessary part of a balanced diet and can keep you from feeling hungry. They do not directly raise your glucose like carbs. However, to prevent weight gain, use portion control with proteins. In people with type 2 diabetes, protein makes insulin work faster, so it may not be a good idea to treat low blood sugar with protein shakes or mixes. Using 15 grams* of fast-acting carbs that contain glucose, like juice, other sugar-sweetened beverages, glucose gel or tablets is the preferred way to treat low blood sugar.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fats',
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Fats are necessary part of a balanced diet, especially healthy fats from fatty fish, nuts and seeds. They do not raise blood glucose but are high in calories and can cause weight gain.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Card(
                color: Colors.amberAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Aim to include all three nutrients to balance your meals.',
                    style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'Montserrat',fontWeight: FontWeight.w900),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Making healthy food choices',
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Your dietitian or diabetes educator can help you develop an eating plan that is right for you and fits into your lifestyle. Healthy eating for diabetes is healthy eating for the whole family.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Here are some guidelines for healthy eating:',
                      style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,8,3),
                child: Text('1) Enjoy having regular meals with proper portion sizes. Your healthcare professional can help you learn to make healthy food choices and proper portion sizes.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,8,3),
                child: Text('2) Eat a variety of nutrient-rich foods in each meal, including healthy fats, lean meats or proteins, whole grains and low-fat dairy in appropriate portion sizes.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,8,3),
                child: Text('3) Choose fiber-rich foods, such as fruits, vegetables and whole grains (bran cereals, whole wheat pasta, brown rice) as often as possible.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,8,3),
                child: Text('4) Try alternatives to meat, such as lentils, beans or tofu.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,8,3),
                child: Text('5) Choose calorie-free liquids, such as unsweetened tea, coffee or water.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,0,8,3),
                    child: Text('6) Choose sugar substitutes.',
                      style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,0,8,3),
                    child: Text('7) Choose lower-salt options.',
                      style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Visualizing food portion size: It’s in your hands',
                  style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Your choice of food and how much you eat is relative to your blood glucose level. If you eat more than you need, your blood glucose will rise. To help manage your diabetes, having a good sense of portion control is an important skill. Luckily, you already have some tools — your hands.',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Image.asset('assets/Diab_images/food_portion.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 250,
                          child: Card(
                            child: FlatButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Diab_worstfood');
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  size: 25,
                                  color: Colors.red[900],
                                ),
                                label: Text("Worst Foods",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w900))),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 200,
                          child: Card(
                            child: FlatButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Diab_goodfood');
                                },
                                icon: Icon(
                                  Icons.check_box,
                                  size: 25,
                                  color: Colors.green[900],
                                ),
                                label: Text("Best Foods",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w900))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}
class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 0, 3),
      child: new Container(
        height: 9.0,
        width: 9.0,
        decoration: new BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}