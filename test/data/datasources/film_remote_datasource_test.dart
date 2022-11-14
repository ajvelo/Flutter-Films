import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_films/data/datasources/film_remote_datasource.dart';
import 'package:flutter_films/domain/usecases/films_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late FilmsRemoteDataSourceImpl filmsRemoteDataSourceImpl;

  setUp(
    () {
      mockDio = MockDio();
      filmsRemoteDataSourceImpl = FilmsRemoteDataSourceImpl(dio: mockDio);
      registerFallbackValue(Uri());
    },
  );

  void setUpMockDio(String fixtureName, int statusCode) {
    when(() => mockDio.get(any())).thenAnswer((invocation) async => Response(
        requestOptions: RequestOptions(path: "/films", method: "GET"),
        statusCode: 200,
        data: json.decode(fixture(fixtureName))));
  }

  final filmparams = FilmsParams(path: '/films');

  group(
    'GET Films',
    () {
      test(
        'Should return a list of film models when a status code of 200 is recieved',
        () async {
          // Arrange
          setUpMockDio('film_models.json', 200);
          // Act
          final films =
              await filmsRemoteDataSourceImpl.getFilms(params: filmparams);
          // Assert
          expect(films.length, equals(6));
        },
      );
    },
  );
}
