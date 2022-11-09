import 'package:service_bee/models/category_item.dart';

class CategoryResponse{
  bool? status;
  String? message;
  List<CategoryItem>? categories;

  CategoryResponse.fromJson(Map<String, dynamic> json){
    status = json["status"] ?? false;
    categories = (json["data"] != null) ? json["data"].map<CategoryItem>((e) => CategoryItem.fromJson(e)).toList() : [];
  }

  CategoryResponse.withError(String msg){
    status = false;
    message = msg;
  }
}