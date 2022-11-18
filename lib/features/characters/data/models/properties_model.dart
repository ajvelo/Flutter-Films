import 'package:hive/hive.dart';

part 'properties_model.g.dart';

@HiveType(typeId: 2)
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

  @HiveField(0)
  final String height;
  @HiveField(1)
  final String mass;
  @HiveField(2)
  final String hairColor;
  @HiveField(3)
  final String skinColor;
  @HiveField(4)
  final String eyeColor;
  @HiveField(5)
  final String birthYear;
  @HiveField(6)
  final String gender;
  @HiveField(7)
  final DateTime created;
  @HiveField(8)
  final DateTime edited;
  @HiveField(9)
  final String name;
  @HiveField(10)
  final String homeworld;
  @HiveField(11)
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
