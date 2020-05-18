import 'package:flutter/material.dart';
import 'package:healthcaredecision/pages/facts_message.dart';
import 'package:healthcaredecision/pages/Style.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class FlutterFactsChatBot extends StatefulWidget {
  FlutterFactsChatBot({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlutterFactsChatBotState createState() => new _FlutterFactsChatBotState();
}

class _FlutterFactsChatBotState extends State<FlutterFactsChatBot> {
  final List<Widget> messageList = <Widget>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _queryInputWidget(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0, right: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitQuery,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send, color: Colors.indigo[700],),
                  onPressed: () => _submitQuery(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void agentResponse(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/doctor-cqfxkd-247966848f36.json").build();
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
      Widget instruction=Welcome(context,response);
      setState(() {
        messageList.insert(0,instruction);
      });
    }
  }


  void _submitQuery(String text) {
    _textController.clear();
    Facts message = new Facts(
      text: text,
      name: "User",
      type: true,
    );
    setState(() {
      messageList.insert(0, message);
    });
    agentResponse(text);
  }

  Widget Welcome(BuildContext context,AIResponse response){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.perm_device_information),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed:(){
              _submitQuery('I need to get to know the probability of getting heart disease');
            },
            label: Text('Heart Predictions')),
        SizedBox(width: 8,),
        FlatButton.icon(
            icon: Icon(Icons.device_unknown),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[500],
            onPressed:()=>_submitQuery('I want to know about heart disease.'),
            label: Text('ASK Question')),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(
        centerTitle: true,
        title: Text("Heart-specialist", style: Style.headerTextStyle,),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.indigo,
                    Colors.blue
                  ])
          ),
        ),

      ),
      backgroundColor: Colors.lightBlue[100],
      body:

        Column(children: <Widget>[

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
  }
}