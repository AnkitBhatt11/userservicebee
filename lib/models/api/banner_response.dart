import '../banner.dart';

class BannerResponse{
  bool? status;
  String? message;
  List<Banner>? banners;

  BannerResponse.fromJson(json){
    status = json['status']??false;
    message="Successfull";
    banners = json['result']==null?[]:(json['result'] as List).map((e) => Banner.fromJson(e)).toList();
  }

  BannerResponse.withError(msg) {
    status = false;
    message = msg;
  }

}