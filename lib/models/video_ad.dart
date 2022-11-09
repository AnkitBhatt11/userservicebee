class VideoAd {
  String? url, thumbnail;

  VideoAd.fromJson(json) {
    url = json['url'];
    thumbnail = json['thumbnail'];
  }
}
