import 'package:equatable/equatable.dart';
import 'package:flutter_films/features/characters/data/models/properties_model.dart';
import 'package:hive/hive.dart';
part 'character_model.g.dart';

@HiveType(typeId: 1)
class CharacterModel extends Equatable {
  const CharacterModel({
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

  @override
  List<Object?> get props => [uid, properties];
}
