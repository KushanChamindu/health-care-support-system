import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Popupmenu.dart';
import 'fact_message.dart';

class CKD_message extends StatefulWidget {
  final BaseAuth auth = Auth();

  @override
  _CKD_messageState createState() => _CKD_messageState();
}

class _CKD_messageState extends State<CKD_message> {
  @override
  Widget build(BuildContext context) {
    final UID args = ModalRoute.of(context).settings.arguments;
    return StreamProvider<DocumentSnapshot>.value(
      value: widget.auth.user_data(args.uid),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'CKD Specialist',
                  style: TextStyle(fontSize: 16),
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
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/CKD_image/botbackGround.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: MessagePageBody(
              auth: widget.auth,
              uid: args.uid,
            )),
      ),
    );
  }
}

class MessagePageBody extends StatefulWidget {
  final String uid;
  final BaseAuth auth;

  MessagePageBody({this.uid, this.auth});

  @override
  _MessagePageBodyState createState() => _MessagePageBodyState();
}

class _MessagePageBodyState extends State<MessagePageBody> {
  final List<Widget> _messages = <Widget>[];
  final TextEditingController _textController = new TextEditingController();
  Widget Telegram(BuildContext context,AIResponse response){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton.icon(
            icon: Icon(Icons.input),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
            color: Colors.blueAccent,
              onPressed:() async => await launch(
                'https://'+response.getMessage()
                    .split(':')[1].toString(),forceWebView:false,forceSafariVC: false),
              label: Text('Click this')),
      ],
    );

  }
  @override
  Widget build(BuildContext context) {
    final UserData = Provider.of<DocumentSnapshot>(context);
    try {
      var userData = UserData.data;
      void _dialogFlowResponse(query) async {
        _textController.clear();
        try {
          AuthGoogle authGoogle =
              await AuthGoogle(fileJson: "assets/dialogflow/bot-cred.json")
                  .build();
          Dialogflow dialogFlow =
              Dialogflow(authGoogle: authGoogle, language: Language.english);
          AIResponse response = await dialogFlow.detectIntent(query);
          print(response.queryResult.intent.displayName);
          FactsMessage message = FactsMessage(
            text: response.getMessage() ??
                CardDialogflow(response.getListMessage()[0]).title,
            name: "Doctor",
            type: false,
          );
          setState(() {
            _messages.insert(0, message);
          });
          if (response.getMessage() != null && response.webhookStatus != null) {
            widget.auth.setCKDPrediction(
                widget.uid,
                double.parse(
                    response.getMessage().split(' ')[4].split('%')[0]));
          }
          else if (response.queryResult.intent.displayName.toString() == 'telegrame') {
            print('kushan');
            print(response.getMessage());
            print(response.getMessage()
                .split(':')[1]);
            Widget custommsg = Telegram(context,response);
            setState((){
              _messages.insert(0, custommsg);
            });

          }
        } catch (e) {
          debugPrint(e);
          _messages.insert(
              0,
              FactsMessage(
                text: 'Check your internet connection',
                name: "Dcotor",
                type: false,
              ));
        }
      }

      void _submitQuery(String text) {
        _textController.clear();
        FactsMessage message = new FactsMessage(
          text: text,
          name: userData['Username'].split(' ')[0],
          type: true,
          imageUrl: userData['ProfilePic'],
        );
        setState(() {
          _messages.insert(0, message);
        });
        _dialogFlowResponse(text);
      }

      Widget _queryInputWidget(BuildContext context) {
        return Container(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _textController,
                      onSubmitted: _submitQuery,
                      decoration: InputDecoration.collapsed(
                          hintText: ("Send a message")),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 32,
                      ),
                      onPressed: () => _submitQuery(_textController.text)),
                ),
              ],
            ),
          ),
        );
      }

      return Builder(
        builder: (context) => Column(
            children: <Widget>[
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true, //To keep the latest messages at the bottom
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          )),
          Divider(height: 1.0),
          Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _queryInputWidget(context),
          ),
        ]),
      );
    } catch (e) {
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
