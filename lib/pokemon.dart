class Pokemon {
  String nome;
  String urlImage;

  List<Ability> abilities;

  Pokemon.fromJson(Map<String, dynamic> json) {
    nome = json['name'];
    urlImage = json['sprites']['front_default'];

    var arrayAbilities = json['abilities'] as List;

    abilities = arrayAbilities.map((item) {
      return Ability.fromJson(item['ability']);
    }).toList();
  }
}

class Ability {
  String name;

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
