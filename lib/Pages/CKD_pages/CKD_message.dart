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

  Widget Telegram(BuildContext context, AIResponse response) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton.icon(
            icon: Icon(Icons.launch),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blueAccent,
            onPressed: () async => await launch('https://t.me/CKD_Doctor_bot',
                forceWebView: false, forceSafariVC: false),
            label: Text('Click this')),
      ],
    );
  }

  Widget Facebook(BuildContext context, AIResponse response) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.launch),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed: () async => await launch(
                'https://fb.me/MobileDoctorHealthCareSupport',
                forceWebView: false,
                forceSafariVC: false),
            label: Text('Click this')),
      ],
    );
  }

  void _dialogFlowResponse(query, userData) async {
    _textController.clear();
    try {
      AuthGoogle authGoogle =
          await AuthGoogle(fileJson: "assets/dialogflow/bot-cred.json").build();
      Dialogflow dialogFlow =
          Dialogflow(authGoogle: authGoogle, language: Language.english);
      AIResponse response = await dialogFlow.detectIntent(query);
      FactsMessage message = FactsMessage(
        text: response.getMessage() ??
            CardDialogflow(response.getListMessage()[0]).title,
        name: "Doctor",
        type: false,
      );
      setState(() {
        _messages.insert(0, message);
      });
      if (response.getMessage() != null &&
          response.webhookStatus != null &&
          response.queryResult.intent.displayName != null) {
        widget.auth.setCKDPrediction(widget.uid,
            double.parse(response.getMessage().split(' ')[4].split('%')[0]));
      } else if (response.queryResult.intent.displayName.toString() ==
          'telegrame') {
        Widget telegram_msg = Telegram(context, response);
        setState(() {
          _messages.insert(0, telegram_msg);
        });
      } else if (response.queryResult.intent.displayName.toString() ==
          'FaceBook') {
        Widget facebook_msg = Facebook(context, response);
        setState(() {
          _messages.insert(0, facebook_msg);
        });
      } else if (response.queryResult.intent.displayName.toString() ==
          'Default Welcome Intent') {
        Widget instuction = Welcome(context, response, userData);
        setState(() {
          _messages.insert(0, instuction);
        });
      } else if (response.queryResult.intent.displayName.toString() ==
          'Threatment_CKD') {
        Widget treatment = Threatment(context, response, userData);
        setState(() {
          _messages.insert(0, treatment);
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

  Widget Welcome(BuildContext context, AIResponse response, userData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.perm_device_information),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed: () {
              _submitQuery('I want CKD prediction', userData);
            },
            label: Text('CKD Predictions')),
        SizedBox(
          width: 8,
        ),
        FlatButton.icon(
            icon: Icon(Icons.device_unknown),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed: () =>
                _submitQuery('I have question about CKD', userData),
            label: Text('CKD Questions')),
      ],
    );
  }

  Widget Threatment(BuildContext context, AIResponse response, userData) {
    var data = response.queryResult.fulfillmentMessages[0]['card'];
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right: 10),
      child: Column(
        children: <Widget>[
          Text(data['subtitle'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
          FadeInImage.assetNetwork(
            width: MediaQuery.of(context).size.width-20,
              height: 200,
              placeholder: 'assets/loading.gif', image: data['imageUri']),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                  icon: Icon(Icons.launch),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  color: Colors.blueAccent,
                  onPressed: () async => await launch(
                      data['buttons'][0]['postback'],
                      forceWebView: false,
                      forceSafariVC: false),
                  label: Text(data['buttons'][0]['text'])),
            ],
          )
        ],
      ),
    );
  }

  void _submitQuery(String text, userData) {
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
    _dialogFlowResponse(text, userData);
  }

  @override
  Widget build(BuildContext context) {
    final UserData = Provider.of<DocumentSnapshot>(context);
    try {
      var userData = UserData.data;

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
                      onSubmitted: (_textController) {
                        _submitQuery(_textController, userData);
                      },
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
                      onPressed: () =>
                          _submitQuery(_textController.text, userData)),
                ),
              ],
            ),
          ),
        );
      }

      return Builder(
        builder: (context) => Column(children: <Widget>[
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            //To keep the latest messages at the bottom
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
