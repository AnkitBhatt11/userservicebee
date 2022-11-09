import '../common_recharge_amount.dart';

class CommonRechargeResponse {
  bool? status;
  String? message;
  List<CommonRechargeAmount>? list;

  CommonRechargeResponse.fromJson(json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "";
    list = json['data'] == null
        ? []
        : (json['data'] as List)
            .map((e) => CommonRechargeAmount.fromJson(e))
            .toList();
  }
  CommonRechargeResponse.withError(msg){
    status = false;
    message = msg??"Something went wrong";
  }

}
