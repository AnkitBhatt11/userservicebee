import '../video_ad.dart';

class VideoAdResponse {
  bool? status;
  List<VideoAd>? ads;

  VideoAdResponse.fromJson(json) {
    status = json['status'] ?? false;
    ads = json['result'] == null
        ? []
        : (json['result'] as List).map((e) => VideoAd.fromJson(e)).toList();
  }

  VideoAdResponse.withError(msg) {
    status = false;
  }
}
