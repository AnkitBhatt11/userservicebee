class PurchaseLeads {
  // {
  // "address": "Bishnu",
  // "pincode": null,
  // "query_date": "2022-08-03 16:30:39",
  // "phno": "8638372157",
  // "name": "Debarshi",
  // "ssc_name": "Split AC Installation"
  // },
  int? query_id;
  String? address, date, phno, name, ssc_name, pin_city, city2,pin;

  PurchaseLeads.fromJson(json) {
    address = json['address'] ?? "";
    date = json['query_date'] ?? "";
    phno = json['phno'] ?? "";
    name = json['name'] ?? "";
    ssc_name = json['ssc_name'] ?? "";
    pin_city = json['pin_city'] ?? "";
    city2 = json['city2'] ?? "";
    pin = json['pin'] ?? "";
    query_id = json['query_id'] ?? 0;
  }
}
