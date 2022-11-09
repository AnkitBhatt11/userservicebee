import 'package:service_bee/models/pin_within_model.dart';
import 'package:service_bee/models/service_item.dart';

import 'city_add_model.dart';

class Profile {
  String? name,
      adhaar_front,
      adhaar_back,
      votercard_front,
      votercard_back,
      driving_license_front,
      driving_license_back,
      passport_front,
      passport_back,
      profile_picture,
      wallet,
      notification_start_time,
      notification_end_time,
      document_status,
      phone;
  List<ServiceItem>? services;
  List<CityAddModel>? servicableCity;
  List<PinWithinModel>? pins;

  Profile.fromJson(json) {
    name = json['name'] ?? '';
    adhaar_front = json['adhaar_front'] ?? "";
    adhaar_back = json['adhaar_back'] ?? "";
    votercard_front = json['votercard_front'] ?? "";
    votercard_back = json['votercard_back'] ?? "";
    driving_license_front = json['driving_license_front'] ?? "";
    driving_license_back = json['driving_license_back'] ?? "";
    passport_front = json['passport_front'] ?? "";
    passport_back = json['passport_back'] ?? "";
    profile_picture = json['profile_picture'] ?? "";
    wallet = json['wallet'] ?? "";
    notification_start_time = json['notification_start_time'] ?? "";
    notification_end_time = json['notification_end_time'] ?? "";
    document_status = json['document_status'] ?? "";
    phone = json['phone'] ?? '';
    // pins = json['serviceable_pincodes'] == null ?
    // [] : (json['serviceable_pincodes'] as List).map((e) => PinWithinModel
    // pins = json['serviceable_pincodes'] == null
    //     ? []
    //     : (json['serviceable_pincodes'] as List)
    //         .map((e) => PinWithinModel.fromJson(e))
    //         .toList();
    // services = json['services_provided'] == null
    //     ? []
    //     : (json['services_provided'] as List)
    //         .map((e) => ServiceItem.fromJson(e))
    //         .toList();
    // servicableCity = json['serviceable_city_pairs'] == null
    //     ? []
    //     : (json['serviceable_city_pairs'] as List)
    //         .map((e) => CityAddModel.fromJson(e))
    //         .toList();
  }
}
