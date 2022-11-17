class Character {
  Character({
    required this.properties,
    required this.uid,
  });

  final Properties properties;

  final String uid;
}

class Properties {
  Properties({
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
}
