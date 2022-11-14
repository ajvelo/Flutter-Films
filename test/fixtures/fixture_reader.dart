import 'dart:convert';
import 'dart:io';

import 'package:flutter_films/data/models/film_model.dart';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

List<FilmModel> getMockFilms() {
  final response = json.decode(fixture('film_model.json'));
  final results = response['results'];
  return (results as List).map((film) => FilmModel.fromJson(film)).toList();
}
