import '../review.dart';

class ReviewResponse {
  bool? status;
  String? message;
  List<Review>? reviews;

  ReviewResponse.withJson(json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "";
    reviews = json['data'] == null
        ? []
        : (json['data'] as List).map((e) => Review.fromJson(e)).toList();
  }

  ReviewResponse.withError(msg) {
    status = false;
    message = msg ?? "Something went wrong";
    reviews = [];
  }
}
