class SubCategoryItem{
  int? id;
  int? categoryId;
  String? name;
  String? desc;
  String? image;

  SubCategoryItem.fromJson(Map<String, dynamic> json){
    id = json["id"] ?? 0;
    categoryId = json["category_id"] ?? 0;
    name = json["sc_name"] ?? "";
    desc = json["sc_description"] ?? "";
    image = json["sc_image"] ?? "";
  }
}
