import 'package:equatable/equatable.dart';

class Film extends Equatable {
  Film(
      {required this.title,
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
      required this.uid});

  final String title;
  final int episodeId;
  final String openingCrawl;
  final String director;
  final String producer;
  final String releaseDate;
  final List<String> characters;
  final List<String> planets;
  final List<String> starships;
  final List<String> vehicles;
  final List<String> species;
  final DateTime created;
  final DateTime edited;
  final String url;
  final bool isFavorite;
  final String uid;

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
        isFavorite,
        uid
      ];
}
