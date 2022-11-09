import '../lead.dart';

class LeadResponse {
  bool? status;
  String? message;
  List<Lead>? leads;

  LeadResponse.fromJson(json) {
    status = json['status'] ?? false;
    message = 'Successfull';
    leads = json['data'] == null
        ? []
        : (json['data'] as List).map((e) => Lead.fromJson(e)).toList();
  }

  LeadResponse.withError(err){
    status = false;
    message = err;
  }


}
