class PinWithinModel{
  int? id;
  List list;

  PinWithinModel(this.id, this.list);

   factory PinWithinModel.fromJson(json) {
    return PinWithinModel(
      19,
      json['pincode'],
     
    );
  }
}