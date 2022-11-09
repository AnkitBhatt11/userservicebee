class GenericResponse {
  bool? status;
  String? message;

  GenericResponse.fromJson(json) {
    status = json['status'] ?? false;
    message = json['message'] ?? status ? 'Successful' : 'Something went wrong';
  }

  GenericResponse.withError(msg){
    status = false;
    message = msg??"Something went wrong";
  }

}
