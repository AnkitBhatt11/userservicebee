class GenericResponse{
  bool? status;
  String? message;

  GenericResponse.fromJson(Map<String, dynamic> json){
    status = json["status"] ?? false;
    message = json["message"] ?? "Something went wrong";
  }

  GenericResponse.withError(String msg){
    status = false;
    message = msg;
  }
}