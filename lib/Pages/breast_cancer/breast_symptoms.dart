import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/Constant.dart';

class BC_Symptoms extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _BC_SymptomsState createState() => _BC_SymptomsState();
}

class _BC_SymptomsState extends State<BC_Symptoms> {
  void choiceAction(String choice)async{
    if(choice=='Account'){
      try {
        String uid= await widget.auth.currentUser();
        Navigator.pushNamed(context, '/account',arguments:UID(uid: uid));
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Check your internet connection'),
        ));
      }
    }else if(choice=='SignOut'){
      print('SignOut');
      await widget.auth.singOut();
      if(await widget.auth.currentUser()==null){
        Navigator.pushReplacementNamed(context, '/');
      }
    }else{
      showAboutDialog(
          context: context,
          applicationIcon: Image.asset('assets/CKD_image/Doctor.png', width: 100,height: 100,),
          applicationName: "Mobile Doctor",
          applicationVersion: '0.0.1',
          applicationLegalese: 'This software developed by HCSS PVT LMD. Copyright © 2020 Arnoud Engelfriet. Some rights reserved.',
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                child: Text('* Chronic kidney disease'),
              ),
            ),
            Container(
              child: Text('* Diabetise'),
            ),
            Container(
              child: Text('* Heart disease'),
            ),
            Container(
              child: Text('* Beast Cancer'),
            )
          ]

      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    //early symptoms
    List early = [
      'Skin changes, such as swelling, redness, or other visible differences in one or both breasts',
      'An increase in size or change in shape of the breast(s)',
      'Changes in the appearance of one or both nipples',
      'Nipple discharge other than breast milk',
      'General pain in/on any part of the breast',
      'Lumps or nodes felt on or inside of the breast',
       'Irritated or itchy breasts',
      'Change in breast color',
      'Increase in breast size or shape (over a short period of time)',
      'Changes in touch (may feel hard, tender or warm)',
      'Peeling or flaking of the nipple skin',
      'A breast lump or thickening',
      'Redness or pitting of the breast skin (like the skin of an orange)',
    ];
    //invasive symptoms
    List invasive=[
      'A lump or mass in the breast',
      'Swelling of all or part of the breast, even if no lump is felt',
      'Skin irritation or dimpling',
      'Breast or nipple pain',
      'Nipple retraction (turning inward)',
      'The nipple or breast skin appears red, scaly, or thickened',
      'Nipple discharge',
      'A lump or swelling in the underarm lymph nodes',
     
    ];

  
    return Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueAccent,
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context){
                      return Constant.choice.map((String choice){
                        if(choice=='Account'){
                          return PopupMenuItem(
                              value: choice,
                              child: Row(children: <Widget>[Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.person, color: Colors.black,),
                              ), Text(choice)],));

                        }else if(choice=='SignOut'){
                          return PopupMenuItem(
                              value: choice,
                              child: Row(children: <Widget>[Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.lock, color: Colors.black,),
                              ), Text(choice)],));
                        }else{
                          return PopupMenuItem(
                              value: choice,
                              child: Row(children: <Widget>[Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.flag, color: Colors.black,),
                              ), Text(choice)],));
                        }
                      }
                      ).toList();
                    },
                  )
                ],
                bottom: TabBar(tabs: [
                  Tab(text: 'Early'),
                  Tab(text: 'Invasive'),
            ]),
            title: Text(
              "Symptoms...  - Breast Cancer",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontFamily: 'KaushanScript'
              ),
            ),
            //centerTitle: true,
//            backgroundColor: Colors.lightBlue,
              ),
              body: TabBarView(children: [
                ListView.builder(
                  itemCount: early.length,
                  itemBuilder: (context,index){
                    return Card(
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            FlatButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.blur_linear),
                                label: Expanded(
                                    child: Text(early[index], 
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'KaushanScript',
                                      ),
                                    ),
                                  ),
                                
                              ),
                          ],
                        )),
                    );        
                  }
                ),
          //   ListView(
          //   children: <Widget>[
          //     containerSectionearly,
          //   ],
          // ),
           ListView.builder(
                  itemCount: invasive.length,
                  itemBuilder: (context,index){
                    return Card(
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            FlatButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.blur_linear),
                                label: Expanded(
                                    child: Text(invasive[index], 
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'KaushanScript',
                                      ),
                                    ),
                                  ),
                                  
                              ),
                          ],
                        )),
                    );        
                  }
                ),
          ]),

        ),
      )
          
    
    );
  }

   Column _buildContainerColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Titles(
                text1 : label,
              ),
            ),
          ],
        
          //margin: const EdgeInsets.only(top: 8),
          //height: 80,
          //width: 100,
      //     child: FlatButton(
      //       onPressed: () {
      //         //Navigator.pushNamed(context, url);
      //       },
      //       child: Center(
      //         child: Row(
      //           children: <Widget>[
      //           Icon(icon, color: color),
      //           Text(
      //             label,
      //             style: TextStyle(
      //               fontFamily: 'KaushanScript',
      //             ),
      //             ),
      //         ],
      //         ),
      //       ),
      //       color: Colors.white70, 
      //       ),
      //   ),
      // ],
    );
  }
}

class Titles extends StatefulWidget {
  final String text1;
  //bool visible = false;

  Titles({this.text1});

  @override
  _TitlesState createState() => _TitlesState();
}

class _TitlesState extends State<Titles> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          child: Column(
        children: <Widget>[
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.list),
              label: Expanded(
                  child: Text(widget.text1, 
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'KaushanScript',
                    ),
                  ),
                ),
                
            ),
        ],
      )),
    );
  }

}