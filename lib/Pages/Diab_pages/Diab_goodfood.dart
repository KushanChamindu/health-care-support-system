import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';

import '../Popupmenu.dart';


class Diab_goodfood extends StatefulWidget {
  BaseAuth auth=Auth();
  @override
  _Diab_goodfoodState createState() => _Diab_goodfoodState();
}

class _Diab_goodfoodState extends State<Diab_goodfood> {
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
                  'Best Foods',
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
                                Text('Best Foods for Diabetes',style: TextStyle(color: Colors.amberAccent,fontSize: 25,fontFamily:'BalsamiqSans',),),
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

                          Card_extend(text1: 'BROWN RICE/ WILD RICE',
                            text2: 'In comparison to white rice, these have a lower glycemic index (50). They are also rich in fiber which slows down the absorption of glucose and hence prevents sudden spikes in blood sugar.',
                            image: 'assets/Diab_images/good_foods/rice.jpg',),
                          Card_extend(text1: 'BLACK TEA/ GREEN TEA',image:'assets/Diab_images/good_foods/tea.jpg' ,text2:'Tea or coffee made with low fat milk and no added sugar are the preferred beverages for Diabetics. Green tea, without the addition of sweeteners (sugar or honey) or milk, is a healthy alternative. it has very few calories and it also has plenty of anti-oxidants.' ,),
                          Card_extend(text1: 'SOME FRUITS',image:'assets/Diab_images/good_foods/fruits.jpg' ,text2:'Certain fruits have lower glycemic index and hence can be consumed without getting high blood sugars. Cherries(20), Grapefruit(25), Berries(20-30), Prunes and Plums(29), Apples(39) and Pears(38) are the list of Top 6 fruits that are safe for Diabetic patients.' ,),
                          Card_extend(text1: 'SOME VEGETABLES',image:'assets/Diab_images/good_foods/vege.jpg' , text2: 'All vegetables that grow above the ground tend to have a lower glycemic index in comparison to roots and tubers. Bitter melon, Green leafy vegetables, Ladies Finger, Broccoli and Fenugreek leaves are the list of Top 5 Veggies that are Good for controlling Diabetes.',),
                          Card_extend(text1:'DARK CHOCOLATE', image: 'assets/Diab_images/good_foods/choco.jpg',text2: 'Chocolate is supposed to have nutrients which improve insulin sensitivity. Dark chocolate does not contain added sugar and hence, it is effective in control of blood sugar levels. Dark chocolate is also known to reduce craving which in turn prevents over eating or binge eating.' ,),
                          Card_extend(text1: 'OATS/ OATMEAL',image:'assets/Diab_images/good_foods/oats.jpg', text2: 'This fiber rich food not only helps in control of blood sugar levels, it also helps in weight management due to low fat, low calorie and high fiber content. It also makes a person feel full for a longer time.' ,),
                          Card_extend(text1: 'FISH',image: 'assets/Diab_images/good_foods/fish.jpg', text2: 'Fish has no fat content. It also has high levels of omega-3 fatty acids which helps in reducing inflammation. This works indirectly to bring down blood sugar levels. It also has an added advantage that it is rich in protein.',),
                          Card_extend(text1: 'NUTS',image:'assets/Diab_images/good_foods/nuts.jpg',text2: 'Nuts like walnuts and almonds are rich in Poly Unsaturated Fatty Acids (PUFA), vitamins and antioxidants. They also bring satiety and so less calories are consumed.' ,),
                          Card_extend(text1: 'CINNAMON',image: 'assets/Diab_images/good_foods/cinnamon.jpg', text2: 'Cinnamon helps in reducing blood sugar levels. It also works on bringing down Triglycerides and LDL levels. It contains Chromium which acts as an enhancer of insulin. Daily consumption of 1-2 grams works wonders.',),
                          Card_extend(text1: 'PULSES',image: 'assets/Diab_images/good_foods/pulses.jpg', text2: 'Pulses are rich in protein and have low glycemic index. When incorporated as the main portion of food, they tend to reduce the consumption of rice which indirectly helps in reducing blood sugar levels.',),
                          Card_extend(text1: 'SALADS',image: 'assets/Diab_images/good_foods/salads.jpeg', text2: 'Salads are considered as a great asset for those who need to watch their weight. They have high fiber, low sugar levels and also makes a person feel full soon.',),


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
