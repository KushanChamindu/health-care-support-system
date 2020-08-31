import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';

import '../Popupmenu.dart';


class Diab_worstfood extends StatefulWidget {
  BaseAuth auth=Auth();
  @override
  _Diab_worstfoodState createState() => _Diab_worstfoodState();
}

class _Diab_worstfoodState extends State<Diab_worstfood> {
  bool visible=true;
  @override
  Widget build(BuildContext context) {
    void set_visible(visi){
      setState(() {
        visible=!visi;
      });
    }
    return
      Scaffold(
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
                  'Worst Foods',
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
          child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 10),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Worst Foods for Diabetes',style: TextStyle(color: Colors.amberAccent,fontSize: 25,fontFamily:'BalsamiqSans',),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Glycemic index is an international value used to measure the rate at which your blood sugar is raised after the intake of each food item.Higher the value,faster it will raise blood sugar. If you are having Diabetes, you are advised to take only those food items, which have a value less than 50.',
                              style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('You may be thinking that its possible to control your blood sugar level by avoiding icecreams and putting less sugar in your coffee. But in reality, icecream has only a Glycemic index of 41 and a slice of watermelon has 72 ! So do have a close look at the lists below and control your blood sugar properly by avoiding these foods.\n',
                              style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Montserrat'),),
                          ),

                          Card_extend(text1: 'WHITE RICE',
                            text2: 'White rice is known to have a high glycemic index, around 89, which tends to spike sugar levels in the blood.\nIt is advised to avoid all food items prepared with white rice alone, like Fried Rice, Biryani, Pulao and other rice delicacies.',
                            image: 'assets/Diab_images/Bad_Foods/white_rice.jpg',),
                          Card_extend(text1: 'FRUIT JUICES AND MILK SHAKES',image:'assets/Diab_images/Bad_Foods/juices.jpg' ,text2:'Fruit juices tend to have sugar in the concentrated form due to the loss of fiber. Fruit juices can be easily consumed in large quantities without reaching satiety and hence, in comparison to eating fresh fruits, more amount of fruit content enters the body, which means more sugar enters the body. The same applies to milk shakes.' ,),
                          Card_extend(text1: 'FATTY MEATS AND PROCESSED MEATS',image:'assets/Diab_images/Bad_Foods/meat.jpg' ,text2:'Red meat is high in fats and processed meat is high in sodium. They play a major role in the occurrence and worsening of heart disease. Since Diabetes is also linked to higher chances of developing heart diseases, these food products should be avoid for a healthy heart.' ,),
                          Card_extend(text1: 'SOME FRUITS',image:'assets/Diab_images/Bad_Foods/fruits.jpg' , text2: 'Though generally fruits are considered good for health, certain fruits can cause havoc when it comes to blood sugar levels.These fruits have a high glycemic index which leads to sudden rise of blood sugars which can be very dangerous. Watermelon(73), Chickoo/Sapodilla(72), Pineapple(66), Raisins(64), Banana(62) and Mangoes(60) are the fruits to be avoided by those who have Diabetes.(Glycemic Index is given in brackets-higher the value,faster it will raise blood sugar)',),
                          Card_extend(text1:'SOME VEGETABLES', image: 'assets/Diab_images/Bad_Foods/vege.jpg',text2: 'Certain vegetables also have a high glycemic index and should be avoided.Potato(94-111), Parsnip(97), Pumpkins(75), Tapioca/Cassava(72-81), and Beetroot(60) are the top 5 vegetables to be avoided.(Glycemic Index is given in brackets)' ,),
                          Card_extend(text1: 'SUGARY/ CARBONATED DRINKS & BLENDED COFFE',image:'assets/Diab_images/Bad_Foods/drinks.jpg', text2: 'Carbonated drinks have high sugar content and have no nutritional benefits. They contain empty calories ans will spike sugar levels. Sugary drinks, liked packaged fruit juices, blended coffee should also be avoided due to the high sugar content.' ,),
                          Card_extend(text1: 'CHINESE FOOD',image: 'assets/Diab_images/Bad_Foods/chinese.jpg', text2: 'Chinese food is loved by most of the people. It is rich in calories, carbohydrates, fat and sodium. All these factors adversely affect the control of blood sugars and the prevention of complications of Diabetes.',),
                          Card_extend(text1: 'BAKERY PRODUCTS',image:'assets/Diab_images/Bad_Foods/bakery.jpg',text2: 'Most baked products, like bread, buns, doughnuts, cakes, biscuits and cookies, are made from white flour which has a high glycemic index. Due to the added sugar and butter/oil, these products also tend to be high in calories and hence should be avoided.' ,),
                          Card_extend(text1: 'FRIED FOOS',image: 'assets/Diab_images/Bad_Foods/fried.jpg', text2: 'Fried food like Fried fish, Meat and French fries contain high amounts of fat, calories and carbohydrates which can all create havoc on blood sugar levels. They also contain added sodium which has negative effects on the heart. Hence all fried foods should be limited as much as possible.',),
                          Card_extend(text1: 'ALCOHOL',image: 'assets/Diab_images/Bad_Foods/alcohol.jpg', text2: 'Alcohol can either cause blood glucose levels to rise or fall, depending on the quantity consumed and the medications being taken for Diabetes. Due to this, the effect of alcohol on Diabetics can be quite unpredictable.\nDo you know that drinking a glass of Beer will create blood sugar spikes equivalent to 3 cups of Icecream?Beer is one of the food item with the highest Glycemic Index of 110, while that of icecream is only 41.',),
                          Card_extend(text1: 'FAST FOOD',image: 'assets/Diab_images/Bad_Foods/fast_food.jpg', text2: 'Current generations have developed a huge inclination towards fast food like burgers, pizzas and fries. Fast food has a high calorie, high fat and high carbohydrate content which can rapidly increase blood sugar levels and it becomes difficult to control blood sugar levels following consumption of such foods.',),


                        ],
                      ))
                ],
              )),
        ),
      );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 0, 3),
      child: new Container(
        height: 10.0,
        width: 10.0,
        decoration: new BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class Card_extend extends StatefulWidget {
  String text1;
  String image;
  String text2;
  bool visible = false;
  Card_extend({this.text1,this.image,this.text2});
  @override
  _Card_extendState createState() => _Card_extendState();
}

class _Card_extendState extends State<Card_extend> {
  void get_visible() {
    setState(() {
      if (widget.visible) {
        widget.visible = false;
      } else {
        widget.visible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(

        child: Card(
          child: Column(
              children:<Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0, 15, 25, 15),
                      child: new MyBullet(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: new Text(
                        widget.text1,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(widget.image,  width: 30,height: 70,),
                        )),


                  ],
                ),
                Visibility(
                    visible: widget.visible,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 10),
                      child: Text(
                        widget.text2,
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5),
                      ),

                    ))
                ,]

          ),



        ),

      ),
      onTap:(){
        get_visible();
      } ,

    );
  }
}
