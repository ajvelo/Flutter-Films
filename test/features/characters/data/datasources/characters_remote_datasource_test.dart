import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:flutter_films/features/characters/domain/usecases/character_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CharacterRemoteDatasource characterRemoteDatasource;
  late MockDio mockDio;
  late CharacterParams params;

  setUp(
    () {
      params = CharacterParams(path: ['/test'], uid: "1");
      mockDio = MockDio();
      characterRemoteDatasource = CharacterRemoteDatasourceImpl(dio: mockDio);
      registerFallbackValue(Uri());
    },
  );

  void setUpMockDio(String fixtureName, int statusCode) {
    when(
      () => mockDio.get(any()),
    ).thenAnswer((invocation) async => Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        statusCode: statusCode,
        data: json.decode(fixtureCharacters('character_model.json'))));
  }

  group(
    'GET Characters',
    () {
      test(
        'Should return a list of characters when status code is 200',
        () async {
          // Arrange
          setUpMockDio('character_model.json', 200);
          // Act
          final result = await characterRemoteDatasource
              .getCharacters(params: params)
              .toList();
          // Assert
          expect(result.first.properties.name, 'Luke Skywalker');
          expect(result.length, equals(1));
        },
      );

      test(
        'Throws a server exception when character list is empty',
        () async {
          // Arrange
          setUpMockDio('character_model.json', 400);
          // Act
          // Assert
          await expectLater(
              () => characterRemoteDatasource
                  .getCharacters(params: params)
                  .toList(),
              throwsA(predicate((p0) =>
                  p0 is ServerException && p0.message == 'Server Error')));
        },
      );
    },
  );
}
