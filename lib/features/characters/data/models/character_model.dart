import 'package:hive/hive.dart';
part 'character_model.g.dart';

@HiveType(typeId: 1)
class CharacterModel {
  CharacterModel({
    required this.properties,
    required this.uid,
  });

  @HiveField(0)
  final PropertiesModel properties;
  @HiveField(1)
  final String uid;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        properties: PropertiesModel.fromJson(json["properties"]),
        uid: json["uid"],
      );
}

class PropertiesModel {
  PropertiesModel({
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.created,
    required this.edited,
    required this.name,
    required this.homeworld,
    required this.url,
  });

  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final DateTime created;
  final DateTime edited;
  final String name;
  final String homeworld;
  final String url;

  factory PropertiesModel.fromJson(Map<String, dynamic> json) =>
      PropertiesModel(
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        gender: json["gender"],
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        name: json["name"],
        homeworld: json["homeworld"],
        url: json["url"],
      );
}
