import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/User.dart';
import 'package:healthcaresupportsystem/Pages/Loading.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:healthcaresupportsystem/Pages/validation/ValidationForm.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _controller = new TextEditingController();
  String App_bar_title = "LogIn";
  String _email;
  String _password;
  String Username;
  DateTime Birthday;
  String bloodGroup;
  FormType _formType = FormType.logIn;

  @override
  void initState() {
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
    List<String> blood_groups = [
      'O−',
      'O+',
      'A−',
      'A+',
      'B−',
      'B+',
      'AB−',
      'AB+'
    ];

    List<Widget> buildInputs() {
      if (_formType == FormType.logIn) {
        return [
          SizedBox(
            height: 5,
          ),
          TextFormField(
            key: Key('loginEmailField'),
            decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Input valid E-mail',
                prefixIcon: Icon(Icons.email),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue))),
            validator: (value) => ValidationForm.emailValidate(value),
            onSaved: (value) => _email = value,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            key: Key('loginPasswordField'),
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue)),
                labelText: 'Password',
                hintText: 'Input Password',
                prefixIcon: Icon(Icons.lock)),
            validator: (value) => ValidationForm.passwordValidate(value),
            obscureText: true,
            onSaved: (value) => _password = value,
          ),
        ];
      } else if (_formType == FormType.register) {
        return [
          TextFormField(
            key: ValueKey('registerUsernameField'),
            decoration: InputDecoration(
                labelText: 'User name',
                hintText: 'Input user name',
                prefixIcon: Icon(Icons.perm_identity),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue))),
            validator: (value) => ValidationForm.usernameValidate(value),
            onSaved: (value) => Username = value,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            key: ValueKey('registerEmailField'),
            decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Input valid E-mail',
                prefixIcon: Icon(Icons.email),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue))),
            validator: (value) => ValidationForm.emailValidate(value),
            onSaved: (value) => _email = value,
          ),
          SizedBox(
            height: 10,
          ),
          Column(children: <Widget>[
//            Text('Basic date field (${format.pattern})'),
            DateTimeField(
              key: ValueKey('registerDateTimeField'),
              onSaved: (value) => Birthday = value,
              validator: (value) => ValidationForm.dateValidate(value),
              decoration: InputDecoration(
                  labelText: 'Birthday',
                  hintText: 'Input birthday',
                  prefixIcon: Icon(Icons.calendar_today),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.blue))),
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
          SizedBox(
            height: 10,
          ),
          TextFormField(
            key: ValueKey('registerBloodGroupField'),
            validator: (value) => ValidationForm.bloodValidate(value),
            onSaved: (value) => bloodGroup = value,
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Blood group',
              hintText: 'Input your blood group',
              prefixIcon: Icon(Icons.local_hospital),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.blue)),
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
          SizedBox(
            height: 10,
          ),
          TextFormField(
            key: ValueKey('registerPasswordField'),
            controller: _passwordController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue)),
                labelText: 'Password',
                hintText: 'Input Password',
                prefixIcon: Icon(Icons.lock)),
            validator: (value) => ValidationForm.passwordValidate(value),
            obscureText: true,
            onSaved: (value) => _password = value,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            key: ValueKey('registerConfirmPasswordField'),
            controller: _confirmPassController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue)),
                labelText: 'Confirm password',
                hintText: 'Input same password',
                prefixIcon: Icon(Icons.lock)),
            validator: (value) =>
                ValidationForm.confirmPassValidate(value, _passwordController),
            obscureText: true,
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
              padding: const EdgeInsets.only(top:16.0,right: 16,left: 16),
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: buildInputs(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.7),
                          child: Container(
                            width: 400,
                            child: Column(children: buildSubmitButtons()),
                          ),
                        ),
                      ],
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
      case LoadingStatus.loadRegister:
        return Loading(
          auth: Auth(),
          email: _email,
          passwaord: _password,
          isLogInResquest: false,
          user: User(
              uid: null,
              Birthday: Birthday,
              bloodGroup: bloodGroup,
              Username: Username),
        );
    }
  }

  final format = DateFormat("yyyy-MM-dd");

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.logIn) {
      return [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width*0.8,
          child: RaisedButton.icon(
            key: Key('logInButton'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[200],
            splashColor: Colors.black38,
            elevation: 10,
            onPressed: validateAndSubmit,
            icon: Icon(Icons.add_to_home_screen),
            label: Text(
              "LogIn",
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
        FlatButton(
          child: Text(
            'Create a account',
            style: TextStyle(fontSize: 20),
            key: ValueKey('register_switch_button'),
          ),
          onPressed: switchForm,
        ),
      ];
//      e.toString().split(',')[1]
    } else if (_formType == FormType.register) {
      return [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width*0.8,
          child: RaisedButton.icon(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[200],
            splashColor: Colors.black38,
            elevation: 10,
            onPressed: validateAndSubmit,
            icon: Icon(Icons.create),
            label: Text("Resgister", key: ValueKey('registerButton')),
          ),
        ),
        FlatButton(
          child: Text(
            'Have a account? LogIn',
            style: TextStyle(fontSize: 20),
            key: ValueKey('login_switch_button'),
          ),
          onPressed: switchForm,
        ),
      ];
    }
  }
}
