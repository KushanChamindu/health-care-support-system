import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
    var data = response.queryResult.fulfillmentMessages
        .where(
            (m) => m['platform'] != 'FACEBOOK' && m['platform'] != 'TELEGRAM')
        .toList()[0]['payload'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton.icon(
            icon: Icon(Icons.launch),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blueAccent,
            onPressed: () async => await launch(
                data['click-button']['button-link'],
                forceWebView: false,
                forceSafariVC: false),
            label: Text(data['click-button']['button-text'])),
      ],
    );
  }

  Widget Facebook(BuildContext context, AIResponse response) {
    var data = response.queryResult.fulfillmentMessages
        .where(
            (m) => m['platform'] != 'FACEBOOK' && m['platform'] != 'TELEGRAM')
        .toList()[0]['payload'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.launch),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed: () async => await launch(
                data['click-button']['button-link'],
                forceWebView: false,
                forceSafariVC: false),
            label: Text(data['click-button']['button-text'])),
      ],
    );
  }

  void _dialogFlowResponse(query, userData) async {
    _textController.clear();
    try {
      AuthGoogle authGoogle =
          await AuthGoogle(fileJson: "assets/dialogflow/CKD-bot.json").build();
      Dialogflow dialogFlow =
          Dialogflow(authGoogle: authGoogle, language: Language.english);
      AIResponse response = await dialogFlow.detectIntent(query);
//      var data_q=response.queryResult.fulfillmentMessages.where((m) => m['platform'] !='FACEBOOK' && m['platform'] !='TELEGRAM');
      print(response.queryResult.intent.displayName);
      print(response.webhookStatus);
      if (response.getMessage() != null &&
          response.webhookStatus != null &&
          response.queryResult.intent.displayName != null) {
        FactsMessage message = FactsMessage(
          text: response.getMessage() ??
              CardDialogflow(response.getListMessage()[0]).title,
          name: "Doctor",
          type: false,
        );
        setState(() {
          _messages.insert(0, message);
        });
        if(response.getMessage().split(' ')[4].contains('%')){
          widget.auth.setCKDPrediction(widget.uid,
              double.parse(response.getMessage().split(' ')[4].split('%')[0]));
        }else{
          widget.auth.setCKDPrediction(widget.uid,
              double.parse(response.getMessage().split(' ')[7].split('%')[0]));
        }

      } else if (response.queryResult.intent.displayName.toString() ==
          'telegrame') {
        var response_data = response.queryResult.fulfillmentMessages
            .where((m) => m['platform'] == 'FACEBOOK')
            .toList();
        Widget telegram_msg = Telegram(context, response);
        FactsMessage message = FactsMessage(
          text: response.getMessage() ?? CardDialogflow(response_data[0]).title,
          name: "Doctor",
          type: false,
        );
        setState(() {
          _messages.insert(0, message);
          _messages.insert(0, telegram_msg);
        });
      } else if (response.queryResult.intent.displayName.toString() ==
          'FaceBook') {
        var response_data = response.queryResult.fulfillmentMessages
            .where((m) => m['platform'] == 'TELEGRAM')
            .toList();
        Widget facebook_msg = Facebook(context, response);
        FactsMessage message = FactsMessage(
          text: response.getMessage() ?? CardDialogflow(response_data[0]).title,
          name: "Doctor",
          type: false,
        );
        setState(() {
          _messages.insert(0, message);
          _messages.insert(0, facebook_msg);
        });
      } else if (response.queryResult.intent.displayName.toString() ==
              'Default Welcome Intent' ||
          response.queryResult.intent.displayName.toString() ==
              'Services_offer_ask') {
        var response_data = response.queryResult.fulfillmentMessages
            .where((m) =>
                m['platform'] == 'TELEGRAM' || m['platform'] == 'FACEBOOK')
            .toList();
        Widget instuction = Services(context, response, userData);
        FactsMessage message = FactsMessage(
          text: response.getMessage() ?? CardDialogflow(response_data[0]).title,
          name: "Doctor",
          type: false,
        );
        setState(() {
          _messages.insert(0, message);
          _messages.insert(0, instuction);
        });
      } else if (response.queryResult.intent.displayName.toString() ==
          'Threatment_CKD') {
        var response_data = response.queryResult.fulfillmentMessages
            .where((m) =>
                m['platform'] == 'TELEGRAM' || m['platform'] == 'FACEBOOK')
            .toList();
        Widget treatment = Threatment(context, response, userData);
        FactsMessage message = FactsMessage(
          text: response.getMessage() ?? CardDialogflow(response_data[0]).title,
          name: "Doctor",
          type: false,
        );
        setState(() {
          _messages.insert(0, message);
          _messages.insert(0, treatment);
        });
      } else {
        FactsMessage message = FactsMessage(
          text: response.getMessage() ??
              CardDialogflow(response.getListMessage()[0]).title,
          name: "Doctor",
          type: false,
        );
        setState(() {
          _messages.insert(0, message);
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

  Widget Services(BuildContext context, AIResponse response, userData) {
    var data = response.queryResult.fulfillmentMessages
        .where(
            (m) => m['platform'] != 'FACEBOOK' && m['platform'] != 'TELEGRAM')
        .toList()[0]['payload'];
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 0,
        ),
        FlatButton.icon(
            icon: Icon(Icons.perm_device_information),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed: () {
              _submitQuery(data['service-button-1']['postback-text'], userData);
            },
            label: Text(data['service-button-1']['button-title'])),
        SizedBox(
          width: 8,
        ),
        FlatButton.icon(
            icon: Icon(Icons.device_unknown),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed: () => _submitQuery(
                data['service-button-2']['postback-text'], userData),
            label: Text(data['service-button-2']['button-title'])),
      ],
    );
  }

  Widget Threatment(BuildContext context, AIResponse response, userData) {
//    var data = response.queryResult.fulfillmentMessages[0]['card'];
    var data = response.queryResult.fulfillmentMessages
        .where(
            (m) => m['platform'] != 'FACEBOOK' && m['platform'] != 'TELEGRAM')
        .toList()[0]['payload'];
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        children: <Widget>[
          FactsMessage(
            type: false,
            name: 'Doctor',
            text: data['image-description'],
          ),
          FadeInImage.assetNetwork(
              width: MediaQuery.of(context).size.width - 20,
              height: 200,
              placeholder: 'assets/loading.gif',
              image: data['image-url']),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                  icon: Icon(Icons.launch),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  color: Colors.blueAccent,
                  onPressed: () async =>  Navigator.pushNamed(context, '/CKD_webview'),
//                  await launch(data['button-url'],
//                      forceWebView: false, forceSafariVC: false),
                  label: Text(data['button-label'])),
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
                margin: EdgeInsets.only(right: 5),
                child: IconButton(
                    icon: Icon(
                      Icons.live_help,
                      size: 32,
                    ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/CKD_messageAbout');
                  },
                )
              ),
              Container(
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
