
class User{
  String uid;
  String Username;
  DateTime Birthday;
  String bloodGroup;

  User({this.uid,this.Username,this.Birthday,this.bloodGroup});

  void setUserId(String uid){
    this.uid=uid;
  }
}