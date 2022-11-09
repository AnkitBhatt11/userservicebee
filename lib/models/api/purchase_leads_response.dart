import '../purchase_leads.dart';

class PurchaseLeadsResponse {
  bool? status;
  String? message;
  List<PurchaseLeads>? purchaseLeads;

  PurchaseLeadsResponse.fromJson(json) {
    status = json['status'] ?? false;
    message="Successful";
    purchaseLeads = json['data'] == null
        ? []
        : (json['data'] as List).map((e) => PurchaseLeads.fromJson(e)).toList();
  }
  PurchaseLeadsResponse.withError(err){
    status = false;
    message = err;
  }

}
