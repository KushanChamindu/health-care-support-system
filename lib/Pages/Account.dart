import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/validation/ValidationForm_userForms.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'Auth/Service/Auth.dart';
import 'CKD_pages/Constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Account extends StatefulWidget {
  final BaseAuth auth = Auth();

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UID args = ModalRoute.of(context).settings.arguments;
    void choiceAction(String choice) async {
      if (choice == 'SignOut') {
        print('SignOut');
        await widget.auth.singOut();
        if (await widget.auth.currentUser() == null) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          showAboutDialog(BuildContext context) {
            AlertDialog alert = AlertDialog(
              backgroundColor: Colors.grey[100],
              title: Center(
                child: Text(
                  "Connection Problem!!",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              content: Column(
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Image.asset(
                    'assets/connection_lost.gif',
                    width: 250,
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(
                      'SignOut problem',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                CupertinoButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                    child: Container(width: 500, height: 400, child: alert));
              },
            );
          }

          showAboutDialog(context);
        }
      } else {
        showAboutDialog(
            context: context,
            applicationIcon: Image.asset(
              'assets/CKD_image/Doctor.png',
              width: 100,
              height: 100,
            ),
            applicationName: "Mobile Doctor",
            applicationVersion: '0.0.1',
            applicationLegalese:
                'This software developed by HCSS PVT LMD. Copyright © 2020 Arnoud Engelfriet. Some rights reserved.',
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

    return StreamProvider<DocumentSnapshot>.value(
      value: widget.auth.user_data(args.uid),
      child: Scaffold(
          backgroundColor: Colors.blue[100],
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'My Account',
                    style: TextStyle(fontSize: 18),
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
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constant.choice.map((String choice) {
                    if (choice == 'Account') {
                      return null;
                    } else if (choice == 'SignOut') {
                      return PopupMenuItem(
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
            backgroundColor: Colors.blueAccent,
          ),
          body: AccountBody(
            uid: args.uid,
          )),
    );
  }
}

class AccountBody extends StatefulWidget {
  final Auth auth = Auth();
  final String uid;

  AccountBody({this.uid});

  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  String Username;
  DateTime Birthday;
  String bloodGroup;
  final format = DateFormat("yyyy-MM-dd");
  final formKey = new GlobalKey<FormState>();
  bool _visibility = true;
  File _image;

  @override
  void initState() {
    super.initState();
    print(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      try {
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image;
          print('Path of image: $_image');
        });
      } catch (e) {
        print("Access deny!!!! ");
      }
    }

    final user_data = Provider.of<DocumentSnapshot>(context);
    try {
      var userData = user_data.data;
      Future uploadImage(BuildContext context) async {
        if (_image != null) {
          String filename = basename(_image.path);
          StorageReference firebaseStorageRef =
              FirebaseStorage.instance.ref().child(userData['Username']);
          StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
          StorageTaskSnapshot takeSnapshot = await uploadTask.onComplete;
          String _downloadURL = await takeSnapshot.ref.getDownloadURL();
          print(_downloadURL);
          await widget.auth.setUserImageDetails(widget.uid, _downloadURL);
          setState(() {
            print('Profile picture uploaded');
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Profile picture uploaded'),
            ));
          });
        }
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

      // ignore: missing_return
      void validateAndSubmit() async {
        if (validateAndSave()) {
          try {
            // ignore: unrelated_type_equality_checks
            if (Username == userData['Username'] &&
                Birthday == userData['Birthday'].toDate() &&
                bloodGroup == userData['bloodGroup']) {
              Navigator.of(context).pop();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Already Saved details'),
              ));
            } else {
              Navigator.of(context).pop();
              await widget.auth.updateAccountDetails(
                  widget.uid, Username, bloodGroup, Birthday);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Saved changes'),
              ));
            }
          } catch (e) {
            print('Error : $e');
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Check your internet connection'),
            ));
          }
        }
      }

      createAlertDialog(BuildContext context) {
        final TextEditingController _controller = new TextEditingController(
            text: (userData['bloodGroup'] != null)
                ? userData['bloodGroup']
                : 'Loading..');
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
        // ignore: missing_return
        return showDialog(
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                key: ValueKey('AccountEditBox'),
                child: AlertDialog(
                  elevation: 20,
                  title: Text('Edit Account Details'),
                  content: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          key: ValueKey('AccountUsernameEdit'),
                          initialValue: (userData['Username'] != null)
                              ? userData['Username']
                              : 'Loading...',
                          decoration: InputDecoration(labelText: 'User name'),
                          // ignore: missing_return
                          validator: (value) =>
                              ValidationForm_userForms.usernameValidate(value),
                          onSaved: (value) => Username = value,
                        ),
                        Column(children: <Widget>[
//            Text('Basic date field (${format.pattern})'),
                          DateTimeField(
                            key: ValueKey('AccountBirthdayEdit'),
                            initialValue: (userData['Birthday'] != null)
                                ? DateTime(
                                    int.parse(userData['Birthday']
                                        .toDate()
                                        .toString()
                                        .split(' ')[0]
                                        .trim()
                                        .split('-')[0]),
                                    int.parse(userData['Birthday']
                                        .toDate()
                                        .toString()
                                        .split(' ')[0]
                                        .trim()
                                        .split('-')[1]),
                                    int.parse(userData['Birthday']
                                        .toDate()
                                        .toString()
                                        .split(' ')[0]
                                        .trim()
                                        .split('-')[2]),
                                  )
                                : Text('Loading...'),
                            onSaved: (value) => Birthday = value,
                            // ignore: missing_return
                            validator: (value) =>
                                ValidationForm_userForms.dateValidate(value),
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
                        TextFormField(
                          readOnly: true,
                          //_controller.text=userData['bloodGroup']
                          validator: (value) =>
                              ValidationForm_userForms.bloodValidate(value),
                          onSaved: (value) => bloodGroup = value,
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'Blood group',
                            suffixIcon: PopupMenuButton<String>(
                              key: ValueKey('AccountBloodGoupEdit'),
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
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      elevation: 2.0,
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    MaterialButton(
                      key: ValueKey('AccountEditSubmitButton'),
                      elevation: 2.0,
                      child: Text('Submit'),
                      onPressed: () {
                        validateAndSubmit();
                      },
                    ),
                  ],
                ),
              );
            });
      }

      // ignore: non_constant_identifier_names
      void change_visibility() {
        setState(() {
          _visibility = !_visibility;
        });
      }

      return Builder(
        builder: (context) => Container(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              key: ValueKey('AccountEditButton'),
              onPressed: () {
                createAlertDialog(context);
              },
              hoverColor: Colors.white,
              tooltip: 'Edit your account details',
              elevation: 10,
              splashColor: Colors.black,
              child: Text("Edit"),
            ),
            body: SingleChildScrollView(
                child: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.white])),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Container(
                                key: ValueKey('AccountProfilePic'),
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white60, width: 2.0)),
                                padding: EdgeInsets.all(8.0),
                                child: (_image != null)
                                    ? ClipOval(
                                        child: Image(
                                          image: FileImage(
                                            _image,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Container(
                                        child: (userData['ProfilePic'] == null)
                                            ? CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/CKD_image/default_profile.jpg'),
                                              )
//                                            : CircleAvatar(
//                                                backgroundImage: NetworkImage(userData['ProfilePic'],),
//                                              )),
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: ClipOval(
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    imageCacheHeight: 200,
                                                    fadeInCurve:
                                                        Curves.decelerate,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        'assets/loading.gif',
                                                    image:
                                                        userData['ProfilePic'],
                                                  ),
                                                ),
                                              )),
                              ),
                            ),
                            Visibility(
                              visible: _visibility,
                              child: Padding(
                                padding: EdgeInsets.only(top: 60),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_enhance,
                                    size: 30.0,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    change_visibility();
                                    getImage();
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !(_visibility),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.cloud_upload,
                                      size: 30.0,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      uploadImage(context);
                                      change_visibility();
                                    },
                                    splashColor: Colors.grey,
                                  ),
                                  Text('Submit'),
                                  IconButton(
                                    icon: Icon(
                                      Icons.cloud_off,
                                      size: 30.0,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
//                                      uploadImage();
                                      change_visibility();
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    splashColor: Colors.grey,
                                  ),
                                  Text('Cancel')
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'User name',
                          style: TextStyle(color: Colors.black38),
                        ),
                        Center(
                          child: Text(
                            (userData['Username'] != null)
                                ? '${userData['Username']}'
                                : 'Loading...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Birthday',
                          style: TextStyle(color: Colors.black38),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          (userData['Birthday'] != null)
                              ? '${userData['Birthday'].toDate().toString().split(' ')[0].trim()}'
                              : 'Loading...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Blood group',
                          style: TextStyle(color: Colors.black38),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          (userData['bloodGroup'] != null)
                              ? '${userData['bloodGroup']}'
                              : 'Loading...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                              child: Card(
                                child: Container(
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Chronic Kidney Disease',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                            'Predicted Percentage: ${userData['CKD'] == null ? 'Not predicted yet' : '${userData['CKD'].split('_')[0]}%'}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                              'Predict date : ${userData['CKD'] == null ? 'Not predicted yet' : '${userData['CKD'].split('_')[1].split('T')[0]}'}',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                              'Predict time : ${userData['CKD'] == null ? 'Not predicted yet' : '${userData['CKD'].split('_')[1].split('T')[1].split(':')[0]}:${userData['CKD'].split('_')[1].split('T')[1].split(':')[1]}'}',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                              child: Card(
                                child: Container(
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Diabetits',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                            'Percentage: ${userData['Diabetits'] == null ? 'Not predicted yet' : userData['Diabetits']}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                              'Precautions according to precentage : ${''}',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                              child: Card(
                                child: Container(
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Breast Canser',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                            'Predicted Decision: ${userData['Breast_canser'] == null ? 'Not predicted yet' : "${userData['Breast_canser'].split('_')[0]}" == '3.0' ? 'Breast cancer does not exist' : 'Breast cancer exist'}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                              'Predict date : ${userData['Breast_canser'] == null ? 'Not predicted yet' : '${userData['Breast_canser'].split('_')[1].split('T')[0]}'}',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                              'Predict time : ${userData['Breast_canser'] == null ? 'Not predicted yet' : '${userData['Breast_canser'].split('_')[1].split('T')[1].split(':')[0]}:${userData['Breast_canser'].split('_')[1].split('T')[1].split(':')[1]}'}',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                              child: Card(
                                child: Container(
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Heart Disease',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                            'Percentage: ${userData['HeartIssue'] == null ? 'Not predicted yet' : userData['HeartIssue']}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 8, 8),
                                          child: Text(
                                              'Precautions according to precentage : ${''}',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      );
    } catch (e) {
      print('Error :$e');
      return Builder(
        builder: (context) => Container(
          child: Center(
              child: Text(
            'Loading....',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          )),
        ),
      );
    }
  }
}
