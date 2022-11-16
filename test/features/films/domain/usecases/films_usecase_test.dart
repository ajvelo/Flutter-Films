import 'package:dartz/dartz.dart';
import 'package:flutter_films/core/failure.dart';
import 'package:flutter_films/features/films/domain/entities/film.dart';
import 'package:flutter_films/features/films/domain/repository/film_repository.dart';
import 'package:flutter_films/features/films/domain/usecases/films_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFilmRepository extends Mock implements FilmRepository {}

void main() {
  late FilmsUsecase filmsUsecase;
  late MockFilmRepository mockFilmRepository;
  late FilmsParams filmsParams;
  late Film film;
  late List<Film> films;
  late ServerFailure errorMessage;
  late String uid;

  setUp(
    () {
      mockFilmRepository = MockFilmRepository();
      filmsUsecase = FilmsUsecase(repository: mockFilmRepository);
      filmsParams = FilmsParams(path: '/films');
      film = Film(
          title: 'title',
          episodeId: 1,
          openingCrawl: 'openingCrawl',
          director: 'director',
          producer: 'producer',
          releaseDate: 'releaseDate',
          characters: const ['characters'],
          planets: const ['planets'],
          starships: const ['starships'],
          vehicles: const ['vehicles'],
          species: const ['species'],
          created: DateTime.now(),
          edited: DateTime.now(),
          url: 'url',
          isFavorite: false,
          uid: 'uid');
      films = [film];
      errorMessage = ServerFailure(message: 'Error');
      uid = "1";
    },
  );

  group(
    'Get films',
    () {
      test(
        'Usecase calls film repository and returns entity when call is successful',
        () async {
          // Arrange
          when(
            () => mockFilmRepository.getFilms(params: filmsParams),
          ).thenAnswer((invocation) async => Right(films));
          // Act
          final result = await filmsUsecase.getFilms(params: filmsParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          expect(resultFolded, films);
          expect(result, Right(films));
          expect(result.isRight(), true);
          verify(
            () => mockFilmRepository.getFilms(params: filmsParams),
          ).called(1);
          verifyNoMoreInteractions(mockFilmRepository);
        },
      );

      test(
        'Usecase calls film repository and returns failure when call is unsuccessful',
        () async {
          // Arrange
          when(
            () => mockFilmRepository.getFilms(params: filmsParams),
          ).thenAnswer((invocation) async => Left(errorMessage));
          // Act
          final result = await filmsUsecase.getFilms(params: filmsParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          expect(resultFolded, errorMessage);
          expect(result, Left(errorMessage));
          expect(result.isLeft(), true);
          verify(
            () => mockFilmRepository.getFilms(params: filmsParams),
          ).called(1);
          verifyNoMoreInteractions(mockFilmRepository);
        },
      );
    },
  );

  group(
    'Toggle film as favorite',
    () {
      test(
        'Usecase calls film repository and returns entity when call is successful',
        () async {
          // Arrange
          when(
            () => mockFilmRepository.toggleFilmAsFavorite(
                uid: uid, params: filmsParams),
          ).thenAnswer((invocation) async => Right(film));
          // Act
          final result = await filmsUsecase.toggleFilmAsFavorite(
              uid: uid, params: filmsParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          expect(resultFolded, film);
          expect(result, Right(film));
          expect(result.isRight(), true);
          verify(
            () => mockFilmRepository.toggleFilmAsFavorite(
                uid: uid, params: filmsParams),
          ).called(1);
          verifyNoMoreInteractions(mockFilmRepository);
        },
      );

      test(
        'Usecase calls film repository and returns failure when call is unsuccessful',
        () async {
          // Arrange
          when(
            () => mockFilmRepository.toggleFilmAsFavorite(
                uid: uid, params: filmsParams),
          ).thenAnswer((invocation) async => Left(errorMessage));
          // Act
          final result = await filmsUsecase.toggleFilmAsFavorite(
              uid: uid, params: filmsParams);
          final resultFolded = result.fold((l) => l, (r) => r);
          // Assert
          expect(resultFolded, errorMessage);
          expect(result, Left(errorMessage));
          expect(result.isLeft(), true);
          verify(
            () => mockFilmRepository.toggleFilmAsFavorite(
                uid: uid, params: filmsParams),
          ).called(1);
          verifyNoMoreInteractions(mockFilmRepository);
        },
      );
    },
  );
}
