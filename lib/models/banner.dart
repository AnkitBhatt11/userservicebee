class Banner{
  String? ad;

  Banner.fromJson(json){
   ad = json['url/text']??"";
  }
}