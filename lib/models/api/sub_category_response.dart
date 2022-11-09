import 'package:service_bee/models/sub_category_item.dart';

class SubCategoryResponse{
  bool? status;
  String? message;
  List<SubCategoryItem>? subCategories;

  SubCategoryResponse.fromJson(Map<String, dynamic> json){
    status = json["status"] ?? false;
    subCategories = (json["data"] != null) ? json["data"].map<SubCategoryItem>((e) => SubCategoryItem.fromJson(e)).toList() : [];
  }

  SubCategoryResponse.withError(String msg){
    status = false;
    message = msg;
  }
}