class VerifyOtpResponse{
  bool? status;
  String? message;
  String? token;

  VerifyOtpResponse.fromJson(Map<String, dynamic> json){
    status = json["status"] ?? false;
    token = json["token"] ?? "";
    message = json["message"] ?? "Something went wrong";
  }

  VerifyOtpResponse.withError(String msg){
    status = false;
    message = msg;
  }
}