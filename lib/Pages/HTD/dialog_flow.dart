import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/Constant.dart';
import 'package:healthcaresupportsystem/Pages/HTD/facts_message.dart';
import 'package:healthcaresupportsystem/Pages/HTD/Style.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:provider/provider.dart';


class FlutterFactsChatBot extends StatefulWidget {
  final BaseAuth auth=Auth();
  FlutterFactsChatBot({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FlutterFactsChatBotState createState() => new _FlutterFactsChatBotState();
}

class _FlutterFactsChatBotState extends State<FlutterFactsChatBot> {
  void choiceAction(String choice) async {
    if (choice == 'Account') {
      try {
        String uid = await widget.auth.currentUser();
        Navigator.pushNamed(context, '/account', arguments: UID(uid: uid));
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Check your internet connection'),
        ));
      }
    } else if (choice == 'SignOut') {
      print('SignOut');
      await widget.auth.singOut();
      if (await widget.auth.currentUser() == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      showAboutDialog(
          context: context,
          applicationIcon: Container(
              width: 120,height: 170,
              child: Image.asset(
                'assets/CKD_image/Doctor.png',
                fit: BoxFit.fill,
              )),
          applicationName: "Mobile Doctor",
          applicationVersion: '0.0.1',
          applicationLegalese:
          ('This software developed by HCSS PVT LMD. Copyright © 2020 Arnoud Engelfriet. Some rights reserved.'),
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
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UID args = ModalRoute.of(context).settings.arguments;

    return StreamProvider<DocumentSnapshot>.value(
      value: widget.auth.user_data(args.uid),
      child: Scaffold(
        key: ValueKey('Doctor_page'),

        appBar: AppBar(
          actions: <Widget>[
        PopupMenuButton<String>(
        key: ValueKey('HomePopUpMenueButton'),
        onSelected: choiceAction,
        itemBuilder: (BuildContext context) {
          return Constant.choice.map((String choice) {
            if (choice == 'Account') {
              return PopupMenuItem(
                  key: ValueKey('gotoAccountButton'),
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      Text(choice)
                    ],
                  ));
            } else if (choice == 'SignOut') {
              return PopupMenuItem(
                  key: ValueKey("SignoutButton"),
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                      Text(choice)
                    ],
                  ));
            } else {
              return PopupMenuItem(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.flag,
                          color: Colors.black,
                        ),
                      ),
                      Text(choice)
                    ],
                  ));
            }
          }).toList();
        },
      )
          ],
          centerTitle: true,
          title: Text("Heart-specialist", style: Style.headerTextStyle,),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.blue,
                      Colors.blue
                    ])
            ),
          ),
        ),
        backgroundColor: Colors.lightBlue[100],
        body:HTDMessagePageBody(
          auth: widget.auth,
          uid: args.uid,
        )


      ),
    );
  }
}
class HTDMessagePageBody extends StatefulWidget {
  final String uid;
  final BaseAuth auth;

  HTDMessagePageBody({this.uid, this.auth});
  @override
  _HTDMessagePageBodyState createState() => _HTDMessagePageBodyState();
}

class _HTDMessagePageBodyState extends State<HTDMessagePageBody> {
  final List<Widget> messageList = <Widget>[];
  final TextEditingController _textController = new TextEditingController();


  void agentResponse(query,userData) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/HTD/doctor-cqfxkd-9ebecdc5f002.json").build();
    Dialogflow dialogFlow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogFlow.detectIntent(query);
    Facts message = Facts(
      text: response.getMessage() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: "Doctor",
      type: false,
    );
    setState(() {
      messageList.insert(0, message);
    });
    if (response.queryResult.intent.displayName.toString()=='Welcome Intent'){
      Widget instruction=Welcome(context,response,userData);
      setState(() {
        messageList.insert(0,instruction);
      });
    }
    print(response.queryResult.fulfillmentMessages);
    print(response.getMessage());
    print(response.queryResult.intent.displayName);
    print(response.webhookStatus==null);
//    else if (response.getMessage() != null &&
//        response.webhookStatus != null &&
//        response.queryResult.intent.displayName != null) {
//      print(response.queryResult.fulfillmentMessages);
//      widget.auth.setHTDPrediction(widget.uid,
//          double.parse(response.getMessage().split(' ')[4].split('%')[0]));
//    }
  }


  void _submitQuery(String text,userData) {
    _textController.clear();
    Facts message = new Facts(
      text: text,
      name: userData['Username'].split(' ')[0],
      type: true,
      imageUrl: userData['ProfilePic'],
    );
    setState(() {
      messageList.insert(0, message);
    });
    agentResponse(text,userData);
  }

  Widget Welcome(BuildContext context,AIResponse response,userData){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.perm_device_information),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed:(){
              _submitQuery('I need to get to know the probability of getting heart disease',userData);
            },
            label: Text('Heart Predictions')),
        SizedBox(width: 8,),
        FlatButton.icon(
            icon: Icon(Icons.device_unknown),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed:()=>_submitQuery('I want to know about heart disease.',userData),
            label: Text('ASK Question')),
      ],
    );

  }
  @override
  Widget build(BuildContext context) {
    final UserData = Provider.of<DocumentSnapshot>(context);
    try{
      var userData = UserData.data;
      Widget _queryInputWidget(BuildContext context) {
        return Card(
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: TextField(
                      controller: _textController,
                      onSubmitted: (_textController) {
                        _submitQuery(_textController, userData);
                      },
                      decoration: InputDecoration.collapsed(hintText: "Send a message"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      icon: Icon(Icons.send, color: Colors.indigo[700],),
                      onPressed: () => _submitQuery(_textController.text,userData)),
                ),
              ],
            ),
          ),
        );
      }
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/CKD_image/botbackGround.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: <Widget>[

          Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true, //To keep the latest messages at the bottom
                itemBuilder: (_, int index) => messageList[index],
                itemCount: messageList.length,
              )),
          _queryInputWidget(context),
        ]),
      );
    }catch(e){
      return Builder(
        builder: (context) => Center(
            child: Text(
              'Loading....',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            )),
      );
    }

  }
}
