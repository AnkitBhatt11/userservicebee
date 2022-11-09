import 'service_item.dart';

class SelectedServicesResponse {
  bool? status;
  String? message;
  List<ServiceItem>? services;

  SelectedServicesResponse.fromJson(json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "Something went wrong";
    services = json['data'] == null
        ? []
        : (json['data'] as List).map((e) => ServiceItem.fromJson(e)).toList();
  }

  SelectedServicesResponse.withError(msg) {
    status = false;
    message = msg ?? "Something went wrong";
  }
}
