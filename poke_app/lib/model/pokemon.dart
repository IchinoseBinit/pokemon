import '/extension/string_extension.dart';

class Pokemon {
  late final String id;
  late final String name;
  late final String image;
  late final List<String> types;

  Pokemon.fromJson(Map obj) {
    id = obj["id"].toString();
    name = obj["name"].toString().toTitleCase();
    image = obj["image"];
    types = getTypes(obj["pokemon_v2_pokemontypes"]);
  }

  List<String> getTypes(List obj) {
    return obj.map((e) => e["pokemon_v2_type"]["name"].toString().toTitleCase()).toList();
  }
}
