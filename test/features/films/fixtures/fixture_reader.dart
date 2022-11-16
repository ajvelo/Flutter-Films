import 'dart:convert';
import 'dart:io';

import 'package:flutter_films/features/films/data/models/film_model.dart';

String fixture(String name) =>
    File('test/features/films/fixtures/$name').readAsStringSync();

List<FilmModel> getMockFilms() {
  final response = json.decode(fixture('film_models.json'));
  final results = response['result'];
  return (results as List).map((film) => FilmModel.fromJson(film)).toList();
}

FilmModel getMockFilm() {
  final response = json.decode(fixture('film_model.json'));
  final result = response['result'][0];
  return FilmModel.fromJson(result);
}
