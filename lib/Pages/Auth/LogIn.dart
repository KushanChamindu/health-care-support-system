import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Loading.dart';

///test@test.com    test1234

class LogIn extends StatefulWidget {
  final BaseAuth auth;
  LogIn({this.auth});
  @override
  _LogInState createState() => _LogInState();
}

enum FormType{
  logIn,
  register
}
enum LoadingStatus{
  loadLogIn,
  loadRegister,
  nigther
}

class _LogInState extends State<LogIn> {
  LoadingStatus loadingStatus=LoadingStatus.nigther;
  final formKey=new GlobalKey<FormState>();
  String App_bar_title="LogIn";
  String _email;
  String _password;
  FormType _formType=FormType.logIn;

  void switchForm(){
    setState(() {
      if(_formType==FormType.logIn){
        formKey.currentState.reset();
        App_bar_title="Register";
        _formType=FormType.register;
      }else if(_formType==FormType.register){
        formKey.currentState.reset();
        App_bar_title="LogIn";
        _formType=FormType.logIn;
      }
    });
  }
  bool validateAndSave() {
    final form=formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }
  void validateAndSubmit()async{
    if(validateAndSave()){
      try{
        if(_formType==FormType.logIn){
          setState(() {
            loadingStatus=LoadingStatus.loadLogIn;
          });
        }else if (_formType==FormType.register){
          setState(() {
            loadingStatus=LoadingStatus.loadRegister;
          });
        }
      }catch(e){
        print('Error : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (loadingStatus){
      case LoadingStatus.nigther:
        return Scaffold(
          backgroundColor: Colors.grey[300],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildInputs()+buildSubmitButtons(),
                  )),
            ),
          ),
        );
      case LoadingStatus.loadLogIn:
        return Loading(auth: Auth(),email: _email,passwaord: _password,isLogInResquest: true,);
//        print("Kushan");
      case LoadingStatus.loadRegister:
        return Loading(auth: Auth(),email: _email,passwaord: _password,isLogInResquest: false,);
    }

  }
  List<Widget> buildInputs(){
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value)=>value.isEmpty? 'Email con\'t be empty' : null,
        onSaved: (value)=> _email=value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        validator: (value)=>value.isEmpty? 'Password con\'t be empty' : null,
        obscureText: true,
        onSaved: (value)=> _password=value,
      ),
    ];
  }
  List<Widget> buildSubmitButtons(){
    if(_formType==FormType.logIn){
      return[
        RaisedButton.icon(
          onPressed: validateAndSubmit,
          icon: Icon(Icons.add_to_home_screen),
          label: Text("LogIn"),
          color: Colors.white,),
        FlatButton(
          child: Text('Create a account', style: TextStyle(fontSize: 20),),
          onPressed: switchForm,
        )
      ];
    }else if(_formType==FormType.register){
      return[
        RaisedButton.icon(
          onPressed: validateAndSubmit,
          icon: Icon(Icons.create),
          label: Text("Register"),
          color: Colors.white,),
        FlatButton(
          child: Text('Have a account? LogIn', style: TextStyle(fontSize: 20),),
          onPressed: switchForm,
        )
      ];
    }

  }
}
