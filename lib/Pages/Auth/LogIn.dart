import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/User.dart';
import 'package:healthcaresupportsystem/Pages/Loading.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

///test@test.com    test1234

class LogIn extends StatefulWidget {
  final BaseAuth auth = Auth();

  @override
  _LogInState createState() => _LogInState();
}

enum FormType { logIn, register }
enum LoadingStatus { loadLogIn, loadRegister, nigther }

class _LogInState extends State<LogIn> {
  LoadingStatus loadingStatus = LoadingStatus.nigther;
  final formKey = new GlobalKey<FormState>();
  String App_bar_title = "LogIn";
  String _email;
  String _password;
  String Username;
  DateTime Birthday;
  String bloodGroup;
  FormType _formType = FormType.logIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentUser().then((value) {
      setState(() {
        if (value != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    });
  }

  void switchForm() {
    setState(() {
      if (_formType == FormType.logIn) {
        formKey.currentState.reset();
        App_bar_title = "Register";
        _formType = FormType.register;
      } else if (_formType == FormType.register) {
        formKey.currentState.reset();
        App_bar_title = "LogIn";
        _formType = FormType.logIn;
      }
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.logIn) {
          setState(() {
            loadingStatus = LoadingStatus.loadLogIn;
          });
        } else if (_formType == FormType.register) {
          setState(() {
            loadingStatus = LoadingStatus.loadRegister;

          });
        }
      } catch (e) {
        print('Error : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
    List<String> blood_groups=['O−',	'O+',	'A−',	'A+',	'B−',	'B+',	'AB−',	'AB+'];

    List<Widget> buildInputs() {
      if (_formType == FormType.logIn) {
        return [
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) =>
            value.isEmpty
                ? 'Email con\'t be empty'
                : null,
            onSaved: (value) => _email = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) =>
            value.isEmpty
                ? 'Password con\'t be empty'
                : null,
            obscureText: true,
            onSaved: (value) => _password = value,
          ),

        ];
      } else if (_formType == FormType.register) {
        return [
//          DropdownButton<String>(
//            items: <String>['A', 'B', 'C', 'D'].map((String value) {
//              return new DropdownMenuItem<String>(
//                value: value,
//                child: new Text(value),
//              );
//            }).toList(),
//            onChanged: (_) {},
//          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'User name'),
            // ignore: missing_return
            validator: (value){
              if(value.isEmpty){
                return 'User name con\'t be empty';
              }else if(value.length>=28){
                return 'User name should be 28 characters';
              }
            },
            onSaved: (value) => Username = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) =>
            value.isEmpty
                ? 'Email con\'t be empty'
                : null,
            onSaved: (value) => _email = value,
          ),
          Column(children: <Widget>[
//            Text('Basic date field (${format.pattern})'),
            DateTimeField(
              onSaved: (value)=> Birthday=value,
              // ignore: missing_return
              validator: (value){
                if(value==null){
                  return 'Birthday is required';
                }else{
                  String date=value.toString().trim().split(' ')[0];
                  final birthday = DateTime(int.parse(date.split('-')[0]) ,int.parse(date.split('-')[1]),int.parse(date.split('-')[2]),);
                  final date2 = DateTime.now();
                  final difference = date2.difference(birthday).inDays;
                  if(difference<=3650){
                    return 'Your age should be more than 10 years';
                  }
                }
              },
              decoration: InputDecoration(labelText: 'Birthday'),
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));

              },
            ),
          ]),
//          TextFormField(
//            decoration: InputDecoration(labelText: 'BloodGroup'),
//            // ignore: missing_return
//            validator: (value) {
//              List<String> blood_groups=['O−',	'O+',	'A−',	'A+,'	'B−',	'B+',	'AB−',	'AB+,'];
//              if(value.isEmpty){
//                return 'Blood group con\'t be empty';
//              }
//              else if(!blood_groups.contains(value)){
//                return 'Blood group should be one of thses: O−	O+	A−	A+	B−	B+	AB−	AB+';
//              }
//            },
//            onSaved: (value) => bloodGroup = value,
//          ),
          TextFormField(
            // ignore: missing_return
            validator: (value) {
//              List<String> blood_groups=['O−',	'O+',	'A−',	'A+,'	'B−',	'B+',	'AB−',	'AB+,'];
              if(value.isEmpty){
                return 'Blood group con\'t be empty';
              }
              else if(!blood_groups.contains(value)){
                return 'Blood group should be one of thses: O−	O+	A−	A+	B−	B+	AB−	AB+';
              }
            },
            onSaved: (value) => bloodGroup = value,
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Blood group',
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  _controller.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return blood_groups
                      .map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) =>
            value.isEmpty
                ? 'Password con\'t be empty'
                : null,
            obscureText: true,
            onSaved: (value) => _password = value,
          ),

        ];
      }
    }
    switch (loadingStatus) {
      case LoadingStatus.nigther:
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '${App_bar_title}',
            ),
            leading: Padding(
              padding: EdgeInsets.fromLTRB(10, 4, 0, 4),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/CKD_image/Doctor.png',
                ),
                radius: 20,
                backgroundColor: Colors.blueAccent,
              ),
            ),
//        centerTitle: true,
            backgroundColor: Colors.blueAccent,
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: buildInputs() + buildSubmitButtons(),
                    ),
                  )),
            ),
          ),
        );
      case LoadingStatus.loadLogIn:
        return Loading(
          auth: Auth(),
          email: _email,
          passwaord: _password,
          isLogInResquest: true,
        );
//        print("Kushan");
      case LoadingStatus.loadRegister:
        return Loading(
          auth: Auth(),
          email: _email,
          passwaord: _password,
          isLogInResquest: false,
          user: User(uid: null,Birthday: Birthday,bloodGroup: bloodGroup,Username: Username),
        );
    }
  }

  final format = DateFormat("yyyy-MM-dd");

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.logIn) {
      return [
        RaisedButton.icon(
          onPressed: validateAndSubmit,
          icon: Icon(Icons.add_to_home_screen),
          label: Text("LogIn"),
          color: Colors.white,
        ),
        FlatButton(
          child: Text(
            'Create a account',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: switchForm,
        ),
      ];
//      e.toString().split(',')[1]
    } else if (_formType == FormType.register) {
      return [
        RaisedButton.icon(
          onPressed: validateAndSubmit,
          icon: Icon(Icons.create),
          label: Text("Register"),
          color: Colors.white,
        ),
        FlatButton(
          child: Text(
            'Have a account? LogIn',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: switchForm,
        ),
      ];
    }
  }
}
