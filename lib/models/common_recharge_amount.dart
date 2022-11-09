class CommonRechargeAmount {
  int? recharge_amount, get_amount;

  CommonRechargeAmount.fromJson(json) {
    recharge_amount = json['recharge_amount'];
    get_amount = json['get_amount'];
  }
}
