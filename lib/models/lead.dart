class Lead {
  int? query_id, purchase_rate, quote_rate, type;
  String? name, service, address, city, date, city_from;

  Lead.fromJson(json) {
    query_id = json['query_id'];
    purchase_rate = json['purchase_rate'];
    quote_rate = json['quote_rate'];
    name = json['name'];
    service = json['service'];
    address = json['address'];
    city_from = json["city_from"];
    city = json['city'];
    date = json['created_at'];
    type = json['type'];
  }
}
