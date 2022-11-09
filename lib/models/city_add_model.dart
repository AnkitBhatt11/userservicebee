class CityAddModel {
  String? city_from, city_to;

  CityAddModel(this.city_from, this.city_to);

  // CityAddModeltoJson() {
  //   return {
  //     'city_from': city_from,
  //     'city_to': city_to,
  //   };
  // }

  factory CityAddModel.fromJson(json) {
    return CityAddModel(
      json['city_from'],
      json['city_to'],
    );
  }
}
