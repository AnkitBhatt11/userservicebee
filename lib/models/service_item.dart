import 'package:service_bee/models/city_to_city.dart';
import 'package:service_bee/models/pin_within_model.dart';

class ServiceItem {
  int? id, type;
  int? categoryId;
  String? name;
  String? desc;
  String? image;
  bool isSelected = false;
  List pins = [];
  List withincity = [];

  List<CityToCity> city2city = [];

  ServiceItem.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    type = json["type"] ?? 0;
    categoryId = json["c_id"] ?? 0;
    name = json["ssc_name"] ?? "";
    desc = json["ssc_description"] ?? "";
    image = json["ssc_image"] ?? "";
    pins = json['pincodes'] == null
        ? []
        : (json['pincodes'] as List).map((e) => e['pincode']).toList();
    withincity = json['cities'] == null
        ? []
        : (json['cities'] as List).map((e) => e['city_id']).toList();
    city2city = json['city_to_city'] == null
        ? []
        : (json['city_to_city'] as List)
            .map((e) => CityToCity.fromJson(e)
                // e['cityfrom'].toString();
                //  e['cityto'];
                )
            .toList();
    // json['serviceable_city_pairs'] != null ?
    // json['serviceable_city_pairs'][0].toString() : '' ;
    //  json['serviceable_city_pairs'] != null
    //     ? []
    //     : (json['serviceable_city_pairs'] as List).map((e) {
    //         e['city_From'] as String;
    //         e['city_To'] as String;

    //         //   e['city_To'];
    //         // CityToCity.fromJson(e);
    //       }).toList();
    //  CityToCity(city1: e['city_From'], city2: e['city_To']);
    // e['city_From'].toString();
    // e['city_To'].toString();

    // : (json['serviceable_city_pairs'] as List<CityToCity>).map((e) {
    //     e['city_From'];
    //     e['city_To'];
    //   }).toList();
  }
}
