class CityToCity {
 late String city1, city2;

  CityToCity({required this.city1, required this.city2});

  CityToCity.fromJson(json) {
    city1 = json['cityfrom'];
    city2 = json['cityto'];
  }
}

class City2Model {
  int? id;
  List<CityToCity?> list;

  City2Model(this.id, this.list);
}
