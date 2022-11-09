class Notification {
  int? id, user_id, vendor_id, query_id;
  String? message, type;

  Notification.fromJson(json) {
    id = json['id'] ?? 0;
    user_id = json['user_id'] ?? 0;
    vendor_id = json['vendor_id'] ?? 0;
    query_id = json['query_id'] ?? 0;
    message = json['message'] ?? "";
    type = json['type'] ?? "";
  }
}

class NotificationResponse {
  bool? status;
  String? message;
  List<Notification>? notifications;

  NotificationResponse.fromJson(json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "Something went wrong";
    notifications = json['data'] == null
        ? []
        : (json['data'] as List).map((e) => Notification.fromJson(e)).toList();
  }

  NotificationResponse.withError(msg) {
    status = false;
    message = msg ?? "Something went wrong";
    notifications = [];
  }
}
