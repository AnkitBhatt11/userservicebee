import 'package:service_bee/models/service_item.dart';

class ServiceResponse{
  bool? status;
  String? message;
  List<ServiceItem>? services;

  ServiceResponse.fromJson(Map<String, dynamic> json){
    status = json["status"] ?? false;
    services = (json["data"] != null) ? json["data"].map<ServiceItem>((e) => ServiceItem.fromJson(e)).toList() : [];
  }

  ServiceResponse.withError(String msg){
    status = false;
    message = msg;
  }
}