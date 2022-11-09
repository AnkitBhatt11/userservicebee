class CategoryItem{
  int? id;
  String? name;
  String? desc;
  String? image;

  CategoryItem({this.id, this.name, this.desc, this.image});

  CategoryItem.fromJson(Map<String, dynamic> json){
    id = json["id"] ?? 0;
    name = json["name"] ?? "";
    desc = json["description"] ?? "";
    image = json["image"] ?? "";
  }
}
