import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/failure.dart';
import '../../data/datasources/film_hive_helper.dart';
import '../../data/datasources/film_local_datasource.dart';
import '../../data/datasources/film_remote_datasource.dart';
import '../../data/repository/film_repository_impl.dart';
import '../../domain/entities/film.dart';
import '../../domain/usecases/films_usecase.dart';

final filmsProvider =
    StateNotifierProvider.autoDispose<FilmNotifier, GetFilmsState>(
  (ref) {
    return FilmNotifier(
        usecase: FilmsUsecase(
            repository: FilmRepositoryImpl(
                localDataSource:
                    FilmLocalDataSourceImpl(filmHiveHelper: FilmHiveHelper()),
                remoteDateSource: FilmsRemoteDataSourceImpl(dio: Dio()))),
        storedFilms: []);
  },
);

class FilmNotifier extends StateNotifier<GetFilmsState> {
  final FilmsUsecase usecase;
  List<Film> storedFilms;
  FilmNotifier({required this.usecase, required this.storedFilms})
      : super(GetFilmsInitial());

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CastFailure:
        return (failure as CastFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'Unknown error';
    }
  }

  void getFilms({required FilmsParams params}) async {
    state = GetFilmsLoading();
    final results = await usecase.getFilms(params: params);
    results.fold((failure) {
      state = GetFilmsError(errorMessage: _getErrorMessage(failure));
    }, (films) {
      storedFilms = films
        ..sort(
          (a, b) {
            return a.episodeId.compareTo(b.episodeId);
          },
        );
      state = GetFilmsSuccess(films: storedFilms);
    });
  }

  void toggleFilmAsFavorite(
      {required int episodeId, required FilmsParams params}) async {
    state = GetFilmsLoading();
    final results = await usecase.toggleFilmAsFavorite(
        episodeId: episodeId, params: params);
    results.fold((failure) {
      state = GetFilmsError(errorMessage: _getErrorMessage(failure));
    }, (film) {
      final index = storedFilms
          .indexWhere((element) => element.episodeId == film.episodeId);
      storedFilms[index] = film;
      state = GetFilmsSuccess(films: storedFilms);
    });
  }
}

abstract class GetFilmsState extends Equatable {}

class GetFilmsInitial extends GetFilmsState {
  @override
  List<Object?> get props => [];
}

class GetFilmsLoading extends GetFilmsState {
  @override
  List<Object?> get props => [];
}

class GetFilmsSuccess extends GetFilmsState {
  final List<Film> films;

  GetFilmsSuccess({required this.films});

  @override
  List<Object?> get props => [films];
}

class GetFilmsError extends GetFilmsState {
  final String errorMessage;

  GetFilmsError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
