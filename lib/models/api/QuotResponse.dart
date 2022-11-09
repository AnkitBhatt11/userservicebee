import '../quot.dart';

class QuotResponse {
  bool? status;
  String? message;
  List<Quot>? quotes;

  QuotResponse.fromJson(json) {
    status = json['status'] ?? false;
    message = "Successfully";
    quotes = json['data'] == null
        ? []
        : (json['data'] as List).map((e) => Quot.fromJson(e)).toList();
  }

  QuotResponse.withError(msg) {
    status = false;
    message = msg;
  }
}
