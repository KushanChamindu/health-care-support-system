import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Diab_symptoms extends StatefulWidget {

  @override
  _Diab_symptomsState createState() => _Diab_symptomsState();
}

class _Diab_symptomsState extends State<Diab_symptoms> {

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Diabetes Symptoms',
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
                    Card_extend(text1: 'Frequent and Excessive Urination',
                      text2: 'As you already know, the glucose level in the blood is very high in diabetes. This glucose circulates in the blood and reaches kidneys which filter the blood to form urine. Kidneys ordinarily never let glucose pass into the urine, but when the glucose level is excessive, this glucose enters the urine. During this, kidneys filter a lot of water which results in excessive and frequent urination in Diabetes',
                      image: 'assets/Diab_images/urine.png',),
                    Card_extend(text1: 'Excessive Thirst',image:'assets/Diab_images/thirsty1.gif' ,text2:'Excessive urination in Diabetes leads to a shortage of water in the body. This leads to extreme thirst and Dry mouth' ,),
                    Card_extend(text1: 'Extreme Hunger',image:'assets/Diab_images/hunger.jpg' ,text2:'Since the body cells do not get glucose, they begin to starve. Eventhough the glucose is all around, the cells cannout utilize it. This is a case of \'Scarcity admist plenty\'. This starvation of body cells leads to extreme hunger ' ,),
                    Card_extend(text1: 'Unexplained weight loss',image:'assets/Diab_images/weightloss.png' , text2: 'When body cells cannot utilize glucose, the stored fat in the body is slowly disintegrated to compensate it. This leads to loss of weight.',),
                    Card_extend(text1:'Fatigue', image: 'assets/Diab_images/fatique.jpg',text2: 'Along with stored fat, the protein in the muscles is also disintegrated to nourish the starving cells. This results in fatigue and weakness of the body' ,),
                    Card_extend(text1: 'Itchy skin and Fungal infection',image:'assets/Diab_images/irritability.jpg', text2: 'The blood of a diabetic is quite rich in glucose which provides favourable conditions for faster growth of micro organisms that cause diseases. This is more visible on the skin which becomes vulnerable to infections. So that, Excessive glucose also causes itchy skin' ,),
                    Card_extend(text1: 'Blurred vision',image: 'assets/Diab_images/blurry.jpg', text2: 'Our eyes have a fluid inside them which helps in focusing. Due to the high concentration of glucose in the blood, this fluid also changes its concentration which leads to Blurred vision and frequent changes in the power of eye lenses',),
                    Card_extend(text1: 'Slow healing cuts and wounds',image:'assets/Diab_images/slowheal.jpeg',text2: 'Since the blood contains an abnormal amount of glucose, it provides an ideal medium for the growth of pus-forming micro organisms. This affects the healing of even small cuts and abrasions and delays the recovery' ,),
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
