import 'package:dartz/dartz.dart';
import 'package:flutter_films/core/extensions/film_model_ext.dart';

import 'package:flutter_films/core/failure.dart';
import 'package:flutter_films/features/films/domain/entities/film.dart';
import 'package:flutter_films/features/films/domain/usecases/films_usecase.dart';
import 'package:flutter_films/features/films/presentation/providers/film_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockGetFilmsUsecase extends Mock implements FilmsUsecase {}

class MockGetFilmsParams extends Mock implements FilmsParams {}

void main() {
  late MockGetFilmsUsecase mockGetFilmsUsecase;
  late MockGetFilmsParams mockGetFilmsParams;
  late NotifierProvider<FilmNotifier, GetFilmsState> filmProvider;
  late String mockUid;
  late Film filmEntityAsFavorite;

  final container = ProviderContainer();
  final filmModels = getMockFilms();
  late List<Film> filmEntitiy;

  setUp(
    () {
      mockGetFilmsUsecase = MockGetFilmsUsecase();
      mockGetFilmsParams = MockGetFilmsParams();
      mockUid = "1";
      filmProvider = NotifierProvider<FilmNotifier, GetFilmsState>(
        () {
          return FilmNotifier(
              usecase: mockGetFilmsUsecase, storedFilms: filmEntitiy);
        },
      );
      filmEntityAsFavorite = Film(
          uid: "1",
          title: 'title',
          episodeId: 1,
          openingCrawl: 'openingCrawl',
          director: 'director',
          producer: 'producer',
          releaseDate: DateTime.now().toIso8601String(),
          characters: const ['characters'],
          planets: const ['planets'],
          starships: const ['starships'],
          vehicles: const ['vehicles'],
          species: const ['species'],
          created: DateTime.now(),
          edited: DateTime.now(),
          url: 'url',
          isFavorite: true);
      filmEntitiy = filmModels.map(((filmModel) {
        return filmModel.toFilm;
      })).toList();
    },
  );
  group('GET films', () {
    test(
      'Initial state should be GetFilmInitial',
      () {
        // Arrange
        final result = container.read(filmProvider);
        // Act
        // Assert
        expect(result, equals(GetFilmsInitial()));
      },
    );

    test(
      'Provider should call get films usecase',
      () async {
        // Arrange
        when(() => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams))
            .thenAnswer((value) async => Right(filmEntitiy));

        // Act
        container
            .read(filmProvider.notifier)
            .getFilms(params: mockGetFilmsParams);
        await untilCalled(
            () => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams));
        // Assert
        verify(() => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams));
        verifyNoMoreInteractions(mockGetFilmsUsecase);
      },
    );

    test(
      'Provider should emit correct order of states when get films usecase is called with success',
      () async {
        // Arrange
        final firstState = container.read(filmProvider);
        var orderOfStates = [firstState];
        container.listen(
          filmProvider,
          (previous, next) {
            orderOfStates.add(next);
          },
        );
        when(() => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams))
            .thenAnswer((value) async => Right(filmEntitiy));
        final correctOrderOfStates = [
          GetFilmsInitial(),
          GetFilmsLoading(),
          GetFilmsSuccess(films: filmEntitiy)
        ];

        // Act
        container
            .read(filmProvider.notifier)
            .getFilms(params: mockGetFilmsParams);
        await untilCalled(
            () => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams));

        // Assert
        expect(orderOfStates, correctOrderOfStates);
        verify(() => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams));
        verifyNoMoreInteractions(mockGetFilmsUsecase);
      },
    );

    test(
      'Provider should emit correct order of states when get films usecase is called with failure',
      () async {
        // Arrange
        final firstState = container.read(filmProvider);
        var orderOfStates = [firstState];
        container.listen(
          filmProvider,
          (previous, next) {
            orderOfStates.add(next);
          },
        );
        when(() => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams))
            .thenAnswer((value) async => Left(ServerFailure(message: 'error')));
        final correctOrderOfStates = [
          GetFilmsInitial(),
          GetFilmsLoading(),
          GetFilmsError(errorMessage: 'error')
        ];

        // Act
        container
            .read(filmProvider.notifier)
            .getFilms(params: mockGetFilmsParams);
        await untilCalled(
            () => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams));
        // Assert
        expect(orderOfStates, correctOrderOfStates);
        verify(() => mockGetFilmsUsecase.getFilms(params: mockGetFilmsParams));
        verifyNoMoreInteractions(mockGetFilmsUsecase);
      },
    );
  });

  group('Toggle film favorite', () {
    test(
      'Provider should call get films usecase',
      () async {
        // Arrange
        when(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
                params: mockGetFilmsParams, uid: mockUid))
            .thenAnswer((value) async => Right(filmEntitiy.first));

        // Act
        container
            .read(filmProvider.notifier)
            .toggleFilmAsFavorite(params: mockGetFilmsParams, uid: mockUid);
        await untilCalled(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
            params: mockGetFilmsParams, uid: mockUid));

        // Assert
        verify(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
            params: mockGetFilmsParams, uid: mockUid));
        verifyNoMoreInteractions(mockGetFilmsUsecase);
      },
    );

    test(
      'Provider should emit correct order of states when toggle film favorite usecase is called with success',
      () async {
        // Arrange
        final firstState = container.read(filmProvider);
        var orderOfStates = [firstState];
        container.listen(
          filmProvider,
          (previous, next) {
            orderOfStates.add(next);
          },
        );
        expect(
            container
                .read(filmProvider.notifier)
                .storedFilms
                .firstWhere((element) => element.episodeId == 1)
                .isFavorite,
            false);
        when(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
                params: mockGetFilmsParams, uid: mockUid))
            .thenAnswer((value) async => Right(filmEntityAsFavorite));
        final correctOrderOfStates = [
          GetFilmsInitial(),
          GetFilmsLoading(),
          GetFilmsSuccess(films: filmEntitiy)
        ];

        // Act
        container
            .read(filmProvider.notifier)
            .toggleFilmAsFavorite(params: mockGetFilmsParams, uid: mockUid);
        await untilCalled(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
            params: mockGetFilmsParams, uid: mockUid));

        // Assert
        expect(orderOfStates, correctOrderOfStates);
        expect(
            container
                .read(filmProvider.notifier)
                .storedFilms
                .firstWhere((element) => element.episodeId == 1)
                .isFavorite,
            true);
        verify(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
            params: mockGetFilmsParams, uid: mockUid));
        verifyNoMoreInteractions(mockGetFilmsUsecase);
      },
    );

    test(
      'Provider should emit correct order of states when toggle film favorite usecase is called with failure',
      () async {
        // Arrange
        final firstState = container.read(filmProvider);
        var orderOfStates = [firstState];
        container.listen(
          filmProvider,
          (previous, next) {
            orderOfStates.add(next);
          },
        );
        expect(
            container
                .read(filmProvider.notifier)
                .storedFilms
                .firstWhere((element) => element.episodeId == 1)
                .isFavorite,
            false);
        when(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
                params: mockGetFilmsParams, uid: mockUid))
            .thenAnswer((value) async => Left(CacheFailure(message: 'error')));
        final correctOrderOfStates = [
          GetFilmsInitial(),
          GetFilmsLoading(),
          GetFilmsError(errorMessage: 'error')
        ];

        // Act
        container
            .read(filmProvider.notifier)
            .toggleFilmAsFavorite(params: mockGetFilmsParams, uid: mockUid);
        await untilCalled(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
            params: mockGetFilmsParams, uid: mockUid));

        // Assert
        expect(orderOfStates, correctOrderOfStates);
        expect(
            container
                .read(filmProvider.notifier)
                .storedFilms
                .firstWhere((element) => element.episodeId == 1)
                .isFavorite,
            false);
        verify(() => mockGetFilmsUsecase.toggleFilmAsFavorite(
            params: mockGetFilmsParams, uid: mockUid));
        verifyNoMoreInteractions(mockGetFilmsUsecase);
      },
    );
  });
}
