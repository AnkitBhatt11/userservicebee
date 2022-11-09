class Quot {
  // {
  // "address": "Bishnu",
  // "name": "Debarshi",
  // "query_id": 15,
  // "pincode": null,
  // "query_date": "2022-08-03 16:30:39",
  // "quot_price": null,
  // "ssc_name": "Split AC Installation"
  // }
  String? address, date, name, ssc_name, pin_city, city2, message;
  int? query_id, quot_price;

  Quot.fromJson(json) {
    address = json['address'] ?? "";
    date = json['query_date'] ?? "";
    query_id = json['query_id'] ?? 0;
    name = json['name'] ?? "";
    quot_price = json['quot_price'] ?? 0;
    ssc_name = json['ssc_name'] ?? "";
    pin_city = json['pin_city'] ?? "";
    city2 = json['city2'] ?? "";
    message = json['message'] ?? "";
  }
}
