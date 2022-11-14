import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'film_model.g.dart';

@HiveType(typeId: 0)
class FilmModel extends Equatable {
  FilmModel({
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.characters,
    required this.planets,
    required this.starships,
    required this.vehicles,
    required this.species,
    required this.created,
    required this.edited,
    required this.url,
    required this.isFavorite,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final int episodeId;
  @HiveField(2)
  final String openingCrawl;
  @HiveField(3)
  final String director;
  @HiveField(4)
  final String producer;
  @HiveField(5)
  final DateTime releaseDate;
  @HiveField(6)
  final List<String> characters;
  @HiveField(7)
  final List<String> planets;
  @HiveField(8)
  final List<String> starships;
  @HiveField(9)
  final List<String> vehicles;
  @HiveField(10)
  final List<String> species;
  @HiveField(11)
  final DateTime created;
  @HiveField(12)
  final DateTime edited;
  @HiveField(13)
  final String url;
  @HiveField(14)
  bool isFavorite;

  factory FilmModel.fromJson(Map<String, dynamic> json) => FilmModel(
      isFavorite: false,
      title: json['title'],
      episodeId: json['episode_id'],
      openingCrawl: json['opening_crawl'],
      director: json['director'],
      producer: json['producer'],
      releaseDate: DateTime.parse(json['release_date']),
      characters: List<String>.from(json['characters'])
          .map((character) => character)
          .toList(),
      planets:
          List<String>.from(json['planets']).map((planet) => planet).toList(),
      starships: List<String>.from(json['starships'])
          .map((starship) => starship)
          .toList(),
      vehicles: List<String>.from(json['vehicles'])
          .map((vehicle) => vehicle)
          .toList(),
      species:
          List<String>.from(json['species']).map((species) => species).toList(),
      created: DateTime.parse(json['created']),
      edited: DateTime.parse(json['edited']),
      url: json['url']);

  @override
  List<Object?> get props => [
        title,
        episodeId,
        openingCrawl,
        director,
        producer,
        releaseDate,
        characters,
        planets,
        starships,
        vehicles,
        species,
        created,
        edited,
        url,
        isFavorite
      ];
}
