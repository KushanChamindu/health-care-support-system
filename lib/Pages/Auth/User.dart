
class User{
  String uid;
  String Username;
  DateTime Birthday;
  String bloodGroup;
  String CKD;
  String Diabetits;
  String HeatIssue;
  String Breast_canser;

  User({this.uid,this.Username,this.Birthday,this.bloodGroup,this.Breast_canser,this.CKD,this.Diabetits,this.HeatIssue});

  void setUserId(String uid){
    this.uid=uid;
  }

}