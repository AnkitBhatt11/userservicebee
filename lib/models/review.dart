class Review {
  // "id": 2,
  // "query_id": 16,
  // "user_id": 39,
  // "vendor_id": 1,
  // "review": "Good work",
  // "rating": 5,
  // "created_at": "2022-08-06T15:53:04.000000Z",
  // "updated_at": "2022-08-06T15:53:04.000000Z",
  // "name": "Dada",
  // "phone": "7896208559",
  // "profile_picture": "uploads/vendors/docs/2e39541331000ee15030f6db04ae9473d5747188.jpg",
  // "email": "egyaan247@gmail.com"

  int? id, query_id, user_id, vendor_id;
  double? rating;
  String? review, name, phone, profile_picture, email, created_at;

  Review.fromJson(json) {
    id = json['id'] ?? 0;
    query_id = json['query_id'] ?? 0;
    user_id = json['user_id'] ?? 0;
    vendor_id = json['vendor_id'] ?? 0;
    rating =
        json['rating'] == null ? 0 : double.parse(json['rating'].toString());
    review = json['review'] ?? "";
    name = json['name'] ?? "";
    phone = json['phone'] ?? "";
    profile_picture = json['profile_picture'] ?? "";
    email = json['email'] ?? "";
    created_at = json['created_at'] ?? "";
  }
}
