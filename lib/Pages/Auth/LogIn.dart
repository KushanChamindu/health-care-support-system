import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/User.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Loading.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:healthcaresupportsystem/Pages/validation/ValidationForm_userForms.dart';
import 'package:intl/intl.dart';

///test@test.com    test1234

class LogIn extends StatefulWidget {
  final BaseAuth auth = Auth();

  @override
  _LogInState createState() => _LogInState();
}

enum FormType { logIn, register, reset }
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
  int config = 0;

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

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    if (args != null &&
        args['user'] == null &&
        args['config'] == 'login' &&
        config == 0) {
      _email = args["email"];
      _password = args["password"];
      _formType = FormType.logIn;
    } else if (args != null &&
        args['user'] != null &&
        args['config'] == 'register' &&
        config == 0) {
      _email = args["email"];
      _password = args["password"];
      Username = args['user'].Username;
      Birthday = args['user'].Birthday;
      bloodGroup = args['user'].bloodGroup;
      _passwordController.text = _password;
      _controller.text = bloodGroup;
      setState(() {
        _formType = FormType.register;
      });
    }
    final format = DateFormat("yyyy-MM-dd");

    void switchForm(formType) {
      setState(() {
        if (formType == FormType.register) {
          formKey.currentState.reset();
          App_bar_title = "Register";
          _formType = FormType.register;
        } else if (formType == FormType.logIn) {
          formKey.currentState.reset();
          App_bar_title = "LogIn";
          _formType = FormType.logIn;
        } else if (formType == FormType.reset) {
          formKey.currentState.reset();
          App_bar_title = "Passwrod reset";
          _formType = FormType.reset;
        }
        config = 1;
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

    createAlertDialog(context){
      return showDialog(context: context,builder: (context){
        return AlertDialog(
          title: Text("Rest password"),
          content: Text('We will mail you a link.... Check this $_email email and click link to reset password'),
          actions: <Widget>[
            MaterialButton(
              elevation: 2.0,
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                switchForm(FormType.logIn);
              },
            ),
          ],
        );
      });
    }

    List<Widget> buildInputs() {
      if (_formType == FormType.logIn) {
        return [
          SizedBox(
            height: 5,
          ),
          TextFormField(
            initialValue: _email == null ? '' : _email,
            key: Key('loginEmailField'),
            decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Input valid E-mail',
                prefixIcon: Icon(Icons.email),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue))),
            validator: (value) => ValidationForm_userForms.emailValidate(value),
            onSaved: (value) => _email = value,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: _password == null ? '' : _password,
            key: Key('loginPasswordField'),
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue)),
                labelText: 'Password',
                hintText: 'Input Password',
                prefixIcon: Icon(Icons.lock)),
            validator: (value) =>
                ValidationForm_userForms.passwordValidate(value),
            obscureText: true,
            onSaved: (value) => _password = value,
          ),
        ];
      }
      else if (_formType == FormType.register) {
        return [
          TextFormField(
            initialValue: Username == null ? '' : Username,
            key: ValueKey('registerUsernameField'),
            decoration: InputDecoration(
                labelText: 'User name',
                hintText: 'Input user name',
                prefixIcon: Icon(Icons.perm_identity),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue))),
            validator: (value) =>
                ValidationForm_userForms.usernameValidate(value),
            onSaved: (value) => Username = value,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: _email == null ? '' : _email,
            key: ValueKey('registerEmailField'),
            decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Input valid E-mail',
                prefixIcon: Icon(Icons.email),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue))),
            validator: (value) => ValidationForm_userForms.emailValidate(value),
            onSaved: (value) => _email = value,
          ),
          SizedBox(
            height: 10,
          ),
          Column(children: <Widget>[
//            Text('Basic date field (${format.pattern})'),
            DateTimeField(
              initialValue: Birthday == null ? null : Birthday,
              key: ValueKey('registerDateTimeField'),
              onSaved: (value) => Birthday = value,
              validator: (value) =>
                  ValidationForm_userForms.dateValidate(value),
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
            readOnly: true,
            key: ValueKey('registerBloodGroupField'),
            validator: (value) => ValidationForm_userForms.bloodValidate(value),
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
            validator: (value) =>
                ValidationForm_userForms.passwordValidate(value),
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
            validator: (value) => ValidationForm_userForms.confirmPassValidate(
                value, _passwordController),
            obscureText: true,
          ),
        ];
      }
      else if(_formType==FormType.reset){
        return [SizedBox(
          height: 5,
        ),
          TextFormField(
            key: Key('forgetpPasswordEmail'),
            decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Input valid E-mail',
                prefixIcon: Icon(Icons.email),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.blue))),
            validator: (value) => ValidationForm_userForms.emailValidate(value),
            onSaved: (value) => _email = value,
          ),
          SizedBox(
            height: 10,
          )];
      }
    }

    List<Widget> buildSubmitButtons() {
      if (_formType == FormType.logIn) {
        return [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton.icon(
              key: Key('logInButton'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
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
            onPressed: () {
              switchForm(FormType.register);
            },
          ),
        ];
//      e.toString().split(',')[1]
      }
      else if (_formType == FormType.register) {
        return [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
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
            onPressed: () {
              switchForm(FormType.logIn);
            },
          ),
        ];
      }
      else if(_formType==FormType.reset){
        return[SizedBox(
          height: 10,
        ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton.icon(
              key: Key('Reset password 2'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Colors.blue[200],
              splashColor: Colors.black38,
              elevation: 10,
              onPressed: ()async{
                validateAndSave();
                createAlertDialog(context);
                await widget.auth.sendPasswordResetEmail(_email);
                },
              icon: Icon(Icons.graphic_eq),
              label: Text(
                "Reset password",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          FlatButton(
            child: Text(
              'Return Login page',
              style: TextStyle(fontSize: 17),
              key: ValueKey('return_login_button'),
            ),
            onPressed: () {
              switchForm(FormType.logIn);
            },
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
//        centerTitle:             backgroundColor: Colors.blueAccent,
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16, left: 16),
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: buildInputs(),
                        ),
                        Container(
                          child: _formType == FormType.logIn
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: 160,
                                      left: MediaQuery.of(context).size.width -
                                          185),
                                  child: InkWell(
                                    onTap: () {switchForm(FormType.reset);},
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.graphic_eq),
                                        Text("  Forgot password?",style: TextStyle(fontSize: 15),)
                                      ],
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.7),
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
        formKey.currentState.save();
        return Loading(
          auth: Auth(),
          email: _email,
          passwaord: _password,
          isLogInResquest: true,
        );
      case LoadingStatus.loadRegister:
        formKey.currentState.save();
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
}
