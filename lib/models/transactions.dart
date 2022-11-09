class Transactions {
  int? id, user_id, amount, query_id, bonus_amount;
  String? message, type, description, statu, created_at;

  Transactions.fromJson(json) {
    id = json['id'] ?? 0;
    user_id = json['user_id'] ?? 0;
    amount = json['amount'] ?? 0;
    query_id = json['query_id'] ?? 0;
    message = json['message'] ?? "";
    type = json['type'] ?? "";
    description = json['description'] ?? "";
    bonus_amount = json['bonus_amount'] ?? 0;
   statu = json['status'] ?? "";
   created_at = json["created_at"] ?? "";
  }
}

class TransactionsResponse {
  bool? status;
  String? message;
  List<Transactions>? transactions;

  TransactionsResponse.fromJson(json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "Something went wrong";
    transactions = json['data'] == null
        ? []
        : (json['data'] as List).map((e) => Transactions.fromJson(e)).toList();
  }

  TransactionsResponse.withError(msg) {
    status = false;
    message = msg ?? "Something went wrong";
    transactions = [];
  }
}
