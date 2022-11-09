import 'package:service_bee/models/profile.dart';

class ProfileResponse {
  bool? status;
  String? message;
  List<Profile>? profile;

  ProfileResponse.fromJson(json) {
    print(json['status']);
    status = json['status'] ?? false;
    profile = json['data'] == null
        ? []
        : (json['data'] as List).map((e) => Profile.fromJson(e)).toList();
  }

  ProfileResponse.withError(msg) {
    status = false;
    message = msg;
  }
}
