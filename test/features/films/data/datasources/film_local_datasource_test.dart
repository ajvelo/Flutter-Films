import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/features/films/data/datasources/film_hive_helper.dart';
import 'package:flutter_films/features/films/data/datasources/film_local_datasource.dart';
import 'package:flutter_films/features/films/data/models/film_model.dart';
import 'package:flutter_films/features/films/domain/usecases/films_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockFilmHiveHelper extends Mock implements FilmHiveHelper {}

void main() {
  late FilmLocalDataSource filmLocalDataSourceImpl;
  late MockFilmHiveHelper mockFilmHiveHelper;
  late List<FilmModel> filmModels;
  late FilmModel filmModel;
  late FilmsParams filmsParams;

  setUp(
    () {
      mockFilmHiveHelper = MockFilmHiveHelper();
      filmLocalDataSourceImpl =
          FilmLocalDataSourceImpl(filmHiveHelper: mockFilmHiveHelper);
      filmModels = getMockFilms();
      filmModel = getMockFilm();
      filmsParams = FilmsParams(path: '/films');
    },
  );

  group(
    'GET Films',
    () {
      test(
        'Should return a list of films from cache when there is data in cache',
        () async {
          // Arrange
          when((() => mockFilmHiveHelper.getFilms()))
              .thenAnswer((invocation) => Future.value(filmModels));
          // Act
          final result = await filmLocalDataSourceImpl.getFilms();
          // Assert
          expect(result, filmModels);
          verify((() => mockFilmHiveHelper.getFilms())).called(1);
          verifyNoMoreInteractions(mockFilmHiveHelper);
        },
      );
      test(
        'Should throw a CacheException when there is no data in cache',
        () async {
          // Arrange
          when((() => mockFilmHiveHelper.getFilms()))
              .thenAnswer((invocation) => Future.value(List.empty()));
          // Act
          // Assert
          expect(
              () async => filmLocalDataSourceImpl.getFilms(),
              throwsA(predicate((f) =>
                  f is CacheException && f.message == "No films found")));
          verify((() => mockFilmHiveHelper.getFilms())).called(1);
          verifyNoMoreInteractions(mockFilmHiveHelper);
        },
      );

      test(
        'Should call HiveHelper to save films',
        () async {
          // Arrange
          when((() => mockFilmHiveHelper.saveFilms(filmModels: filmModels)))
              .thenAnswer((invocation) => Future.value());
          // Act
          await filmLocalDataSourceImpl.saveFilms(
            filmModels: filmModels,
          );
          // Assert
          verify((() => mockFilmHiveHelper.saveFilms(
                filmModels: filmModels,
              ))).called(1);
          verifyNoMoreInteractions(mockFilmHiveHelper);
        },
      );
    },
  );

  group(
    'Toggle Film as Favorite',
    () {
      test(
        'Should call HiveHelper to toggle film as favorite',
        () async {
          // Arrange
          when((() => mockFilmHiveHelper.toggleFilmAsFavorite(
              params: filmsParams,
              uid: "1"))).thenAnswer((invocation) => Future.value(filmModel));
          // Act
          final result = await filmLocalDataSourceImpl.toggleFilmAsFavorite(
              params: filmsParams, uid: "1");
          // Assert
          expect(result, filmModel);
          verify((() => mockFilmHiveHelper.toggleFilmAsFavorite(
              uid: "1", params: filmsParams))).called(1);
          verifyNoMoreInteractions(mockFilmHiveHelper);
        },
      );
    },
  );
}
