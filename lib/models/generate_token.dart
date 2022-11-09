class GenerateToken {
//  {
//     "orderId": "order_K2MnR4kLIvIGmF",
//     "razorpayId": "rzp_test_sU280loIylfRT0",
//     "amount": 1000,
//     "currency": "INR",
//     "description": "Add money to wallet"
// }
  String? orderId, razorpayId, currency, description;
  int? amount;

  GenerateToken.fromJson(json){
    orderId = json['orderId']??"";
    razorpayId = json['razorpayId']??"";
    amount = json['amount']??0;
    currency=json['currency']??"INR";
    description=json['description']??"";
  }

}
