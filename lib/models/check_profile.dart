class CheckProfile{
  bool? exists;
  CheckProfile.fromJson(json){
    exists= json['User_Profile_Exists']??false;
  }
  CheckProfile.withError(){
    exists = false;
  }
}