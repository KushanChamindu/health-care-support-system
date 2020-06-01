import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/HTD/HTD_Pages/HTD_More.dart';
import 'package:healthcaresupportsystem/Pages/HTD/Style.dart';
class DetailPage extends StatelessWidget{
  final Disease disease;
  DetailPage(this.disease);
 Widget build (BuildContext context){
   return new Scaffold(
    body: new Container(
    constraints: new BoxConstraints.expand(),
      color: Colors.lightBlue[700],
        child: new Stack(
          children:<Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),

          ]
        ),
    ),
);
}
//set the background gif
Container _getBackground(){
   return new Container(
     child: new Image.asset(disease.image1,
       fit:BoxFit.cover,
       height:350,
     ),
         constraints: new BoxConstraints.expand(height:350.0)
   );
 }

// setting background gradient
Container _getGradient(){
   return Container(
     margin: new EdgeInsets.only(top:240),
     height:110.0,
     decoration: new BoxDecoration(
       gradient: new LinearGradient(
           colors: <Color>[
             new Color(0x00736AB7),
             new Color(0xFF736AB7),
           ],
               stops:[0,0.9],
               begin: const FractionalOffset(0, 0),
               end: const FractionalOffset(0, 1),
       )
     ),
   );
}

//setting content
Widget _getContent(){
   final _overviewTitle="Overview".toUpperCase();
   return new ListView(
     padding: new EdgeInsets.fromLTRB(0.0,72.0,0.0,32.0),
     children:<Widget>[
       new ContentHeading(disease,horizontal: false),
       new Container(
         padding : new EdgeInsets.symmetric(horizontal: 32.0),
         child: new Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             new Text(_overviewTitle,style: Style.headerTextStyle),
             new Separator(),
             new Text(disease.description,style:Style.commonTextStyle),
           ],
         ),
       ),
     ],
   );
}
//get back button
Container _getToolbar(BuildContext context){
   return new Container(
     margin: new EdgeInsets.only(
       top: MediaQuery
           .of(context)
           .padding
           .top),
     child: new BackButton(color :Colors.white,key: ValueKey('HTDMoreBackButton'),),
     );

}
}


//This is for the top card

class ContentHeading extends StatelessWidget{
  final Disease disease;
  final bool horizontal;
  ContentHeading(this.disease,{this.horizontal=true});
  ContentHeading.vertical(this.disease): horizontal=false;
  Widget build(BuildContext context){
    final diseaseThumbnail= new Container(
      margin: new EdgeInsets.symmetric(
        vertical:16
      ),
      alignment: horizontal? FractionalOffset.centerLeft: FractionalOffset.center,
      child: new Hero(
        tag:"disease-hero-${disease.name}",
        child:new Image(
          image: new AssetImage(disease.image),
          height: 250.0,
          width:92.0,
        ),
      ),
    );

  final diseaseCardContent=new Container(
    margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
    constraints: new BoxConstraints.expand(),
    child: new Column(
      crossAxisAlignment: horizontal ? CrossAxisAlignment.start: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(height:4),
        new Text(disease.name,style: Style.headerTextStyle),
      ],

    ),

  );
  final diseaseCard = new Container(
    child: diseaseCardContent,
    height: horizontal ? 130.0 : 130.0,
    margin: horizontal ? new EdgeInsets.only(left: 46.0) : new EdgeInsets.only(top: 150.0),
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


  return new GestureDetector(
       onTap: horizontal? () => Navigator.of(context).push(
             new PageRouteBuilder(
               pageBuilder: (_, __, ___) => new DetailPage(disease),
               transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                 new FadeTransition(opacity: animation, child: child),
               ) ,
             )
          : null,
        child: new Container(
         margin: const EdgeInsets.symmetric(
           vertical: 16.0,
           horizontal: 24.0,
         ),
         child: new Stack(
           children: <Widget>[
              diseaseCard,
              diseaseThumbnail,
          ],
        ),
      )
    );


  }
}

class Separator extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return new Container(
         margin: new EdgeInsets.symmetric(vertical: 8.0),
         height: 2.0,
         width: 18.0,
         color: new Color(0xff00c6ff)
     );
    }
  }

