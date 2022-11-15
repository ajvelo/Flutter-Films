import 'dart:convert';

import 'package:flutter_films/core/extensions/film_model_ext.dart';
import 'package:flutter_films/data/models/film_model.dart';
import 'package:flutter_films/domain/entities/film.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final model = FilmModel(
      title: "A New Hope",
      episodeId: 4,
      openingCrawl: "It is a period of civil war.",
      director: "George Lucas",
      producer: "Gary Kurtz, Rick McCallum",
      releaseDate: DateTime.parse("1977-05-25"),
      characters: const ["https://swapi.dev/api/people/1/"],
      planets: const ["https://swapi.dev/api/planets/1/"],
      starships: const ["https://swapi.dev/api/starships/2/"],
      vehicles: const ["https://swapi.dev/api/vehicles/4/"],
      species: const ["https://swapi.dev/api/species/1/"],
      created: DateTime.parse("2014-12-10T14:23:31.880000Z"),
      edited: DateTime.parse("2014-12-20T19:49:45.256000Z"),
      url: "https://swapi.dev/api/films/1/",
      isFavorite: false,
      uid: "1");

  group(
    'Model mapping',
    () {
      test(
        'Should successfully convert to a Film entity',
        () {
          final filmEntity = model.toFilm;
          expect(filmEntity, isA<Film>());
          expect(filmEntity.title, model.title);
          expect(filmEntity.characters, model.characters);
          expect(filmEntity.created, model.created);
          expect(filmEntity.director, model.director);
          expect(filmEntity.edited, model.edited);
          expect(filmEntity.episodeId, model.episodeId);
          expect(filmEntity.isFavorite, model.isFavorite);
          expect(filmEntity.openingCrawl, model.openingCrawl);
          expect(filmEntity.planets, model.planets);
          expect(filmEntity.producer, model.producer);
          expect(filmEntity.releaseDate, '25/05/1977');
          expect(filmEntity.species, model.species);
          expect(filmEntity.starships, model.starships);
          expect(filmEntity.title, model.title);
          expect(filmEntity.url, model.url);
          expect(filmEntity.vehicles, model.vehicles);
        },
      );
      test(
        'Model should successfully deserialize from JSON',
        () {
          final filmModel = getMockFilm();
          expect(filmModel, isA<FilmModel>());
          expect(filmModel, equals(model));
        },
      );
    },
  );
}
