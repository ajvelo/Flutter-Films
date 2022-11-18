import 'package:equatable/equatable.dart';

class Properties extends Equatable {
  const Properties({
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

  @override
  List<Object?> get props => [
        height,
        mass,
        hairColor,
        skinColor,
        eyeColor,
        birthYear,
        gender,
        created,
        edited,
        name,
        homeworld,
        url
      ];
}
