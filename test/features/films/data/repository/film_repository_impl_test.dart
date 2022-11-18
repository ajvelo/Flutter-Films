import 'package:flutter_films/core/exception.dart';
import 'package:flutter_films/core/extensions/film_model_ext.dart';
import 'package:flutter_films/core/failure.dart';

import 'package:flutter_films/features/films/data/datasources/film_local_datasource.dart';
import 'package:flutter_films/features/films/data/datasources/film_remote_datasource.dart';
import 'package:flutter_films/features/films/data/models/film_model.dart';
import 'package:flutter_films/features/films/data/repository/film_repository_impl.dart';
import 'package:flutter_films/features/films/domain/entities/film.dart';
import 'package:flutter_films/features/films/domain/usecases/films_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockLocalDataSource extends Mock implements FilmLocalDataSource {}

class MockRemoteDataSource extends Mock implements FilmRemoteDataSource {}

void main() {
  late FilmRepositoryImpl filmRepositoryImpl;
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late FilmsParams filmsParams;
  late List<FilmModel> filmModels;
  late List<Film> films;
  late FilmModel filmModel;

  setUp(
    () {
      mockLocalDataSource = MockLocalDataSource();
      mockRemoteDataSource = MockRemoteDataSource();
      filmRepositoryImpl = FilmRepositoryImpl(
          localDataSource: mockLocalDataSource,
          remoteDataSource: mockRemoteDataSource);
      filmsParams = FilmsParams(path: '/films');
      filmModels = getMockFilms();
      films = filmModels.map((e) => e.toFilm).toList();
      filmModel = filmModels.first;
    },
  );

  group(
    'Get Films',
    () {
      test(
        'Should return films when call to remote data is successful and save to cache',
        () async {
          // Arrange
          when((() => mockRemoteDataSource.getFilms(params: filmsParams)))
              .thenAnswer((invocation) async => filmModels);
          when(() => mockLocalDataSource.getFilms())
              .thenThrow(CacheException(message: 'No films found'));
          // Act
          final result = await filmRepositoryImpl.getFilms(params: filmsParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          verify(() => mockRemoteDataSource.getFilms(params: filmsParams))
              .called(1);
          verify(() => mockLocalDataSource.getFilms()).called(1);
          verify(() => mockLocalDataSource.saveFilms(
                filmModels: filmModels,
              )).called(1);
          expect(result.isRight(), true);
          expect(resultFolded, films);
          expect(resultFolded, equals(films));
        },
      );

      test(
        'Should return failure when call to remote and local data source fails',
        () async {
          // Arrange
          when((() => mockRemoteDataSource.getFilms(params: filmsParams)))
              .thenThrow(ServerException(message: "Error"));
          when(() => mockLocalDataSource.getFilms())
              .thenThrow(CacheException(message: 'No films found'));
          // Act
          final result = await filmRepositoryImpl.getFilms(params: filmsParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          verify(() => mockRemoteDataSource.getFilms(params: filmsParams))
              .called(1);
          verify(() => mockLocalDataSource.getFilms()).called(1);
          expect(result.isLeft(), true);
          expect(resultFolded, ServerFailure(message: "Error"));
        },
      );
    },
  );

  group('Toggle film as favorite', (() {
    test(
      'Should return a film when successfully toggled as favorite',
      () async {
        // Arrange
        when((() => mockLocalDataSource.toggleFilmAsFavorite(
            params: filmsParams,
            uid: "1"))).thenAnswer((invocation) async => filmModel);
        // Act
        final result = await filmRepositoryImpl.toggleFilmAsFavorite(
            uid: "1", params: filmsParams);
        final resultFolded = result.fold((l) => l, (r) => r);
        // Assert
        verify(() => mockLocalDataSource.toggleFilmAsFavorite(
            params: filmsParams, uid: "1")).called(1);
        expect(result.isRight(), true);
        expect(resultFolded, films.first);
        expect(resultFolded, equals(films.first));
      },
    );

    test(
      'Should return a failure when toggled as favorite is unsuccessful',
      () async {
        // Arrange
        when(
          () => mockLocalDataSource.toggleFilmAsFavorite(
              params: filmsParams, uid: "1"),
        ).thenThrow(CacheException(message: 'Error'));
        // Act
        final result = await filmRepositoryImpl.toggleFilmAsFavorite(
            uid: '1', params: filmsParams);
        final resultFolded = result.fold((l) => l, (r) => r);
        // Assert
        verify(() => mockLocalDataSource.toggleFilmAsFavorite(
            params: filmsParams, uid: "1")).called(1);
        expect(result.isLeft(), true);
        expect(resultFolded, CacheFailure(message: "Error"));
      },
    );
  }));
}
